Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE53DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9072087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UwVEGGkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387489AbfHBPck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:32:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40869 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733275AbfHBPck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:32:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so74263949qtn.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=84FAN5plY18NUAIPKsxSSrpBaMCaqBqY01+bJKwhcus=;
        b=UwVEGGkq3hYSS4o3zIyXvt/N40Oo/xnbMug6Y4fvBDh2ZjgaXUand6OLNubfLv+8Jc
         sKCH8BX7uoJaZjjFlCln2lvu/kuO1bMEiaXTogDR32mzdVqc2OcLizGR/2jiQG0zuEtP
         7B+je13L4NoVXaqpdiHqdyadTvY0BjGCSLdr7DCswg44OEAVr3xiN8ap3MLRDZSNvZVV
         ezv/cu/IxbwtoOIjrN6u9UQu+T92sf5Q6SYY+1sOyePhN+uL+4C8C5XN/Bt33x6B3rGx
         viQBttM3ePJeOOz+Dl1snhMebemAY024is0N4w7FOoA/L8ITABK/wmAbqGLHG8qALqTC
         fCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=84FAN5plY18NUAIPKsxSSrpBaMCaqBqY01+bJKwhcus=;
        b=iedmAZwGhMAL9g6vuOi8ECAyHC9se5cEd7yrmBLypCIWiU07VNkTOql6h1kDvgGrta
         TSQPNQXLOBcZN8ghbQx5h6GQlLESVY90o6YwNloQyzqfEQQodaKOPf5HjOYFatJpSXdG
         h8UrbrPU/2k9rrChCIrXtA12cDnM8yZM++AUHEPLU+0Wdy8jt+LBmniOIkckrdY1eEWu
         LzOQzS4RPGm0g/kUUiLqmQk9koAG/BPhi/u2fwX9FEdfmz0/iBnUu6WcsWfbPp6K0f1h
         1smLl+Nx2DCyap7AtfCSP40T9niTUZD8DTVxeoyhQxFE/P50u9CWH1TDfupM/MofBBmC
         XMPg==
X-Gm-Message-State: APjAAAXGysq/Jkn4gpI16MUqNCn6tqH6fgzcQO8FbFKGmAAGEcThB7rE
        iFnzVPQ5BVyN7PKTVeJ74DcIoQ==
X-Google-Smtp-Source: APXvYqzzg0WWHlFjmv1i2xNZKSEVRDeXkteRnpzhC8HIE2j6yEBACm4hIhub82tVhp/5Cgn8qxBHBg==
X-Received: by 2002:a0c:8774:: with SMTP id 49mr94879794qvi.223.1564759959248;
        Fri, 02 Aug 2019 08:32:39 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z12sm30605271qkf.20.2019.08.02.08.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 08:32:38 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     will@kernel.org, catalin.marinas@arm.com
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] arm64/cache: fix -Woverride-init compiler warnings
Date:   Fri,  2 Aug 2019 11:32:24 -0400
Message-Id: <1564759944-2197-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 155433cb365e ("arm64: cache: Remove support for ASID-tagged
VIVT I-caches") introduced some compiation warnings from GCC,

arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field
overwritten [-Woverride-init]
  [ICACHE_POLICY_VIPT]  = "VIPT",
                          ^~~~~~
arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for
'icache_policy_str[2]')
arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field
overwritten [-Woverride-init]
  [ICACHE_POLICY_PIPT]  = "PIPT",
                          ^~~~~~
arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for
'icache_policy_str[3]')
arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field
overwritten [-Woverride-init]
  [ICACHE_POLICY_VPIPT]  = "VPIPT",
                           ^~~~~~~
arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for
'icache_policy_str[0]')

because it initializes icache_policy_str[0 ... 3] twice.

Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/kernel/cpuinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 876055e37352..193b38da8d96 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -34,10 +34,10 @@
 static struct cpuinfo_arm64 boot_cpu_data;
 
 static char *icache_policy_str[] = {
-	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
+	[ICACHE_POLICY_VPIPT]		= "VPIPT",
+	[ICACHE_POLICY_VPIPT + 1]	= "RESERVED/UNKNOWN",
 	[ICACHE_POLICY_VIPT]		= "VIPT",
 	[ICACHE_POLICY_PIPT]		= "PIPT",
-	[ICACHE_POLICY_VPIPT]		= "VPIPT",
 };
 
 unsigned long __icache_flags;
-- 
1.8.3.1

