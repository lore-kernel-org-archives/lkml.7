Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F171C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C807218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeFKuNnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfC3Fuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 01:50:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53008 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfC3Fuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 01:50:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so4588229wma.2;
        Fri, 29 Mar 2019 22:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FqYBQB6pYlJH9QgLzLHVknywBUlBBnDpVDjy/mdsSUQ=;
        b=ZeFKuNnPVjtevKjp5BpNoT+LrfUnKbhMFmHTZJMyMr759/lHA3eHItvwEzvZOoksRi
         iwDw5wT5gNrkJvYIo2EC+Ncm6dT+7RNKv5Bt46mzblvQXPPqdITCIpc3UNLUgNz7678b
         xsc7CZSYORk4k/tkm8cKLGi5dGW9DwqQ844e63/GgxoOZ3FYf7iFwSSEbuwH1tU4t4ee
         SI/RTPiqf/WssxsNhoKvaqnhuoZJ6lt5Y/eMeQCMwrb+EIk1J8DrHxXDEJGIxaTvmnB5
         sIoJxE3brEqCk+8XbLmM/EYSmeUe21z0prLOwlkNcygqLdFpvYwt2EsUV7kqN7iVDKzY
         8X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FqYBQB6pYlJH9QgLzLHVknywBUlBBnDpVDjy/mdsSUQ=;
        b=CJ8bDii0C3yHrGri3ov+XVUhldMxVgDVBP0HgDJnWOoyr6yu4LfWrXm8aGUzTFeD4A
         q5GQOnmH0Xw3D8BwqqOrKRux2gFvITgTuKOolvjtCSZ0/ff9gmRAjHWj6ARWflyiHQAj
         Cd9ZfFaPjQU6HR7p93NOGevTsL7FqhiJXNVS3mqqzyiGWVr013obeZ3Ynmcfjb7oeFMy
         SYTByBLxPNrbT8qXeuk8znoluY0NP0w9EQJVIQXYWlGe1wRkmZtSloQi9bIvcczQ7qd6
         z2wc99hOymyzZLossm4tVXB9d8PQoZwO0o9vVvN2clDLlpcZ+TMjDaZyJPlzLXZdS+/i
         hDWw==
X-Gm-Message-State: APjAAAWO5vHlh6kaxY0fDS53NficmAhb4DglOPnypeF5uuM0a1/6BIxu
        u+WWiw2rHTHx2yUnOkcC87r4gVYM
X-Google-Smtp-Source: APXvYqyE8LnJgrqRln6EX+/2l+VhJra0dNrBFW4aCei18/7hb6GYPMKGKvqhUbImi42coO5mj9ty1Q==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr5611978wmj.43.1553925042284;
        Fri, 29 Mar 2019 22:50:42 -0700 (PDT)
Received: from localhost.localdomain (79.red-83-47-240.dynamicip.rima-tde.net. [83.47.240.79])
        by smtp.gmail.com with ESMTPSA id l8sm4089610wrv.45.2019.03.29.22.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 22:50:41 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, devicetree@vger.kernel.org,
        john@phrozen.org, linux-mips@vger.kernel.org, robh+dt@kernel.org,
        neil@brown.name
Subject: [PATCH v2 1/2] dt-bindings: phy: Add binding for Mediatek MT7621 PCIe PHY
Date:   Sat, 30 Mar 2019 06:50:37 +0100
Message-Id: <20190330055038.18958-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330055038.18958-1-sergio.paracuellos@gmail.com>
References: <20190330055038.18958-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to describe Mediatek MT7621 PCIe PHY.

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

