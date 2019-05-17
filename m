Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D21C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2B020879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dZYArZrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfEQK5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:57:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52063 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfEQK5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:57:19 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190517105717euoutp01b10477b9d8df68afb4a57db5dae79549~fcy3_Aghs2453624536euoutp01P;
        Fri, 17 May 2019 10:57:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190517105717euoutp01b10477b9d8df68afb4a57db5dae79549~fcy3_Aghs2453624536euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558090637;
        bh=GHxtnDlgcHGdjozDjzQMyJD91oTHv+OsBP5Hlks3kaI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=dZYArZrSAENx1/IWipg0U4nd/xSUf7jpuOv+Ea85pU/4FmzwXu8uejjsYgdidGplP
         N7BsxN2yuLh6t+DdyjQDgAwZz7yjQDMRS/WWEIcR7h8piy2PTQLQr3YoHNCNyJskO5
         f58WE76CbXORwf2JDutABcQSyMF+WnB6sU7CgWsI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190517105716eucas1p2783b31ad4a2795f21342adc8c2da6cf0~fcy3gArxk2618626186eucas1p2x;
        Fri, 17 May 2019 10:57:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C2.5A.04298.C839EDC5; Fri, 17
        May 2019 11:57:16 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190517105716eucas1p108609f1a119877c866f8afd194fdaa34~fcy233LQb1088710887eucas1p1q;
        Fri, 17 May 2019 10:57:16 +0000 (GMT)
X-AuditID: cbfec7f2-3615e9c0000010ca-9c-5cde938c37d6
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 39.83.04146.C839EDC5; Fri, 17
        May 2019 11:57:16 +0100 (BST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PRN00CD3AFAQR60@eusync3.samsung.com>;
        Fri, 17 May 2019 11:57:15 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v4] usb: exynos: add workaround for the USB device bindings
 conflict
Date:   Fri, 17 May 2019 12:57:02 +0200
Message-id: <20190517105702.4522-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djP87o9k+/FGOy/oW2xccZ6VovmxevZ
        LM6f38BucXnXHDaLGef3MVksWtbKbPHyyA9Gi7VH7rJb/Hg4ncniz707rA5cHrfu1HtsWtXJ
        5rF/7hp2jzenT7F7bHy3g8mjb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Mpo+PGUs+CtT8fzn
        G8YGxoUSXYycHBICJhL3/rYzdTFycQgJrGCUuHBsLjOE85lRonPlK0aYqu9Pm9kgEssYJc5/
        28oOkuAVEJT4MfkeSxcjBwezgLzEkUvZIGFmAU2JrbvXs0PU/2eU2DnnDitIgk3AUKLrbRcb
        iC0ikCBxZPN7sG3MAseYJD5d+8ACkhAWCJNovL8ebDOLgKrEpZkroZbZSNw6+44N4iJ5idUb
        DoA1SwicYJM4fWExO0TCReL+l/1QZ8tIdHYcZIIoamaUeHhuLTuE08MocblpBlSVtcTh4xdZ
        IQ7nk5i0bTozyD8SArwSHW1CEKaHxKSr8SAVQgKxErun/GCbwCg1CykAZiECYBZSACxgZF7F
        KJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRmA5O/zv+aQfj10tJhxgFOBiVeHgFfO7GCLEm
        lhVX5h5ilOBgVhLh3fD+dowQb0piZVVqUX58UWlOavEhRmkOFiVx3mqGB9FCAumJJanZqakF
        qUUwWSYOTqkGxt4jhYm3t83N8tyXx3NnzXKn7U7N3683XXCfFeR94UzMjK3vf5yKcz3Pc+Rh
        Bt8vI+GV39+fPGcrdmZmycG46fJ/QuKflO7h/982aVX2jD87HE33FB90s+I7/VX0TM7OlmbL
        iJxS21f5Odq7p0gHBnm47c8/NCHGzfWU6vlDT67M+briRdZJ6SglluKMREMt5qLiRAC2U4sb
        AwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsVy+t/xq7o9k+/FGLR/ZLTYOGM9q0Xz4vVs
        FufPb2C3uLxrDpvFjPP7mCwWLWtltnh55Aejxdojd9ktfjyczmTx594dVgcuj1t36j02repk
        89g/dw27x5vTp9g9Nr7bweTRt2UVo8fnTXIB7FFcNimpOZllqUX6dglcGU0fnjIW/JWpeP7z
        DWMD40KJLkZODgkBE4nvT5vZuhi5OIQEljBKvH3UzAKS4BUQlPgx+R6QzcHBLCAvceRSNkiY
        WUBdYtK8RcwQ9Y1MEr/O3GcGSbAJGEp0ve1iA7FFBBIklrzdzA5SxCxwgkniytkPrCAJYYEw
        icb76xlBbBYBVYlLM1eyQyyzkbh19h0bxEXyEqs3HGCewMg7C8kdsxDumIXkjgWMzKsYRVJL
        i3PTc4sN9YoTc4tL89L1kvNzNzECQ3nbsZ+bdzBe2hh8iFGAg1GJh1fA526MEGtiWXFl7iFG
        CQ5mJRHeDe9vxwjxpiRWVqUW5ccXleakFh9ilOZgURLn7RA4GCMkkJ5YkpqdmlqQWgSTZeLg
        lGpgDFfwv8rwpyS1ncGcJdBPI0P20Nxq0TefuH50Gn+auK6Bt/TalpJj/hyRBiFPy4O97j2s
        WFGx5/aPk7suBCTOt3OY/FTRvfMXT0lMl1be/EfXjm28G+9nMm9P+P81t5/2Ps73u5f/92fX
        FYnIiIpfyndfdYv+ntcczdvHHSS4eW/8kneV5c8XKrEUZyQaajEXFScCAMqOlEZhAgAA
