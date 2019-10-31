Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2961BCA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 21:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E085D216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 21:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FanvcEmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfJaVsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 17:48:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40184 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbfJaVsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 17:48:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id o28so7855606wro.7;
        Thu, 31 Oct 2019 14:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ve3LOHXOaREWp3o88DTnyild24rHhjfRfeBuPC+5t3M=;
        b=FanvcEmIjrpvEib4DeOjMcywQ5YoiPsMt2E1MaRu2j5P+pjb0QURqOoKhFzdA1cT8g
         PVQloZnh3ZYYocdAP4KNIYrmIbrz9E1skM8eN6QlWTaLqXz6oHOlC25WVZxIGt9yDhjh
         a+qXdZSXTLbsGQf8VpUnGpfs06hwzXWN3rOH/hXSkhOOunpFMvfhmvJj/WpoiLxaqdN8
         4+1LgclolGv9sfw9NXnwEk15FNjpJOdZ3adry5aTk3py2ffdCLGwRb50OJ3mds2kDDB1
         ouNA8Q1nvjaBCBYchlNlhzRCmgeJftAwDCoVBkuNRBIzfcTxcucMjC2gGsx0DIMk7ySV
         RAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ve3LOHXOaREWp3o88DTnyild24rHhjfRfeBuPC+5t3M=;
        b=fEXGqLY+n3AyYzx/L86ADr6A627G94M48G6W4gnS1ln4nwrzMh3cEpfA95CdZhGuYy
         Kth19+q+CZBVRTJvMv9avnnYEs4mAYAuUIiE+/hzGVEiqHJXrlCNeO/DFD1VLn+tp9jA
         Wk4PGQKHYb3UocvJFDC2kI5//oo5C1v11ozlXIazYT6JxgISp+SaBRwnwh9Ob9A7zcD5
         MNWVEmQQNz4SQWIjO6JE0HXhXNoJtQAx7/P23dSM81CtAMW8OmmFUeov93/pUAgpvXok
         E2CUypQM+y4wgHWyPp+KuuhrwtSoQY+WPLhNEsquMDX3p49xlBIMa40MkCUq0yoNfQQh
         hrHg==
X-Gm-Message-State: APjAAAW+8IE2gjFRF+KgmLMh4pjlwQaVJVdWmEesiDCAwef7/D95eI6p
        ixTcLG0H7B0HwZE5P+hdpm4=
X-Google-Smtp-Source: APXvYqyc891iyQP05RQpakGQc/2QDPOJzJ1GroEpUNgMx+loVXIWeZMG7nVgs2+XEYEzGuKeYzi/Cw==
X-Received: by 2002:a5d:5288:: with SMTP id c8mr708420wrv.1.1572558500533;
        Thu, 31 Oct 2019 14:48:20 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g184sm5813674wma.8.2019.10.31.14.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 14:48:19 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hanjun Guo <guohanjun@huawei.com>, Qian Cai <cai@lca.pw>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        Marc Zyngier <maz@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] arm64: apply ARM64_ERRATUM_845719 workaround for Brahma-B53 core
Date:   Thu, 31 Oct 2019 14:47:23 -0700
Message-Id: <20191031214725.1491-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031214725.1491-1-f.fainelli@gmail.com>
References: <20191031214725.1491-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

The Broadcom Brahma-B53 core is susceptible to the issue described by
ARM64_ERRATUM_845719 so this commit enables the workaround to be applied
when executing on that core.

Since there are now multiple entries to match, we must convert the
existing ARM64_ERRATUM_845719 into an erratum list.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/arm64/silicon-errata.rst |  3 +++
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/kernel/cpu_errata.c         | 13 +++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index ab7ed2fd072f..57757c73ead1 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -91,6 +91,9 @@ stable kernels.
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
+| Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
++----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX ITS    | #22375,24313    | CAVIUM_ERRATUM_22375        |
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX ITS    | #23144          | CAVIUM_ERRATUM_23144        |
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index b1454d117cd2..aca07c2f6e6e 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -79,6 +79,7 @@
 #define CAVIUM_CPU_PART_THUNDERX_83XX	0x0A3
 #define CAVIUM_CPU_PART_THUNDERX2	0x0AF
 
+#define BRCM_CPU_PART_BRAHMA_B53	0x100
 #define BRCM_CPU_PART_VULCAN		0x516
 
 #define QCOM_CPU_PART_FALKOR_V1		0x800
@@ -105,6 +106,7 @@
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
 #define MIDR_CAVIUM_THUNDERX2 MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX2)
+#define MIDR_BRAHMA_B53 MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_BRAHMA_B53)
 #define MIDR_BRCM_VULCAN MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_VULCAN)
 #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
 #define MIDR_QCOM_FALKOR MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 6c3b10a41bd8..c065dd48d661 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -737,6 +737,16 @@ static const struct midr_range erratum_1418040_list[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_ERRATUM_845719
+static const struct midr_range erratum_845719_list[] = {
+	/* Cortex-A53 r0p[01234] */
+	MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 4),
+	/* Brahma-B53 r0p[0] */
+	MIDR_REV(MIDR_BRAHMA_B53, 0, 0),
+	{},
+};
+#endif
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -777,10 +787,9 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_845719
 	{
-	/* Cortex-A53 r0p[01234] */
 		.desc = "ARM erratum 845719",
 		.capability = ARM64_WORKAROUND_845719,
-		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 4),
+		ERRATA_MIDR_RANGE_LIST(erratum_845719_list),
 	},
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_23154
-- 
2.17.1

