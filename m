Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BE3C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D30D2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c+yxA71N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgAHNXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:23:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36891 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgAHNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:23:53 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200108132350euoutp010cd00d5023f8871d360de60da3ffce8b~n7CNLlswU1848818488euoutp01h
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jan 2020 13:23:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200108132350euoutp010cd00d5023f8871d360de60da3ffce8b~n7CNLlswU1848818488euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578489830;
        bh=vlkCVhdICE1g4MM364vsZ5VbqdQdf/4uTZNggyFrW9Q=;
        h=From:To:Cc:Subject:Date:References:From;
        b=c+yxA71Nh794nkg8brjoYvYsl+7euFKaCoYjvBhR4cuQfWfK2MpHSagOv1X6m/ZyG
         D78NGdeQMEmVBYRGElwW/2joIynCcLz/r1n7Ia7OjKj5vfpQP4wh0oHSMd3QSLhPPo
         oKcqN7kmqIBjEFYpaMTtObtd4XcLarAFjXcEb83A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200108132350eucas1p2d58bb50b50d3336746802bbfb32a5d17~n7CNAQeuR1278412784eucas1p2Z;
        Wed,  8 Jan 2020 13:23:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3D.AF.60698.6E7D51E5; Wed,  8
        Jan 2020 13:23:50 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200108132350eucas1p1476f4aa038dbf5ea199b84c5c82a25a5~n7CMqvSkY1935519355eucas1p10;
        Wed,  8 Jan 2020 13:23:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200108132350eusmtrp250a3eb32693a004f118db0c56523ce66~n7CMqEuz61195311953eusmtrp2s;
        Wed,  8 Jan 2020 13:23:50 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-9f-5e15d7e6d122
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 44.A1.08375.6E7D51E5; Wed,  8
        Jan 2020 13:23:50 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200108132349eusmtip15b9cf16c83a41c808627c1c7bb3f8eb5~n7CMN4Dh91653416534eusmtip1P;
        Wed,  8 Jan 2020 13:23:49 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] phy: core: Fix error path in devm_of_phy_get()
Date:   Wed,  8 Jan 2020 14:23:42 +0100
Message-Id: <20200108132342.14635-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7djPc7rProvGGbQvk7XY+OQ0o8XGGetZ
        LS487WGzOH9+A7vF5V1z2CxmnN/HZLH2yF12B3aPTas62Tz6tqxi9Hj6Yy+zx/Eb25k8Pm+S
        C2CN4rJJSc3JLEst0rdL4MqYe/QIW8FJ0Yq5c86wNDB+F+pi5OSQEDCRmLXqBFsXIxeHkMAK
        Rol9W/YyQzhfGCU+bnnHDFIlJPCZUeL7cT6YjnX9qxkhipYzSnxdMokJruPoyeWMIFVsAoYS
        XW+72EBsEQFVic9tC9hBipgFWpgkLr7azASSEBawl1h0ZQeYzQJU1P5yDyuIzStgK/Gu/RAr
        xDp5idUbDoDdJCFwmU1i5sczjBAJF4kn626zQ9jCEq+Ob4GyZST+75zPBNHQzCjx8Nxadgin
        h1HictMMqG5riTvnfgHdxwF0k6bE+l36EGFHif1PprOChCUE+CRuvBUECTMDmZO2TWeGCPNK
        dLRBA09NYtbxdXBrD164BFXiIXF8bgAk5GIlVl9byD6BUW4WwqoFjIyrGMVTS4tz01OLjfNS
        y/WKE3OLS/PS9ZLzczcxApPB6X/Hv+5g3Pcn6RCjAAejEg/vj8UicUKsiWXFlbmHGCU4mJVE
        eLV0gEK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUwel45
        UlrDteH55ZNNZrvS3lmFNPGc9mbX4NwZ8dI65np1pswGufLTfDJJaSsO8i/Vvr7Duf6Ewkfv
        pyzq4jxvr5yffV2F6UdgneAPp4wb2Xlr/u+WbszZtOXBQZ9nght2PKu7e91j1eXTfKbnru3I
        43RuTyh7pfzKw+3El/Vz52+Q4wl8ZHvzvRJLcUaioRZzUXEiAPbOXPYCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsVy+t/xu7rProvGGTQ9YbfY+OQ0o8XGGetZ
        LS487WGzOH9+A7vF5V1z2CxmnN/HZLH2yF12B3aPTas62Tz6tqxi9Hj6Yy+zx/Eb25k8Pm+S
        C2CN0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MuY
        e/QIW8FJ0Yq5c86wNDB+F+pi5OSQEDCRWNe/mrGLkYtDSGApo8Sd85vYIBIyEienNbBC2MIS
        f651sUEUfWKUeHlgJ1iCTcBQouttF1iDiICqxOe2BewgRcwCHUwSR2f2soMkhAXsJRZd2cEE
        YrMAFbW/3APWzCtgK/Gu/RDUBnmJ1RsOME9g5FnAyLCKUSS1tDg3PbfYUK84Mbe4NC9dLzk/
        dxMjMAy3Hfu5eQfjpY3BhxgFOBiVeHh/LBaJE2JNLCuuzD3EKMHBrCTCq6UDFOJNSaysSi3K
        jy8qzUktPsRoCrR8IrOUaHI+MEbySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphak
        FsH0MXFwSjUwssaqhrNlpp9Xn3Hsz3KhczyG8yP8p61bOmNN7L5Unu//WAx3T1gfLPGg/frx
        zk1OE/qV6kItdu8wfmNl/E+H7eKEp8mn32mkT5oWYFzKN7tmiteb8/ziTUq8FROexUrbl6qc
        naH2ODA222wzx+oJp/saNjXM4LusJsL3ilH0lq2Lj9Z8/fVrlFiKMxINtZiLihMBatS9aFkC
        AAA=
