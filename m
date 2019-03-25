Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4DFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16AC20870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wHo/2/uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfCYJjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:39:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33063 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730376AbfCYJjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:39:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so9280866wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gVIrPdOFdZvdnroywufsY+QsNjB1DOvF/UDjdy0FiHY=;
        b=wHo/2/uZgXxm+xw6/nHYKVfXM1qkY/ErPBMa2PYelMs7twOKz97S2oNvRX8AOi21Gy
         EFWO93IYeW5Hf77WSES6WCShjHUbmPlzVDVfyLV6MNdDr9z15RpIrnBkn8sUI9ua1hUT
         7XAhQ71P3GLWB3eyVj7eoe7nU78YWlwlSxLhOvwoJsQ6nt5FdyydSXUeZvi7CJAjyY7y
         FrlNuwGN/yfp2J1bRrXcOfajBDovrer3hkcZqDQIRsYIN0nq2roxErvfI+vfpwHByO+s
         OlLSeVMwLqk62qtVnWTZM0h5Bu4mdO8xUty2fkBCY9mVEpZJ+/zRp+SnzDzmr8mDoAEi
         zBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gVIrPdOFdZvdnroywufsY+QsNjB1DOvF/UDjdy0FiHY=;
        b=eTigo9dAsmp4Sb2gSt54rZyQ3YXWz1/EYdkpnEgowc7YQ+RHQEcRuME/h8T5p2+/Q7
         CFv+YlEKEwwbY+jmkXIXfLxC7RzPmRXkBuV3TA7vWQB6lOaJr28YIvUjSDiqajCKzXnF
         hWnLkArkKGXMHW9zo9OMLWXbEzM5QOWwKT6nR7CLuAxYYLS7pmCu4IDz7UarPammELuO
         PMecQIKEA7n0usEsyM1FoIY9uEBzNATp02J5eC0QFUN82qxLMJKb4dr6BVf01X6VTNLC
         Ml8+XcyQeaSCZ0KwOPmudQXVZNnU0o67jhytVbPCru2Vzrk1sMsNbQ6NU9LxiEXN6OZA
         RxpA==
X-Gm-Message-State: APjAAAWm5rUNMbtcezLFm3CDsW49aW8II7Oz2EtEckyKeB9q3AHAKO4B
        fF1+5tlJNo69YUD4hnfvJ9XhoA==
X-Google-Smtp-Source: APXvYqxwz/TOn5DsU4AZsdlDrmumTaQph5bp62v3v6MVqtZfZ8nFKu+fGvjFZuZMOw+Mq/vfV6PAUg==
X-Received: by 2002:adf:ec4e:: with SMTP id w14mr2332205wrn.53.1553506788719;
        Mon, 25 Mar 2019 02:39:48 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k14sm13044652wmj.26.2019.03.25.02.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 02:39:48 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/8] dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo PHY Bindings
Date:   Mon, 25 Mar 2019 10:39:37 +0100
Message-Id: <20190325093943.29138-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325093943.29138-1-narmstrong@baylibre.com>
References: <20190325093943.29138-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Amlogic G12A Family USB3 + PCIE Combo PHY Bindings.

This PHY can provide exclusively USB3 or PCIE support on shared I/Os.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/meson-g12a-usb3-pcie-phy.txt | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt b/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
new file mode 100644
index 000000000000..7cfc17e2df31
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
@@ -0,0 +1,22 @@
+* Amlogic G12A USB3 + PCIE Combo PHY binding
+
+Required properties:
+- compatible:	Should be "amlogic,meson-g12a-usb3-pcie-phy"
+- #phys-cells:	must be 1. The cell number is used to select the phy mode
+  as defined in <dt-bindings/phy/phy.h> between PHY_TYPE_USB3 and PHY_TYPE_PCIE
+- reg:		The base address and length of the registers
+- clocks:	a phandle to the 100MHz reference clock of this PHY
+- clock-names:	must be "ref_clk"
+- resets:	phandle to the reset lines for the PHY control
+- reset-names:	must be "phy"
+
+Example:
+	usb3_pcie_phy: phy@46000 {
+		compatible = "amlogic,g12a-usb3-pcie-phy";
+		reg = <0x0 0x46000 0x0 0x2000>;
+		clocks = <&clkc CLKID_PCIE_PLL>;
+		clock-names = "ref_clk";
+		resets = <&reset RESET_PCIE_PHY>;
+		reset-names = "phy";
+		#phy-cells = <1>;
+	};
-- 
2.21.0

