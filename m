Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DB8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930C8218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ax2CAfHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfCWVRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:17:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38561 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfCWVRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:17:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id g12so5976713wrm.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K20dmGWJ700LL+vpJjpcnDlimzQRZKLYUWDMmgR6T8c=;
        b=Ax2CAfHOTtSVpQD45ZlHkjQ1osTfDL6m+S2jsdo6/daBbRaOSRhb+YHpJsmcYagxYl
         LzuawF35/KY3VeCxMJrCCt+W7l6v/DBsN+vtzTjsEqUzAKuGpJ6P5J1BPeA25dM0SGYk
         UXh99ev8n35Vc82HR/XgHc+9ssKMZYPFZ00ck2Sob/F0CdVs/FHZ08EMlRwwsY6RGdpn
         qHhMd8SEeqbFRz14MnvdcwneYd+jFv37DFIa3Hodt0wMui421gW0RZnIbk0/J7GwYQ4D
         eX+VS7aSmMoA803EHq3QY3hUL7+i3kub/m14dyWIUREkoaiSny3QdlFMtg53culKeldb
         NRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K20dmGWJ700LL+vpJjpcnDlimzQRZKLYUWDMmgR6T8c=;
        b=Mjn9AnIFmGHFmLEkSqG22cCEIZK9woOytzYOMOrzBXJfxJD8J7U4vCS8zQxR71RYzu
         2VAQ/vPNy6CzA9yrfuiEimjbE9JGchiKqA9HYECKtdU48VaM4TVRDd/Hoaaf7ossgmS8
         Ri9AFVdaLXCayZSb+vRcM/+21zV61qjK//1WX9R9ZqNqt2TXF7pGe1/N9kpEyK/ABTbR
         oeZocF6Zv6Y0sjwTDsSwyRagCLkMmPvK00BfncuWKS7YbD8fOVnNXR5G3Ic6MZgGIIp2
         rodsWf3pi+LrELGYV30sxlaSjLs1GU3ny2PfI7Tlqh63/MrT0TP2SsLzgadMP0q7/hAe
         USjw==
X-Gm-Message-State: APjAAAXl7W/pUO/qPNqI22WRf76vCwic7aRKAYauBZtu8LviiLRLgll/
        +FqMiZ0ZZcpbm2dy+qDsienJbQ==
X-Google-Smtp-Source: APXvYqzvPU9gvnf+4ndL3DNOrj6Hhfv+9uwIhBaEw+FF+rFWoOLTgkZJrKyNDTGLxRXVrXwEUc4CcA==
X-Received: by 2002:a05:6000:1291:: with SMTP id f17mr10665878wrx.201.1553375829378;
        Sat, 23 Mar 2019 14:17:09 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:17:08 -0700 (PDT)
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
Subject: [PATCH 12/24] dt-bindings: mediatek: infracfg: add support for MT8516
Date:   Sat, 23 Mar 2019 22:16:00 +0100
Message-Id: <20190323211612.860-13-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of infracfg for MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../bindings/arm/mediatek/mediatek,infracfg.txt          | 1 +
 include/dt-bindings/clock/mt8516-clk.h                   | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index 417bd83d1378..cbc38a8ee985 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -15,6 +15,7 @@ Required Properties:
 	- "mediatek,mt7629-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
+	- "mediatek,mt8516-infracfg", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
 
diff --git a/include/dt-bindings/clock/mt8516-clk.h b/include/dt-bindings/clock/mt8516-clk.h
index 8d44cb32efba..956ee2c0748e 100644
--- a/include/dt-bindings/clock/mt8516-clk.h
+++ b/include/dt-bindings/clock/mt8516-clk.h
@@ -8,6 +8,15 @@
 #ifndef _DT_BINDINGS_CLK_MT8516_H
 #define _DT_BINDINGS_CLK_MT8516_H
 
+/* INFRACFG */
+
+#define CLK_IFR_MUX1_SEL		0
+#define CLK_IFR_ETH_25M_SEL		1
+#define CLK_IFR_I2C0_SEL		2
+#define CLK_IFR_I2C1_SEL		3
+#define CLK_IFR_I2C2_SEL		4
+#define CLK_IFR_NR_CLK			5
+
 /* TOPCKGEN */
 
 #define CLK_TOP_CLK_NULL		0
-- 
2.20.1

