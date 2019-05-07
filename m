Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86850C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5780E20578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KpxrKWes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfEGM4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:56:33 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48121 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGM4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:56:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190507125631euoutp02e6b6639ad8400dbe5083f21c39356db9~cZ_IC4Gj02423324233euoutp02g;
        Tue,  7 May 2019 12:56:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190507125631euoutp02e6b6639ad8400dbe5083f21c39356db9~cZ_IC4Gj02423324233euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557233791;
        bh=xUjT1aKwWvPSI6nVT4VtoO7jy++v6QMY5/tvZAbO3t0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KpxrKWesAN50VLLKddrB9PB3wK4lTEW97WTVdo4ZTKJmXtFtcIstb3G2B4L1lxfYT
         GhxnsbIwUfaB+jfYRKUDOPiJ4jJXPqzggWW0SjMrAamPbofNUKq6ZAEaljvKtSKUu6
         hwaBO001G6X7CgSSd10NADcLzj6RDZmuLO1yDcz0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190507125631eucas1p145b5499a857fcf20e1c4429f28bede47~cZ_HoxoSf1873518735eucas1p1i;
        Tue,  7 May 2019 12:56:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DA.04.04325.E7081DC5; Tue,  7
        May 2019 13:56:30 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190507125630eucas1p1c5fd171a8dc2a6b8eb9dd317fe245f0c~cZ_GuytwV1097010970eucas1p1Y;
        Tue,  7 May 2019 12:56:30 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-46-5cd1807e2c82
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D6.B6.04140.E7081DC5; Tue,  7
        May 2019 13:56:30 +0100 (BST)
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PR4001CRXA2KE30@eusync1.samsung.com>;
        Tue, 07 May 2019 13:56:30 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mans Rullgard <mans@mansr.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] usb: core: verify devicetree nodes for disabled interfaces
Date:   Tue, 07 May 2019 14:56:15 +0200
Message-id: <20190507125615.9381-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7djPc7p1DRdjDH7OMbLYOGM9q0Xz4vVs
        FufPb2C3uLxrDpvFjPP7mCwWLWtltnh55Aejxdojd9ktfjyczuTA6XHrTr3HplWdbB77565h
        93hz+hS7R9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGWcb57JVHCcr+J0607WBsYVPF2MnBwS
        AiYS7/u/sYDYQgIrGCWubGPuYuQCsj8zSmz4MY0dpqhh9ktGiMQyRokZb1tZIJz/jBKrt24A
        q2ITMJToetvFBmKLCCRIHNn8nhnEZhboZpL4skwAxBYW8JY4t/0M2DoWAVWJDdvWMoLYvAI2
        Eq0bPjNCbJOXWL3hANgZEgKNbBLTDs1kgUi4SFx88BeqSEbi8uRuFoiiZkaJh+fWskM4PYwS
        l5tmQFVZSxw+fpEV4gw+iUnbpgON5QCK80p0tAlBlHhI9B7+AhYWEoiV2LY1aAKj+AJGhlWM
        4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBsXb63/GvOxj3/Uk6xCjAwajEw/ui4GKMEGti
        WXFl7iFGCQ5mJRHexGfnYoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzVjM8iBYSSE8sSc1OTS1I
        LYLJMnFwSjUw8rjcLf7UX8r5LmWDZkz1aWbujXfuCuxe9njPt0cJR9Y/qio4U/7RZt1kS9sz
        s+4/2zfperKqSeIZ9dkSDycKfeuYesv5dMyhVQvOBa3N5w46/f7ArcsZW/SfdneK3L6kv+RQ
        wVXhRuv+oO/n11qlnBcy8+L7cMj90W222jlaNw7+9JgiKXhsrb0SS3FGoqEWc1FxIgCcaiYm
        sQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJMWRmVeSWpSXmKPExsVy+t/xy7p1DRdjDL6dYLPYOGM9q0Xz4vVs
        FufPb2C3uLxrDpvFjPP7mCwWLWtltnh55Aejxdojd9ktfjyczuTA6XHrTr3HplWdbB77565h
        93hz+hS7R9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGWcb57JVHCcr+J0607WBsYVPF2MnBwS
        AiYSDbNfMoLYQgJLGCUmPbLqYuQCshuZJFb+nMQGkmATMJToetsFZosIJEgsebuZHaSIWaCb
        SaK56TcrSEJYwFvi3PYzLCA2i4CqxIZta8Gm8grYSLRu+MwIsU1eYvWGA8wTGLkWMDKsYhRJ
        LS3OTc8tNtIrTswtLs1L10vOz93ECAyUbcd+btnB2PUu+BCjAAejEg/vi4KLMUKsiWXFlbmH
        GCU4mJVEeBOfnYsR4k1JrKxKLcqPLyrNSS0+xCjNwaIkztshcDBGSCA9sSQ1OzW1ILUIJsvE
        wSnVwNgQdtXALI491JP9TPHPh+Hya5jCZultFT7YuIp5H8sUY+lTO+doTOx3ZDm735hD9vrX
        5Kf3drV1cxkzfC7UyXNzNb88Y6trxv43KwVlbnQszFh18hjL0eULSw66fDwY7Xgj9J2QqfWr
        hsf361ZNvv79n+/mzck3+N8fqWgQvhsgF/dlwvSr+ZlKLMUZiYZazEXFiQBdkFXGEAIAAA==
X-CMS-MailID: 20190507125630eucas1p1c5fd171a8dc2a6b8eb9dd317fe245f0c
CMS-TYPE: 201P
X-CMS-RootMailID: 20190507125630eucas1p1c5fd171a8dc2a6b8eb9dd317fe245f0c
References: <CGME20190507125630eucas1p1c5fd171a8dc2a6b8eb9dd317fe245f0c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 01fdf179f4b0 ("usb: core: skip interfaces disabled in devicetree")
add support for disabling given USB device interface by adding nodes to
the USB host controller device. The mentioned commit however identifies
the given USB interface node only by the 'reg' property in the host
controller children nodes and then checks for their the 'status'. The USB
device interface nodes however also has to have a 'compatible' property as
described in Documentation/devicetree/bindings/usb/usb-device.txt. This is
important, because USB host controller might have child-nodes for other
purposes. For example, Exynos EHCI and OHCI drivers already define
child-nodes for each physical root hub port and assigns respective PHY
controller and parameters for them. This conflicts with the proposed
approach and verifying for the presence of the compatible property fixes
this issue without changing the devicetree bindings and the way the PHY
controllers are handled by Exynos EHCI/OHCI drivers.

Reported-by: Markus Reichl <m.reichl@fivetechno.de>
Fixes: 01fdf179f4b0 ("usb: core: skip interfaces disabled in devicetree")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/core/message.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 82239f27c4cc..cd455c4add25 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2007,6 +2007,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 		struct usb_interface *intf = cp->interface[i];
 
 		if (intf->dev.of_node &&
+		    of_device_is_compatible(intf->dev.of_node, NULL) &&
 		    !of_device_is_available(intf->dev.of_node)) {
 			dev_info(&dev->dev, "skipping disabled interface %d\n",
 				 intf->cur_altsetting->desc.bInterfaceNumber);
-- 
2.17.1

