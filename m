Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318A4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018BF2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uZiehy1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfCRKMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:12:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36311 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfCRKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:11:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so11797568wrd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2taATSeLwYLlK3AoeIDGHb1SmDZDEtC2Zy8s96NWr0=;
        b=uZiehy1Pkj8HeRnG8b+OAw61mBfpoetMn1l7ItxkS5UIHofyDCMYNNa57xIAKvV3H/
         zgvF24rErH0zumgH3DZU162mdwHHwolJ8xCSLAajEG6oFUAhZb4krrCDZBI2gtnJY9P4
         pP8V3DgBc51x3+Jh/xUS77339Q4Ylrt35xZpOE6p0FnE33RgcIhFatwcJb3HAdrIbLrg
         tM7dlmLnz6IRyi9PfLNKMg+IAoHp7aKGp2kpGKotUveF7/6VWAu33LHOfYnFXB+Q2YXu
         OeLyi+W67Itao4mjZ3IczGWLwZ8PSkBWQUvdXeYPHUz6HE5zoI3DpVlwyGajO0X45qEF
         jfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2taATSeLwYLlK3AoeIDGHb1SmDZDEtC2Zy8s96NWr0=;
        b=hsAzQCj8eoCc1Zc9/xfh3RJzcXjtHwgDM2ReKjGRQK726HVKRIAsdP7a0XZqXeyyfd
         sjtyCYljAMQWAnwveh82+MZsPYLHFFR0HAFJyP7cU0ahEpz447sBJplOAHko++Pvadzy
         na2EXDLwLDToWF5qKjWeNTlBtZVqPQHlW2Dxwvt6lo7uAQndbVXk5zHGwSaCoSBSof5v
         TX1FpzcXBYJMDjl7if+i/iMCX+3HiQHonSoZDL8r6hnL5jlnSz1RiFiD0olMwGrD/XkU
         cK5nWejruvs7XAaaIvA1qeX1JVI5iohvYyk9LwfngLJrxribg1P5r3EpTLblW+JnckGN
         IAyA==
X-Gm-Message-State: APjAAAW2dzJIvxQPQP6JFMSopkt7GknzHh5jki96nWSTDTqU+qB16vdO
        M7eSFp/Bzoo4I2epQidChs0Sgw==
X-Google-Smtp-Source: APXvYqx4UUWMu3ithhWuFDOAOqWDb3jZ0Zk8xcYwGo0XAgJTOH3zTeBLW6l44V0yX3JPiGrPSnu4NA==
X-Received: by 2002:a5d:530f:: with SMTP id e15mr409937wrv.19.1552903917127;
        Mon, 18 Mar 2019 03:11:57 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z8sm6697855wrl.59.2019.03.18.03.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:11:56 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/8] dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
Date:   Mon, 18 Mar 2019 11:11:46 +0100
Message-Id: <20190318101153.7531-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318101153.7531-1-narmstrong@baylibre.com>
References: <20190318101153.7531-1-narmstrong@baylibre.com>
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

