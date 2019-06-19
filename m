Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73959C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499E32064A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sSRIPzPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfFSOUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:20:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38784 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730345AbfFSOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:20:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so3625080wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 07:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kT6C5gE5FK+KfGlZUIPAV8YPgNwsfj0frh0Wye9Nflo=;
        b=sSRIPzPK+cPvn1MTMZBkX0cP7V4UYFS/H/JmGFKmf/qben3Z21FjOkPBh/Mfe8nKNv
         CGx+fG8LX4MzmhIqhLYyXlOL+6TEFHSgwR323FP/RdYc3LOK+Ja6Nq4I5qe73LXMZ25N
         JgWj297MqgpUtnqnioJrYPlJZmETPT/Mo54B5Ogyc1wo0HsuHp6qSctXAtn6eWBz9bho
         dtKKpDftYUiYmJNRo6g89JTDnkReLn0x6XYFhLuRG8Geqlj4husJAfw2UOOu+TsTrrYq
         ZXeRmyUHlllMdiqiJ+oMyirBtcf+50WcH+dooZG4mWyhLEnZDDUEJXoiJNaKWFih8OaS
         pgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kT6C5gE5FK+KfGlZUIPAV8YPgNwsfj0frh0Wye9Nflo=;
        b=cQEBj0ND7bfbwkSQez/WYGlIt2NipMAC8UugBRMgjoJMNC8get2TlAGfUQ44/rF7Us
         FKxVOIiP6JTYskfrNtCL0CC03EgQbjr4/gbUuviOTU4d0qoL9BXa5HHiq9UCzgPDFevj
         vK8KBsOQtliwruJipfJMpkNo5abzqBq3LRIVc0oVu7qCiQArcByMkMxuzXpCxfU7zcc2
         Dp+4Lrsm4ufI42d015w9iO67aT/1NrT9Ae5blikDadANGwSlW0xBvXC/VAVFspesq2kI
         CpophKYB7lXVYIzqVvOGKojtgimpjl3cHbrHBrHHAoXI9qbflZg7ShWESPgjt0LOU9U0
         3YYw==
X-Gm-Message-State: APjAAAVskayfQW0KCTP3eQWhEfsDF/Ps8bVXPacJBmAb15ZVljIVx0Jm
        WcEk1oGyDiXJ2eJUp7Te/WG8uw==
X-Google-Smtp-Source: APXvYqy2BRCb05/k/zzKqZd8m/UIuZO+uW8jfzrNFlV7AFJWIlz2oU4yN1NtUSCIidGEmkuu4fzypg==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr3516215wrj.298.1560954020155;
        Wed, 19 Jun 2019 07:20:20 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id o20sm24209979wrh.8.2019.06.19.07.20.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 07:20:19 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/7] dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
Date:   Wed, 19 Jun 2019 16:20:08 +0200
Message-Id: <20190619142013.20913-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619142013.20913-1-fparent@baylibre.com>
References: <20190619142013.20913-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the currently supported bindings for the MT6392 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

V4:

	* No change

V3:
	* No change

V2:
	* New patch

---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 0ebd08af777d..aa6d2eb0eb19 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -17,7 +17,10 @@ Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
 This document describes the binding for MFD device and its sub module.
 
 Required properties:
-compatible: "mediatek,mt6397" or "mediatek,mt6323"
+compatible: Should be one of:
+	- "mediatek,mt6397"
+	- "mediatek,mt6392"
+	- "mediatek,mt6323"
 
 Optional subnodes:
 
@@ -28,6 +31,8 @@ Optional subnodes:
 	Required properties:
 		- compatible: "mediatek,mt6397-regulator"
 	see Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
+		- compatible: "mediatek,mt6392-regulator"
+	see Documentation/devicetree/bindings/regulator/mt6392-regulator.txt
 		- compatible: "mediatek,mt6323-regulator"
 	see Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
 - codec
@@ -43,7 +48,10 @@ Optional subnodes:
 
 - keys
 	Required properties:
-		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+		- compatible: Should be one of:
+			- "mediatek,mt6397-keys"
+			- "mediatek,mt6392-keys"
+			- "mediatek,mt6323-keys"
 	see Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
 
 Example:
-- 
2.20.1

