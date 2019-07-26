Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C43C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6E621901
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TSLvqFpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfGZIPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:15:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40291 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfGZIPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:15:09 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190726081507euoutp02171d7b48b61fa50d103d48e2b26087e2~05vQ-AFqW0299602996euoutp02T
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 08:15:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190726081507euoutp02171d7b48b61fa50d103d48e2b26087e2~05vQ-AFqW0299602996euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564128907;
        bh=hZ4MwfR13AaNPCdSDCn6Bz3onvIw3auhZCwCGXSUNnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSLvqFpKJaK5hViqWUlAHLgVggZBQsZgwhNPi6ZAu7f5fCEGr3X7i0iW1NwtnDtc6
         f83H0I9C+1og7rbJYE++bzwe+aNTMLBOVZVAtUetl2bp4pCGLsBZ2GoITZJdY2Cyib
         6R7S5MNJmdo7Y0lB96aDA79haX2AkX6EvCOeLR5I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190726081506eucas1p14600c7c986b96b8ee9421c77feffeb1d~05vQhNVwB2123721237eucas1p1n;
        Fri, 26 Jul 2019 08:15:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FE.1B.04377.A86BA3D5; Fri, 26
        Jul 2019 09:15:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190726081505eucas1p146c14eed320c57050aa968b7c97b227b~05vPw7Rex2124521245eucas1p1k;
        Fri, 26 Jul 2019 08:15:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190726081505eusmtrp2a16d4c68bde1588516aa8abab6f93049~05vPi0ebv3187231872eusmtrp2s;
        Fri, 26 Jul 2019 08:15:05 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-d1-5d3ab68a4a7d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CD.7C.04146.986BA3D5; Fri, 26
        Jul 2019 09:15:05 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190726081505eusmtip2c82af7ba052a9d2ff106ab59d8600296~05vO8aiy43038030380eusmtip2t;
        Fri, 26 Jul 2019 08:15:05 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/3] usb: exynos: add support for getting PHYs from the
 standard dt array
