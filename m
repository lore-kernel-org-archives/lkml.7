Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0FFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E17F2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RaqFqpAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfCWVTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:19:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32880 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfCWVQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:16:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so6018692wrp.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AvtBLsKLNWu+ywafXMmRrKND7dTDO57aIqV2ZZB2CJo=;
        b=RaqFqpAjJFXotCIJxIaPFncshGS4+OlCbgDuvpBwl/83SgYPH1R2YGALChAWnqrPEo
         oOO7R2EPeBrHL0+20piwWqcA7vzGgoaJJZtch0M1cn9d/fVgMCJWjQ9d9MwXvaGjGbmU
         +ugzEEsnzDExtV21sovtKGIjJSaPjrkUpJyK7z9bn803UHdd7h6HCrR52gj0F6mMeZNX
         nIC8zDrcEd6g+R5huFvGKdjR/87/WpKUJLt/E/Mrk+cG/uLezCHBXRxWCTsYbdPGPZZZ
         AHseMpJmlrEnyyB65c39wiucf3aT8FfJRleTEkMl5Q3F3DP1n75FhrCX9pbVJVGjLATV
         nqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AvtBLsKLNWu+ywafXMmRrKND7dTDO57aIqV2ZZB2CJo=;
        b=YEmf4czKFClAlPlBvZCz7hf++Z2uz8Zish1owZOGZpPEE5/f+Uz9JH0f+XGOvURjI4
         es0pnZ3NugfogcCDw6f4RLqrIhd+GCwSs9OBfX5XXLasR4aVovsgB92Cnc/8dZ44DRG6
         TeWXoMb/P7iXI/8CeKPEGpy2Xd4eZW7WBil0fT7knJ6jES1I1sLkNwzUKJPlRMxGM9y6
         BbZ3yFZjib0TmNmevBO3YXsED36V7zYDdDIihfWmkGIur4MDNATbIzT8NDq4ttDSA0HT
         5FYJg8LOJPucRdhAM4RcIgj8XH9qN3Shw4NXTMFOpfCxBrMSdpBQvGPVSCihl6kCp5m6
         HlKg==
X-Gm-Message-State: APjAAAU72FMoIPZR2AsszQhigUffCg/ndNfbiY6IwYzpXr9t1/3p9qld
        xQKywADXbCIQENwrSXfxHj7IDA==
X-Google-Smtp-Source: APXvYqxjNWHypi6LC8z9SnG/Nr8nHpXvSSjdOYVbtPSjKY6HqjTWRaJLnc0sGtL7JiGUp+gGSozcgQ==
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr11109206wrj.118.1553375809110;
        Sat, 23 Mar 2019 14:16:49 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:16:48 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 05/24] soc: mediatek: pwrap: add support for MT8516 pwrap
