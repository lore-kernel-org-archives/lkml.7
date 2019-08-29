Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295DFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABA822CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jkAex+PU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfH2Fav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 01:30:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44679 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfH2Fav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 01:30:51 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190829053049euoutp02afe9be47049c63d84866f27f7d958253~-Tbhx7B2v3210332103euoutp02R
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 05:30:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190829053049euoutp02afe9be47049c63d84866f27f7d958253~-Tbhx7B2v3210332103euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567056649;
        bh=8i0ZsJoTCw9igACp/Y80+zUSsANQc6ilNqp2fm8mj+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkAex+PUGM0UzkGup/lsyzvyFXaXLxmGHIfJEAFDO4/APVdsmRRM+8CsLhjLSN+sb
         k1BIQCGq9lR++VEoC/J2UdPxKqYpW4az6iNgDU3VAVwD2CzywLW90bdxh+jBdnRpi3
         W/YHTd0BynGgOsy/QfFB9tgV1cjZIWuyorR7uITw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190829053049eucas1p19f2698838b20e78fba38d0b16bf44b71~-TbhGU0TO0697306973eucas1p1p;
        Thu, 29 Aug 2019 05:30:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AF.1B.04469.803676D5; Thu, 29
        Aug 2019 06:30:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190829053048eucas1p1f6549a72d7374812b2aa3cf93862794e~-TbgKE0qJ2620626206eucas1p16;
        Thu, 29 Aug 2019 05:30:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190829053047eusmtrp189a30599d35ed8b49a69bd087c6a06f0~-Tbf7y6bG1101011010eusmtrp1E;
        Thu, 29 Aug 2019 05:30:47 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-7e-5d67630854cf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B6.EC.04117.703676D5; Thu, 29
        Aug 2019 06:30:47 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190829053047eusmtip173d9461db18a05736a4e9e8197ce07ed~-TbfU3H2p1820418204eusmtip1N;
        Thu, 29 Aug 2019 05:30:47 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 1/2 RESEND] usb: core: phy: add support for PHY
 calibration
Date:   Thu, 29 Aug 2019 07:30:27 +0200
Message-Id: <20190829053028.32438-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190829053028.32438-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djP87ocyemxBhsvmlpsnLGe1eJY2xN2
        i+bF69kslv69x2hx/vwGdovLu+awWcw4v4/JYtGyVmaLdRtvsVusPXKX3eLYopMsFs2bprA6
        8HjsnHWX3ePphMnsHov3vGTy2LSqk81j/9w17B59W1YxemzY8o/F4/MmuQCOKC6blNSczLLU
        In27BK6My+8b2AoWi1c0r1nI3MD4WLiLkZNDQsBEYtHHDrYuRi4OIYEVjBLN/esYIZwvjBJH
        d+yDcj4zSqz9upQRpuXgmYPsEInljBK/f59jgms587YXrIpNwFCi620XG4gtIuAgsWTpHbAl
        zAK7mSX2/nwHlhAWCJCY/e0vO4jNIqAqcfX+JrBmXgFbiT/ve1kh1slLrN5wgBnE5hSwk3jw
        uhFsm4TAKnaJE9O3s0AUuUj8+rWDDcIWlnh1fAs7hC0jcXpyDwtEQzOjxMNza9khnB5GictN
        M6A+spY4fPwi0DoOoPs0Jdbv0ocIO0o8OnkLLCwhwCdx460gSJgZyJy0bTozRJhXoqNNCKJa
        TWLW8XVwaw9euMQMYXtIbG89Dg2hiYwSS2e8YJ7AKD8LYdkCRsZVjOKppcW56anFhnmp5XrF
        ibnFpXnpesn5uZsYgann9L/jn3Ywfr2UdIhRgINRiYeXIzEtVog1say4MvcQowQHs5II7yOV
        1Fgh3pTEyqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjEam001s
        b0yI/3dn7nzHCZVVbTNyRb+ZVYbc255mLeT65OMMnmAWo9dreGrjc7/E8HtZbrIV0C75teXO
        AZ4O+QJf2f3f9D43qX/vr01NKN/81e7CXodXtWs+rf+adtqjMErgXuC8f/lyvy9uETM6Urbo
        +nyddSs+VqY0/NZ1fnXnd7aM8MWcLCWW4oxEQy3mouJEAHvCXI45AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4XV325PRYgyl7TC02zljPanGs7Qm7
        RfPi9WwWS//eY7Q4f34Du8XlXXPYLGac38dksWhZK7PFuo232C3WHrnLbnFs0UkWi+ZNU1gd
        eDx2zrrL7vF0wmR2j8V7XjJ5bFrVyeaxf+4ado++LasYPTZs+cfi8XmTXABHlJ5NUX5pSapC
        Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G5fcNbAWLxSua1yxk
        bmB8LNzFyMkhIWAicfDMQfYuRi4OIYGljBKfep8yQSRkJE5Oa2CFsIUl/lzrYoMo+sQocX7R
        HEaQBJuAoUTXW5AEJ4eIgJNE59rTYEXMAgeZJS5e3MsOkhAW8JM49+wzWAOLgKrE1fubwGxe
        AVuJP+97oTbIS6zecIAZxOYUsJN48LoR7AohoJpXNx8wT2DkW8DIsIpRJLW0ODc9t9hIrzgx
        t7g0L10vOT93EyMwDrYd+7llB2PXu+BDjAIcjEo8vAnJabFCrIllxZW5hxglOJiVRHgfqaTG
        CvGmJFZWpRblxxeV5qQWH2I0BTpqIrOUaHI+MEbzSuINTQ3NLSwNzY3Njc0slMR5OwQOxggJ
        pCeWpGanphakFsH0MXFwSjUw6qeGfBA72GEVzBxTu4z3v6mUmPvNEK0zB+4YcOi8nbd7H/NR
        53dKF2dWznWZZ353xe+dd4qVlax1EmctaaycaXQ2dM3CXzHm0StWv1jBvf+hre/yVe4TWhde
        NFh50CmSK66ogZVR7lGdm9R7hm/cUz51299z1el+9rDIPPHIlwl5kW+vCOupK7EUZyQaajEX
        FScCAEJBmrKZAgAA
