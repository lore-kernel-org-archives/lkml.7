Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D766C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 03:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D560D21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 03:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TZQYSYwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfEWD6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 23:58:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfEWD6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 23:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aDbPF9xZkOXagZBfL9B86UzehHLgcKweWKApD3cNhgw=; b=TZQYSYwFFkRnA3tn3Kgv68bUY
        phomhkujcgbsK/ybnpYmJnH1dX9cpjYhNmaDAKqRZpRXa8C2xRsFx97c0UyAJm4E2etVVysjNaoWs
        FproNuhyat+3Skkm0BGgkbgI+kTX1gTkIRunxQx6o0nkpMAc4ojEMPDaEMO4x8pEt9oliF97HkQ6o
        lbGFFrU+XnkaM6HbvjpsfP7z3Osecy6Uy1zhznQZF2zJIt2eoZ1MfbyuikhuMhCrBxwfAVo0Lnjfu
        qZsqFsiY9ZbX2mR2IwfRMkJvtCSxDOEbcOVXyJD5SsEwOSFUK//erX62YYLVhqk+PmaijSSuOerXr
        rna1j3v9Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTesU-00058P-CB; Thu, 23 May 2019 03:58:50 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: sound/soc/intel/boards: limit some drivers to X86 since
 headers are only in arch/x86/
Message-ID: <46dc0767-bb21-2b98-90f2-34dd4bcad7c0@infradead.org>
Date:   Wed, 22 May 2019 20:58:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Several drivers in sound/soc/intel/boards/ #include header files
that only exist in arch/x86/include/asm.  This causes build errors,
so make these drivers depend on X86.

Fixes these build errors (on ia64):

../sound/soc/intel/boards/bxt_da7219_max98357a.c:19:10: fatal error: asm/cpu_device_id.h: No such file or directory
 #include <asm/cpu_device_id.h>
../sound/soc/intel/boards/bytcr_rt5640.c:31:10: fatal error: asm/cpu_device_id.h: No such file or directory
 #include <asm/cpu_device_id.h>
../sound/soc/intel/boards/bytcr_rt5651.c:33:10: fatal error: asm/cpu_device_id.h: No such file or directory
 #include <asm/cpu_device_id.h>
../sound/soc/intel/boards/cht_bsw_rt5645.c:29:10: fatal error: asm/cpu_device_id.h: No such file or directory
 #include <asm/cpu_device_id.h>
../sound/soc/intel/boards/bytcht_es8316.c:33:10: fatal error: asm/cpu_device_id.h: No such file or directory
 #include <asm/cpu_device_id.h>
../sound/soc/intel/boards/bytcht_da7213.c:26:10: fatal error: asm/platform_sst_audio.h: No such file or directory
 #include <asm/platform_sst_audio.h>

And more drivers determined by:
> grep "include.*asm.cpu_device_id.h" *.c
bxt_da7219_max98357a.c:#include <asm/cpu_device_id.h>
bytcht_es8316.c:#include <asm/cpu_device_id.h>
bytcr_rt5640.c:#include <asm/cpu_device_id.h>
bytcr_rt5651.c:#include <asm/cpu_device_id.h>
cht_bsw_rt5645.c:#include <asm/cpu_device_id.h>
sof_rt5682.c:#include <asm/cpu_device_id.h>
  and
> grep "include.*asm.platform_sst_audio.h" *.c
bytcht_da7213.c:#include <asm/platform_sst_audio.h>
bytcht_es8316.c:#include <asm/platform_sst_audio.h>

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/intel/boards/Kconfig |    6 ++++++
 1 file changed, 6 insertions(+)

--- lnx-52-rc1.orig/sound/soc/intel/boards/Kconfig
+++ lnx-52-rc1/sound/soc/intel/boards/Kconfig
@@ -87,6 +87,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
 	tristate "Baytrail and Baytrail-CR with RT5640 codec"
 	depends on I2C && ACPI
 	depends on X86_INTEL_LPSS || COMPILE_TEST
+	depends on X86
 	select SND_SOC_ACPI
 	select SND_SOC_RT5640
 	help
@@ -99,6 +100,7 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
 	tristate "Baytrail and Baytrail-CR with RT5651 codec"
 	depends on I2C && ACPI
 	depends on X86_INTEL_LPSS || COMPILE_TEST
+	depends on X86
 	select SND_SOC_ACPI
 	select SND_SOC_RT5651
 	help
@@ -123,6 +125,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "Cherrytrail & Braswell with RT5645/5650 codec"
 	depends on I2C && ACPI
 	depends on X86_INTEL_LPSS || COMPILE_TEST
+	depends on X86
 	select SND_SOC_ACPI
 	select SND_SOC_RT5645
 	help
@@ -159,6 +162,7 @@ config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 	tristate "Baytrail & Cherrytrail with DA7212/7213 codec"
 	depends on I2C && ACPI
 	depends on X86_INTEL_LPSS || COMPILE_TEST
+	depends on X86
 	select SND_SOC_ACPI
 	select SND_SOC_DA7213
 	help
@@ -171,6 +175,7 @@ config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 	tristate "Baytrail & Cherrytrail with ES8316 codec"
 	depends on I2C && ACPI
 	depends on X86_INTEL_LPSS || COMPILE_TEST
+	depends on X86
 	select SND_SOC_ACPI
 	select SND_SOC_ES8316
 	help
@@ -249,6 +254,7 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357
 	tristate "Broxton with DA7219 and MAX98357A in I2S Mode"
 	depends on I2C && ACPI
 	depends on MFD_INTEL_LPSS || COMPILE_TEST
+	depends on X86
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC


