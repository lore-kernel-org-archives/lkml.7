Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EDFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6C5214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="QAjrYxx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfHFTfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:35:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44376 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFTfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:35:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id 44so54750567qtg.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 12:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZC9qslcCrd9LAJb+xVAgGZabPCxU3+95aq+tE0LEHpk=;
        b=QAjrYxx3+yXc9YPNpegH6ocJSiZIrPEtvnv6d6NXuo/9Y8gtp+C+UL2IOwCDH5MjLD
         adXdIMjWu8sb9nreDpOwEsMd5LTRzLHtE8iqUicZytIdje5R2VuPAvQ9skkp8Ukbgcaj
         2YOwbd5xaEDbEIEWP+j/B8a55rV5mchMVTHV+NWwM0JFy+N+0ubrf1SOc+mz98IqAOPZ
         ZxsEZsMdqyZ0tkZiwUfnfHjO9VNcpMaWaCpuJMBGLRuu8OxXuxMaT6hPJcfBpxbZu0GP
         GHMlCWYHzjYcb0YC8QNdhfzJEKVZ+rLAcrjFUaoxZqj4dxjbGEpBldrf5KBLaU6zwJs0
         WQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZC9qslcCrd9LAJb+xVAgGZabPCxU3+95aq+tE0LEHpk=;
        b=SSNt9H7jcW1Rp2sIkOoOlvvxV9L+Q0OwFyntPjHkxvkg2iadu6T6aX/3SccQWV3ghe
         gMJfkqs/wFevHSboLZUjuB4s4hEj3qxUX1TodfktgGRNpSFmEsIFxqb9qRqLLKCBUdIk
         rJB74It+VuS/bPWd7KhWI6Ylpe5ffGdlFU8YGjyAI2Ym1wI8Ps2MvgYDdcLvFKnwRp6S
         oZvDD8mDevFHj+WBxCCBBLrH5IuWVTyiB1fTNmJDkoAk0/1V+EUj2QZ5u2B33R/yCrEo
         ZnpFPp5heisht5o+5m6RBEItXAk9Ses3dMWu3CEVGS8um6QUSsgbHoHv0TyTJsptr6Y+
         popQ==
X-Gm-Message-State: APjAAAX85FmTntidE03ETUqhfITUlJ3ryIO93dEcSsGa75BXaVE4Jkvj
        c+ThruvDt0NxJMhFAIElWZEpkg==
X-Google-Smtp-Source: APXvYqxqbqCvos8lzUfbDdxAGlCp4GIVPMNYbOWFZ6RCFiUoRpZ6EHfOicvxWp4f8jQiZ1hGTTji2Q==
X-Received: by 2002:ac8:4a9a:: with SMTP id l26mr4622738qtq.67.1565120111113;
        Tue, 06 Aug 2019 12:35:11 -0700 (PDT)
Received: from ovpn-123-215.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q56sm45073004qtq.64.2019.08.06.12.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 12:35:10 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     will@kernel.org, catalin.marinas@arm.com
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] arm64/cache: fix -Woverride-init compiler warnings
Date:   Tue,  6 Aug 2019 15:34:34 -0400
Message-Id: <20190806193434.965-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 155433cb365e ("arm64: cache: Remove support for ASID-tagged
VIVT I-caches") introduced some compiation warnings from GCC (and
Clang),

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

because it initializes icache_policy_str[0 ... 3] twice. Since the array
is only used in cpuinfo_detect_icache_policy(), fix it by initializing
a specific field there just before using.

Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Initialize a specific field in cpuinfo_detect_icache_policy().

 arch/arm64/kernel/cpuinfo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 876055e37352..a0c495a3f4fd 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -34,10 +34,7 @@ DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
 static struct cpuinfo_arm64 boot_cpu_data;
 
 static char *icache_policy_str[] = {
-	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
-	[ICACHE_POLICY_VIPT]		= "VIPT",
-	[ICACHE_POLICY_PIPT]		= "PIPT",
-	[ICACHE_POLICY_VPIPT]		= "VPIPT",
+	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN"
 };
 
 unsigned long __icache_flags;
@@ -310,13 +307,16 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 
 	switch (l1ip) {
 	case ICACHE_POLICY_PIPT:
+		icache_policy_str[ICACHE_POLICY_PIPT] = "PIPT";
 		break;
 	case ICACHE_POLICY_VPIPT:
+		icache_policy_str[ICACHE_POLICY_VPIPT] = "VPIPT";
 		set_bit(ICACHEF_VPIPT, &__icache_flags);
 		break;
 	default:
 		/* Fallthrough */
 	case ICACHE_POLICY_VIPT:
+		icache_policy_str[ICACHE_POLICY_VIPT] = "VIPT";
 		/* Assume aliasing */
 		set_bit(ICACHEF_ALIASING, &__icache_flags);
 	}
-- 
2.20.1 (Apple Git-117)

