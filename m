Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD8BC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D89218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vjwTf5Cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfGCOEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:04:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57913 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCOEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:04:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63E48Hc3320414
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:04:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63E48Hc3320414
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562162649;
        bh=/XoBGCZK3N/P1P1X66+Xh4sTo3iiL2Nti/+CwYzT03g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=vjwTf5CjDIJ7aLQzMUJncpLNuBcmmNsWEjx/pPzNXfeqH4LaxdxV5enJy9U1Hz6Yw
         qyFwd5MxBqjePAfpbKJns/VS5EERFFBK0LYJ+SGWZUOJ6Z/vH/7xs68yLDJZ4b32zu
         6cLpFySpfkn7iFng0AZ8G3Y0SoOQE1JC7Rt85y11vm9HeeoEDORiQ3XYBL8k8DW3D3
         88QYMrDS/rDpnxX4UzbKeKsgDGHdM6PF5roE5ZHcHsEKR+mYX8q6jqa934EoiU5frd
         /PgnNUj4okb62kw7eJVk0e3+o0n2wRmHBSKFP/TtceMhlJX/qrmxfzPoTf0X7eIXZV
         Cht28Ne4njytQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63E48J63320411;
        Wed, 3 Jul 2019 07:04:08 -0700
Date:   Wed, 3 Jul 2019 07:04:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-abe5a1d3e4bee361bd3b21b8909c8421e46911d1@git.kernel.org>
Cc:     hpa@zytor.com, adrian.hunter@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        acme@redhat.com
Reply-To: acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jolsa@redhat.com
In-Reply-To: <20190622093248.581-2-adrian.hunter@intel.com>
References: <20190622093248.581-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Decoder to output CBR changes
 immediately
Git-Commit-ID: abe5a1d3e4bee361bd3b21b8909c8421e46911d1
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

Commit-ID:  abe5a1d3e4bee361bd3b21b8909c8421e46911d1
Gitweb:     https://git.kernel.org/tip/abe5a1d3e4bee361bd3b21b8909c8421e46911d1
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Sat, 22 Jun 2019 12:32:42 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 08:47:10 -0300

perf intel-pt: Decoder to output CBR changes immediately

The core-to-bus ratio (CBR) provides the CPU frequency. With branches
enabled, the decoder was outputting CBR changes only when there was a
branch. That loses the correct time of the change if the trace is not in
context (e.g. not tracing kernel space). Change to output the CBR change
immediately.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190622093248.581-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index f8b71bf2bb4c..3d2255f284f4 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -2015,16 +2015,8 @@ next:
 
 		case INTEL_PT_CBR:
 			intel_pt_calc_cbr(decoder);
-			if (!decoder->branch_enable &&
-			    decoder->cbr != decoder->cbr_seen) {
-				decoder->cbr_seen = decoder->cbr;
-				decoder->state.type = INTEL_PT_CBR_CHG;
-				decoder->state.from_ip = decoder->ip;
-				decoder->state.to_ip = 0;
-				decoder->state.cbr_payload =
-							decoder->packet.payload;
+			if (decoder->cbr != decoder->cbr_seen)
 				return 0;
-			}
 			break;
 
 		case INTEL_PT_MODE_EXEC:
@@ -2626,8 +2618,12 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 		decoder->sample_tot_cyc_cnt = decoder->tot_cyc_cnt;
 	} else {
 		decoder->state.err = 0;
-		if (decoder->cbr != decoder->cbr_seen && decoder->state.type) {
+		if (decoder->cbr != decoder->cbr_seen) {
 			decoder->cbr_seen = decoder->cbr;
+			if (!decoder->state.type) {
+				decoder->state.from_ip = decoder->ip;
+				decoder->state.to_ip = 0;
+			}
 			decoder->state.type |= INTEL_PT_CBR_CHG;
 			decoder->state.cbr_payload = decoder->cbr_payload;
 		}
