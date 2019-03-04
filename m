Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715EEC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DC1206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SB9Cs8Nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfCDKjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:39:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37100 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfCDKix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:38:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so4133624wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 02:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=72v4hanMqXDrgOzm+tqI3X31HXue2r+EANQzMeKqzLE=;
        b=SB9Cs8NrcFoAysdT5wqeIpNirIvYRpHeUMRbI9E+2sthBPc7xfD1weWTfYu8CYHWOM
         YPd53BCc3lCMKuXBS6b3CwXNKvDGPGhrxYyLxKL1ybpJJTNgaukyhZnsSLXd1u5VTm+o
         uQOF/X8RKPUemDRtiD615+lctc7nzWcGXIn2UTpgEIAebsBG48/Lgm90UYYfaIsOOJaL
         VYmFJjcvK90pO7w+T3Qjm8UcPws+kL1qvdK3U6jFFvQK55zPtK1dwBCFLUWoJ5H9TR0S
         uOFJ+8okCGFe71b3Q873dQpKaV3xV6PQ0k9P3HifOElX4qwh9ElY7s1tXlId5mmohFSp
         m+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=72v4hanMqXDrgOzm+tqI3X31HXue2r+EANQzMeKqzLE=;
        b=qn78ZcPXkxxP2q67vlmJ1I9HmQtN7F2nsL367W283MzBaYen0em1Nu564dod6Mz8pv
         NA7Hbqw8sE8KMGBNGtZ9uCiE8Io0oUz3W3o7PfYTTDWqv/KnN1U4h+EYAM+96RZlUtyS
         zwsEZh5Uydd3JIcsTjthu/lWX1FyaTrRfIX7WRrReW5E+XitQfaC+4JTmf3MG2vBe60p
         pw7h9y7Ot3vD0R7JU36WFijImpjyYx1QyKMhExcNgV2kMhiwXJFAfWn2r+lAGnwnJs74
         0+YscY41Syw288DLkt26G0/pT3U6uXb6kBhDNauFYnE3YIfLvY2zD9dROIVTxBHzGGf8
         sopQ==
X-Gm-Message-State: AHQUAuYspS+4zjt8wDS61ydOcMqWPaJ8Q02I5V9pEsTACfTeEByB+EOr
        GoExi9GOL5UCBJBclYT5DFo4jA==
X-Google-Smtp-Source: APXvYqwme+spwSChOM2OAQ1d4kRmi8GdP+TLE1UI9LgqzH9IUaC6HNhNDEmhNlB+8YvfArxsiseH+g==
X-Received: by 2002:a1c:3b06:: with SMTP id i6mr10555237wma.55.1551695931563;
        Mon, 04 Mar 2019 02:38:51 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g24sm5505676wmh.45.2019.03.04.02.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 02:38:50 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/8] dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo PHY Bindings
Date:   Mon,  4 Mar 2019 11:38:40 +0100
Message-Id: <20190304103846.2060-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304103846.2060-1-narmstrong@baylibre.com>
References: <20190304103846.2060-1-narmstrong@baylibre.com>
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

