Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D38C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF832084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E/yhBor6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfF0HSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:18:00 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47724 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfF0HRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:17:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190627071746euoutp029723f62e89c482599e05322598b1dd1e~r-P7AhdVh2029320293euoutp02d;
        Thu, 27 Jun 2019 07:17:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190627071746euoutp029723f62e89c482599e05322598b1dd1e~r-P7AhdVh2029320293euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561619866;
        bh=01kyvHj/JU4j5qOUAe5VfR1X7QHg7wasRsZbbGpVbbw=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=E/yhBor6ZVpi/rnR27i5Tdi7K+zxt3YxLolJaxBpAKZpJ0dbz8fBZecP2m4y8MVZU
         Eu4sSZ18+75yKcaPqz9yi9KhBEd0iIsCo7N2DIcsNg2jo5wsljjcVsDXKEeuSbLf+c
         wmSbZu/N1wtWWzQbCyq3a6FOCmXgtLpAUscQQRDU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190627071746eucas1p24a7e1eec98d8e78a1f7a848bdde63816~r-P6nTk9s1039310393eucas1p2N;
        Thu, 27 Jun 2019 07:17:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BB.62.04298.A9D641D5; Thu, 27
        Jun 2019 08:17:46 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190627071745eucas1p1c171dcafd92fe51c99dc102949de6c99~r-P56WsyL2388423884eucas1p1x;
        Thu, 27 Jun 2019 07:17:45 +0000 (GMT)
X-AuditID: cbfec7f2-3615e9c0000010ca-18-5d146d9a0a2a
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EA.F3.04140.99D641D5; Thu, 27
        Jun 2019 08:17:45 +0100 (BST)
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PTQ00HYSXLCML00@eusync4.samsung.com>;
        Thu, 27 Jun 2019 08:17:45 +0100 (BST)
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
Subject: [PATCH 3/3] usb: dwc3: Remove generic PHY calibrate() calls
Date:   Thu, 27 Jun 2019 09:17:26 +0200
Message-id: <20190627071726.30467-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190627071726.30467-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7djP87qzckViDZp/8lhsnLGe1eJY2xN2
        i+bF69kslv69x2hx/vwGdovLu+awWcw4v4/JYtGyVmaLdRtvsVusPXIXqG7TFFYHbo+ds+6y
        eyze85LJY9OqTjaP/XPXsHv0bVnF6LFhyz8Wj8+b5ALYo7hsUlJzMstSi/TtErgyLlw/x1Lw
        m6vi0qXVTA2MfZxdjJwcEgImEvdnzmTqYuTiEBJYwShxYtYcRpCEkMBnRolVt8S6GDnAinb9
        r4aoWcYo8ezyLqiG/4wSHRtfMIE0sAkYSnS97WIDsUUEHCSWLL3DBlLELPCfSWL6jROsIAlh
        AReJ5beawRpYBFQlps0+zA5i8wrYSrR8f88OcZK8xOoNB5hBbE4BO4mj0yazgwySENjCJrH/
        4xeoIheJ92f2skDYMhKXJ3ezQBQ1M0o8PLcWqqOHUeJy0wxGiCpricPHL4KdwSzAJzFp23Rm
        iOd4JTrahCBKPCTuHtzGAvHbREaJSbP3ME5glFjAyLCKUTy1tDg3PbXYMC+1XK84Mbe4NC9d
        Lzk/dxMjME5P/zv+aQfj10tJhxgFOBiVeHgZ9gjHCrEmlhVX5h5ilOBgVhLhzQ8TiRXiTUms
        rEotyo8vKs1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXAuKRkwr/St1//m3Ic
        anee57BI7c70FyFeM8w/Zp2sk/bbxpu2Kv/I9Uv5c+cfvttzY6JkeMwpT9WVjyL0FnLwrrV8
        9Man8ZqMbp/6Fe5mO0nm7V1+9mczlcSFreP7Ui/PZTdzamC2WyXhtX1n8seWh5slqvY/fqvu
        niupL7zKUlQjc5PyjlemSizFGYmGWsxFxYkAxmRefM8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsVy+t/xa7ozc0ViDf63qFtsnLGe1eJY2xN2
        i+bF69kslv69x2hx/vwGdovLu+awWcw4v4/JYtGyVmaLdRtvsVusPXIXqG7TFFYHbo+ds+6y
        eyze85LJY9OqTjaP/XPXsHv0bVnF6LFhyz8Wj8+b5ALYo7hsUlJzMstSi/TtErgyLlw/x1Lw
        m6vi0qXVTA2MfZxdjBwcEgImErv+V3cxcnEICSxhlHjQ+4mxi5ETyGlkknj5RxDEZhMwlOh6
        28UGYosIOEgsWXqHDaSBWaCRWeL3jrOsIAlhAReJ5beamUBsFgFViWmzD7OD2LwCthIt39+D
        2RIC8hKrNxxgBrE5Bewkjk6bzA6xzFbiavt69gmMPAsYGVYxiqSWFuem5xYb6RUn5haX5qXr
        JefnbmIEht22Yz+37GDsehd8iFGAg1GJh3fFTuFYIdbEsuLK3EOMEhzMSiK8+WEisUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5OwQOxggJpCeWpGanphakFsFkmTg4pRoYmz9f8Oq7xJd8R9Eo
        Q2aViKuc3MEjX2Wl5Qw+WbZf359rYTD/x2f+M7u5Jj7JMf56e8bSteorHCdMepyf+dZNSaF5
        xfnE7cZ7PYLnvhIXKRH0mHXt34e9Nz+kuueHcNn9qm891VJT+cbUVnG5hRyvp22f5JMM2Rei
        Exd+0bjzOMt475pz5dMClViKMxINtZiLihMBqBqAYzcCAAA=
X-CMS-MailID: 20190627071745eucas1p1c171dcafd92fe51c99dc102949de6c99
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627071745eucas1p1c171dcafd92fe51c99dc102949de6c99
References: <20190627071726.30467-1-m.szyprowski@samsung.com>
        <CGME20190627071745eucas1p1c171dcafd92fe51c99dc102949de6c99@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calls to USB2 generic PHY calibrate() method were added by commit
d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for
exynos5420/5800"), but it turned out that the mentioned patch worked only
by the pure luck and fixed only one use case. To fix the issues with PHY
calibration it has been moved to XHCI HCD driver, what allows to perform
calibration in the proper time window. This patch removes those calls
from DWC3 driver, as they are no longer needed there.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/dwc3/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index baa029ceede9..f62e8442c614 100644
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

