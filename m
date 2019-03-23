Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AD3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561F821902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gNaS7397"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfCWVRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:17:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46741 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbfCWVRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:17:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id o1so5953248wrs.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BxLGh2CBvUvDWCammh6EkQByk3dPoOatfljaYW+ZP0=;
        b=gNaS7397qU31ju4RxcU/q7E9nw2pPdtZWBQuyzS+LD+nsd5+s86qsVRAd8Oh+CfGh8
         ce++ZQD4UyZoK6eCCg9sns66R5bj3kYbscg3svGRBqrlRC7PujX8R4dI4Ng7cULG7OJD
         ojPjvYSks+XqtXqnzxMxpcxvk3J19CFpIVOJAgD5ejHP+4cUFlSmO9yxGhHokMi/UMlP
         SOXA3O2d1vYgrVrkaE1NOW55pSsmwA6ziMC2GDlhRXHDTgs2uKnGTJsbm5txRR95c+2Y
         fqC1o8lwbk8JViM9sfGZJO8n7+wL+3ICtxjTOND0DYQcAJDfGgW2UUn5HXiT2wZBj/b8
         Dglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BxLGh2CBvUvDWCammh6EkQByk3dPoOatfljaYW+ZP0=;
        b=pA25i2nb5xwFjFvwXJSwxTKXHW1xBpmbuRJBGtr8g1HgLqpYdDZCbXUXw00K/XNcCd
         hJiQG0nEP+Lc8BCPI+IgwPUFsZOiWotz82V1PZQPT4a8Iq30Ze/i00QMgOtPFAXjTA1R
         nfd8yh0KlVgq6gUZtPjYFeimyeFpxJeuQUcAuRbWI6qF9DpJh/0qX4K14aKZ/XD5+0Vf
         +/OU/TPaXAQNmHN3bG/SmT1WKxFAUMNamYZXqKUDKt4HIs2Hy5MQ5SaRmR56h+KsOKrk
         AUdOghHjpvX1UABWQcNnhv72WFZuF7xJhZX9IlYQCdAvcP/jYG7sL9ME8AzZ75Ij1TUt
         5xkw==
X-Gm-Message-State: APjAAAVJKm++TkuaLpJBG6waNsAWvjLgktJQan1+wYYfe43FkmtHA/7F
        +sxKraMGWOHZxuTrhzmWo5Xqsw==
X-Google-Smtp-Source: APXvYqwhs1FyfevtTe63lt7BpKRON9B5vJszoIQLvb+d7ipntcHrgJys9lAGMbrWu6NgrP1xsIgbXw==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr6474233wrr.147.1553375826726;
        Sat, 23 Mar 2019 14:17:06 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:17:06 -0700 (PDT)
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
Subject: [PATCH 11/24] dt-bindings: mediatek: topckgen: add support for MT8516
Date:   Sat, 23 Mar 2019 22:15:59 +0100
Message-Id: <20190323211612.860-12-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of topckgen for MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../arm/mediatek/mediatek,topckgen.txt        |   1 +
 include/dt-bindings/clock/mt8516-clk.h        | 192 ++++++++++++++++++
 2 files changed, 193 insertions(+)
 create mode 100644 include/dt-bindings/clock/mt8516-clk.h

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index d160c2b4b6fe..0843d73a1282 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -14,6 +14,7 @@ Required Properties:
 	- "mediatek,mt7629-topckgen"
 	- "mediatek,mt8135-topckgen"
 	- "mediatek,mt8173-topckgen"
+	- "mediatek,mt8516-topckgen"
 - #clock-cells: Must be 1
 
 The topckgen controller uses the common clk binding from
