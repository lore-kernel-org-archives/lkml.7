Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09C8C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BDB2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613648;
	bh=tV808St7A5Hpdgkq54RIYT7FRJi6zzl/zCewLZTtoos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gsRhkBOmrd4skdksXvwY1lVnjSNuarM5aimIu9DB0VR3RHTTQo3suuLfuaEfdxLV9
	 vglVGmIhccmAl441xKzcEVFFzxeByHKhVONCg/kCTUD6uSGjk3ANID+LgVmkPr6qDj
	 sEQZlTbAd1sX2JqXIZUrIJvfoV0+t9t8XLAXQ74I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbfIDQOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732481AbfIDP7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:59:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA642070C;
        Wed,  4 Sep 2019 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612789;
        bh=tV808St7A5Hpdgkq54RIYT7FRJi6zzl/zCewLZTtoos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HogUkI1AE4dfmG2KoZl08dFlaYGISvqGvYqf9CP9awXivYjHXBsk83DxaNPVJxyRK
         8hDhxHn5S5h6t11OJbag9kC0Ld3HtrgtNJVBULFDWNzliux9U9VFoxlQ5ac67snswF
         D3cBsqMnanNV+s2wgsJiE+BzUWXJSTaJLJmU2HpM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Kosuke Tatsukawa <tatsu@ab.jp.nec.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 84/94] tools/power turbostat: Fix Haswell Core systems
Date:   Wed,  4 Sep 2019 11:57:29 -0400
Message-Id: <20190904155739.2816-84-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

[ Upstream commit cd188af5282d9f9e65f63915b13239bafc746f8d ]

turbostat: cpu0: msr offset 0x630 read failed: Input/output error

because Haswell Core does not have C8-C10.

Output C8-C10 only on Haswell ULT.

Fixes: f5a4c76ad7de ("tools/power turbostat: consolidate duplicate model numbers")

Reported-by: Prarit Bhargava <prarit@redhat.com>
Suggested-by: Kosuke Tatsukawa <tatsu@ab.jp.nec.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0ff52b3c967a7..de76bf355120a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3211,6 +3211,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		break;
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
@@ -3407,6 +3408,7 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	case INTEL_FAM6_IVYBRIDGE:	/* IVB */
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
@@ -3843,6 +3845,7 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
 	case INTEL_FAM6_SANDYBRIDGE:
 	case INTEL_FAM6_IVYBRIDGE:
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
@@ -4034,6 +4037,7 @@ void perf_limit_reasons_probe(unsigned int family, unsigned int model)
 
 	switch (model) {
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 		do_gfx_perf_limit_reasons = 1;
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
@@ -4253,6 +4257,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_IVYBRIDGE_X:	/* IVB Xeon */
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSW */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
@@ -4286,7 +4291,7 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_HASWELL_CORE:
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
@@ -4570,9 +4575,6 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_XEON_PHI_KNM:
 		return INTEL_FAM6_XEON_PHI_KNL;
 
-	case INTEL_FAM6_HASWELL_ULT:
-		return INTEL_FAM6_HASWELL_CORE;
-
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
 		return INTEL_FAM6_BROADWELL_X;
-- 
2.20.1

