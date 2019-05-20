Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D831EC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A328320815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="smyRVsSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbfETJIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:08:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40753 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfETJIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:08:36 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190520090834euoutp012fed366e6d5352b9ccb1c914fa24489a~gWPznLw8A2334223342euoutp011
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 09:08:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190520090834euoutp012fed366e6d5352b9ccb1c914fa24489a~gWPznLw8A2334223342euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558343314;
        bh=F6KtNC0NMgH4WuuveNuxoi+XAP2gbgG4+yRzDs8W2tk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=smyRVsSIsC9cQdRm030ERHofF2gML5TKz1Nu8BBKYQhRichG3Slr0UG5LBltoFz9C
         80ixSpYNjSjTQW3TGnrF0iXunuw3vvT0VQTS4kSCJveIUsrxmyJyXw7cyeFNeRgFq5
         WK0vVftEYUQytsJIHvEmJDid5xb4VVcThTdF5jZM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190520090833eucas1p25395a1a4cc560cce211bb9f3aa720095~gWPy0jT2p0817608176eucas1p2q;
        Mon, 20 May 2019 09:08:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C6.DA.04325.19E62EC5; Mon, 20
        May 2019 10:08:33 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190520090832eucas1p163fb465647a030c5eafe399e4b5377c8~gWPyC8zWV0897408974eucas1p1s;
        Mon, 20 May 2019 09:08:32 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-d5-5ce26e91b05f
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 63.14.04146.09E62EC5; Mon, 20
        May 2019 10:08:32 +0100 (BST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PRS00MNKPE4IJ30@eusync3.samsung.com>;
        Mon, 20 May 2019 10:08:32 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v5] usb: exynos: add workaround for the USB device bindings
 conflict
Date:   Mon, 20 May 2019 11:08:23 +0200
Message-id: <20190520090823.17189-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7djP87oT8x7FGMx4zGaxccZ6VovmxevZ
        LM6f38BucXnXHDaLGef3MVksWtbKbPHyyA9Gi7VH7rJb/Hg4ncniz707rBYTfl9gc+D2uHWn
        3mPTqk42j/1z17B7vDl9it1j47sdTB6z7/5g9OjbsorR4/MmuQCOKC6blNSczLLUIn27BK6M
        7WunMhfcVKxY16HYwLhCpouRk0NCwESic/Mk1i5GLg4hgRWMEi3rPjNBOJ8ZJR5taGODqXoy
        fSczRGIZo8TPX/fYQRK8AoISPybfY+li5OBgFpCXOHIpGyTMLKApsXX3enaI+v+MEuv2r2QC
        SbAJGEp0ve0CGyoikCBxZPN7sKHMAh+YJN4dbWQGSQgLhElMubkYzGYRUJXofjGbFWKZrcSR
        6+ugLpKXWL3hAFizhMB1Nom+xauhEi4SJ+7DFMlIdHYcZIIoamaUeHhuLTuE08MocblpBiNE
        lbXE4eMXWSEO55OYtG06M8g/EgK8Eh1tQhAlHhI723vBhgoJxEosubSTcQKj1CykEJiFCIFZ
        SCGwgJF5FaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmCKOP3v+NcdjPv+JB1iFOBgVOLh
        9Zj+MEaINbGsuDL3EKMEB7OSCK+x+v0YId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTS
        E0tSs1NTC1KLYLJMHJxSDYwJBs+3ZB9f4fjM1jz+zarW1ra79vdEjZZsudnj2NynUbvjsHhD
        nWji8f2XpMqsH5S2zHU6+ikud+ppzpPX9r/Re+FkFzv9juCb72+ZWf6KzT1zI0s5clpbuCBL
        mNCc+7kvfJ792sR6e4bihhkzpF61b5/c/ay6YtnjGdeZxBnPci0VVgmoEhJRYinOSDTUYi4q
        TgQAVndaHA0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsVy+t/xq7oT8h7FGCxZoWSxccZ6VovmxevZ
        LM6f38BucXnXHDaLGef3MVksWtbKbPHyyA9Gi7VH7rJb/Hg4ncniz707rBYTfl9gc+D2uHWn
        3mPTqk42j/1z17B7vDl9it1j47sdTB6z7/5g9OjbsorR4/MmuQCOKC6blNSczLLUIn27BK6M
        7WunMhfcVKxY16HYwLhCpouRk0NCwETiyfSdzF2MXBxCAksYJZonTmUFSfAKCEr8mHyPpYuR
        g4NZQF7iyKVskDCzgLrEpHmLoOobmSTmvbzPCJJgEzCU6HrbxQZiiwgkSCx5u5kdpIhZ4BOT
        RNObVmaQhLBAmMSUm4vBbBYBVYnuF7OhltlKHLm+jg3iInmJ1RsOME9g5J2F5I5ZCHfMQnLH
        AkbmVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHBve3Yz807GC9tDD7EKMDBqMTD+2HKwxgh
        1sSy4srcQ4wSHMxKIrzG6vdjhHhTEiurUovy44tKc1KLDzFKc7AoifN2CByMERJITyxJzU5N
        LUgtgskycXBKNTCKOtesDGD1exbwM/37DHGmPm+Putti8iKx9YtK0rhZdl+z0mm03MtSW7v7
        3hYvg6/ez/9dfK46+yaTyWKvMzfeOySmvDPWjQks81jJGWbdmRzO4fou8ZfIpOMp5envjmxO
        +j0xSFTsX5tR2KxN/NcFJ3Jc714tHiL5TVzGZ/lE78n6i1wMpyqxFGckGmoxFxUnAgAUSI7p
        agIAAA==