X-CMS-MailID: 20190829053048eucas1p1f6549a72d7374812b2aa3cf93862794e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190829053048eucas1p1f6549a72d7374812b2aa3cf93862794e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190829053048eucas1p1f6549a72d7374812b2aa3cf93862794e
References: <20190829053028.32438-1-m.szyprowski@samsung.com>
        <CGME20190829053048eucas1p1f6549a72d7374812b2aa3cf93862794e@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PHYs (for example Exynos5 USB3.0 DRD PHY) require calibration to be
done after every USB HCD reset. Generic PHY framework has been already
extended with phy_calibrate() function in commit 36914111e682 ("drivers:
phy: add calibrate method"). This patch adds support for it to generic
PHY handling code in USB HCD core.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>
---
 drivers/usb/core/hcd.c |  7 +++++++
 drivers/usb/core/phy.c | 21 +++++++++++++++++++++
 drivers/usb/core/phy.h |  1 +
 3 files changed, 29 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 88533938ce19..b89936c1df23 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2291,6 +2291,9 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
 	hcd->state = HC_STATE_RESUMING;
 	status = hcd->driver->bus_resume(hcd);
 	clear_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
+	if (status == 0)
+		status = usb_phy_roothub_calibrate(hcd->phy_roothub);
+
 	if (status == 0) {
 		struct usb_device *udev;
 		int port1;
@@ -2864,6 +2867,10 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	}
 	hcd->rh_pollable = 1;
 
+	retval = usb_phy_roothub_calibrate(hcd->phy_roothub);
+	if (retval)
+		goto err_hcd_driver_setup;
+
 	/* NOTE: root hub and controller capabilities may not be the same */
 	if (device_can_wakeup(hcd->self.controller)
 			&& device_can_wakeup(&hcd->self.root_hub->dev))
diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
index 7580493b867a..fb1588e7c282 100644
--- a/drivers/usb/core/phy.c
+++ b/drivers/usb/core/phy.c
@@ -151,6 +151,27 @@ int usb_phy_roothub_set_mode(struct usb_phy_roothub *phy_roothub,
 }
 EXPORT_SYMBOL_GPL(usb_phy_roothub_set_mode);
 
+int usb_phy_roothub_calibrate(struct usb_phy_roothub *phy_roothub)
+{
+	struct usb_phy_roothub *roothub_entry;
+	struct list_head *head;
+	int err;
+
+	if (!phy_roothub)
+		return 0;
+
+	head = &phy_roothub->list;
+
+	list_for_each_entry(roothub_entry, head, list) {
+		err = phy_calibrate(roothub_entry->phy);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_phy_roothub_calibrate);
+
 int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub)
 {
 	struct usb_phy_roothub *roothub_entry;
diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
index dad564e2d2d4..20a267cd986b 100644
--- a/drivers/usb/core/phy.h
+++ b/drivers/usb/core/phy.h
@@ -18,6 +18,7 @@ int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
 
 int usb_phy_roothub_set_mode(struct usb_phy_roothub *phy_roothub,
 			     enum phy_mode mode);
+int usb_phy_roothub_calibrate(struct usb_phy_roothub *phy_roothub);
 int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
 void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
 
-- 
2.17.1

