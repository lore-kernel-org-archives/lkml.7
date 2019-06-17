Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FBCC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9539B2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bT+GskI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfFQTl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:41:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45213 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfFQTl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:41:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJf0fb3566886
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:41:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJf0fb3566886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800461;
        bh=0zkNDlAH1V9qSROkTpQlgFIP6cy77U8VcPGPMo07MPU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bT+GskI5iqafbraSphtpxUZOM9Xl+6+nVpDZZDZia4jnKDHcpqZYBnCncqYHyX//h
         QFRHbjE4nms9zn9OCqf0RYFzHwXGa45gf7w4hXAgWKWJoCMXx/JW+PaQAfdTeJKKMX
         PenJVhyopECTU8KXSGLNDU091fkKgdSSiVp4b3f0HN7tv5uxsKcqEKDizjj0ZScCoV
         nfMzkYtbmTWlZrfj+tpV6YnHni+XTCD76p5vk8TNGRoIj5g0CGhZyt316qEtapVKep
         vrEfCx7H0O8i0EXEY42b97QjySMneb1Ly1wYP8AiH+Xasei8oI5ga2go+3Zzibk1sV
         2dYvZEwdS4iaQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJf05a3566883;
        Mon, 17 Jun 2019 12:41:00 -0700
Date:   Mon, 17 Jun 2019 12:41:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-e72b52a2cfdea5cb0279b2d63a36d78b8c2134de@git.kernel.org>
Cc:     acme@redhat.com, adrian.hunter@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        hpa@zytor.com, yao.jin@linux.intel.com
Reply-To: yao.jin@linux.intel.com, hpa@zytor.com, jolsa@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com, acme@redhat.com
In-Reply-To: <20190604130017.31207-6-adrian.hunter@intel.com>
References: <20190604130017.31207-6-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Factor out intel_pt_8b_tsc()
Git-Commit-ID: e72b52a2cfdea5cb0279b2d63a36d78b8c2134de
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

Commit-ID:  e72b52a2cfdea5cb0279b2d63a36d78b8c2134de
Gitweb:     https://git.kernel.org/tip/e72b52a2cfdea5cb0279b2d63a36d78b8c2134de
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:03 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:12 -0300

perf intel-pt: Factor out intel_pt_8b_tsc()

Factor out intel_pt_8b_tsc() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 26 ++++++++++++++--------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 13123b195083..c06dceb774e9 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1369,6 +1369,21 @@ static int intel_pt_mode_tsx(struct intel_pt_decoder *decoder, bool *no_tip)
 	return 0;
 }
 
+static uint64_t intel_pt_8b_tsc(uint64_t timestamp, uint64_t ref_timestamp)
+{
+	timestamp |= (ref_timestamp & (0xffULL << 56));
+
+	if (timestamp < ref_timestamp) {
+		if (ref_timestamp - timestamp > (1ULL << 55))
+			timestamp += (1ULL << 56);
+	} else {
+		if (timestamp - ref_timestamp > (1ULL << 55))
+			timestamp -= (1ULL << 56);
+	}
+
+	return timestamp;
+}
+
 static void intel_pt_calc_tsc_timestamp(struct intel_pt_decoder *decoder)
 {
 	uint64_t timestamp;
@@ -1376,15 +1391,8 @@ static void intel_pt_calc_tsc_timestamp(struct intel_pt_decoder *decoder)
 	decoder->have_tma = false;
 
 	if (decoder->ref_timestamp) {
-		timestamp = decoder->packet.payload |
-			    (decoder->ref_timestamp & (0xffULL << 56));
-		if (timestamp < decoder->ref_timestamp) {
-			if (decoder->ref_timestamp - timestamp > (1ULL << 55))
-				timestamp += (1ULL << 56);
-		} else {
-			if (timestamp - decoder->ref_timestamp > (1ULL << 55))
-				timestamp -= (1ULL << 56);
-		}
+		timestamp = intel_pt_8b_tsc(decoder->packet.payload,
+					    decoder->ref_timestamp);
 		decoder->tsc_timestamp = timestamp;
 		decoder->timestamp = timestamp;
 		decoder->ref_timestamp = 0;
