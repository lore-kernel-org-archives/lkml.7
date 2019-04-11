Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70147C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340F22146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUMhu51h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfDKWNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:13:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44553 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfDKWNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:13:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so6965605ljg.11;
        Thu, 11 Apr 2019 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PuqdMQcdT7qoJfmyecxFJAj7wtojxP/MdnUIpgVZLmY=;
        b=JUMhu51hDB1tiJAkww1RbJMUIzZsmPmQoX25956wwjZaVi4g6V7fpx2hWco7X4uqjp
         ZXNE/LX0QDg6URJ8ZSkY1hkjHUt45gbw/8ZJyC0Jz9O56x+xOiP/mDwudN7Qwm/5fyAS
         uU3HYJ7FxCLmEHUpgHt9Z9CTRjec2jeQ95ocXHwknaAGyI0G+oGdAUEiAExWO6MXK9Wy
         E7Sd+KUSqtm+BTzXaEQsgnkmUPaepDSbu+lZ1R+d0yAmHc3btvMzYq1MszRvpClGS6+Q
         8D+SfHQf9qeaGOmiqVZevMuGjwdP3mpSkT044WHKQ6kobazxUlfuOZrQHh9w/rYXUCSq
         voqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PuqdMQcdT7qoJfmyecxFJAj7wtojxP/MdnUIpgVZLmY=;
        b=KBRIzch/7v+kuV0b2VdjeKKcs5cg//D9NwkC4FEFws7zjyRYQyRb+JsvVNEvqKJhB7
         cjKYGGm3hmhHbSqFO2nPsyRUE2f/Q82Z4+6KFYyfitqUyyxHAo+1xbZAhV7Yrw6UpKK9
         ID5wjP8lYAqcvED250ObtQRLuw5zTMdBs7dbd1Xg+yXL5Wtgt6GNJQqKtidvFc2S6FAO
         Br+1L2tda58VmG8oBcMgy2EjwDAb4Q6PHNkIM9BfwrdpTBhzW1C3BoX50g9MsVro7r9L
         mFycr3nd7Qqh/EiNGX23hNop2fS6aWu/F8atmRf1xXKTjCBWJGWDaeruaQp4rxpoq448
         awPw==
X-Gm-Message-State: APjAAAXbBL48RMMVbrtpnK6QFS2emHS3y1BrjIlh0szbVWy6fTLwwWiO
        K3jEA8Br+M2jsyU4yUhxqK8=
X-Google-Smtp-Source: APXvYqzy69paz5m6C/fo/lwYhIhBQbRxPK2iBocS4xt5LRs0cJK09jSkMD9AgIeKv3oIDH8K8dy4wg==
X-Received: by 2002:a2e:8ece:: with SMTP id e14mr11697847ljl.66.1555020812259;
        Thu, 11 Apr 2019 15:13:32 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id f4sm7953526ljg.37.2019.04.11.15.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:13:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] Revert "ARM: tegra: Restore memory arbitration on resume from LP1 on Tegra30+"
Date:   Fri, 12 Apr 2019 01:12:50 +0300
Message-Id: <20190411221250.23233-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411221250.23233-1-digetx@gmail.com>
References: <20190411221250.23233-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turned out that the actual bug was in the Memory Controller driver
that programmed shadowed registers without latching the new values
and then there was a bug on EMEM arbitration configuration calculation
that results in a wrong value being latched on resume from suspend.
The Memory Controller has been fixed properly now, hence the workaround
patch could be reverted safely.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/iomap.h         |  9 ---------
 arch/arm/mach-tegra/sleep-tegra30.S | 21 ---------------------
 2 files changed, 30 deletions(-)

diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
index 4af9e92a216f..ba61db7fe533 100644
--- a/arch/arm/mach-tegra/iomap.h
+++ b/arch/arm/mach-tegra/iomap.h
@@ -79,24 +79,15 @@
 #define TEGRA_PMC_BASE			0x7000E400
 #define TEGRA_PMC_SIZE			SZ_256
 
