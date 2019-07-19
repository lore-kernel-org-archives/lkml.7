Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CA9C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B492084D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hvN+B6NM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfGSJas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:30:48 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50321 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfGSJar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:30:47 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190719093046euoutp02e676421cf21a792fa21517d04e2f4166~yxQU33SKw2889628896euoutp02V
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:30:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190719093046euoutp02e676421cf21a792fa21517d04e2f4166~yxQU33SKw2889628896euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563528646;
        bh=4WJcerrgtqpZTnMzI8e8akF7VisSMSEGx9wGghtcB1M=;
        h=From:To:Cc:Subject:Date:References:From;
        b=hvN+B6NMN9agXkG4cyi9Drh+0zVNlzuVVPOrhFRifFTCS8wuYk7XGZi5SWdXqjmwc
         rSNcrgVZbyUiA69jXMsEObLsUM/E0DiDheIqNmW5dJ7veIsjG4H4FcXeDMc7Cxp2pk
         iJ8oh8sty5JfoZaDfOT3/QeWUZ8bRdInntJdQcso=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190719093046eucas1p2bb8352bf1b3c2e8dac7829539acd8c0e~yxQUYzFPB2488424884eucas1p2S;
        Fri, 19 Jul 2019 09:30:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 62.D2.04377.5CD813D5; Fri, 19
        Jul 2019 10:30:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190719093045eucas1p1a1c6f26ae4103e9ed283fff2396beaef~yxQTmz3S31684216842eucas1p1x;
        Fri, 19 Jul 2019 09:30:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719093045eusmtrp2432848cc26ad2cd414490ba5972aab52~yxQTaq_lj1662516625eusmtrp23;
        Fri, 19 Jul 2019 09:30:45 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-4e-5d318dc598c2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 67.79.04146.5CD813D5; Fri, 19
        Jul 2019 10:30:45 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719093044eusmtip179cb8ff21b96772ee15df951a7268fbf~yxQTAQUsN1578415784eusmtip1d;
        Fri, 19 Jul 2019 09:30:44 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] usb: dwc3: remove generic PHYs forwarding for XHCI device
Date:   Fri, 19 Jul 2019 11:30:37 +0200
Message-Id: <20190719093037.16181-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWy7djPc7rHeg1jDY4dZ7LYOGM9q8Wxtifs
        FufPb2C3uLxrDpvFjPP7mCwWLWtltlh75C67RfOmKawOHB6L97xk8ti0qpPNo2/LKkaPz5vk
        AliiuGxSUnMyy1KL9O0SuDJaVrxnLHgqXPF77grGBsaZAl2MnBwSAiYSvfP3M4HYQgIrGCVO
        L1LuYuQCsr8wSnyYtpYRwvnMKPHkfhdQFQdYx759hRDx5YwS777/ZYfr2PX7HQvIKDYBQ4mu
        t11sILaIgIPEkqV3wGxmgV+MEk2zNEFsYQEviYML57KD2CwCqhI9V6eC1fAK2Ep86njCCnGe
        vMTqDQeYQRZICFxnk5h48w4jRMJF4taDQ0wQtrDEq+Nb2CFsGYn/O+czQTQ0M0o8PLeWHcLp
        YZS43DQDqtta4vDxi6wg/zALaEqs36UPEXaUuDVrKgvEm3wSN94KQhzNJzFp23RmiDCvREeb
        EES1msSs4+vg1h68cIkZwvaQ2Nm5mg0SpLESXxonM09glJuFsGsBI+MqRvHU0uLc9NRio7zU
        cr3ixNzi0rx0veT83E2MwFRw+t/xLzsYd/1JOsQowMGoxMMbkGsQK8SaWFZcmXuIUYKDWUmE
        9/ZL/Vgh3pTEyqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjBo2
        Wu6+P/Wqbv4K3BZ+9zK33LGDv/b8jzUPeqBz4mIQV1it4YTkOYrrDbZGf3sk9TPidUOR7Kdv
        TMVvCjbdWqp8r+Rezg0VzvZ9HyXevwp8vnT77nalXomM77LaszfJGd+ZI24cpLu5x0UxmYmx
        ISHE3Mxuhuwn263NXxfJrROQDfaJ9a7sVmIpzkg01GIuKk4EAIb9HfYBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t/xu7pHew1jDSZs5LPYOGM9q8Wxtifs
        FufPb2C3uLxrDpvFjPP7mCwWLWtltlh75C67RfOmKawOHB6L97xk8ti0qpPNo2/LKkaPz5vk
        Alii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJa
        VrxnLHgqXPF77grGBsaZAl2MHBwSAiYS+/YVdjFycQgJLGWU6Pv8k6WLkRMoLiNxcloDK4Qt
        LPHnWhcbRNEnRon7/afAitgEDCW63oIkODlEBJwkOteeBitiFvjHKPFr9ydmkISwgJfEwYVz
        2UFsFgFViZ6rU8EaeAVsJT51PIHaIC+xesMB5gmMPAsYGVYxiqSWFuem5xYb6hUn5haX5qXr
        JefnbmIEBuG2Yz8372C8tDH4EKMAB6MSD29ArkGsEGtiWXFl7iFGCQ5mJRHe2y/1Y4V4UxIr
        q1KL8uOLSnNSiw8xmgItn8gsJZqcD4yQvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZ
        qakFqUUwfUwcnFINjJVMix9P4ii5NTFvtqDSDCGDM8IRdjtcT7nqvGT3vfLL7ZGsaU3+3aji
        c0zFkcIzAp+xVHlbyF/OCYjUy570evmHxHvbdu/eJXvQtbtd6JvHnu4/Eks1mUOUH4vlH628
        nSQgIDy/jVH2mXhAz4fQi5E+PU/9b5nVO8hkims8cq7vXJaxuCVAiaU4I9FQi7moOBEAkFq8
        z1gCAAA=
