Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93068C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F632084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="P7lE9+Bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfFQTDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:03:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35717 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:03:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJ3NM23555128
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:03:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJ3NM23555128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798203;
        bh=Z6nObtRq65mHCPWJoKN4vRczBaR5+HDW/+F2EIOm900=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=P7lE9+BnBZJemDhG3sX3Z/UTLXq9kWYVCEJxXFOKm+LbALWQaoEnUStft7xGBVslr
         jarejHjPmTwEsAc1n4q9RZM0D6GxZPE6rHLBVn/AX1KoDmyLhSWQsObOQLJduO5ogK
         aF2tDIHNVmX6kwN55wKQimQVLfUmBWMlJLHfx3IGb5dTfgFNLAafwV0HhNCqg//c79
         TXqeKUhMjxfhBg/evlzRO8PFdnup6s2Ml1f9heZPeCq+npABAbCCbjRNJjdvI2EXEo
         RLarrtfmB94LzE6Ax1Beu+XexBOGYS1h9G5t38ouZVFnUWpyVaJfgn63NV/Deh3C6m
         yXYMKqI2oCLhw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJ3NDU3555125;
        Mon, 17 Jun 2019 12:03:23 -0700
Date:   Mon, 17 Jun 2019 12:03:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-f3c98c4b5ac831f29b1cc19fa84d3c8401f846d6@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
        jolsa@redhat.com
Reply-To: jolsa@redhat.com, acme@redhat.com, hpa@zytor.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190520113728.14389-11-adrian.hunter@intel.com>
References: <20190520113728.14389-11-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Re-factor TIP cases in
 intel_pt_walk_to_ip
Git-Commit-ID: f3c98c4b5ac831f29b1cc19fa84d3c8401f846d6
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

Commit-ID:  f3c98c4b5ac831f29b1cc19fa84d3c8401f846d6
Gitweb:     https://git.kernel.org/tip/f3c98c4b5ac831f29b1cc19fa84d3c8401f846d6
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:16 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:56 -0300

perf intel-pt: Re-factor TIP cases in intel_pt_walk_to_ip

To make it easier to add new code for different TIP cases, separate each
case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 23 ++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index a2384a314990..99773445872d 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -2128,18 +2128,29 @@ static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
 		switch (decoder->packet.type) {
 		case INTEL_PT_TIP_PGD:
 			decoder->continuous_period = false;
-			__fallthrough;
+			decoder->pge = false;
+			if (intel_pt_have_ip(decoder))
+				intel_pt_set_ip(decoder);
+			if (!decoder->ip)
+				break;
+			decoder->state.type |= INTEL_PT_TRACE_END;
+			return 0;
+
 		case INTEL_PT_TIP_PGE:
+			decoder->pge = true;
+			if (intel_pt_have_ip(decoder))
+				intel_pt_set_ip(decoder);
+			if (!decoder->ip)
+				break;
+			decoder->state.type |= INTEL_PT_TRACE_BEGIN;
+			return 0;
+
 		case INTEL_PT_TIP:
-			decoder->pge = decoder->packet.type != INTEL_PT_TIP_PGD;
+			decoder->pge = true;
 			if (intel_pt_have_ip(decoder))
 				intel_pt_set_ip(decoder);
 			if (!decoder->ip)
 				break;
-			if (decoder->packet.type == INTEL_PT_TIP_PGE)
-				decoder->state.type |= INTEL_PT_TRACE_BEGIN;
-			if (decoder->packet.type == INTEL_PT_TIP_PGD)
-				decoder->state.type |= INTEL_PT_TRACE_END;
 			return 0;
 
 		case INTEL_PT_FUP:
