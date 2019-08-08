Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4F6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858D521874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="REMvWkfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732489AbfHHJlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:41:50 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46576 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732169AbfHHJlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:41:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190808094147euoutp01192430210823a8669dba02a98b789d46~46Tp3iT081488514885euoutp018
        for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2019 09:41:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190808094147euoutp01192430210823a8669dba02a98b789d46~46Tp3iT081488514885euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565257307;
        bh=8i0ZsJoTCw9igACp/Y80+zUSsANQc6ilNqp2fm8mj+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REMvWkfujrNbrugXb355ht/X0j80unvJhgP6bTdCcwjUmWVdJMDI/ra/5klSgx+s5
         ZPgvUs1PE5EDezz+9TisUXJa3TOnaAcpvUVKYKq91gYbuI2iiULlkhv/QboGH+Hq32
         ZBF3h/OzA36L5+dPrwFVC5mWaClLkybEtLgwZYk4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190808094147eucas1p1e45c1f2bdb73d61d6a0f318248689611~46TpNAm2k1424414244eucas1p1X;
        Thu,  8 Aug 2019 09:41:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 88.84.04374.A5EEB4D5; Thu,  8
        Aug 2019 10:41:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190808094146eucas1p2a5a88ce5e7a87d47c4bcececab4df9a5~46TodoXf20339303393eucas1p20;
        Thu,  8 Aug 2019 09:41:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190808094146eusmtrp1548af4d6fddd50dd790cc64abf22148b~46ToO-MCt0652806528eusmtrp1b;
        Thu,  8 Aug 2019 09:41:46 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-b9-5d4bee5aad1b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 58.E5.04166.95EEB4D5; Thu,  8
        Aug 2019 10:41:45 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190808094145eusmtip14ac841d81885e0e191b4896c39a79d32~46TnqfF-T2468724687eusmtip1Q;
        Thu,  8 Aug 2019 09:41:45 +0000 (GMT)
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
Date:   Thu,  8 Aug 2019 11:41:27 +0200
Message-Id: <20190808094128.27213-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190808094128.27213-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfyxUcQD39d699+7m2utovlOx3fqxtPwotbeRnWX1zNqsVn8wceWFOOwe
        J1lNlHFJwmR+5fwI1+GcX0VJmAuLuP6ohmUobChkmR/L89B/n5/fz3fffQlEUiawIUIjohll
        hDxcionQpu6V/hO+c97+TqZqF6out1ZAdSdP4FRSaS1Gla+PAmpgQI9TppYCjModaDOnSl48
        RKiaum84Vd01glPdJT0olWTIFsgs6Nd5Izg9mZGF06Vvps1pgzYVo98V6nA6vUELaH3DBkov
        Gmx9CF+RWxATHqpilI7ugaIQ03wCFlVqfTtJp0ESwLilGggJSLrArymzqBqICAlZCaCuXY/z
        ZAnA38ud22QRwOHVAnSnUjSkQ3ijAsDlmSJkt5LXUgW4FEY6Q/WsGuOwFSmDZeXDGBdCyFYE
        vl2Z2zIsSR+Yv7yOcxglD8PSRzNbupg8C6fSCwE/Zwdf6tsRDgtJdziVUAy4gyCpxWHNeI05
        H/KEDxYGER5bwhljA87jA7AvKw3lC0kAjvVX4zxJA9CUmLs94Qo7jYMCNSA273cM1rY48rIH
        rEhNxTkZknvgl9m9nIxswsymZwgvi2FKsoRPH4F5xprd2fefhrYjNOzVHOJkCfl08xmfUBnA
        Lu//VDEAWmDNxLCKYIY9FcHEOrByBRsTEexwI1JhAJt/p2/D+OcVaFu73gFIAkgtxB96vf0l
        ArmKjVN0AEggUivxqMrLXyIOksfdYZSRAcqYcIbtAPsJVGotjjf77ichg+XRTBjDRDHKHdec
        ENokgKrAsueabF+DqrX3Zo+Z24+x6e5LUuygd6ZfQMzFu4Wj1P2cMFc2cEKzZn+rZOmKbf3V
        +MZmr3mhp+joar7o/MnmjfrYwZzsz7KMoHOr62fuySzwVhRtnPHrypJfe1xQGfLzgqVCOfrR
        MXJh8PhQbWri6cm6fU6TYUN/PeKnfl1GpSgbIne2R5Ss/B++aANSNwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Xd3Id96xBou22FhsnLGe1eJY2xN2
        i+bF69kslv69x2hx/vwGdovLu+awWcw4v4/JYtGyVmaLdRtvsVusPXKX3eLYopMsFs2bprA6
        8HjsnHWX3ePphMnsHov3vGTy2LSqk81j/9w17B59W1YxemzY8o/F4/MmuQCOKD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2My+8b2AoWi1c0r1nI
        3MD4WLiLkZNDQsBEYt6lNcxdjFwcQgJLGSV2XL/IApGQkTg5rYEVwhaW+HOtiw2i6BOjRMPX
        84wgCTYBQ4mutyAJTg4RASeJzrWnwYqYBQ4yS1y8uJcdJCEs4Cdx7tlnsAYWAVWJxd2vwBp4
        BWwlXvTNZYTYIC+xesMBZhCbU8BO4kXDArC4EFDN731tLBMY+RYwMqxiFEktLc5Nzy021CtO
        zC0uzUvXS87P3cQIjINtx35u3sF4aWPwIUYBDkYlHt6CE96xQqyJZcWVuYcYJTiYlUR475V5
        xgrxpiRWVqUW5ccXleakFh9iNAU6aiKzlGhyPjBG80riDU0NzS0sDc2NzY3NLJTEeTsEDsYI
        CaQnlqRmp6YWpBbB9DFxcEo1ME59GjphlexLYd6G1lUcXnp7bvU4b9HW9DD7/UzzAdfiJRO4
        GfdMadjT0y8qe+pidkk/f8G14x91C7oUQ/ddPnJ9bZABa+CUgmhPZYHEA4Xm+1xsFvw70b+7
        L753UqWswdKaaW5rt0dOWeV6cYKFTjfHHeXpqcXT0kU9/pZddP6y/Xio1vWnS5RYijMSDbWY
        i4oTATajDFCZAgAA
X-CMS-MailID: 20190808094146eucas1p2a5a88ce5e7a87d47c4bcececab4df9a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190808094146eucas1p2a5a88ce5e7a87d47c4bcececab4df9a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190808094146eucas1p2a5a88ce5e7a87d47c4bcececab4df9a5
References: <20190808094128.27213-1-m.szyprowski@samsung.com>
        <CGME20190808094146eucas1p2a5a88ce5e7a87d47c4bcececab4df9a5@eucas1p2.samsung.com>
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

