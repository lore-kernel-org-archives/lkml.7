Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C081DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D01204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUzQxqh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfCNNWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:22:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51927 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfCNNWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:22:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id n19so2974384wmi.1;
        Thu, 14 Mar 2019 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oliUT0pSFOjtck/zQnuqBh/BfYM3EdXdya4w7qqF3aU=;
        b=oUzQxqh7DVrtT31QmMiiCunZHDizISaXg6sbt7JWjdNnMlM2Q/5ClVGUqoq95lX9OC
         jRQDkF8wsktsvkiyoyqwdNW24oA8ecgv++y0/bDVeerj8funODbc1C2w1n2GYzc4d5EX
         QtMIhkS5kOVBQ231aBDZlnIRmVN2wG07ZXr3FcOm6oisgJwOZFAyZEoDSas4N0HmPvUz
         XhS9FYF0w3fumtYgM7v32Brkhxa/dOgDSA6MQ3eWVKmrAxWHLoRnXxnE+fn1vqCha5Bz
         9h8PAW24ROBK50GqaZZ7RIYH/RIydOmiHa9u07UbosUYavSD+hQAph2IogmVesWRhV/9
         xytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oliUT0pSFOjtck/zQnuqBh/BfYM3EdXdya4w7qqF3aU=;
        b=fLMU0fqQdxhcQAtbL9/sz21ItXKtc5N1lrMKyQgFmA4YLKpSe8a3fbVLAdxn/lQMg1
         kPBK/UydOBj15zW88o7z5vGMsbPCk7752GovR8ouz4Rj73eReyABJ6vh9XEm9yaEkGBR
         YcEc48qG7xpLnyiH2vrsJ1Wk56T44fSHvNXgBkLv4GxVW68SyPrdNVWoBEnRG/SacgSF
         cnZDU4Y4PDg+HpCp0hC2Gs4lw9XvhIfvIGNZxQx0uPYiXnlCqM2j96A3TX8/0QfyJ1JV
         3sXdsAJrQnlZypCEwMgoYW5EvovX3f27MGDINlY67WTanAOjG7O3oSFCakuHxctPhG1u
         3GzQ==
X-Gm-Message-State: APjAAAUuXx+RFZK+a9NbNcVu0C2Wvj9yWvZ9arKGqe/yzSH3lJox6559
        XnBWr1PecGq1LRd1Fw+AnwY=
X-Google-Smtp-Source: APXvYqw75vqQ16V0rSu6uFzO22gEFMfY8X8fRKy2nHJMLkwIhYBZ3P+hOda1Vt/63felVnT+lKNsHg==
X-Received: by 2002:a7b:c404:: with SMTP id k4mr675752wmi.117.1552569735712;
        Thu, 14 Mar 2019 06:22:15 -0700 (PDT)
Received: from localhost.localdomain (79.red-83-47-240.dynamicip.rima-tde.net. [83.47.240.79])
        by smtp.gmail.com with ESMTPSA id y66sm2979820wmd.37.2019.03.14.06.22.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Mar 2019 06:22:15 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, devicetree@vger.kernel.org,
        john@phrozen.org, linux-mips@vger.kernel.org, robh+dt@kernel.org,
        neil@brown.name
Subject: [PATCH 2/2] dt-bindings: phy: Add binding for Mediatek MT7621 PCIe PHY
Date:   Thu, 14 Mar 2019 14:22:10 +0100
Message-Id: <20190314132210.654-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190314132210.654-1-sergio.paracuellos@gmail.com>
References: <20190314132210.654-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to describe Mediatek MT7621 PCIe PHY.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/phy/mediatek,mt7621-pci-phy.txt  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt
new file mode 100644
index 000000000000..8addedbe815e
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt
@@ -0,0 +1,54 @@
+Mediatek Mt7621 PCIe PHY
+
+Required properties:
+- compatible: must be "mediatek,mt7621-pci-phy"
+- reg: base address and length of the PCIe PHY block
+- #address-cells: must be 1
+- #size-cells: must be 0
+
+Each PCIe PHY should be represented by a child node
+
+Required properties For the child node:
+- reg: the PHY ID
+0 - PCIe RC 0
+1 - PCIe RC 1
+- #phy-cells: must be 0
+
+Example:
+	pcie0_phy: pcie-phy@1e149000 {
+		compatible = "mediatek,mt7621-pci-phy";
+		reg = <0x1e149000 0x0700>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pcie0_port: pcie-phy@0 {
+			reg = <0>;
+			#phy-cells = <0>;
+		};
+
+		pcie1_port: pcie-phy@1 {
+			reg = <1>;
+			#phy-cells = <0>;
+		};
+	};
+
+	pcie1_phy: pcie-phy@1e14a000 {
+		compatible = "mediatek,mt7621-pci-phy";
+		reg = <0x1e14a000 0x0700>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pcie2_port: pcie-phy@0 {
+			reg = <0>;
+			#phy-cells = <0>;
+		};
+	};
+
+	/* users of the PCIe phy */
+
+	pcie: pcie@1e140000 {
+		...
+		...
+		phys = <&pcie0_port>, <&pcie1_port>, <&pcie2_port>;
+		phy-names = "pcie-phy0", "pcie-phy1", "pcie-phy2";
+	};
-- 
2.19.1

