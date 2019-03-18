Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ED5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB4D20872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="k9psut69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfCRN1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:27:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53600 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfCRN1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:27:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id e74so12979587wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 06:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g6ocBA+5CcZLFehmuenX/brSnm02yANlgkqtJdTZvaM=;
        b=k9psut69Jf3ozrHv0nsInX4d37vW2Pzw8gdMlerCQ8c8oB5YYt19lCo2mTOLbWFd+i
         3dDLFHpE5CM1ZsWuqpzZBglObWO850Wkht7TT7LAfOL3C49G/sQypf7GIj+TH3X24jqR
         Q8daGAVWcgIYH5s63loThbf0HKnGl+zBD0NDMQPDpprdXcpZig6PXGqQm+gy/qo6mJYP
         Z0t8P+JF51Q5Qefsm2KdvPZkvqj14GSAYEhW1nkorEDzCeRxFE1p85M8cpeTgvgHUAKV
         30yYmOhohJHwJNVe5MvnbWhM4vJV/fWf5rxcSkHhy+ni0/ai27gdG0KXvfD0QL+JUsYA
         /dXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6ocBA+5CcZLFehmuenX/brSnm02yANlgkqtJdTZvaM=;
        b=J9fHTD/WNmL+OFCjHn4virrclVOKNRw/xwCALL1xdNkredzfVQZEhPQiRtOj7r9CvD
         33IrdsXt29wY9x50psFiGYy6P6GRjruxgPKloFMinT2cBf3l/K6Lxm3smEojbj2nI/3t
         ZbM5Jhe5i50pGLm9h/HeILZAhycvCssF7lI0f6jE9GSlWy7dU8vH2Q7DFofNE+TCQNbt
         z9CCRhdA/YbdoGYdBNpGgI3cKJpR296MpvH/MyBfBzyClABguCzwFfklTnJei8NKdfW8
         koimY5FpUtbKgiRSfzxhnTvQGEorNcNJfumiQBeIW1H2ULzKZn7b6dViQlPg/R/9gZj2
         16Sg==
X-Gm-Message-State: APjAAAUFTSh9fiYwJOXq8SacxlIjU/nsFwz6ACKuCkAI5io2XbAJ51AM
        oqfIngBv02xWbT5IYyNm4c5b6A==
X-Google-Smtp-Source: APXvYqy+438qD1uat7C6Dyw/bxfXr8AGTdadgnhWoXqIOwdUSthgwxA/qN2Mqb7oObjkcqc98xkXKw==
X-Received: by 2002:a1c:234d:: with SMTP id j74mr10395413wmj.130.1552915620192;
        Mon, 18 Mar 2019 06:27:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j128sm10421601wmb.43.2019.03.18.06.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 06:26:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/8] dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo PHY Bindings
Date:   Mon, 18 Mar 2019 14:26:49 +0100
Message-Id: <20190318132655.30040-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318132655.30040-1-narmstrong@baylibre.com>
References: <20190318132655.30040-1-narmstrong@baylibre.com>
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

