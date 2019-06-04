Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99043C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7228721537
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfFDNCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:02:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:5100 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbfFDNCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:02:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:02:03 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:02:02 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/19] perf intel-pt: Add intel_pt_fast_forward()
Date:   Tue,  4 Jun 2019 16:00:06 +0300
Message-Id: <20190604130017.31207-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel PT decoding is done in time order. In order to support efficient time
interval filtering, add a facility to "fast forward" towards a particular
timestamp. That involves finding the right buffer, stepping to that buffer,
and then stepping forward PSBs. Because decoding must begin at a PSB,
"fast forward" stops at the last PSB that has a timestamp before the target
timestamp.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 130 ++++++++++++++++++
 .../util/intel-pt-decoder/intel-pt-decoder.h  |   2 +
 2 files changed, 132 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index dde6a7a97a7a..c374a856e73f 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -126,6 +126,7 @@ struct intel_pt_decoder {
 	uint64_t timestamp;
 	uint64_t tsc_timestamp;
 	uint64_t ref_timestamp;
+	uint64_t buf_timestamp;
 	uint64_t sample_timestamp;
 	uint64_t ret_addr;
 	uint64_t ctc_timestamp;
@@ -519,6 +520,7 @@ static int intel_pt_get_data(struct intel_pt_decoder *decoder, bool reposition)
 		intel_pt_log("No more data\n");
 		return -ENODATA;
 	}
+	decoder->buf_timestamp = buffer.ref_timestamp;
 	if (!buffer.consecutive || reposition) {
 		intel_pt_reposition(decoder);
 		decoder->ref_timestamp = buffer.ref_timestamp;
@@ -2854,3 +2856,131 @@ unsigned char *intel_pt_find_overlap(unsigned char *buf_a, size_t len_a,
 			return buf_b; /* No overlap */
 	}
 }
+
+/**
+ * struct fast_forward_data - data used by intel_pt_ff_cb().
+ * @timestamp: timestamp to fast forward towards
+ * @buf_timestamp: buffer timestamp of last buffer with trace data earlier than
+ *                 the fast forward timestamp.
+ */
+struct fast_forward_data {
+	uint64_t timestamp;
+	uint64_t buf_timestamp;
+};
+
+/**
+ * intel_pt_ff_cb - fast forward lookahead callback.
+ * @buffer: Intel PT trace buffer
+ * @data: opaque pointer to fast forward data (struct fast_forward_data)
+ *
+ * Determine if @buffer trace is past the fast forward timestamp.
+ *
+ * Return: 1 (stop lookahead) if @buffer trace is past the fast forward
+ *         timestamp, and 0 otherwise.
+ */
+static int intel_pt_ff_cb(struct intel_pt_buffer *buffer, void *data)
+{
+	struct fast_forward_data *d = data;
+	unsigned char *buf;
+	uint64_t tsc;
+	size_t rem;
+	size_t len;
+
+	buf = (unsigned char *)buffer->buf;
+	len = buffer->len;
+
+	if (!intel_pt_next_psb(&buf, &len) ||
+	    !intel_pt_next_tsc(buf, len, &tsc, &rem))
+		return 0;
+
+	tsc = intel_pt_8b_tsc(tsc, buffer->ref_timestamp);
+
+	intel_pt_log("Buffer 1st timestamp " x64_fmt " ref timestamp " x64_fmt "\n",
+		     tsc, buffer->ref_timestamp);
+
+	/*
+	 * If the buffer contains a timestamp earlier that the fast forward
+	 * timestamp, then record it, else stop.
+	 */
+	if (tsc < d->timestamp)
+		d->buf_timestamp = buffer->ref_timestamp;
+	else
+		return 1;
+
+	return 0;
+}
+
+/**
+ * intel_pt_fast_forward - reposition decoder forwards.
+ * @decoder: Intel PT decoder
+ * @timestamp: timestamp to fast forward towards
+ *
+ * Reposition decoder at the last PSB with a timestamp earlier than @timestamp.
+ *
+ * Return: 0 on success or negative error code on failure.
+ */
+int intel_pt_fast_forward(struct intel_pt_decoder *decoder, uint64_t timestamp)
+{
+	struct fast_forward_data d = { .timestamp = timestamp };
+	unsigned char *buf;
+	size_t len;
+	int err;
+
+	intel_pt_log("Fast forward towards timestamp " x64_fmt "\n", timestamp);
+
+	/* Find buffer timestamp of buffer to fast forward to */
+	err = decoder->lookahead(decoder->data, intel_pt_ff_cb, &d);
+	if (err < 0)
+		return err;
+
+	/* Walk to buffer with same buffer timestamp */
+	if (d.buf_timestamp) {
+		do {
+			decoder->pos += decoder->len;
+			decoder->len = 0;
+			err = intel_pt_get_next_data(decoder, true);
+			/* -ENOLINK means non-consecutive trace */
+			if (err && err != -ENOLINK)
+				return err;
+		} while (decoder->buf_timestamp != d.buf_timestamp);
+	}
+
+	if (!decoder->buf)
+		return 0;
+
+	buf = (unsigned char *)decoder->buf;
+	len = decoder->len;
+
+	if (!intel_pt_next_psb(&buf, &len))
+		return 0;
+
+	/*
+	 * Walk PSBs while the PSB timestamp is less than the fast forward
+	 * timestamp.
+	 */
+	do {
+		uint64_t tsc;
+		size_t rem;
+
+		if (!intel_pt_next_tsc(buf, len, &tsc, &rem))
+			break;
+		tsc = intel_pt_8b_tsc(tsc, decoder->buf_timestamp);
+		/*
+		 * A TSC packet can slip past MTC packets but, after fast
+		 * forward, decoding starts at the TSC timestamp. That means
+		 * the timestamps may not be exactly the same as the timestamps
+		 * that would have been decoded without fast forward.
+		 */
+		if (tsc < timestamp) {
+			intel_pt_log("Fast forward to next PSB timestamp " x64_fmt "\n", tsc);
+			decoder->pos += decoder->len - len;
+			decoder->buf = buf;
+			decoder->len = len;
+			intel_pt_reposition(decoder);
+		} else {
+			break;
+		}
+	} while (intel_pt_step_psb(&buf, &len));
+
+	return 0;
+}
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index de36254c6ac9..e633fad2fd5d 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -130,6 +130,8 @@ void intel_pt_decoder_free(struct intel_pt_decoder *decoder);
 
 const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder);
 
+int intel_pt_fast_forward(struct intel_pt_decoder *decoder, uint64_t timestamp);
+
 unsigned char *intel_pt_find_overlap(unsigned char *buf_a, size_t len_a,
 				     unsigned char *buf_b, size_t len_b,
 				     bool have_tsc, bool *consecutive);
-- 
2.17.1

