Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4125C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEB820883
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FoNmwejJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfCYJjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:39:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33785 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfCYJjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:39:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so9166541wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 02:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g86iJMmpiIt9uJMirQpX2pfFVqCHdpc9EgHcmLnnmyI=;
        b=FoNmwejJhwIsa/yIr0o07fBLozFX+B3AGuqWnUtaK9pzq2etU/8aTZtImiqPYwWTSy
         nSaEYD6px13HssAhAXbQ82tFx3ZZ5GOSXwpL1TzBzm2nLX+WUy2KKJ+1DqPt4oix2R+u
         NqLx3nJN3twNPkzQTZUYO+9g0mKyLJFDBoSz1AHgjmg+ReSnCDk5qdsP7P5zYdajP8v0
         TCfEwoliwOtl9Xot5eYpby0hisYoEv/QSIAeOEG1wz71a6hZQlfY03ULj1axliSS2tOm
         H1VL37KDP6c8cko4mR9AkVgE/w++Mn7AEYzBqc/cXx35DFhr6vBJO5k9KUNIksnMyTpV
         vWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g86iJMmpiIt9uJMirQpX2pfFVqCHdpc9EgHcmLnnmyI=;
        b=NrCueMNHf2zAFQxiYAU1Yzs4iQUrKYxTtDGcdHwxCOpTCAOdjARyqaDGHxokwYiG9m
         DkbTDsY+IzUwQuny/IbvTp8QvLKh3ROeQbdd6SSa4ShI3PfegtheBJeoQ9rBUPwIvFqk
         OFUAx7YlG+Oy/UPDWcXTtE59YPYgqlz0iVXOWLCbpDBq1maR/SovPbn8ctVRZnIa2DzI
         UDGUyiyD3bSxnhv8ztLDDvuvDu++W9BbSwZ0+F4d6gCYQkfBsBfsl67rszeWhFw+zF7x
         1JNE23L5duOPby2K5Dr+8QOZJZru+JlaIx7fcKTI3ZRJUQ+iP9CsFEBvFbMxNGFfTduR
         6z+w==
X-Gm-Message-State: APjAAAWTwlGgbENp0ZBmpJuT0yjvtOhHzUpwrC1HGpACtMiNPknDLGuH
        57dtdJpwyYHHZteLIz1Lp77m3A==
X-Google-Smtp-Source: APXvYqygtNeUJ0rqGLjj8WeuR8//m+ZExOBwhEdmf9mhGsKp1CYtOB+g85yFZFKgtCbjW1N38o91fg==
X-Received: by 2002:a1c:3944:: with SMTP id g65mr10452741wma.34.1553506787409;
        Mon, 25 Mar 2019 02:39:47 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k14sm13044652wmj.26.2019.03.25.02.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 02:39:46 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/8] dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
Date:   Mon, 25 Mar 2019 10:39:36 +0100
Message-Id: <20190325093943.29138-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325093943.29138-1-narmstrong@baylibre.com>
References: <20190325093943.29138-1-narmstrong@baylibre.com>
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
2.21.0

