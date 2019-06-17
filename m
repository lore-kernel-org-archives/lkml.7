Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B5DC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D757C2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="sf6NVRhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfFQTmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:42:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41499 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfFQTmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:42:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJgO1f3567264
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:42:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJgO1f3567264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800545;
        bh=0IEKdfIeNM/hQBNm0WavvHf/0EegvklCvThUGuFwk3c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=sf6NVRhXxL/K1KVi5/lI96VEus6wAJmKtB6t0OIh8x4FZMG01x8ZTzHMP9GBTVL92
         M9VsRsA6Q5AJaM10ZjkEynHN8tFx5Srpv2OueTRebLwF8XlBOMt+RO5oWxiftv5iRY
         CGRT6W9UsoNmXH2IQRE7ecZbkYx8qEy2cNOxGjQOWx9zLD1bbtzUiqrMy1CJM6tY+o
         s5O8mI7L24DZPAseXxRVpbMjG0ChTN0W8q/ae11k00RWm5TWHr+1pVQdrw6gc0w7lU
         aN7VgrMDKI9tPUj4oJ7/KaGLAxVjYrq++b83gfYTa50fODvtjqOIUtTexbjIHj1zDO
         nUDni03JjCAMw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJgOAk3567260;
        Mon, 17 Jun 2019 12:42:24 -0700
Date:   Mon, 17 Jun 2019 12:42:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-6c1f0b18ac3361837dbe53e794e28096285fb4f0@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        adrian.hunter@intel.com, tglx@linutronix.de, jolsa@redhat.com,
        hpa@zytor.com, yao.jin@linux.intel.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com,
          jolsa@redhat.com, yao.jin@linux.intel.com, hpa@zytor.com
In-Reply-To: <20190604130017.31207-8-adrian.hunter@intel.com>
References: <20190604130017.31207-8-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add reposition parameter to
 intel_pt_get_data()
Git-Commit-ID: 6c1f0b18ac3361837dbe53e794e28096285fb4f0
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

Commit-ID:  6c1f0b18ac3361837dbe53e794e28096285fb4f0
Gitweb:     https://git.kernel.org/tip/6c1f0b18ac3361837dbe53e794e28096285fb4f0
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:05 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:12 -0300

perf intel-pt: Add reposition parameter to intel_pt_get_data()

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
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 17 +++++++++--------
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