diff --git a/include/dt-bindings/clock/mt8516-clk.h b/include/dt-bindings/clock/mt8516-clk.h
new file mode 100644
index 000000000000..8d44cb32efba
--- /dev/null
+++ b/include/dt-bindings/clock/mt8516-clk.h
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_MT8516_H
+#define _DT_BINDINGS_CLK_MT8516_H
+
+/* TOPCKGEN */
+
+#define CLK_TOP_CLK_NULL		0
+#define CLK_TOP_I2S_INFRA_BCK		1
+#define CLK_TOP_MEMPLL			2
+#define CLK_TOP_DMPLL			3
+#define CLK_TOP_MAINPLL_D2		4
+#define CLK_TOP_MAINPLL_D4		5
+#define CLK_TOP_MAINPLL_D8		6
+#define CLK_TOP_MAINPLL_D16		7
+#define CLK_TOP_MAINPLL_D11		8
+#define CLK_TOP_MAINPLL_D22		9
+#define CLK_TOP_MAINPLL_D3		10
+#define CLK_TOP_MAINPLL_D6		11
+#define CLK_TOP_MAINPLL_D12		12
+#define CLK_TOP_MAINPLL_D5		13
+#define CLK_TOP_MAINPLL_D10		14
+#define CLK_TOP_MAINPLL_D20		15
+#define CLK_TOP_MAINPLL_D40		16
+#define CLK_TOP_MAINPLL_D7		17
+#define CLK_TOP_MAINPLL_D14		18
+#define CLK_TOP_UNIVPLL_D2		19
+#define CLK_TOP_UNIVPLL_D4		20
+#define CLK_TOP_UNIVPLL_D8		21
+#define CLK_TOP_UNIVPLL_D16		22
+#define CLK_TOP_UNIVPLL_D3		23
+#define CLK_TOP_UNIVPLL_D6		24
+#define CLK_TOP_UNIVPLL_D12		25
+#define CLK_TOP_UNIVPLL_D24		26
+#define CLK_TOP_UNIVPLL_D5		27
+#define CLK_TOP_UNIVPLL_D20		28
+#define CLK_TOP_MMPLL380M		29
+#define CLK_TOP_MMPLL_D2		30
+#define CLK_TOP_MMPLL_200M		31
+#define CLK_TOP_USB_PHY48M		32
+#define CLK_TOP_APLL1			33
+#define CLK_TOP_APLL1_D2		34
+#define CLK_TOP_APLL1_D4		35
+#define CLK_TOP_APLL1_D8		36
+#define CLK_TOP_APLL2			37
+#define CLK_TOP_APLL2_D2		38
+#define CLK_TOP_APLL2_D4		39
+#define CLK_TOP_APLL2_D8		40
+#define CLK_TOP_CLK26M			41
+#define CLK_TOP_CLK26M_D2		42
+#define CLK_TOP_AHB_INFRA_D2		43
+#define CLK_TOP_NFI1X			44
+#define CLK_TOP_ETH_D2			45
+#define CLK_TOP_THEM			46
+#define CLK_TOP_APDMA			47
+#define CLK_TOP_I2C0			48
+#define CLK_TOP_I2C1			49
+#define CLK_TOP_AUXADC1			50
+#define CLK_TOP_NFI			51
+#define CLK_TOP_NFIECC			52
+#define CLK_TOP_DEBUGSYS		53
+#define CLK_TOP_PWM			54
+#define CLK_TOP_UART0			55
+#define CLK_TOP_UART1			56
+#define CLK_TOP_BTIF			57
+#define CLK_TOP_USB			58
+#define CLK_TOP_FLASHIF_26M		59
+#define CLK_TOP_AUXADC2			60
+#define CLK_TOP_I2C2			61
+#define CLK_TOP_MSDC0			62
+#define CLK_TOP_MSDC1			63
+#define CLK_TOP_NFI2X			64
+#define CLK_TOP_PMICWRAP_AP		65
+#define CLK_TOP_SEJ			66
+#define CLK_TOP_MEMSLP_DLYER		67
+#define CLK_TOP_SPI			68
+#define CLK_TOP_APXGPT			69
+#define CLK_TOP_AUDIO			70
+#define CLK_TOP_PMICWRAP_MD		71
+#define CLK_TOP_PMICWRAP_CONN		72
+#define CLK_TOP_PMICWRAP_26M		73
+#define CLK_TOP_AUX_ADC			74
+#define CLK_TOP_AUX_TP			75
+#define CLK_TOP_MSDC2			76
+#define CLK_TOP_RBIST			77
+#define CLK_TOP_NFI_BUS			78
+#define CLK_TOP_GCE			79
+#define CLK_TOP_TRNG			80
+#define CLK_TOP_SEJ_13M			81
+#define CLK_TOP_AES			82
+#define CLK_TOP_PWM_B			83
+#define CLK_TOP_PWM1_FB			84
+#define CLK_TOP_PWM2_FB			85
+#define CLK_TOP_PWM3_FB			86
+#define CLK_TOP_PWM4_FB			87
+#define CLK_TOP_PWM5_FB			88
+#define CLK_TOP_USB_1P			89
+#define CLK_TOP_FLASHIF_FREERUN		90
+#define CLK_TOP_66M_ETH			91
+#define CLK_TOP_133M_ETH		92
+#define CLK_TOP_FETH_25M		93
+#define CLK_TOP_FETH_50M		94
+#define CLK_TOP_FLASHIF_AXI		95
+#define CLK_TOP_USBIF			96
+#define CLK_TOP_UART2			97
+#define CLK_TOP_BSI			98
+#define CLK_TOP_RG_SPINOR		99
+#define CLK_TOP_RG_MSDC2		100
+#define CLK_TOP_RG_ETH			101
+#define CLK_TOP_RG_AUD1			102
+#define CLK_TOP_RG_AUD2			103
+#define CLK_TOP_RG_AUD_ENGEN1		104
+#define CLK_TOP_RG_AUD_ENGEN2		105
+#define CLK_TOP_RG_I2C			106
+#define CLK_TOP_RG_PWM_INFRA		107
+#define CLK_TOP_RG_AUD_SPDIF_IN		108
+#define CLK_TOP_RG_UART2		109
+#define CLK_TOP_RG_BSI			110
+#define CLK_TOP_RG_DBG_ATCLK		111
+#define CLK_TOP_RG_NFIECC		112
+#define CLK_TOP_RG_APLL1_D2_EN		113
+#define CLK_TOP_RG_APLL1_D4_EN		114
+#define CLK_TOP_RG_APLL1_D8_EN		115
+#define CLK_TOP_RG_APLL2_D2_EN		116
+#define CLK_TOP_RG_APLL2_D4_EN		117
+#define CLK_TOP_RG_APLL2_D8_EN		118
+#define CLK_TOP_APLL12_DIV0		119
+#define CLK_TOP_APLL12_DIV1		120
+#define CLK_TOP_APLL12_DIV2		121
+#define CLK_TOP_APLL12_DIV3		122
+#define CLK_TOP_APLL12_DIV4		123
+#define CLK_TOP_APLL12_DIV4B		124
+#define CLK_TOP_APLL12_DIV5		125
+#define CLK_TOP_APLL12_DIV5B		126
+#define CLK_TOP_APLL12_DIV6		127
+#define CLK_TOP_UART0_SEL		128
+#define CLK_TOP_EMI_DDRPHY_SEL		129
+#define CLK_TOP_AHB_INFRA_SEL		130
+#define CLK_TOP_MSDC0_SEL		131
+#define CLK_TOP_UART1_SEL		132
+#define CLK_TOP_MSDC1_SEL		133
+#define CLK_TOP_PMICSPI_SEL		134
+#define CLK_TOP_QAXI_AUD26M_SEL		135
+#define CLK_TOP_AUD_INTBUS_SEL		136
+#define CLK_TOP_NFI2X_PAD_SEL		137
+#define CLK_TOP_NFI1X_PAD_SEL		138
+#define CLK_TOP_DDRPHYCFG_SEL		139
+#define CLK_TOP_USB_78M_SEL		140
+#define CLK_TOP_SPINOR_SEL		141
+#define CLK_TOP_MSDC2_SEL		142
+#define CLK_TOP_ETH_SEL			143
+#define CLK_TOP_AUD1_SEL		144
+#define CLK_TOP_AUD2_SEL		145
+#define CLK_TOP_AUD_ENGEN1_SEL		146
+#define CLK_TOP_AUD_ENGEN2_SEL		147
+#define CLK_TOP_I2C_SEL			148
+#define CLK_TOP_AUD_I2S0_M_SEL		149
+#define CLK_TOP_AUD_I2S1_M_SEL		150
+#define CLK_TOP_AUD_I2S2_M_SEL		151
+#define CLK_TOP_AUD_I2S3_M_SEL		152
+#define CLK_TOP_AUD_I2S4_M_SEL		153
+#define CLK_TOP_AUD_I2S5_M_SEL		154
+#define CLK_TOP_AUD_SPDIF_B_SEL		155
+#define CLK_TOP_PWM_SEL			156
+#define CLK_TOP_SPI_SEL			157
+#define CLK_TOP_AUD_SPDIFIN_SEL		158
+#define CLK_TOP_UART2_SEL		159
+#define CLK_TOP_BSI_SEL			160
+#define CLK_TOP_DBG_ATCLK_SEL		161
+#define CLK_TOP_CSW_NFIECC_SEL		162
+#define CLK_TOP_NFIECC_SEL		163
+#define CLK_TOP_APLL12_CK_DIV0		164
+#define CLK_TOP_APLL12_CK_DIV1		165
+#define CLK_TOP_APLL12_CK_DIV2		166
+#define CLK_TOP_APLL12_CK_DIV3		167
+#define CLK_TOP_APLL12_CK_DIV4		168
+#define CLK_TOP_APLL12_CK_DIV4B		169
+#define CLK_TOP_APLL12_CK_DIV5		170
+#define CLK_TOP_APLL12_CK_DIV5B		171
+#define CLK_TOP_APLL12_CK_DIV6		172
+#define CLK_TOP_USB_78M			173
+#define CLK_TOP_MSDC0_INFRA		174
+#define CLK_TOP_MSDC1_INFRA		175
+#define CLK_TOP_MSDC2_INFRA		176
+#define CLK_TOP_NR_CLK			177
+
+#endif /* _DT_BINDINGS_CLK_MT8516_H */
-- 
2.20.1

