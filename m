Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BBFCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44002087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDjaYRz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfJ2TRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:17:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39490 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2TRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:17:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id g19so183240wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lypg9C4ry4DPd4ImOzQhAGtmZAf1Ysh6wu62GTtQEkQ=;
        b=dDjaYRz7Ny2C0svhKXBGm/aXJSNM5l55D8Mofm8aLwCat9G/GlebWTuYPy6lGRWQR+
         RCnLg2bsaKl7wILCPxgLS818zlTieKrNbPSrXSlQJQx9DfQsaT/CS9GhXn3TAZmrYQMp
         C3gou8znUyeyR636z8FRCPuhzYmAcqbCGK07ohlqqT+0eaW2fq3z2W4/NxmZdyykc98x
         zmg6n0+nAq649JaTiUCqi2MsCbPlPWBnxl+JEPLnjDHFyK5pasY5uTp1cTc4ZnhwPTgE
         GQKiLkKSjqU0412o6shY3U2XFX5ap+wf7SI0hb4HuR6MB+JDeyXESQToFlf3I8v1/6Pn
         K40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lypg9C4ry4DPd4ImOzQhAGtmZAf1Ysh6wu62GTtQEkQ=;
        b=X1Kgfb8on8dxwruAmGzl6RZv51pf4Pc/YAMTLqKTMh1rzZtUFwwZcLx3D6R6vsicBR
         zijWGxF/Yc6oCK/py8DJJQA2+F1RX4mPwsz7A1zq45jMz45u+kCHAY18i3YeZZWwyJSm
         mltC+LP0xw4XeAumaQ8Ec4/tRiC83UVtY34XO5T6bMim7DKD63fAXlLrSeC3wnu0vKlZ
         WpLMr35C2L0TC0ZjRr7yKWBziMWSqtvVysEGIWiekMe4/2We1DhGjcnUxBMhx2ItWawY
         VKWbhBOYr6FSN6LtbHw1NLEkxYw42zGrAOaLu/lnsnKyr/epapRO4SCS9qA2S8sU1fRz
         EvFQ==
X-Gm-Message-State: APjAAAVqYzK5trM2l1uNSCffIN3oSU939Y8AT9jsWupSHEs76c5fMRF+
        upUpOABTDcxwlH3FAeF9+Ow=
X-Google-Smtp-Source: APXvYqz7tv8yAogXi5IzRNfj/AtWXiJGRh//k9cZU8b9Ujrkd3h/ZwCTCfSHqEXRvaIu5YrBFEjT4A==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr5192319wmf.37.1572376624942;
        Tue, 29 Oct 2019 12:17:04 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 16sm2373674wmj.48.2019.10.29.12.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 12:17:03 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        John Garry <john.garry@huawei.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@lca.pw>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: apply ARM64_ERRATUM_845719 workaround for Brahma-B53 core
Date:   Tue, 29 Oct 2019 12:16:19 -0700
Message-Id: <20191029191623.17839-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
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
 arch/arm64/include/asm/cputype.h |  2 ++
 arch/arm64/kernel/cpu_errata.c   | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

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