Date:   Fri, 26 Jul 2019 10:14:52 +0200
Message-Id: <20190726081453.9456-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726081453.9456-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSyUcRz3u+eeF3L2ODY/uoWr9La8NGtPXE2rtWdrK72trYauPB3h2N0h
        WlxujJuk1sKpsSghzvs4k3AlbE6oybw2eltYWJ2dKXcP8t/n+/l+Pr/P57v9CITfjboQ4VIF
        I5OKI4WYDbfh7ZJhv7rBL8h7fk5AVedqUapA34tSqiItRhkMVTg1oHuMUbmGVxzq6fNUhPqu
        NwKqQj+KU8bJHA61PDaCUqktepzKNvVhATx6eCSZrinLwOjWJy9x+mdPN05XzzZy6PxRI6Cz
        6soAvVCzLZC4ZCMKZSLD4xiZ15ErNmEfSkUx+dtvlowUo0pgEKiBNQFJX/imvxwxYz75AsDf
        s9fVwGYVLwJ4r2gaZ4cFAJUTtWDd8XClEGEXJQAudafhG5Y0432OWYWRPlA9o8bM2JEMgMXP
        RjCzCCF7EVi0lG4ROZDB8OvHOlQNCIJL7oTzU25mmkeK4LeGUS6b5grLq15b+lmTh+HdLxUc
        VmMPu/KmLBpkVaOqz7c0guQYDsdNQyhrPg5XBrvWHnKAPzrrcBYL4N+mAg5rUAE42VuBs0Mm
        gAMpuWuH+sOOzveWdgi5B2p1Xix9FH7qSgFmGpJ2cGjGni1hBx805CAszYPpaXxW7QE1nZUb
        sW19/QiLaTjf/AfPBu6aTedoNp2j+Z9bCJAy4MTEyqMkjPyAlIn3lIuj5LFSiee16KgasPrD
        elY6FxuBbvlqOyAJILTl7S47FMRHxXHyhKh2AAlE6Mirb1yleKHihERGFh0ii41k5O1gK8EV
        OvFuWU1c5pMSsYKJYJgYRra+5RDWLkqQWNsSMx9B16xUT+DSQdFZj0yBzM92YQYdVyXtC5Nm
        P6o/qccVzcm08iKWkucY4BY/8Sv5Rpj3Gd/WZL1zqVYncA3Ozt01rXDewtH6e562/Tw6eczK
        JAqUVbqbkrqclcMnJCFY04WOrB139Kp3pxR9jW3n5zJuH5SE6/nnjGlCrjxM7LMXkcnF/wBx
        1nOQXQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7qd26xiDaZP17TYOGM9q8X8I+dY
        LZoXr2ezOH9+A7vF5V1z2CxmnN/HZLFoWSuzxcsjPxgt1h65y27x4+F0Jos/9+6wWrTuPcJu
        MeH3BTYHXo9bd+o9Nq3qZPPYP3cNu8eb06fYPTa+28HkMfvuD0aPvi2rGD0+b5IL4IjSsynK
        Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7i60qZgtnLF
        8jtLWBsYz8t0MXJySAiYSEz5t4C5i5GLQ0hgKaPErZ0dTBAJGYmT0xpYIWxhiT/Xutggij4x
        Spz72wWWYBMwlOh6C5Lg5BARcJLoXHsarIhZ4BqzxI6LnWAJYYEYibs7vgA1cHCwCKhKfHqi
        ABLmFbCReLHtLgvEAnmJ1RsOMIPYnAK2Er3P1oIdIQRUs//XbjaIekGJkzOfsICMYRZQl1g/
        TwgkzAzU2rx1NvMERsFZSKpmIVTNQlK1gJF5FaNIamlxbnpusaFecWJucWleul5yfu4mRmBc
        bjv2c/MOxksbgw8xCnAwKvHwXlhuGSvEmlhWXJl7iFGCg1lJhHfrDqAQb0piZVVqUX58UWlO
        avEhRlOgzyYyS4km5wNTRl5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4m
        Dk6pBkb344lrr8zO3LY/VSTtcPfK9qdPc2LWZcyYmBV5aGV0ykbVR42200SZoroc15zgteQw
        D/5vayAQq/Dqc4L4tZrjR35y5UpvvKCxUfLhlXTBwyfyPynlBuipGXDPqytiDuBsC/JYGn25
        yJuZ7+0xoXnXa0q3L9lv7GjZdnl3VZCuc8/NVVsL7ZVYijMSDbWYi4oTAe708dThAgAA
X-CMS-MailID: 20190726081505eucas1p146c14eed320c57050aa968b7c97b227b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190726081505eucas1p146c14eed320c57050aa968b7c97b227b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190726081505eucas1p146c14eed320c57050aa968b7c97b227b
References: <20190726081453.9456-1-m.szyprowski@samsung.com>
        <CGME20190726081505eucas1p146c14eed320c57050aa968b7c97b227b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the code for getting generic PHYs from standard device tree array
from the main controller device node. This is a first step in resolving
the conflict between Exynos EHCI/OHCI sub-nodes and generic USB device
bindings. Later the sub-nodes currently used for assigning PHYs to root
ports of the controller will be removed making a place for the generic
USB device bindings nodes.

Suggested-by: Måns Rullgård <mans@mansr.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/host/ehci-exynos.c | 23 +++++++++++++++++++----
 drivers/usb/host/ohci-exynos.c | 23 +++++++++++++++++++----
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index 3a29a1a8519c..01debfd03d4a 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -41,6 +41,7 @@ struct exynos_ehci_hcd {
 	struct clk *clk;
 	struct device_node *of_node;
 	struct phy *phy[PHY_NUMBER];
+	bool legacy_phy;
 };
 
 #define to_exynos_ehci(hcd) (struct exynos_ehci_hcd *)(hcd_to_ehci(hcd)->priv)
