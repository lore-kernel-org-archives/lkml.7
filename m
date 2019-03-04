Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AD0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9120620675
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="g4/2160H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfCDKiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:38:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39150 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfCDKiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:38:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so4150512wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 02:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2taATSeLwYLlK3AoeIDGHb1SmDZDEtC2Zy8s96NWr0=;
        b=g4/2160HSfKd8XRPPiSf9tpXJNBsPMIW29lKAkxpAzVxSTCo1+odo8nErsED55c3Hd
         Fk6vKBtvwF4CTbqskJVFHe0jucEtvzFfGxZ5xE8+eZUqsuWxQ9+lajW6h8UT+03WPeyC
         oFfp8zV4pIwGexIOQKQRHn+XWtx/wqdmpT2EuBiycznDrtYlXpr+mdppI22RR+dWXNwR
         IRG6o+p2ACi7EGjvNSv63f4U+ClhyHz6FCNRr4m+kLgcQeI9h6OSP+NAJv9FRQwpaAiT
         ItNAjs3SHTwFC8YKLoIKVaYn9+5Mg0Vzm3cYZaCMGJ+fxJkQ4SEikQLEanQO/GdiVZ8v
         zbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2taATSeLwYLlK3AoeIDGHb1SmDZDEtC2Zy8s96NWr0=;
        b=gnB4tF72ZW3VLedJbJSu3sBo8wtfVyfnoLu31bQnXLWNypktT0mVfX1mAMtQBFoj0Z
         +NarIIiZjxzbBHc6t5MA36IProzLShbFwTBqZydFQRvz/KFFUNjvoF13Xc6KFLNAIX2Q
         i/Z0cFoCYfgHXcRcTvaGdAp9Qn2k4XdSYsUAwASkbGBbvZh23jm51/xWJy3v0GYzdt8f
         4lhGAYYXuZGADxT6BPBNjBqhD5zAUmEaEqOe3AV3lwPlYKATG422FXcI4G629UpBy81Y
         jSWMMVfnm9DhC5IuWLOOyIUVisExQn6w5BoepsU9Iz5D+uFtWixJNe/tPsI/td5E/Wll
         y2Kw==
X-Gm-Message-State: APjAAAXtNfsvJqzTGrNipPvYieIEaeE9qClEBpApQ57eVAQ8LuIKPZ7j
        MS179Wm1xzuPrFTDSQP4aFkJkQ==
X-Google-Smtp-Source: APXvYqyDJn4uyzB4Hi/bHTAo8UZVv79cmW8ylPRmDsbPLT+yF4S0bn/iUhQ4ChY6yO2EU2dOJVnNzw==
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr10432625wmi.21.1551695930410;
        Mon, 04 Mar 2019 02:38:50 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g24sm5505676wmh.45.2019.03.04.02.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 02:38:49 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/8] dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
Date:   Mon,  4 Mar 2019 11:38:39 +0100
Message-Id: <20190304103846.2060-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304103846.2060-1-narmstrong@baylibre.com>
References: <20190304103846.2060-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Amlogic G12A Family USB2 OTG PHY Bindings

The PHY can work in host or peripheral modes depending on it's position.
Configuration of the mode is part of the USBCTRL registers which are
outside of the PHY registers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/meson-g12a-usb2-phy.txt      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt b/Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
new file mode 100644
index 000000000000..a6ebc3dea159
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
@@ -0,0 +1,22 @@
+* Amlogic G12A USB2 PHY binding
+
+Required properties:
+- compatible:	Should be "amlogic,meson-g12a-usb2-phy"
+- reg:		The base address and length of the registers
+- #phys-cells:	must be 0 (see phy-bindings.txt in this directory)
+- clocks:	a phandle to the clock of this PHY
+- clock-names:	must be "xtal"
+- resets:	a phandle to the reset line of this PHY
+- reset-names:	must be "phy"
+- phy-supply:	see phy-bindings.txt in this directory
+
+Example:
+	usb2_phy0: phy@36000 {
+		compatible = "amlogic,g12a-usb2-phy";
+		reg = <0x0 0x36000 0x0 0x2000>;
+		clocks = <&xtal>;
+		clock-names = "xtal";
+		resets = <&reset RESET_USB_PHY21>;
+		reset-names = "phy";
+		#phy-cells = <0>;
+	};
-- 
2.20.1