X-CMS-MailID: 20190520090832eucas1p163fb465647a030c5eafe399e4b5377c8
CMS-TYPE: 201P
X-CMS-RootMailID: 20190520090832eucas1p163fb465647a030c5eafe399e4b5377c8
References: <CGME20190520090832eucas1p163fb465647a030c5eafe399e4b5377c8@eucas1p1.samsung.com>
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
v5:
- fixed error path handling as pointed by Alan

v4: https://patchwork.kernel.org/patch/10947773/
- moved workaround to Exynos OHCI/EHCI drivers as suggested by Måns

v3: https://lkml.org/lkml/2019/5/9/119
- replaced ad hoc checks by proper test for proper value of the
  compatible string in drivers/usb/core/of.c

v2: https://lkml.org/lkml/2019/5/8/321

v1: https://lkml.org/lkml/2019/5/7/715
---
 drivers/usb/host/ehci-exynos.c | 11 +++++++++++
 drivers/usb/host/ohci-exynos.c | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index 8e3bab1e0c1f..3a29a1a8519c 100644
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
 
@@ -219,6 +227,7 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 
 fail_add_hcd:
 	exynos_ehci_phy_disable(&pdev->dev);
+	pdev->dev.of_node = exynos_ehci->of_node;
 fail_io:
 	clk_disable_unprepare(exynos_ehci->clk);
 fail_clk:
@@ -231,6 +240,8 @@ static int exynos_ehci_remove(struct platform_device *pdev)
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct exynos_ehci_hcd *exynos_ehci = to_exynos_ehci(hcd);
 
+	pdev->dev.of_node = exynos_ehci->of_node;
+
 	usb_remove_hcd(hcd);
 
 	exynos_ehci_phy_disable(&pdev->dev);
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index c0c4dcca6f3c..905c6317e0c3 100644
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
@@ -180,6 +188,7 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 
 fail_add_hcd:
 	exynos_ohci_phy_disable(&pdev->dev);
+	pdev->dev.of_node = exynos_ohci->of_node;
 fail_io:
 	clk_disable_unprepare(exynos_ohci->clk);
 fail_clk:
@@ -192,6 +201,8 @@ static int exynos_ohci_remove(struct platform_device *pdev)
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
 
+	pdev->dev.of_node = exynos_ohci->of_node;
+
 	usb_remove_hcd(hcd);
 
 	exynos_ohci_phy_disable(&pdev->dev);
-- 
2.17.1

