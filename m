Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A2CC04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E482173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G9NVtCSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfEUMCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:02:53 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57728 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfEUMCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:02:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190521120251euoutp0153a36125c6390e0c19936dec801be425~gsRQ3PevO3228532285euoutp01p
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:02:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190521120251euoutp0153a36125c6390e0c19936dec801be425~gsRQ3PevO3228532285euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558440171;
        bh=LICT6p63z28m+QBvow/NtYuLWxdakRY3i+TlswUz6bc=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=G9NVtCSbhZzYqEVop3794RGRuL0A3NkxorqZULqyTH86ltmFYpFuZExyHNPb5sb65
         NqsOgr2/ZAtLOKih99P3GkmQsoGq3GKmpt0QiEMl81cA3nm2NV+hraDDB9PzHbRSjo
         KeYYJgDrDLt99+ZjdRIGGiFQWbOYIZWdYj4UeJ/Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190521120250eucas1p1e0980b40c4b574111e72b1da9e5960cd~gsRQA9xsh0539705397eucas1p1w;
        Tue, 21 May 2019 12:02:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B1.EF.04298.AE8E3EC5; Tue, 21
        May 2019 13:02:50 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190521120249eucas1p2e4a8fec922fa78783d7d3fed785f3e3b~gsRPRCFfS0974209742eucas1p2m;
        Tue, 21 May 2019 12:02:49 +0000 (GMT)
X-AuditID: cbfec7f2-3615e9c0000010ca-b0-5ce3e8ea7c4c
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 54.62.04146.9E8E3EC5; Tue, 21
        May 2019 13:02:49 +0100 (BST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PRU006F4RY90T20@eusync4.samsung.com>;
        Tue, 21 May 2019 13:02:49 +0100 (BST)
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
Subject: [PATCH 3/5] usb: exynos: add support for getting PHYs from the
 standard dt array
Date:   Tue, 21 May 2019 13:58:47 +0200
Message-id: <20190521115849.9882-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190521115849.9882-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87qvXjyOMXi1gcdi44z1rBbzj5xj
        tWhevJ7N4vz5DewWl3fNYbOYcX4fk8WiZa3MFi+P/GC0WHvkLrvFj4fTmSz+3LvDatG69wi7
        xYTfF9gceD1u3an32LSqk81j/9w17B5vTp9i99j4bgeTx+y7Pxg9+rasYvT4vEkugCOKyyYl
        NSezLLVI3y6BK2PHiTVMBY0iFRNO32RtYDwk0MXIySEhYCJxdu1yxi5GLg4hgRWMEh83dTNB
        OJ8ZJS5PW88MU3Wo9wYzRGIZo8S3U13sIAleAUGJH5PvsXQxcnAwC8hLHLmUDRJmFtCU2Lp7
        PViJkMB/RomnUyJAbDYBQ4mut11sILaIgIPEkqV32EBmMgucY5ZY/LODCSQhLBAtsefeZbBm
        FgFViS0tLxghdtlIrF98B+ogeYnVGw6A2ZwCthLzm56DHSch8JtNon/2MTaIIheJ0wu/s0PY
        MhKdHQeZIIqaGSUenlvLDuH0AP3ZNIMRospa4vDxi6wQP/BJTNo2nRnkNQkBXomONiGIEg+J
        xomPWCBBMYFR4tbijUwTGKVnIYXGLERozEIKjQWMzKsYxVNLi3PTU4sN81LL9YoTc4tL89L1
        kvNzNzECE8rpf8c/7WD8einpEKMAB6MSD6/Fw8cxQqyJZcWVuYcYJTiYlUR4T596FCPEm5JY
        WZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2ampBahFMlomDU6qBkS1jR7XURwfP13+n
        XLp7evMKuTsX676IGnyUlxK30PeMy6gQ9zD6cTSwc6b3zDNvjv7SvWpVPvGLpoOk5b8piW8v
        S1hMfloZqMC+XufUc48jX+2X+x/Uyw+53uBfIBbSv1HT5em0pTYdillGB59J/jpg7n9H8vnl
        w52dJaX9O7Q5TypJPld0VWIpzkg01GIuKk4EAFki0cUkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xa7ovXzyOMfi/T8pi44z1rBbzj5xj
        tWhevJ7N4vz5DewWl3fNYbOYcX4fk8WiZa3MFi+P/GC0WHvkLrvFj4fTmSz+3LvDatG69wi7
        xYTfF9gceD1u3an32LSqk81j/9w17B5vTp9i99j4bgeTx+y7Pxg9+rasYvT4vEkugCOKyyYl
        NSezLLVI3y6BK2PHiTVMBY0iFRNO32RtYDwk0MXIySEhYCJxqPcGcxcjF4eQwBJGiQk/XrGC
        JHgFBCV+TL7H0sXIwcEsIC9x5FI2SJhZQF1i0rxFUPWNTBKzWhYygyTYBAwlut52sYHYIgIO
        EkuW3mEDKWIWuMAs0bnjDztIQlggWmLPvctgNouAqsSWlheMEMtsJNYvvsMMcZG8xOoNB8Bs
        TgFbiflNz8FsIaCaVzM6mCcw8s9Cct8shPtmIblvASPzKkaR1NLi3PTcYkO94sTc4tK8dL3k
        /NxNjMAY2Xbs5+YdjJc2Bh9iFOBgVOLhfXDvcYwQa2JZcWXuIUYJDmYlEd7Tpx7FCPGmJFZW
        pRblxxeV5qQWH2KU5mBREuftEDgYIySQnliSmp2aWpBaBJNl4uCUamA0LliY8Nwz6Hq0KFfx
        zbizc1lM1r7x5uUVcT9fEm+072tYrEW797Jn+1SmeU1Sr73jZSfhy1yqzcn6vNdZ9+O8Izpt
        qQlCQt69+msOyq4SmfFs8yv5oJcWi5/zhCfdfeRrevOPgcvLk9W/LMTig7NjVDZH/6z7ksHM
        GKDTFfOVo4LTxJWbVYmlOCPRUIu5qDgRABVdqLqNAgAA
X-CMS-MailID: 20190521120249eucas1p2e4a8fec922fa78783d7d3fed785f3e3b
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521120249eucas1p2e4a8fec922fa78783d7d3fed785f3e3b
References: <20190521115849.9882-1-m.szyprowski@samsung.com>
        <CGME20190521120249eucas1p2e4a8fec922fa78783d7d3fed785f3e3b@eucas1p2.samsung.com>
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
 drivers/usb/host/ehci-exynos.c | 14 +++++++++++++-
 drivers/usb/host/ohci-exynos.c | 14 +++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index 3a29a1a8519c..2a551a807ec0 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -50,10 +50,22 @@ static int exynos_ehci_get_phy(struct device *dev,
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
+	if (num_phys)
+		return 0;
+
+	/* Get PHYs using legacy bindings */
 	for_each_available_child_of_node(dev->of_node, child) {
 		ret = of_property_read_u32(child, "reg", &phy_number);
 		if (ret) {
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 905c6317e0c3..195ea5fa021e 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -39,10 +39,22 @@ static int exynos_ohci_get_phy(struct device *dev,
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
+	if (num_phys)
+		return 0;
+
+	/* Get PHYs using legacy bindings */
 	for_each_available_child_of_node(dev->of_node, child) {
 		ret = of_property_read_u32(child, "reg", &phy_number);
 		if (ret) {
-- 
2.17.1

