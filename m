Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BFAC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08AE2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JpMv4Gbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfENKMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:12:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36016 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfENKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:12:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id s17so2053977wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 03:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yxpKfujHEhPIHoJPgausEqvUsELQIfSOz/WpLWWrJwA=;
        b=JpMv4GbqJSjK4Jj4Xd4VCVcTOcAHyDyms1YnbLpEFXIfuGWRxEAEN8DEq2yBaZZso+
         ccQTaMKUoE9TY1Ct/2b5Ut5bBsspH/TAQ3mZ+F6abkPS0GQ/RYQRzvsZIA3DXLkE0ubS
         3YQq5oEgutmKhYNPFnJoMNz5tk6hu7dZMSs7IkQc1SMAzj3g9/+oDG4gqG7+6Nat9KE+
         FsW8okdBNiZVHVP2YI8wdqXmgC9xD5Sywbc3mQMyTHDgxON8Fkj3C/CtUA7byfXLJfns
         3Xo5zkPIjl8vTRH+UxDS15Ft3cITovMDhO+X2Qx7iW8srmexaTk7PMvbHV1caFFQnkX8
         sZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxpKfujHEhPIHoJPgausEqvUsELQIfSOz/WpLWWrJwA=;
        b=tiMj5/69iTupX48eA9sk1hgDUd7L114FesF3QgTcBmnBydlBs4poOi440VjsJiMoBb
         uy2VY6DZoE4j8GHPdzg7fZkAlsPShMiHT3PwVpyN+BmDWKUUPm6+lW2ln/IsUJFDWJ8J
         9JwsaV7X96jA86vJAi1Pl/aMK4XQPiKEW5H6NvdW8GMR+luNNdN68pQSpGOmaHMs3UzF
         01FwVXbIyh0SGppIWdI07iLWhYYQlBSc6XMpYGmGgxTZpOSI9L60qgB82GQ6XixB9Ivh
         gRejsy5FoaRhCzIBG0JnHA9AyveZjmK9uLa1wvjLYQQGXb4FeD+OlfAw0XmNNRKDwjLi
         YnQw==
X-Gm-Message-State: APjAAAXIiAxpVwmNK2ZKR27ebKl9b0IScJBEgeZk7/m9G4PaytPfTh+T
        aqnMupC85jn2BJkG55BfFXbgdQ==
X-Google-Smtp-Source: APXvYqwrnY1vJ4xCi/k6VxuZ6yScPtNF0qrWnWKDBS3cueG0t5fymBsZR5BapsPLSHbbAMMRnglRow==
X-Received: by 2002:adf:b456:: with SMTP id v22mr18917590wrd.55.1557828769848;
        Tue, 14 May 2019 03:12:49 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r23sm2219564wmh.29.2019.05.14.03.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 03:12:48 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: meson: u200: enable i2c busses
Date:   Tue, 14 May 2019 12:12:36 +0200
Message-Id: <20190514101237.13969-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514101237.13969-1-jbrunet@baylibre.com>
References: <20190514101237.13969-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 3 i2c busses present on the u200 reference design.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-u200.dts      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 972926121beb..e02534ab7673 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -169,6 +169,27 @@
 	pinctrl-names = "default";
 };
 
+/* i2c Touch */
+&i2c0 {
+	status = "okay";
+	pinctrl-0 = <&i2c0_sda_z0_pins>, <&i2c0_sck_z1_pins>;
+	pinctrl-names = "default";
+};
+
+/* i2c CM */
+&i2c2 {
+	status = "okay";
+	pinctrl-0 = <&i2c2_sda_z_pins>, <&i2c2_sck_z_pins>;
+	pinctrl-names = "default";
+};
+
+/* i2c Audio */
+&i2c3 {
+	status = "okay";
+	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
+	pinctrl-names = "default";
+};
+
 /* SD card */
 &sd_emmc_b {
 	status = "okay";
-- 
2.20.1

