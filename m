Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC07EC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E26221655
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ELNh3uBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfFQTnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:43:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53207 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfFQTnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:43:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJh6rg3567357
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:43:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJh6rg3567357
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800587;
        bh=99r3N7XhsEZ3qlogV09DVcTpzHR1C2pJoaQEe3ReYE0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ELNh3uBAT7W/9dJpE3Bl8RlMtrb8QghLuX2fNpSs8a7VWc4EmM2G0WVj1iGOUqTvk
         NIpyrFAqflwyFUnsAUsGwEZxeDpXNcqyrQ/+JkZEY4rYh9H3QXC4lbQQQsm+pKgIku
         lzOEilWmH/mM9bRtsrOmpsaYL208KwD9RYKF91et9cQNX2tXzvldilqxdsyaTWFKR7
         jRnVe/wlHsJPE4WbHxE9hrZyuuHqdKAo8P39vuhBo1lt3JGxZ5oC/R5hxSvbWcTUqZ
         EapzrognYmWUwkAjHo8Zx1EVMM58L+2aH6XWUzNssjIqY9QiCl4CAVL0kzsHkWICQ7
         wrE4K8akD2XWQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJh6Do3567354;
        Mon, 17 Jun 2019 12:43:06 -0700
Date:   Mon, 17 Jun 2019 12:43:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-a7fa19f5a255cc8970202d5c54092089a01fc042@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
        jolsa@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
          tglx@linutronix.de, jolsa@redhat.com, mingo@kernel.org,
          yao.jin@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190604130017.31207-9-adrian.hunter@intel.com>
References: <20190604130017.31207-9-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add intel_pt_fast_forward()
Git-Commit-ID: a7fa19f5a255cc8970202d5c54092089a01fc042
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a7fa19f5a255cc8970202d5c54092089a01fc042
Gitweb:     https://git.kernel.org/tip/a7fa19f5a255cc8970202d5c54092089a01fc042
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:06 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:12 -0300

perf intel-pt: Add intel_pt_fast_forward()

Intel PT decoding is done in time order. In order to support efficient time
interval filtering, add a facility to "fast forward" towards a particular
timestamp. That involves finding the right buffer, stepping to that buffer,
and then stepping forward PSBs. Because decoding must begin at a PSB,
"fast forward" stops at the last PSB that has a timestamp before the target
timestamp.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 130 +++++++++++++++++++++
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   2 +
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