X-CMS-MailID: 20190517105716eucas1p108609f1a119877c866f8afd194fdaa34
CMS-TYPE: 201P
X-CMS-RootMailID: 20190517105716eucas1p108609f1a119877c866f8afd194fdaa34
References: <CGME20190517105716eucas1p108609f1a119877c866f8afd194fdaa34@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 69bec7259853 ("USB: core: let USB device know device node") added
support for attaching devicetree node for USB devices. Those nodes are
children of their USB host controller. However Exynos EHCI and OHCI
driver bindings already define child-nodes for each physical root hub
port and assigns respective PHY controller and parameters to them. Those
bindings predates support for USB device tree nodes.

To mitigate the side-effects of the conflict between those bindings,
lets reset Exynos host controller of_node pointer before registering it
to USB subsystem. This fixes the issue raised by the commit 01fdf179f4b0
("usb: core: skip interfaces disabled in devicetree"), which incorrectly
disabled some devices on Exynos based boards.

Reported-by: Markus Reichl <m.reichl@fivetechno.de>
Suggested-by: Måns Rullgård <mans@mansr.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v4:
- moved workaround to Exynos OHCI/EHCI drivers as suggested by Måns

v3: https://lkml.org/lkml/2019/5/9/119
- replaced ad hoc checks by proper test for proper value of the
  compatible string in drivers/usb/core/of.c

v2: https://lkml.org/lkml/2019/5/8/321

v1: https://lkml.org/lkml/2019/5/7/715
---
 drivers/usb/host/ehci-exynos.c | 10 ++++++++++
 drivers/usb/host/ohci-exynos.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index 8e3bab1e0c1f..b127642332ee 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -39,6 +39,7 @@ static struct hc_driver __read_mostly exynos_ehci_hc_driver;
 
 struct exynos_ehci_hcd {
 	struct clk *clk;
+	struct device_node *of_node;
 	struct phy *phy[PHY_NUMBER];
 };
 
@@ -203,6 +204,13 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 	ehci = hcd_to_ehci(hcd);
 	ehci->caps = hcd->regs;
 
+	/*
+	 * Workaround: reset of_node pointer to avoid conflict between Exynos
+	 * EHCI port subnodes and generic USB device bindings
+	 */
+	exynos_ehci->of_node = pdev->dev.of_node;
+	pdev->dev.of_node = NULL;
+
 	/* DMA burst Enable */
 	writel(EHCI_INSNREG00_ENABLE_DMA_BURST, EHCI_INSNREG00(hcd->regs));
 
@@ -231,6 +239,8 @@ static int exynos_ehci_remove(struct platform_device *pdev)
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct exynos_ehci_hcd *exynos_ehci = to_exynos_ehci(hcd);
 
+	pdev->dev.of_node = exynos_ehci->of_node;
+
 	usb_remove_hcd(hcd);
 
 	exynos_ehci_phy_disable(&pdev->dev);
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index c0c4dcca6f3c..29f65963af3b 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -30,6 +30,7 @@ static struct hc_driver __read_mostly exynos_ohci_hc_driver;
 
 struct exynos_ohci_hcd {
 	struct clk *clk;
+	struct device_node *of_node;
 	struct phy *phy[PHY_NUMBER];
 };
 
@@ -170,6 +171,13 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 		goto fail_io;
 	}
 
+	/*
+	 * Workaround: reset of_node pointer to avoid conflict between Exynos
+	 * OHCI port subnodes and generic USB device bindings
+	 */
+	exynos_ohci->of_node = pdev->dev.of_node;
+	pdev->dev.of_node = NULL;
+
 	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add USB HCD\n");
@@ -192,6 +200,8 @@ static int exynos_ohci_remove(struct platform_device *pdev)
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
 
+	pdev->dev.of_node = exynos_ohci->of_node;
+
 	usb_remove_hcd(hcd);
 
 	exynos_ohci_phy_disable(&pdev->dev);
-- 
2.17.1

