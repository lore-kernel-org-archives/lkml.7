Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB6C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A224D2088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z69jBMOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfDYPld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:41:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33456 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfDYPl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:41:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id s18so129270wrp.0;
        Thu, 25 Apr 2019 08:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mVd6AA+BSKv4ZSmWjrYqpyWQnuXae7df1FbMH3nxboY=;
        b=Z69jBMOErRW3waEtq1mf5YvFSatuARJRmMFZetZqyI2VnjcyDYSjliaszUwZ/e7zW+
         OzNloL8Ghy3/NiVhGULZpj/YB+zLIEM0FouuwZbIctPcQMD9PTbXJwTexSxbpAYyVWtL
         KY4oBmg56rCD9Nole6EAsoEgWA1+6sgSyjIS78bRHeXzmxDxMXp8BghZqCKY/mNs10Qi
         6HW//dO+LtjBh4EH07Wbv0KePIi5xT1KhOgLayu5hp9Rr1GZ0Z5y388AXn094VeGlPxe
         16jyeb7ZGKzz231x4l2ttG7+OKMooU1u8rwPmx1LE1YGneHoNHUGaZuYZFohdq+c2nJy
         pFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mVd6AA+BSKv4ZSmWjrYqpyWQnuXae7df1FbMH3nxboY=;
        b=fM8dMdIiouheuxURAZyQd34IYGgbCjU04OvXCniRQGifDsfRC9H0K6x5/Dxq0uORuE
         ECFB6aEf2d9g7gKhQu12ibUK+PRnfbRLs72Z8DZUV7U16XhfpQ8p2ue9eAQwwLwzItd1
         KqmHrdnyNY9Mwcb7lCvZRckStV6W80QrRDWvgZyaMh8k78wZfs5mVbzOQE85q5YNjcSc
         O3rzM23p/QjgdWKaxrrtg71mWAEmspVzLTiPoZVednwLR45GzfOP+phdFGpl0WIAe1zx
         E5dD3R1NVzqwzdByXWjJJ3yBvvvzhw3vY5GJztBFFcAR+DBeKiIF5d3DdhF3hz1kkq7I
         +4Yw==
X-Gm-Message-State: APjAAAWoAcXFR8Wy7Aw45+iDiHne4Ml6lFMOEykrGAQjlr3FNE7CvSy+
        3ikNyGbrWQgyH+Pha+/02Wk=
X-Google-Smtp-Source: APXvYqyrtbnKNIPAJR+ocVYLMIQoVbuczUYo660Vvtb/GchLSXbBRPUsvkbhHLUmUCaNhvHCE2wmmw==
X-Received: by 2002:a05:6000:11cf:: with SMTP id i15mr25518720wrx.287.1556206886432;
        Thu, 25 Apr 2019 08:41:26 -0700 (PDT)
Received: from localhost.localdomain (216.red-79-159-55.dynamicip.rima-tde.net. [79.159.55.216])
        by smtp.gmail.com with ESMTPSA id r9sm21793674wmh.38.2019.04.25.08.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Apr 2019 08:41:25 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, devicetree@vger.kernel.org,
        john@phrozen.org, linux-mips@vger.kernel.org, robh+dt@kernel.org,
        neil@brown.name
Subject: [PATCH v3 1/2] dt-bindings: phy: Add binding for Mediatek MT7621 PCIe PHY
Date:   Thu, 25 Apr 2019 17:41:21 +0200
Message-Id: <20190425154122.24122-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190425154122.24122-1-sergio.paracuellos@gmail.com>
References: <20190425154122.24122-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to describe Mediatek MT7621 PCIe PHY.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/phy/mediatek,mt7621-pci-phy.txt  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt
new file mode 100644
index 000000000000..a369d715378b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt
@@ -0,0 +1,28 @@
+Mediatek Mt7621 PCIe PHY
+
+Required properties:
+- compatible: must be "mediatek,mt7621-pci-phy"
+- reg: base address and length of the PCIe PHY block
+- #phy-cells: must be <1> for pcie0_phy and for pcie1_phy.
+
+Example:
+	pcie0_phy: pcie-phy@1e149000 {
+		compatible = "mediatek,mt7621-pci-phy";
+		reg = <0x1e149000 0x0700>;
+		#phy-cells = <1>;
+	};
+
+	pcie1_phy: pcie-phy@1e14a000 {
+		compatible = "mediatek,mt7621-pci-phy";
+		reg = <0x1e14a000 0x0700>;
+		#phy-cells = <1>;
+	};
+
+	/* users of the PCIe phy */
+
+	pcie: pcie@1e140000 {
+		...
+		...
+		phys = <&pcie0_phy 0>, <&pcie0_phy 1>, <&pcie1_phy 0>;
+		phy-names = "pcie-phy0", "pcie-phy1", "pcie-phy2";
+	};
-- 
2.19.1