X-CMS-MailID: 20200108132350eucas1p1476f4aa038dbf5ea199b84c5c82a25a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200108132350eucas1p1476f4aa038dbf5ea199b84c5c82a25a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200108132350eucas1p1476f4aa038dbf5ea199b84c5c82a25a5
References: <CGME20200108132350eucas1p1476f4aa038dbf5ea199b84c5c82a25a5@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5253fe05bb47 ("phy: core: Add consumer device link support") added
support for consumer device links, but it missed proper update for error
handling in devm_of_phy_get(). Fix this by adding proper return statement.

This patch fixes the following invalid pointer dereference on
Exynos5250-based Arndale board with multi_v7_defconfig:

8<--- cut here ---
Unable to handle kernel paging request at virtual address fffffe7f
pgd = (ptrval)
[fffffe7f] *pgd=6ffff841, *pte=00000000, *ppte=00000000
Internal error: Oops: 27 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc5-next-20200108 #167
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at device_link_add+0x68/0x4c4
LR is at device_link_add+0x68/0x4c4
...
Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
...
[<c0984d70>] (device_link_add) from [<c0707e8c>] (devm_of_phy_get+0x6c/0xb0)
[<c0707e8c>] (devm_of_phy_get) from [<c0a0deb8>] (ahci_platform_get_phy+0x28/0xe0)
[<c0a0deb8>] (ahci_platform_get_phy) from [<c0a0e64c>] (ahci_platform_get_resources+0x398/0x48c)
[<c0a0e64c>] (ahci_platform_get_resources) from [<c0a0daec>] (ahci_probe+0x14/0xb4)
[<c0a0daec>] (ahci_probe) from [<c098a1ec>] (platform_drv_probe+0x48/0x9c)
[<c098a1ec>] (platform_drv_probe) from [<c0988214>] (really_probe+0x1dc/0x33c)
[<c0988214>] (really_probe) from [<c09884f4>] (driver_probe_device+0x60/0x164)
[<c09884f4>] (driver_probe_device) from [<c09887a0>] (device_driver_attach+0x58/0x60)
[<c09887a0>] (device_driver_attach) from [<c0988828>] (__driver_attach+0x80/0xbc)
[<c0988828>] (__driver_attach) from [<c09865b4>] (bus_for_each_dev+0x68/0xb4)
[<c09865b4>] (bus_for_each_dev) from [<c0987594>] (bus_add_driver+0x160/0x1e4)
[<c0987594>] (bus_add_driver) from [<c09892c0>] (driver_register+0x78/0x10c)
[<c09892c0>] (driver_register) from [<c0302f14>] (do_one_initcall+0x54/0x220)
[<c0302f14>] (do_one_initcall) from [<c1500f4c>] (kernel_init_freeable+0x150/0x1b4)
[<c1500f4c>] (kernel_init_freeable) from [<c0ef6b34>] (kernel_init+0x8/0x10c)
[<c0ef6b34>] (kernel_init) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
...

Fixes: 5253fe05bb47 ("phy: core: Add consumer device link support")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/phy/phy-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 8dfb4868c8c3..2eb28cc2d2dc 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -799,6 +799,7 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 		devres_add(dev, ptr);
 	} else {
 		devres_free(ptr);
+		return phy;
 	}
 
 	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
-- 
2.17.1