@@ -50,10 +51,22 @@ static int exynos_ehci_get_phy(struct device *dev,
 {
 	struct device_node *child;
 	struct phy *phy;
-	int phy_number;
+	int phy_number, num_phys;
 	int ret;
 
 	/* Get PHYs for the controller */
+	num_phys = of_count_phandle_with_args(dev->of_node, "phys",
+					      "#phy-cells");
+	for (phy_number = 0; phy_number < num_phys; phy_number++) {
+		phy = devm_of_phy_get_by_index(dev, dev->of_node, phy_number);
+		if (IS_ERR(phy))
+			return PTR_ERR(phy);
+		exynos_ehci->phy[phy_number] = phy;
+	}
+	if (num_phys > 0)
+		return 0;
+
+	/* Get PHYs using legacy bindings */
 	for_each_available_child_of_node(dev->of_node, child) {
 		ret = of_property_read_u32(child, "reg", &phy_number);
 		if (ret) {
@@ -84,6 +97,7 @@ static int exynos_ehci_get_phy(struct device *dev,
 		}
 	}
 
+	exynos_ehci->legacy_phy = true;
 	return 0;
 }
 
@@ -205,11 +219,12 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 	ehci->caps = hcd->regs;
 
 	/*
-	 * Workaround: reset of_node pointer to avoid conflict between Exynos
-	 * EHCI port subnodes and generic USB device bindings
+	 * Workaround: reset of_node pointer to avoid conflict between legacy
+	 * Exynos EHCI port subnodes and generic USB device bindings
 	 */
 	exynos_ehci->of_node = pdev->dev.of_node;
-	pdev->dev.of_node = NULL;
+	if (exynos_ehci->legacy_phy)
+		pdev->dev.of_node = NULL;
 
 	/* DMA burst Enable */
 	writel(EHCI_INSNREG00_ENABLE_DMA_BURST, EHCI_INSNREG00(hcd->regs));
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 905c6317e0c3..d5ce98e205c7 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -32,6 +32,7 @@ struct exynos_ohci_hcd {
 	struct clk *clk;
 	struct device_node *of_node;
 	struct phy *phy[PHY_NUMBER];
+	bool legacy_phy;
 };
 
 static int exynos_ohci_get_phy(struct device *dev,
@@ -39,10 +40,22 @@ static int exynos_ohci_get_phy(struct device *dev,
 {
 	struct device_node *child;
 	struct phy *phy;
-	int phy_number;
+	int phy_number, num_phys;
 	int ret;
 
 	/* Get PHYs for the controller */
+	num_phys = of_count_phandle_with_args(dev->of_node, "phys",
+					      "#phy-cells");
+	for (phy_number = 0; phy_number < num_phys; phy_number++) {
+		phy = devm_of_phy_get_by_index(dev, dev->of_node, phy_number);
+		if (IS_ERR(phy))
+			return PTR_ERR(phy);
+		exynos_ohci->phy[phy_number] = phy;
+	}
+	if (num_phys > 0)
+		return 0;
+
+	/* Get PHYs using legacy bindings */
 	for_each_available_child_of_node(dev->of_node, child) {
 		ret = of_property_read_u32(child, "reg", &phy_number);
 		if (ret) {
@@ -73,6 +86,7 @@ static int exynos_ohci_get_phy(struct device *dev,
 		}
 	}
 
+	exynos_ohci->legacy_phy = true;
 	return 0;
 }
 
@@ -172,11 +186,12 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * Workaround: reset of_node pointer to avoid conflict between Exynos
-	 * OHCI port subnodes and generic USB device bindings
+	 * Workaround: reset of_node pointer to avoid conflict between legacy
+	 * Exynos OHCI port subnodes and generic USB device bindings
 	 */
 	exynos_ohci->of_node = pdev->dev.of_node;
-	pdev->dev.of_node = NULL;
+	if (exynos_ohci->legacy_phy)
+		pdev->dev.of_node = NULL;
 
 	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (err) {
-- 
2.17.1

