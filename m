Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586D9C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F18C20656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LsbnxUg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfEHKor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:44:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38781 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfEHKop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:44:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190508104443euoutp02f6a8cfe642d54062fdacb785e8ed7051~cr0VfeNqE1605816058euoutp02Y;
        Wed,  8 May 2019 10:44:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190508104443euoutp02f6a8cfe642d54062fdacb785e8ed7051~cr0VfeNqE1605816058euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557312283;
        bh=dgpyXP29E0frg5Fb1yn3nfCEe+lXMK1zNnGILlOg4wE=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=LsbnxUg12a3jsWUhy7ktPsHEqRK5IKOfeM9BQmfeAxHVuvlEP7nsFLJsj/3EQgJLB
         9uLR6RZyr6pPNPL6NjVur2GIhcceJFLISHRfH9TLZ7dLaHqxNn2ASmzq9RwW5mBoT5
         TORTCdH8Dst2+AoJjgvFwrDueIos3W37rAvKRnTs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190508104443eucas1p2cb672c979c05cf0208787536c9c60eeb~cr0VH7jsW3139531395eucas1p2W;
        Wed,  8 May 2019 10:44:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 37.32.04325.A13B2DC5; Wed,  8
        May 2019 11:44:42 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190508104442eucas1p2ebdffa348465f2c28177601014614853~cr0UfcbQI3139631396eucas1p2U;
        Wed,  8 May 2019 10:44:42 +0000 (GMT)
X-AuditID: cbfec7f5-fbbf09c0000010e5-90-5cd2b31a8b7a
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E2.E0.04146.A13B2DC5; Wed,  8
        May 2019 11:44:42 +0100 (BST)
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PR600EL2LUETP60@eusync4.samsung.com>;
        Wed, 08 May 2019 11:44:42 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mans Rullgard <mans@mansr.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] usb: core: verify devicetree nodes for disabled
 interfaces
Date:   Wed, 08 May 2019 12:44:34 +0200
Message-id: <20190508104434.3409-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <106fc58c-1a4f-6605-41d7-b6031c5751a3@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7djP87pSmy/FGJzvtrHYOGM9q0Xz4vVs
        FufPb2C3uLxrDpvFjPP7mCwWLWtltnh55Aejxdojd9ktfjyczuTA6XHrTr3HplWdbB77565h
        93hz+hS7R9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGXMWL+KseAwX0XPpc8sDYxLeLoYOTkk
        BEwkFmy+zdjFyMUhJLCCUeJs438WCOczo8TN6XNZYKpar52HqlrGKPHh50Goqv+MEvunLmUG
        qWITMJToetvFBmKLCCRIHNn8HizOLNDNJPFlmQCILSwQIHHkXTMjiM0ioCpx/Md/sBpeARuJ
        ibvuM0Nsk5dYveEAmM0pYC/xYfcsVoj4AjaJa0fjIGwXiQWLlrFB2DISnR0HmUAOkhBoZpR4
        eG4tO4TTwyhxuWkGI0SVtcTh4xdZIS7ik5i0bTrQBg6gOK9ER5sQRImHxLmrv1khPpvEKHH+
        5y22CYwSCxgZVjGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgTG4el/x7/uYNz3J+kQowAH
        oxIP74uCizFCrIllxZW5hxglOJiVRHivT7wUI8SbklhZlVqUH19UmpNafIhRmoNFSZy3muFB
        tJBAemJJanZqakFqEUyWiYNTqoFxptpe/fXP0u9rnd34IO3WpeQ8/orVR50/GXwzC3K+WOt7
        7mHL3+TTlydLvLlSk+B9KSvujfR1wbLr7rPvvpyYb18cwRX8Y6WAAY/K5Oa5qmuOs0ZLxM6P
        P7ro7Ash3um/RMtyNrrELd/Z2MKuc/zOr3bWtIb8Y8duRJesyn/Tv81I5Yo2w+ZzSizFGYmG
        WsxFxYkAAQGh178CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKLMWRmVeSWpSXmKPExsVy+t/xa7pSmy/FGLQtErLYOGM9q0Xz4vVs
        FufPb2C3uLxrDpvFjPP7mCwWLWtltnh55Aejxdojd9ktfjyczuTA6XHrTr3HplWdbB77565h
        93hz+hS7R9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGXMWL+KseAwX0XPpc8sDYxLeLoYOTkk
        BEwkWq+dZ+xi5OIQEljCKDH3/RcmCKeRSaLj8zE2kCo2AUOJrrddYLaIQILEkreb2UGKmAW6
        mSSam36zdjFycAgL+EkcmSMNUsMioCpx/Md/ZhCbV8BGYuKu+8wQ2+QlVm84AGZzCthLfNg9
        ixXEFhKwk9h38iLrBEaeBYwMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQIDa9uxn5t3MF7a
        GHyIUYCDUYmHd8KsSzFCrIllxZW5hxglOJiVRHivTwQK8aYkVlalFuXHF5XmpBYfYpTmYFES
        5+0QOBgjJJCeWJKanZpakFoEk2Xi4JRqYOy/rba+8LNe1+Quo582XCn/98dOKHmeyuE8/5mT
        sZ/nl+f+3RbZjMmmlt2VkSdU+e4JzdTeEsibsijslMbBmc7mj1wX2dn66S/Zznlr4jaD42u7
        LyQeyRJfO//l3QMVnE8FrGTCWxRDV3EvSGFZOMXCRHnmHImKvZPXqh2dznvj6tN7awuPuyix
        FGckGmoxFxUnAgB3PLddKAIAAA==
X-CMS-MailID: 20190508104442eucas1p2ebdffa348465f2c28177601014614853
CMS-TYPE: 201P
X-CMS-RootMailID: 20190508104442eucas1p2ebdffa348465f2c28177601014614853
References: <106fc58c-1a4f-6605-41d7-b6031c5751a3@samsung.com>
        <CGME20190508104442eucas1p2ebdffa348465f2c28177601014614853@eucas1p2.samsung.com>
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
this issue without changing the bindings and the way the PHY controllers
are handled by Exynos EHCI/OHCI drivers.

Reported-by: Markus Reichl <m.reichl@fivetechno.de>
Fixes: 01fdf179f4b0 ("usb: core: skip interfaces disabled in devicetree")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/core/message.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index e844bb7b5676..6f7d047392bd 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2009,6 +2009,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 		struct usb_interface *intf = cp->interface[i];
 
 		if (intf->dev.of_node &&
+		    of_find_property(intf->dev.of_node, "compatible", NULL) &&
 		    !of_device_is_available(intf->dev.of_node)) {
 			dev_info(&dev->dev, "skipping disabled interface %d\n",
 				 intf->cur_altsetting->desc.bInterfaceNumber);
-- 
2.17.1

