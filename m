Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA84C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7962075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BpmL3z6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfCRKMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:12:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44821 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfCRKMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:12:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id w2so16282143wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g6ocBA+5CcZLFehmuenX/brSnm02yANlgkqtJdTZvaM=;
        b=BpmL3z6K1oIo81odcihCKBfnXDjGvWfD2Kr6RBNXQ41EaMVoG/4LYFi+jourMJhqQF
         r9GSz4WyqhrJz07lssaq4sY27oxLWCQfi4P9EYsnEXQa/x3KhxMiTaylM09YuZIwlH9k
         T1AJ5ZGgGqXb1qrF581kM/r1XR8/BW//YpaLwquMtuwCXHiW1aSodQ0nYg6PF0LIZoK0
         5hqV2Kxw6CVan35XSUZW43hos9+fECW1UoBfbHvlM+2sV2Or5+rD8e9vpip2ExposJbP
         Atq/fXxH9fR5KmQOlt7D/qzVw1aCCXWrjZ3LD6VUOfxwzw05kHLew88EyTu1sYanb1+q
         SS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6ocBA+5CcZLFehmuenX/brSnm02yANlgkqtJdTZvaM=;
        b=cOIqOToFS2LPHn5zBtAConrHwZcSd2UiPqfBCGzMC8mQcRkaInKCEZdslby6vtZPtk
         4jNJcHcIyfFRyJl1dW+9a0E8ApHXTkicpOHSx372Onsc/aSUssgUCy6yTtW9jydKpwiF
         cfxZLm9xAH8n9K5OHgK+iJNlfe/qkyc5ybSFnUQJHmgy1afkQcLp9WnzilSxF48TBWT+
         /Sq+NOGUqN6UmN/s7TzTv+RK0Nsaymtp/r2FZRWgNFjmfq+pbYnA6yoK2KAxJDP9/n79
         NwPu+GW5PVwYzl4PHyyBH1WvSmxrPvrwkWGHDIMDhT/kL5CIs16NsX6cdyQLXke8/TQz
         61Sw==
X-Gm-Message-State: APjAAAXAvD05UrwKEuxYWqg4kLrlPlnM2Vm3q1W/81RSW6SmpdfP5x4O
        iwZL2/pfgBHLwvgxBUyW+OVFNw==
X-Google-Smtp-Source: APXvYqx1AJ63n0tl2hlTrLnOloaBnlcu/datzW+s5d7DVDtnk2hh1NxTKTlVFSL5kIbF5w/Osfwfmg==
X-Received: by 2002:adf:822d:: with SMTP id 42mr11907063wrb.162.1552903918168;
        Mon, 18 Mar 2019 03:11:58 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z8sm6697855wrl.59.2019.03.18.03.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:11:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/8] dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo PHY Bindings
Date:   Mon, 18 Mar 2019 11:11:47 +0100
Message-Id: <20190318101153.7531-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318101153.7531-1-narmstrong@baylibre.com>
References: <20190318101153.7531-1-narmstrong@baylibre.com>
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
2.20.1

