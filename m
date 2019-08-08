Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6412EC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DD52173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KItGPt71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389776AbfHHJl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:41:58 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46587 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732281AbfHHJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:41:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190808094148euoutp0104392fa2da58d467319e87d630d527c7~46TqZ2Aaz1464214642euoutp01N
        for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2019 09:41:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190808094148euoutp0104392fa2da58d467319e87d630d527c7~46TqZ2Aaz1464214642euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565257308;
        bh=cz4Qd6MlizXRretLU95QGiGoiGOemuoYoRdu6ABD9jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KItGPt71NBC6ltnkE3fto32lsThXSodw2duHmJfqj4nmQLbqka0XOfTgub6BdaDSh
         ICB95UjuEFer5hK+GABthehT4okCzEk8oCJOHofK2hkXfIt3Q9RLwhMpNyk1TU81w+
         NIoimCfdfuDS/5Zyi7pa299yxI8/GExG5t896V+g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190808094147eucas1p2389c9f807a695836c3c25b6629fe1524~46TpqTPUh3273032730eucas1p2f;
        Thu,  8 Aug 2019 09:41:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 89.84.04374.B5EEB4D5; Thu,  8
        Aug 2019 10:41:47 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190808094146eucas1p27c673846a5a9be0c55f1f87c89af4adf~46To-nEeV3273032730eucas1p2c;
        Thu,  8 Aug 2019 09:41:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190808094146eusmtrp2ec2650f8d2256fd43dbab1e64b694e10~46ToweoCy2859328593eusmtrp2I;
        Thu,  8 Aug 2019 09:41:46 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-bb-5d4bee5bb977
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BC.E6.04117.A5EEB4D5; Thu,  8
        Aug 2019 10:41:46 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190808094146eusmtip133b223338a0b9f9cfd92077cf8157957~46ToLCmDV2428224282eusmtip1Z;
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
Subject: [PATCH v2 2/2 RESEND] usb: dwc3: remove generic PHY calibrate()
 calls
Date:   Thu,  8 Aug 2019 11:41:28 +0200
Message-Id: <20190808094128.27213-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190808094128.27213-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djP87rR77xjDQ5OFrPYOGM9q8Wxtifs
        Fs2L17NZLP17j9Hi/PkN7BaXd81hs5hxfh+TxaJlrcwW6zbeYrdYe+Quu8WxRSdZLJo3TWF1
        4PHYOesuu8fTCZPZPRbvecnksWlVJ5vH/rlr2D36tqxi9Niw5R+Lx+dNcgEcUVw2Kak5mWWp
        Rfp2CVwZk/7OZC5o466YdbaXtYFxGWcXIyeHhICJxJsZ81m7GLk4hARWMEq8PnqTGSQhJPCF
        UeLXmlKIxGdGiX131rLAdCz9u4oFomg5o8S6T6oQRUANqw9+YQdJsAkYSnS97WIDsUUEHCSW
        LL3DBlLELLCbWWLvz3dgCWGBAIn1MxrB1rEIqEo8eL4SbCqvgK3En0eb2SC2yUus3nAArIZT
        wE7iRcMCRpBBEgKr2CV2dG1kgihykXi8aD47hC0s8er4FihbRuL/zvlMEA3NjBIPz61lh3B6
        GCUuN81ghKiyljh8/CIwCDiA7tOUWL9LHyLsKDHtzTp2kLCEAJ/EjbeCIGFmIHPStunMEGFe
        iY42IYhqNYlZx9fBrT144RIzhO0hMfXyamZICE1klJg9Zy/rBEb5WQjLFjAyrmIUTy0tzk1P
        LTbOSy3XK07MLS7NS9dLzs/dxAhMO6f/Hf+6g3Hfn6RDjAIcjEo8vCdOeccKsSaWFVfmHmKU
        4GBWEuG9V+YZK8SbklhZlVqUH19UmpNafIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNT
        qoHxpmVKhirL8etBWTs/cLnpek3mOfmm3CY7cPEbf733llPKMiQu8CuHGeo6Tkt+dnQnqyC3
        jynjc8W1tXbnjjw0Mq6wkEtN3W61u8bKtP38vu9vNm3WflDMNrfyULiP7N0t2bt0PkVI7Ns0
        7clVhj4Zb+kM/x21r75Nt+3cfO21doX2WnP947lKLMUZiYZazEXFiQAQWEAnNwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Xd2od96xBlMbFS02zljPanGs7Qm7
        RfPi9WwWS//eY7Q4f34Du8XlXXPYLGac38dksWhZK7PFuo232C3WHrnLbnFs0UkWi+ZNU1gd
        eDx2zrrL7vF0wmR2j8V7XjJ5bFrVyeaxf+4ado++LasYPTZs+cfi8XmTXABHlJ5NUX5pSapC
        Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GpL8zmQvauCtmne1l
        bWBcxtnFyMkhIWAisfTvKpYuRi4OIYGljBI/v+5hg0jISJyc1sAKYQtL/LnWxQZR9IlR4vPf
        FnaQBJuAoUTX2y6wBhEBJ4nOtafBipgFDjJLXLy4F6xIWMBPYuejRrBJLAKqEg+er2QBsXkF
        bCX+PNoMtU1eYvWGA8wgNqeAncSLhgWMILYQUM3vfW0sExj5FjAyrGIUSS0tzk3PLTbSK07M
        LS7NS9dLzs/dxAiMg23Hfm7Zwdj1LvgQowAHoxIPb8EJ71gh1sSy4srcQ4wSHMxKIrz3yjxj
        hXhTEiurUovy44tKc1KLDzGaAh01kVlKNDkfGKN5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE
        0hNLUrNTUwtSi2D6mDg4pRoY97CmXNUWPvVn3tkodhaXsqD/2szGAtxvtzQfq66Y7z4nhOOz
        xNXVxVtnFjzUjbW7PFsn4ugH4xixAuPa+R88LFPSju+J6qgufuMTumdRf/DkbfKdux+82zGd
        6cT7hBlT5tm97W18XqfIvzdz1oqVuZ5RTy/tTw79+Sn0tXvbreUl0jb7F5U9UWIpzkg01GIu
        Kk4EABIURCCZAgAA
X-CMS-MailID: 20190808094146eucas1p27c673846a5a9be0c55f1f87c89af4adf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190808094146eucas1p27c673846a5a9be0c55f1f87c89af4adf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190808094146eucas1p27c673846a5a9be0c55f1f87c89af4adf
References: <20190808094128.27213-1-m.szyprowski@samsung.com>
        <CGME20190808094146eucas1p27c673846a5a9be0c55f1f87c89af4adf@eucas1p2.samsung.com>
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

