Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BC2C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926FD217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ISx+VM17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfEUMD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:03:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47512 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfEUMD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:03:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190521120356euoutp02c892e1840ad7d6ff3bdc5d3d4865cb6b~gsSNMKnkE2172121721euoutp02f
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:03:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190521120356euoutp02c892e1840ad7d6ff3bdc5d3d4865cb6b~gsSNMKnkE2172121721euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558440236;
        bh=CHPrUFU5Cx2/8C7het5Q6gacxBr3DSqd8aCWWckjr4k=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=ISx+VM17AcI/IWORtry6RQhOT6uer+KemjxtKKLtphzpDp8rrTn6b/2qQC+QbHr+N
         VCu3N+z1zfR7tY4qBDI520z6ex5KwvxhtVlR+583mOelCuhjDx2X9uePwmcl7LRp2k
         xocqK8VnDSQRSOakQ4Se5x30OiYfG9YPILfZoqLg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190521120355eucas1p1cb595d69733fd52ed44f2893c2900090~gsSMRVO8F2855228552eucas1p1F;
        Tue, 21 May 2019 12:03:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 11.3B.04377.A29E3EC5; Tue, 21
        May 2019 13:03:54 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190521120354eucas1p2a39ba06586ddd388a9c376a40327bb4c~gsSLeG_4H2602826028eucas1p2P;
        Tue, 21 May 2019 12:03:54 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-b5-5ce3e92afa46
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5A.DE.04140.A29E3EC5; Tue, 21
        May 2019 13:03:54 +0100 (BST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PRU006F4RY90T20@eusync4.samsung.com>;
        Tue, 21 May 2019 13:03:53 +0100 (BST)
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
Subject: [PATCH 5/5] usb: exynos: Remove support for legacy PHY bindings
Date:   Tue, 21 May 2019 13:58:49 +0200
Message-id: <20190521115849.9882-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190521115849.9882-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTcRTG++/uvjha3KbhH7WkUYGSmiF5Kw2NwhsYGEmBGbnyouKctqum
        liSKZbeUlYK2fMM3bGW+pLKMzObQcOEsZdhwkhnITP3inK9pzavkt+ec5wfnnIdDIJKnqBuR
        oEhllAqZXIqJhJ19y0Yfb+tk9DHT+kmqtawZpar0gyiVV9uMUUZjC04Nd5VjVJmxW0DVNOQj
        lFW/BKgmvQWnliZKBdTa+BhK5X/Q45RqdQgLEdPmsft0m+YRRn+seI3TM4YBnG6d0wroF5Yl
        QBe1awA933YggogSBcUy8oR0Rul3JkYUb6jsRFLsfhm63xo0B1iOcMCJgGQAtFprEA6ICAnZ
        CGDvZzvKF/MAtpavC7apPlsb4I0GACfHexCHISb3wqXicSEHCAIhPaH+W6KjjZBesON9M87z
        GwB+minY5DHSH3KzHObQLmQIrKsfwxwQQg4isHa5YHOaM0nDLm0v7tBC8jAcLjKh/LAgWG9t
        wPmNPOGrFn4JJzIYVuVOIXx/A4ONjUd5fQ5qqzYArz3gcPFjoWMYJPMAnBhswvniCYDDuWVb
        1GnY2/8V5W/YA591liKO0yAphgUPJDxCQ82Xgq2MVACOlMygKuCu3pGG+n8a6h1pVANEA1yZ
        NDYpjmGPK5g7vqwsiU1TxPneSk5qA/8exbDeb9OCrrWbOkASQLpbTE1MRktQWTqbmaQDkECk
        LmLDwM9oiThWlpnFKJNvKNPkDKsD7oRQ6iq+u+vHNQkZJ0tlEhkmhVFuuwLCyS0HvPwTxamd
        5wYO3gs1rUVWms5fGJpu9+8NeFuR220byy6M+SWszFKFX4qwnIgaNe/zqXv30GUF2rNnibOr
        p7iV7yPyywvG51cXwm2HRi+GLUZUM4VYR0bCdZVfceB0iJeZ6Vg0mYFHGFfo59z3JvBKjJPh
        tr1kNXhKS4b27F+OlArZeJm/N6JkZX8BRYvEriQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xa7paLx/HGHycwGSxccZ6Vov5R86x
        WjQvXs9mcf78BnaLy7vmsFnMOL+PyWLRslZmi5dHfjBarD1yl93ix8PpTBZ/7t1htWjde4Td
        YsLvC2wOvB637tR7bFrVyeaxf+4ado83p0+xe2x8t4PJY/bdH4wefVtWMXp83iQXwBHFZZOS
        mpNZllqkb5fAlXF63jbmgm/6FYder2JtYLyr1sXIySEhYCJx7Msmxi5GLg4hgSWMEsdfX2cE
        SfAKCEr8mHyPpYuRg4NZQF7iyKVskDCzgLrEpHmLmCHqG5kkrq5fyQaSYBMwlOh62wVmiwg4
        SCxZeocNpIhZ4AKzROeOP+wgCWEBD4ldOw6D2SwCqhKX+66xQiyzkVj6chk7xEXyEqs3HGAG
        sTkFbCXmNz0Hs4WAal7N6GCewMg/C8l9sxDum4XkvgWMzKsYRVJLi3PTc4uN9IoTc4tL89L1
        kvNzNzECY2TbsZ9bdjB2vQs+xCjAwajEw/vg3uMYIdbEsuLK3EOMEhzMSiK8p089ihHiTUms
        rEotyo8vKs1JLT7EKM3BoiTO2yFwMEZIID2xJDU7NbUgtQgmy8TBKdXAWLSpsmGFsZCpVccf
        Lh2RZXm2TZbl3duPt78T2nKN6YjLr0qOLo/r/bJ1QpIJk8M3vWfZcjRl+poLf6/uev1ghpfm
        pcIURttdXNvZvOs2z9F42WryOGpK6YX80lmLa14vtLs5nXN2xo7rth8vzu40maw3nduDv67j
        CZfjcfFbz0sO/RNVuPNOWImlOCPRUIu5qDgRANDy9seNAgAA
X-CMS-MailID: 20190521120354eucas1p2a39ba06586ddd388a9c376a40327bb4c
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521120354eucas1p2a39ba06586ddd388a9c376a40327bb4c
References: <20190521115849.9882-1-m.szyprowski@samsung.com>
        <CGME20190521120354eucas1p2a39ba06586ddd388a9c376a40327bb4c@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exnyos EHCI/OHCI custom port device tree sub-nodes under EHCI/OHCI
devices has been removed, so the code for handling them can be also
removed. Once this has been done, we can also remove the workaround
added by commit 01d4071486fe ("usb: exynos: add workaround for the USB
device bindings conflict") and enable support for the generic USB device
bindings.

Suggested-by: Måns Rullgård <mans@mansr.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/host/ehci-exynos.c | 46 ----------------------------------
 drivers/usb/host/ohci-exynos.c | 46 ----------------------------------
 2 files changed, 92 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index 2a551a807ec0..afde1ffa0824 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -39,7 +39,6 @@ static struct hc_driver __read_mostly exynos_ehci_hc_driver;
 
 struct exynos_ehci_hcd {
 	struct clk *clk;
-	struct device_node *of_node;
 	struct phy *phy[PHY_NUMBER];
 };
 
@@ -48,10 +47,8 @@ struct exynos_ehci_hcd {
 static int exynos_ehci_get_phy(struct device *dev,
 				struct exynos_ehci_hcd *exynos_ehci)
 {
-	struct device_node *child;
 	struct phy *phy;
 	int phy_number, num_phys;
-	int ret;
 
 	/* Get PHYs for the controller */
 	num_phys = of_count_phandle_with_args(dev->of_node, "phys",
@@ -62,39 +59,6 @@ static int exynos_ehci_get_phy(struct device *dev,
 			return PTR_ERR(phy);
 		exynos_ehci->phy[phy_number] = phy;
 	}
-	if (num_phys)
-		return 0;
-
-	/* Get PHYs using legacy bindings */
-	for_each_available_child_of_node(dev->of_node, child) {
-		ret = of_property_read_u32(child, "reg", &phy_number);
-		if (ret) {
-			dev_err(dev, "Failed to parse device tree\n");
-			of_node_put(child);
-			return ret;
-		}
-
-		if (phy_number >= PHY_NUMBER) {
-			dev_err(dev, "Invalid number of PHYs\n");
-			of_node_put(child);
-			return -EINVAL;
-		}
-
-		phy = devm_of_phy_get(dev, child, NULL);
-		exynos_ehci->phy[phy_number] = phy;
-		if (IS_ERR(phy)) {
-			ret = PTR_ERR(phy);
-			if (ret == -EPROBE_DEFER) {
-				of_node_put(child);
-				return ret;
-			} else if (ret != -ENOSYS && ret != -ENODEV) {
-				dev_err(dev,
-					"Error retrieving usb2 phy: %d\n", ret);
-				of_node_put(child);
-				return ret;
-			}
-		}
-	}
 
 	return 0;
 }
@@ -216,13 +180,6 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 	ehci = hcd_to_ehci(hcd);
 	ehci->caps = hcd->regs;
 
-	/*
-	 * Workaround: reset of_node pointer to avoid conflict between Exynos
-	 * EHCI port subnodes and generic USB device bindings
-	 */
-	exynos_ehci->of_node = pdev->dev.of_node;
-	pdev->dev.of_node = NULL;
-
 	/* DMA burst Enable */
 	writel(EHCI_INSNREG00_ENABLE_DMA_BURST, EHCI_INSNREG00(hcd->regs));
 
@@ -239,7 +196,6 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 
 fail_add_hcd:
 	exynos_ehci_phy_disable(&pdev->dev);
-	pdev->dev.of_node = exynos_ehci->of_node;
 fail_io:
 	clk_disable_unprepare(exynos_ehci->clk);
 fail_clk:
@@ -252,8 +208,6 @@ static int exynos_ehci_remove(struct platform_device *pdev)
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct exynos_ehci_hcd *exynos_ehci = to_exynos_ehci(hcd);
 
-	pdev->dev.of_node = exynos_ehci->of_node;
-
 	usb_remove_hcd(hcd);
 
 	exynos_ehci_phy_disable(&pdev->dev);
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 195ea5fa021e..8e9f4ef4e397 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -30,17 +30,14 @@ static struct hc_driver __read_mostly exynos_ohci_hc_driver;
 
 struct exynos_ohci_hcd {
 	struct clk *clk;
-	struct device_node *of_node;
 	struct phy *phy[PHY_NUMBER];
 };
 
 static int exynos_ohci_get_phy(struct device *dev,
 				struct exynos_ohci_hcd *exynos_ohci)
 {
-	struct device_node *child;
 	struct phy *phy;
 	int phy_number, num_phys;
-	int ret;
 
 	/* Get PHYs for the controller */
 	num_phys = of_count_phandle_with_args(dev->of_node, "phys",
@@ -51,39 +48,6 @@ static int exynos_ohci_get_phy(struct device *dev,
 			return PTR_ERR(phy);
 		exynos_ohci->phy[phy_number] = phy;
 	}
-	if (num_phys)
-		return 0;
-
-	/* Get PHYs using legacy bindings */
-	for_each_available_child_of_node(dev->of_node, child) {
-		ret = of_property_read_u32(child, "reg", &phy_number);
-		if (ret) {
-			dev_err(dev, "Failed to parse device tree\n");
-			of_node_put(child);
-			return ret;
-		}
-
-		if (phy_number >= PHY_NUMBER) {
-			dev_err(dev, "Invalid number of PHYs\n");
-			of_node_put(child);
-			return -EINVAL;
-		}
-
-		phy = devm_of_phy_get(dev, child, NULL);
-		exynos_ohci->phy[phy_number] = phy;
-		if (IS_ERR(phy)) {
-			ret = PTR_ERR(phy);
-			if (ret == -EPROBE_DEFER) {
-				of_node_put(child);
-				return ret;
-			} else if (ret != -ENOSYS && ret != -ENODEV) {
-				dev_err(dev,
-					"Error retrieving usb2 phy: %d\n", ret);
-				of_node_put(child);
-				return ret;
-			}
-		}
-	}
 
 	return 0;
 }
@@ -183,13 +147,6 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 		goto fail_io;
 	}
 
-	/*
-	 * Workaround: reset of_node pointer to avoid conflict between Exynos
-	 * OHCI port subnodes and generic USB device bindings
-	 */
-	exynos_ohci->of_node = pdev->dev.of_node;
-	pdev->dev.of_node = NULL;
-
 	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add USB HCD\n");
@@ -200,7 +157,6 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 
 fail_add_hcd:
 	exynos_ohci_phy_disable(&pdev->dev);
-	pdev->dev.of_node = exynos_ohci->of_node;
 fail_io:
 	clk_disable_unprepare(exynos_ohci->clk);
 fail_clk:
@@ -213,8 +169,6 @@ static int exynos_ohci_remove(struct platform_device *pdev)
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
 
-	pdev->dev.of_node = exynos_ohci->of_node;
-
 	usb_remove_hcd(hcd);
 
 	exynos_ohci_phy_disable(&pdev->dev);
-- 
2.17.1