Date:   Sat, 23 Mar 2019 22:15:53 +0100
Message-Id: <20190323211612.860-6-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the code to support the pwrap IP on the MediaTek MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 106 +++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index b3ba2301f569..73f0be0567bd 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -381,6 +381,10 @@ enum pwrap_regs {
 	PWRAP_EXT_GPS_AUXADC_RDATA_ADDR,
 	PWRAP_GPSINF_0_STA,
 	PWRAP_GPSINF_1_STA,
+
+	/* MT8516 only regs */
+	PWRAP_OP_TYPE,
+	PWRAP_MSB_FIRST,
 };
 
 static int mt2701_regs[] = {
@@ -852,6 +856,91 @@ static int mt8183_regs[] = {
 	[PWRAP_WACS2_VLDCLR] =			0xC28,
 };
 
+static int mt8516_regs[] = {
+	[PWRAP_MUX_SEL] =		0x0,
+	[PWRAP_WRAP_EN] =		0x4,
+	[PWRAP_DIO_EN] =		0x8,
+	[PWRAP_SIDLY] =			0xc,
+	[PWRAP_RDDMY] =			0x10,
+	[PWRAP_SI_CK_CON] =		0x14,
+	[PWRAP_CSHEXT_WRITE] =		0x18,
+	[PWRAP_CSHEXT_READ] =		0x1c,
+	[PWRAP_CSLEXT_START] =		0x20,
+	[PWRAP_CSLEXT_END] =		0x24,
+	[PWRAP_STAUPD_PRD] =		0x28,
+	[PWRAP_STAUPD_GRPEN] =		0x2c,
+	[PWRAP_STAUPD_MAN_TRIG] =	0x40,
+	[PWRAP_STAUPD_STA] =		0x44,
+	[PWRAP_WRAP_STA] =		0x48,
+	[PWRAP_HARB_INIT] =		0x4c,
+	[PWRAP_HARB_HPRIO] =		0x50,
+	[PWRAP_HIPRIO_ARB_EN] =		0x54,
+	[PWRAP_HARB_STA0] =		0x58,
+	[PWRAP_HARB_STA1] =		0x5c,
+	[PWRAP_MAN_EN] =		0x60,
+	[PWRAP_MAN_CMD] =		0x64,
+	[PWRAP_MAN_RDATA] =		0x68,
+	[PWRAP_MAN_VLDCLR] =		0x6c,
+	[PWRAP_WACS0_EN] =		0x70,
+	[PWRAP_INIT_DONE0] =		0x74,
+	[PWRAP_WACS0_CMD] =		0x78,
+	[PWRAP_WACS0_RDATA] =		0x7c,
+	[PWRAP_WACS0_VLDCLR] =		0x80,
+	[PWRAP_WACS1_EN] =		0x84,
+	[PWRAP_INIT_DONE1] =		0x88,
+	[PWRAP_WACS1_CMD] =		0x8c,
+	[PWRAP_WACS1_RDATA] =		0x90,
+	[PWRAP_WACS1_VLDCLR] =		0x94,
+	[PWRAP_WACS2_EN] =		0x98,
+	[PWRAP_INIT_DONE2] =		0x9c,
+	[PWRAP_WACS2_CMD] =		0xa0,
+	[PWRAP_WACS2_RDATA] =		0xa4,
+	[PWRAP_WACS2_VLDCLR] =		0xa8,
+	[PWRAP_INT_EN] =		0xac,
+	[PWRAP_INT_FLG_RAW] =		0xb0,
+	[PWRAP_INT_FLG] =		0xb4,
+	[PWRAP_INT_CLR] =		0xb8,
+	[PWRAP_SIG_ADR] =		0xbc,
+	[PWRAP_SIG_MODE] =		0xc0,
+	[PWRAP_SIG_VALUE] =		0xc4,
+	[PWRAP_SIG_ERRVAL] =		0xc8,
+	[PWRAP_CRC_EN] =		0xcc,
+	[PWRAP_TIMER_EN] =		0xd0,
+	[PWRAP_TIMER_STA] =		0xd4,
+	[PWRAP_WDT_UNIT] =		0xd8,
+	[PWRAP_WDT_SRC_EN] =		0xdc,
+	[PWRAP_WDT_FLG] =		0xe0,
+	[PWRAP_DEBUG_INT_SEL] =		0xe4,
+	[PWRAP_DVFS_ADR0] =		0xe8,
+	[PWRAP_DVFS_WDATA0] =		0xec,
+	[PWRAP_DVFS_ADR1] =		0xf0,
+	[PWRAP_DVFS_WDATA1] =		0xf4,
+	[PWRAP_DVFS_ADR2] =		0xf8,
+	[PWRAP_DVFS_WDATA2] =		0xfc,
+	[PWRAP_DVFS_ADR3] =		0x100,
+	[PWRAP_DVFS_WDATA3] =		0x104,
+	[PWRAP_DVFS_ADR4] =		0x108,
+	[PWRAP_DVFS_WDATA4] =		0x10c,
+	[PWRAP_DVFS_ADR5] =		0x110,
+	[PWRAP_DVFS_WDATA5] =		0x114,
+	[PWRAP_DVFS_ADR6] =		0x118,
+	[PWRAP_DVFS_WDATA6] =		0x11c,
+	[PWRAP_DVFS_ADR7] =		0x120,
+	[PWRAP_DVFS_WDATA7] =		0x124,
+	[PWRAP_SPMINF_STA] =		0x128,
+	[PWRAP_CIPHER_KEY_SEL] =	0x12c,
+	[PWRAP_CIPHER_IV_SEL] =		0x130,
+	[PWRAP_CIPHER_EN] =		0x134,
+	[PWRAP_CIPHER_RDY] =		0x138,
+	[PWRAP_CIPHER_MODE] =		0x13c,
+	[PWRAP_CIPHER_SWRST] =		0x140,
+	[PWRAP_DCM_EN] =		0x144,
+	[PWRAP_DCM_DBC_PRD] =		0x148,
+	[PWRAP_SW_RST] =		0x168,
+	[PWRAP_OP_TYPE] =		0x16c,
+	[PWRAP_MSB_FIRST] =		0x170,
+};
+
 enum pmic_type {
 	PMIC_MT6323,
 	PMIC_MT6351,
@@ -869,6 +958,7 @@ enum pwrap_type {
 	PWRAP_MT8135,
 	PWRAP_MT8173,
 	PWRAP_MT8183,
+	PWRAP_MT8516,
 };
 
 struct pmic_wrapper;
@@ -1297,6 +1387,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	case PWRAP_MT6765:
 	case PWRAP_MT6797:
 	case PWRAP_MT8173:
+	case PWRAP_MT8516:
 		pwrap_writel(wrp, 1, PWRAP_CIPHER_EN);
 		break;
 	case PWRAP_MT7622:
@@ -1765,6 +1856,18 @@ static const struct pmic_wrapper_type pwrap_mt8183 = {
 	.init_soc_specific = pwrap_mt8183_init_soc_specific,
 };
 
+static struct pmic_wrapper_type pwrap_mt8516 = {
+	.regs = mt8516_regs,
+	.type = PWRAP_MT8516,
+	.arb_en_all = 0xff,
+	.int_en_all = ~(u32)(BIT(31) | BIT(2)),
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_DCM,
+	.init_reg_clock = pwrap_mt2701_init_reg_clock,
+	.init_soc_specific = NULL,
+};
+
 static const struct of_device_id of_pwrap_match_tbl[] = {
 	{
 		.compatible = "mediatek,mt2701-pwrap",
@@ -1787,6 +1890,9 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt8183-pwrap",
 		.data = &pwrap_mt8183,
+	}, {
+		.compatible = "mediatek,mt8516-pwrap",
+		.data = &pwrap_mt8516,
 	}, {
 		/* sentinel */
 	}
-- 
2.20.1

