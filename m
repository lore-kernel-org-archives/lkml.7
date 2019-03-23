Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7085DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C30C2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tDqSlOVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfCWVRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:17:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44990 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbfCWVR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:17:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so1872727wrn.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wBNomKiJoztRlogBYx09sMSVyAs7kTHw2QtTllo3CmU=;
        b=tDqSlOVgvciOTKcDERSZubVGhbVMJ7efUTw2Cx3Ku/BMJlLbp8B3NSB0Kw4adUwXLh
         ndWoWvER1m54U0xjI/ZIGzhKR75bhNgtF5wUxehiVR2i6NXRqxpKtY+/0If4m23PNIyc
         thoRX4nvDHptfp4NmXW+XcgHeGuZMyaE+iAk9+9sfUyVcAJBC0PZE/DQwHtzYXBget4Y
         q/qwKBToi10uetCLCZEvI0rJJjEwm/fXWVp71r4KetQ//1TAJicL7SshfQ1qayNkJ+Y2
         0KP6HQ1KRrde9l00bcfJccknYh59CVnUnHxlPGPHb7jYJHzI4j03MUU8wpVdrT+hYCKT
         ryjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wBNomKiJoztRlogBYx09sMSVyAs7kTHw2QtTllo3CmU=;
        b=eftduuK4XLJmimBXAJomBTbZcA/o2thvSmYxLnrLrXMorG3baOki3a9Ba1aCjpeqAy
         eCaiGu7j7hwO0ECY0zOzRD/hAMF6EHsHyDcchcy790dUH63WSsgJYUwACqLB4t5hAFu0
         U3jGU4YKo4nvPhANXkDRhARB0stXjpyNAEtdOy5cBCKTC08M1sOm6dNG2ehXJhzHDqJb
         Ae7p+cPWSi6b+fDvStzFJqZ/kFI49hYOlkvVgRNMA6ajErNxFSsz50ABQsX19C7BqB53
         gEgJh+5QpOkx1+NvZlDAQpa5mFZvV0DaQBGpOWtGYm8UQzbBcrJygg2u1KLdndEAmeNe
         lT2Q==
X-Gm-Message-State: APjAAAXP/8XYwtEKKYIFVzSr1ArL2S3yDYU68HzQx1qPEkYjvERqKIeA
        tIChQdaTnmrIsOlTMaO68BaONZIODLK3m7zQ
X-Google-Smtp-Source: APXvYqz/ovcCC3cF9dhxmHF8kKGM3qTjpLzMBrbp+nnwzeKhuZfREh3eYWeiSkM3wM92f2/tvaaVaA==
X-Received: by 2002:a5d:6883:: with SMTP id h3mr10529391wru.215.1553375846942;
        Sat, 23 Mar 2019 14:17:26 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:17:26 -0700 (PDT)
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
Subject: [PATCH 18/24] dt-bindings: timer: mtk-timer: add support for MT8516
Date:   Sat, 23 Mar 2019 22:16:06 +0100
Message-Id: <20190323211612.860-19-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of mtk-timer for MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index ff7c567a7972..74c3eadad844 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -17,6 +17,7 @@ Required properties:
 	* "mediatek,mt8127-timer" for MT8127 compatible timers (GPT)
 	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
 	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
+	* "mediatek,mt8516-timer" for MT8516 compatible timers (GPT)
 	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
 
 	For those SoCs that use SYST
-- 
2.20.1

