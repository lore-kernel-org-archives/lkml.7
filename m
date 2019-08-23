Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD62C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1CE22CF7
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tXU3kWHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392590AbfHWHDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:03:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35138 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404828AbfHWHDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:03:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so8038819wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=azywW4aY+7wwgpNcGjCphBBHWjJRM460WoYJzBT0wYk=;
        b=tXU3kWHD6fL1kUtu493aPKmgU35PK0cJBZuXho29b/UAUO5IUdGJ5s0YwYZIcxbkJx
         rsS5aJ63ewGloC4FDFkDeYWx90taKRGxx9PuHTEs01ZDvDkwOtkjqJDiV87WTrvQ/TgO
         C/mhppXl3Fog2EO/Tlbb1Ee3g+pIuD4BQx6Im1Zi1pxM3pxbCygGcmiirKntjhzSUaRG
         qo6ip9/J7rTm8kBLIOPXLLuTOZNKJK0j+nRi6MHdtTJTXLDM/LdbCOSRBMrCqBAHyMzp
         3fTNWdADY/M3BLnld/6bdQGC8X6weIZnE1Dq2ph83G1BevN5OQmhFr1L8MlrpBZbTQPV
         e8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=azywW4aY+7wwgpNcGjCphBBHWjJRM460WoYJzBT0wYk=;
        b=sbj8SnCyuMgOcJXTyOf4oz/WquvuB6o+8lTAIFypxSJfi11GUO1+lH4ds2NeoWfE+9
         JKTfIzTKOshxhs4L28hqPwC6FwMdklirgq8Kycl7kwxPLgOA9Yderf2cYcp6+1Vmtwwf
         ljqk6N5dk0u67y6bOrQj+CKWeXO9wJ3rzOmmComWwcJ50wX1y6TkPDlkMY0BMf1dV/jV
         l3x56Rf2gaLpLaAIltBYCeSR7BzC8djVWrOZ2spUFGz6hKuhN96Km3bJRlmbwVBKjfRZ
         Ou9HBRPD0uGbJHzYZZ2wGUGVHarO3ITuitG0hgPuFN2k4gj/bDwuWG7AdveA1EIgj4cH
         32WQ==
X-Gm-Message-State: APjAAAXHA8hBSwf2iO+rZFm2O3Ek/JCu0rjcZaglVwlB38aEzioz89o4
        0Mm20LQ7p8uUU5L3nErZkI8SbYqbmomssw==
X-Google-Smtp-Source: APXvYqypWTGY1OgUHLWikf1dmECp2VpbfjrWpKD1mRPlCd6Udkbv7ND2F33HHWtG2cvD70GipoVAYA==
X-Received: by 2002:a05:600c:218d:: with SMTP id e13mr3277166wme.29.1566543779798;
        Fri, 23 Aug 2019 00:02:59 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm1741833wmg.45.2019.08.23.00.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 00:02:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RESEND PATCH v2 06/14] arm64: dts: meson-gx: fix mhu compatible
Date:   Fri, 23 Aug 2019 09:02:40 +0200
Message-Id: <20190823070248.25832-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823070248.25832-1-narmstrong@baylibre.com>
References: <20190823070248.25832-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxbb-nanopi-k2.dt.yaml: mailbox@404: compatible:0: 'amlogic,meson-gx-mhu' is not one of ['amlogic,meson-gxbb-mhu']
meson-gxl-s805x-libretech-ac.dt.yaml: mailbox@404: compatible:0: 'amlogic,meson-gx-mhu' is not one of ['amlogic,meson-gxbb-mhu']

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index b3fe3268af3e..74a2cdff0563 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -490,7 +490,7 @@
 			};
 
 			mailbox: mailbox@404 {
-				compatible = "amlogic,meson-gx-mhu", "amlogic,meson-gxbb-mhu";
+				compatible = "amlogic,meson-gxbb-mhu";
 				reg = <0 0x404 0 0x4c>;
 				interrupts = <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
 					     <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
-- 
2.22.0

