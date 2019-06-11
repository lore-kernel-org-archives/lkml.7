Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2B0C0650E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F0421871
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279859;
	bh=zjmgtp8eiy+Z0NyT/5YxTE3+tpZXzyH/dDpjJU0Pi+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JYLIye6bYjQLznmGxbwGF6hI4a2tpZmrSZbqzGCadt1a89a886HksSW3FwRd69YeV
	 1PIKpmvXgmfw727phR/UC+02GVahj4amsmuMM1CEV57oqtdPfZTAaqDWe09vRrJigT
	 R/6wk7e8Q6Q64D/NQneHIrQpSElsX4YTtYm7kPq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407253AbfFKTES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:04:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405412AbfFKTEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:16 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD9E321852;
        Tue, 11 Jun 2019 19:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279855;
        bh=zjmgtp8eiy+Z0NyT/5YxTE3+tpZXzyH/dDpjJU0Pi+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zzz3ed4mYj/89Fz75CEPEHXIhYhq5w/AUDom6R0RBTt3IkYG74xXc7OQRE6+ydLP4
         ZXfHQvExYp6YxvRCmXbR6K/8DT6t06vbZo1xMe04hyIfCF0uPVMv8cJ2zvFkeCwIe+
         crsjCvXyXTs3O8d+dIlXVlhfQ9CC4QtV8I4SotHI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 69/85] perf intel-pt: Add reposition parameter to intel_pt_get_data()
Date:   Tue, 11 Jun 2019 15:58:55 -0300
Message-Id: <20190611185911.11645-70-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

When the decoder gets the next trace buffer, some state is reset if the
buffer is not consecutive to the previous buffer. Add a parameter
'reposition' so that can be done also to support a "fast forward"
facility.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c    | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 70bff7bb79f3..dde6a7a97a7a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -502,7 +502,7 @@ static void intel_pt_reposition(struct intel_pt_decoder *decoder)
 	decoder->have_tma = false;
 }
 
-static int intel_pt_get_data(struct intel_pt_decoder *decoder)
+static int intel_pt_get_data(struct intel_pt_decoder *decoder, bool reposition)
 {
 	struct intel_pt_buffer buffer = { .buf = 0, };
 	int ret;
@@ -519,7 +519,7 @@ static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 		intel_pt_log("No more data\n");
 		return -ENODATA;
 	}
-	if (!buffer.consecutive) {
+	if (!buffer.consecutive || reposition) {
 		intel_pt_reposition(decoder);
 		decoder->ref_timestamp = buffer.ref_timestamp;
 		decoder->state.trace_nr = buffer.trace_nr;
@@ -531,10 +531,11 @@ static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 	return 0;
 }
 
-static int intel_pt_get_next_data(struct intel_pt_decoder *decoder)
+static int intel_pt_get_next_data(struct intel_pt_decoder *decoder,
+				  bool reposition)
 {
 	if (!decoder->next_buf)
-		return intel_pt_get_data(decoder);
+		return intel_pt_get_data(decoder, reposition);
 
 	decoder->buf = decoder->next_buf;
 	decoder->len = decoder->next_len;
@@ -553,7 +554,7 @@ static int intel_pt_get_split_packet(struct intel_pt_decoder *decoder)
 	len = decoder->len;
 	memcpy(buf, decoder->buf, len);
 
-	ret = intel_pt_get_data(decoder);
+	ret = intel_pt_get_data(decoder, false);
 	if (ret) {
 		decoder->pos += old_len;
 		return ret < 0 ? ret : -EINVAL;
@@ -879,7 +880,7 @@ static int intel_pt_get_next_packet(struct intel_pt_decoder *decoder)
 		decoder->len -= decoder->pkt_step;
 
 		if (!decoder->len) {
-			ret = intel_pt_get_next_data(decoder);
+			ret = intel_pt_get_next_data(decoder, false);
 			if (ret)
 				return ret;
 		}
@@ -2369,7 +2370,7 @@ static int intel_pt_get_split_psb(struct intel_pt_decoder *decoder,
 	decoder->pos += decoder->len;
 	decoder->len = 0;
 
-	ret = intel_pt_get_next_data(decoder);
+	ret = intel_pt_get_next_data(decoder, false);
 	if (ret)
 		return ret;
 
@@ -2395,7 +2396,7 @@ static int intel_pt_scan_for_psb(struct intel_pt_decoder *decoder)
 	intel_pt_log("Scanning for PSB\n");
 	while (1) {
 		if (!decoder->len) {
-			ret = intel_pt_get_next_data(decoder);
+			ret = intel_pt_get_next_data(decoder, false);
 			if (ret)
 				return ret;
 		}
-- 
2.20.1

