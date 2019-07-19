Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7054EC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397ED2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o4h5eIMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfGSIN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:13:26 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52108 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfGSINZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:13:25 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190719081324euoutp02dfb1fe89c6986e226ab4cd7dc552b074~ywMxJJq0Z1997519975euoutp02U
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 08:13:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190719081324euoutp02dfb1fe89c6986e226ab4cd7dc552b074~ywMxJJq0Z1997519975euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563524004;
        bh=X+0sRSBwj49+/ldRgneHCL3di9djaWyRquWJEnNhSZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4h5eIMs/RDjPAI4xXM1uaYMkHxDHsaDFHOa7AYSHq8Z09wF32DqxO+FGDrjiBVJx
         IQFD+oE75zyYsG/uVLv5oV4Awt57KzWr3QV+U5sRsRIqwRYIKdttizCDJ/3w+7JYpl
         mBhYygvffpuBoFfIcF54ftDJCkzPdY2Ws4wPdHL4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190719081323eucas1p1b1a4d7092531d08be1dc47ddfc96ac15~ywMwbRYNz0104801048eucas1p1q;
        Fri, 19 Jul 2019 08:13:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 26.53.04325.3AB713D5; Fri, 19
        Jul 2019 09:13:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190719081322eucas1p1f3114c43ca3c53b60766edf1846347cc~ywMvd-epk2477124771eucas1p1M;
        Fri, 19 Jul 2019 08:13:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190719081322eusmtrp1ae3099dc895de74ea0360e8553bd63f5~ywMvUA0oY0401704017eusmtrp1E;
        Fri, 19 Jul 2019 08:13:22 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-6e-5d317ba3a4a5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1E.17.04140.2AB713D5; Fri, 19
        Jul 2019 09:13:22 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190719081321eusmtip2047069aab218be661f3ac23c15eccea4~ywMutCK2M3248932489eusmtip2l;
        Fri, 19 Jul 2019 08:13:21 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 1/2] usb: core: phy: add support for PHY calibration
Date:   Fri, 19 Jul 2019 10:13:16 +0200
Message-Id: <20190719081316.9298-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719081212.9249-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87qLqw1jDV4tEbbYOGM9q8Wxtifs
        Fs2L17NZLP17j9Hi/PkN7BaXd81hs5hxfh+TxaJlrcwW6zbeYrdYe+QuUN2mKawO3B47Z91l
        91i85yWTx6ZVnWwe++euYffo27KK0WPDln8sHp83yQWwR3HZpKTmZJalFunbJXBl9K2OLtgr
        VnH0QStrA2O7cBcjJ4eEgInEjQk/2boYuTiEBFYwSix89RfK+cIo8fpAFxOE85lR4t+Eneww
        LY83HWKHSCxnlFi6+ykzXEvn79dMIFVsAoYSXW+72EBsEQEHiSVL74DNZRb4zyQx/cYJVpCE
        sIC7ROfTB0A2BweLgKpEwxNBkDCvgI3Ess6jjBDb5CVWbzjADGJzCthKTGi4BbZZQmA6u8Tf
        P2+ZIYpcJJ5c/sUEYQtLvDq+BepUGYnTk3tYIBqaGSUenlsL1d3DKHG5aQbUCmuJw8cvgl3B
        LKApsX6XPkTYUeL45AcsIGEJAT6JG2/BjmMGMidtm84MEeaV6GgTgqhWk5h1fB3c2oMXLkGd
        5iGxafEpaABNYJQ41DCfeQKj/CyEZQsYGVcxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIE
        ppjT/45/3cG470/SIUYBDkYlHt6AXINYIdbEsuLK3EOMEhzMSiK8t1/qxwrxpiRWVqUW5ccX
        leakFh9ilOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpg3PhfYtG2o9ECCsZLGFzPvjXt
        KEsydPuutF3m0fJvTLfOMvKtkcroSEn+ffFoahWroGBs4fNHqpf7XIKy34tsZL/I22Y79VJ1
        rm1Hly8fx3/Gsi03J7rOrSqJOBM3N37ZVLHQAt/D5jx95nYvk55EtP1WmJOlaOF7rHLdYoGA
        9xcdd16b2pWnxFKckWioxVxUnAgAoQBM3S0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7qLqg1jDSYf47fYOGM9q8Wxtifs
        Fs2L17NZLP17j9Hi/PkN7BaXd81hs5hxfh+TxaJlrcwW6zbeYrdYe+QuUN2mKawO3B47Z91l
        91i85yWTx6ZVnWwe++euYffo27KK0WPDln8sHp83yQWwR+nZFOWXlqQqZOQXl9gqRRtaGOkZ
        WlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl9K2OLtgrVnH0QStrA2O7cBcjJ4eEgInE
        402H2LsYuTiEBJYySuxfPYcRIiEjcXJaAyuELSzx51oXG0TRJ0aJk6sOMIMk2AQMJbregiQ4
        OUQEnCQ6154GK2IWaGWW6N5xA6xIWMBdovPpA6BJHBwsAqoSDU8EQcK8AjYSyzqPQi2Tl1i9
        AWImp4CtxISGW+wgthBQzdpH5xgnMPItYGRYxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERju
        24793LKDsetd8CFGAQ5GJR7egFyDWCHWxLLiytxDjBIczEoivLdf6scK8aYkVlalFuXHF5Xm
        pBYfYjQFumkis5Rocj4wFvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQx
        cXBKNTBu2n1d5fHfFbceNEwvvvfvdO/mXdxTU+5/cZwfe/JrfUP1dDclrlwuP5+ZjyWaDL8a
        Tc9ynt4Q0dc17YqbDPdJ7bLMvA+frr+okCz7zLJsrlNIRKHvKlXribpibzTD/Er+X21eJm0k
        srcmd84d6aMxj5s3Z/Pktdo/nXl04XnV32+eh1Y1v5irxFKckWioxVxUnAgAoSil1I0CAAA=
X-CMS-MailID: 20190719081322eucas1p1f3114c43ca3c53b60766edf1846347cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719081322eucas1p1f3114c43ca3c53b60766edf1846347cc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719081322eucas1p1f3114c43ca3c53b60766edf1846347cc
References: <20190719081212.9249-1-m.szyprowski@samsung.com>
        <CGME20190719081322eucas1p1f3114c43ca3c53b60766edf1846347cc@eucas1p1.samsung.com>
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