-#define TEGRA_MC_BASE			0x7000F000
-#define TEGRA_MC_SIZE			SZ_1K
-
 #define TEGRA_EMC_BASE			0x7000F400
 #define TEGRA_EMC_SIZE			SZ_1K
 
-#define TEGRA114_MC_BASE		0x70019000
-#define TEGRA114_MC_SIZE		SZ_4K
-
 #define TEGRA_EMC0_BASE			0x7001A000
 #define TEGRA_EMC0_SIZE			SZ_2K
 
 #define TEGRA_EMC1_BASE			0x7001A800
 #define TEGRA_EMC1_SIZE			SZ_2K
 
-#define TEGRA124_MC_BASE		0x70019000
-#define TEGRA124_MC_SIZE		SZ_4K
-
 #define TEGRA124_EMC_BASE		0x7001B000
 #define TEGRA124_EMC_SIZE		SZ_2K
 
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index d0b4c486ddbf..7727e005c30e 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -44,8 +44,6 @@
 #define EMC_XM2VTTGENPADCTRL		0x310
 #define EMC_XM2VTTGENPADCTRL2		0x314
 
-#define MC_EMEM_ARB_CFG			0x90
-
 #define PMC_CTRL			0x0
 #define PMC_CTRL_SIDE_EFFECT_LP0 (1 << 14) /* enter LP0 when CPU pwr gated */
 
@@ -420,22 +418,6 @@ _pll_m_c_x_done:
 	movweq	r0, #:lower16:TEGRA124_EMC_BASE
 	movteq	r0, #:upper16:TEGRA124_EMC_BASE
 
-	cmp	r10, #TEGRA30
-	moveq	r2, #0x20
-	movweq	r4, #:lower16:TEGRA_MC_BASE
-	movteq	r4, #:upper16:TEGRA_MC_BASE
-	cmp	r10, #TEGRA114
-	moveq	r2, #0x34
-	movweq	r4, #:lower16:TEGRA114_MC_BASE
-	movteq	r4, #:upper16:TEGRA114_MC_BASE
-	cmp	r10, #TEGRA124
-	moveq	r2, #0x20
-	movweq	r4, #:lower16:TEGRA124_MC_BASE
-	movteq	r4, #:upper16:TEGRA124_MC_BASE
-
-	ldr	r1, [r5, r2]		@ restore MC_EMEM_ARB_CFG
-	str	r1, [r4, #MC_EMEM_ARB_CFG]
-
 exit_self_refresh:
 	ldr	r1, [r5, #0xC]		@ restore EMC_XM2VTTGENPADCTRL
 	str	r1, [r0, #EMC_XM2VTTGENPADCTRL]
@@ -564,7 +546,6 @@ tegra30_sdram_pad_address:
 	.word	TEGRA_PMC_BASE + PMC_IO_DPD_STATUS			@0x14
 	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_CLK_SOURCE_MSELECT	@0x18
 	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_SCLK_BURST		@0x1c
-	.word	TEGRA_MC_BASE + MC_EMEM_ARB_CFG				@0x20
 tegra30_sdram_pad_address_end:
 
 tegra114_sdram_pad_address:
@@ -581,7 +562,6 @@ tegra114_sdram_pad_address:
 	.word	TEGRA_EMC1_BASE + EMC_AUTO_CAL_INTERVAL			@0x28
 	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL			@0x2c
 	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL2			@0x30
-	.word	TEGRA114_MC_BASE + MC_EMEM_ARB_CFG			@0x34
 tegra114_sdram_pad_adress_end:
 
 tegra124_sdram_pad_address:
@@ -593,7 +573,6 @@ tegra124_sdram_pad_address:
 	.word	TEGRA_PMC_BASE + PMC_IO_DPD_STATUS			@0x14
 	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_CLK_SOURCE_MSELECT	@0x18
 	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_SCLK_BURST		@0x1c
-	.word	TEGRA124_MC_BASE + MC_EMEM_ARB_CFG			@0x20
 tegra124_sdram_pad_address_end:
 
 tegra30_sdram_pad_size:
-- 
2.21.0

