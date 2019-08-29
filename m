Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C351AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90904206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kXHa+xN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfH2Faw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 01:30:52 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44684 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfH2Fav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 01:30:51 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190829053050euoutp02b97ba0cba7130364d741dcf9bda6f965~-TbiFdTim3222532225euoutp02G
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 05:30:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190829053050euoutp02b97ba0cba7130364d741dcf9bda6f965~-TbiFdTim3222532225euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567056650;
        bh=I6N6bv0h1HrvQoG0yNZnRE9a99bMMNihpEquu9JqhQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXHa+xN/2qxCZKNYzNumaxwmpJ7v3/Qslsqsh99b9ZS3Gi/iy12+01mV9njdDOgKf
         yC3CeZAqk3lCR3tbV8C8MqvIb0d49vQLTjSXLTM5ZBDr6bD2QFUDV3Xp9dBKkilqT/
         ldp7ww5lGxn4UzoT2snqa/0Hph9tO++1Qu0zWtO4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190829053049eucas1p2792bffb88ddefd299427d66552b56d7b~-Tbhhg-Cq0680006800eucas1p2g;
        Thu, 29 Aug 2019 05:30:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C7.0B.04374.903676D5; Thu, 29
        Aug 2019 06:30:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190829053048eucas1p23a263403490acf3ef91c02b1c851b03f~-TbguEljJ2559925599eucas1p23;
        Thu, 29 Aug 2019 05:30:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190829053048eusmtrp1df1c544086b3e6aa05e50137b33c9f9a~-TbgfmAjg1101011010eusmtrp1G;
        Thu, 29 Aug 2019 05:30:48 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-5c-5d676309d4f0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A7.EC.04117.803676D5; Thu, 29
        Aug 2019 06:30:48 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190829053047eusmtip119ea01e8a8c11a679e4aa502c977db42~-Tbf5eBLi1911419114eusmtip1L;
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
Subject: [PATCH v2 2/2 RESEND] usb: dwc3: remove generic PHY calibrate()
 calls
Date:   Thu, 29 Aug 2019 07:30:28 +0200
Message-Id: <20190829053028.32438-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190829053028.32438-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHfXfOds7M6WkKPll4WSokqUkGBzJR6sMJhPwSUio59XjLTdlR
        04JwSlrTykvhWil5S5n3MVxampluhuEsFUU0LJKuRuGFpJScR+vb73mf///5v+/DS2LSRqEb
        marMYlVKebpMZI93m9fH/MUJybFHflRJ6S5th5A2F30g6ML6DhHduPEW0VZrJ0FP9D4Q0Vpr
        v4Cue3QNo9u7Zgm6bWieoM11L3G60HBHGObA9OjmCWaxrJJg6p9+FjAG/Q0R86y6lWBuGfWI
        6TRu4syywT2SPG8fksimp+awqsDQOPuUm6b7KLNvT+7GT4soH82INUhMAhUMk0VWTIPsSSnV
        jGB+pE3IFysI1K++7RTLCAaa1rFdS/nvyR1LE4KR2TnRP0tLwySyqURUEGiWNCIbu1Bh0NDI
        izDqCQZ969+3G85UJHRo1dtjccoHNNVrAhtLqBOwuFqG83Ee0NI5sK0RU6Gw8FUtsA0CSk/A
        lKZnR3QKVlo/CXh2hi8WI8HzARitLMV5QyGCd2NtBF+UIpgo0CJedRxeWF5vPZXcut8h6OgN
        tCFQ4TDdk8OjI8ws7bWJsS2s6K7C+GMJXC+S8jN8QWdp/5f6fPzNzrYYME/X4vyCyhH8atVj
        ZchD9z/rIUJ65Mpmc4pkljuqZC8FcHIFl61MDkjIUBjQ1ucZ3bSsPkb9f+IHEUUimYMkLiEp
        ViqU53B5ikEEJCZzkbz3ZmOlkkR53mVWlXFBlZ3OcoNoP4nLXCVX7BaipVSyPIu9yLKZrGq3
        KyDFbvno2FXPxsTxONx8xjtCHDNndM8ucdKGOHn4nyOLoyrqdWLTdMlU9JhaWXfQmY1P4rp8
        FR+jimtqfWBkXX2yQj9snUhzTKBMXrPDyP30RoGp1DOv3M6vc7R5n2+NLlU+qi5baz6rq/BI
        G/LabDicGxBzL9jgH146d3umLQLC78pwLkUe5IepOPlfVgZwFTgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4XV2O5PRYg0cPZS02zljPanGs7Qm7
        RfPi9WwWS//eY7Q4f34Du8XlXXPYLGac38dksWhZK7PFuo232C3WHrnLbnFs0UkWi+ZNU1gd
        eDx2zrrL7vF0wmR2j8V7XjJ5bFrVyeaxf+4ado++LasYPTZs+cfi8XmTXABHlJ5NUX5pSapC
        Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl5G7/bZjAV7uSv+fjzO
        1sB4g7OLkZNDQsBEYuLvK8xdjFwcQgJLGSW+N8xmgkjISJyc1sAKYQtL/LnWxQZR9IlR4sa6
        HWBFbAKGEl1vQRKcHCICThKda0+DFTELHGSWuHhxLztIQljAT2Lno0awSSwCqhJdc7+BNfMK
        2Eo8/TqBBWKDvMTqDQeYQWxOATuJB68bwWqEgGpe3XzAPIGRbwEjwypGkdTS4tz03GIjveLE
        3OLSvHS95PzcTYzAONh27OeWHYxd74IPMQpwMCrx8CYkp8UKsSaWFVfmHmKU4GBWEuF9pJIa
        K8SbklhZlVqUH19UmpNafIjRFOioicxSosn5wBjNK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMk
        kJ5YkpqdmlqQWgTTx8TBKdXAyH9E9ssSjYyVX9Rr9Owsu7oqqtqEn4cyuCyVu3VfZsLs+IaL
        5ZlxgvmPS4397oYo3pxo4u7wxzSoeXsUU4KEb8r8I7oR1ecNuz5ce+xgJPr0c+ZztwjuKvs4
        zsZw9pZWxtKmruUJRQyMPQ+U/Ge2+36akjc7nOkyw9zzl1bxpB46IxK5qVWJpTgj0VCLuag4
        EQAykg+amQIAAA==
X-CMS-MailID: 20190829053048eucas1p23a263403490acf3ef91c02b1c851b03f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190829053048eucas1p23a263403490acf3ef91c02b1c851b03f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190829053048eucas1p23a263403490acf3ef91c02b1c851b03f
References: <20190829053028.32438-1-m.szyprowski@samsung.com>
        <CGME20190829053048eucas1p23a263403490acf3ef91c02b1c851b03f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calls to USB2 generic PHY calibrate() method has been moved to HCD core,
which now successfully handles generic PHYs and their calibration after
every HCD reset. This fixes all the timing issues related to PHY
calibration done directly from DWC3 driver: incorrect operation after
system suspend/resume or USB3.0 detection failure when XHCI-plat driver
compiled as separate module.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 drivers/usb/dwc3/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c9bb93a2c81e..7dd6d419254d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -168,7 +168,6 @@ static void __dwc3_set_mode(struct work_struct *work)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
 			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
 			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
-			phy_calibrate(dwc->usb2_generic_phy);
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -1166,7 +1165,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 				dev_err(dev, "failed to initialize host\n");
 			return ret;
 		}
-		phy_calibrate(dwc->usb2_generic_phy);
 		break;
 	case USB_DR_MODE_OTG:
 		INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
-- 
2.17.1