X-CMS-MailID: 20190719093045eucas1p1a1c6f26ae4103e9ed283fff2396beaef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719093045eucas1p1a1c6f26ae4103e9ed283fff2396beaef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719093045eucas1p1a1c6f26ae4103e9ed283fff2396beaef
References: <CGME20190719093045eucas1p1a1c6f26ae4103e9ed283fff2396beaef@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 08f871a3aca2 ("usb: dwc3: host: convey the PHYs to xhci") added
forwarding of the generic PHYs from DWC3 core to the instantiated XHCI-plat
device. However XHCI(-plat) driver never gained support for generic PHYs,
thus the lookup added by that commit is never used. In meantime the commit
d64ff406e51e ("usb: dwc3: use bus->sysdev for DMA configuration")
incorrectly changed the device used for creating lookup, making the lookup
useless and generic PHYs inaccessible from XHCI device.

However since commit 178a0bce05cb ("usb: core: hcd: integrate the PHY
wrapper into the HCD core") USB HCD already handles generic PHYs acquired
from the HCD's 'sysdev', which in this case is DWC3 core device. This means
that creating any custom lookup entries for XHCI driver is no longer needed
and can be simply removed.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/dwc3/host.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index f55947294f7c..8deea8c91e03 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -85,7 +85,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 						DWC3_XHCI_RESOURCES_NUM);
 	if (ret) {
 		dev_err(dwc->dev, "couldn't add resources to xHCI device\n");
-		goto err1;
+		goto err;
 	}
 
 	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
@@ -112,37 +112,23 @@ int dwc3_host_init(struct dwc3 *dwc)
 		ret = platform_device_add_properties(xhci, props);
 		if (ret) {
 			dev_err(dwc->dev, "failed to add properties to xHCI\n");
-			goto err1;
+			goto err;
 		}
 	}
 
-	phy_create_lookup(dwc->usb2_generic_phy, "usb2-phy",
-			  dev_name(dwc->dev));
-	phy_create_lookup(dwc->usb3_generic_phy, "usb3-phy",
-			  dev_name(dwc->dev));
-
 	ret = platform_device_add(xhci);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register xHCI device\n");
-		goto err2;
+		goto err;
 	}
 
 	return 0;
-err2:
-	phy_remove_lookup(dwc->usb2_generic_phy, "usb2-phy",
-			  dev_name(dwc->dev));
-	phy_remove_lookup(dwc->usb3_generic_phy, "usb3-phy",
-			  dev_name(dwc->dev));
-err1:
+err:
 	platform_device_put(xhci);
 	return ret;
 }
 
 void dwc3_host_exit(struct dwc3 *dwc)
 {
-	phy_remove_lookup(dwc->usb2_generic_phy, "usb2-phy",
-			  dev_name(dwc->dev));
-	phy_remove_lookup(dwc->usb3_generic_phy, "usb3-phy",
-			  dev_name(dwc->dev));
 	platform_device_unregister(dwc->xhci);
 }
-- 
2.17.1

