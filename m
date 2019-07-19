Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B50C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D879621849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b2PGbYAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfGSINi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:13:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52190 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfGSINh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:13:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190719081336euoutp02e9facefda862cd602bfd539844f15f72~ywM8aiPNH2054620546euoutp02d
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 08:13:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190719081336euoutp02e9facefda862cd602bfd539844f15f72~ywM8aiPNH2054620546euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563524016;
        bh=drg5AOx0OUTEFNPddGl8KS3mvIQGIebASAgTyhQFOYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b2PGbYAbRFFvpouRZpOauHV+NF7L+jEx7ktGC68JZq6rY6coYbGma7nAnSzEWm7DQ
         IuTczRrD+KuWE4p+8h1CkUVG2RivaILppSXASMH7PiWZmFAMdvPGrOg6SOFeNVHJlj
         lt0rd28GCQw7vgxJTy+2U9H4sspIxL4tyrtD3bhc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190719081335eucas1p1870db09343e0104a6690a0a246c78e2e~ywM7qcup42868428684eucas1p1X;
        Fri, 19 Jul 2019 08:13:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C6.D8.04298.FAB713D5; Fri, 19
        Jul 2019 09:13:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190719081334eucas1p1fd614e56c1ec0dfa654d0bb77f17ba5d~ywM6tFXO82473624736eucas1p1u;
        Fri, 19 Jul 2019 08:13:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719081334eusmtrp2e4ca084ef0679af6a6f0c14cec324c81~ywM6jDSiK3201232012eusmtrp2H;
        Fri, 19 Jul 2019 08:13:34 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-25-5d317baff1c7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EE.EE.04146.EAB713D5; Fri, 19
        Jul 2019 09:13:34 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190719081333eusmtip2e227f34779f0b92d208bf023e8e626ce~ywM6DCQNQ3189331893eusmtip20;
        Fri, 19 Jul 2019 08:13:33 +0000 (GMT)
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
Subject: [PATCH v2 2/2] usb: dwc3: remove generic PHY calibrate() calls
Date:   Fri, 19 Jul 2019 10:13:26 +0200
Message-Id: <20190719081326.9347-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719081212.9249-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG/Xa2c85Wk+O0/LBIWFYUeYOIQy0xCjrhPxIklUquPKnkpuyo
        af4jSlJmoeJlLdPhrZy56Royl2VauNJ0XnHOCxZlaJmULopM2/Es++/3Pe/zfC88vDgi0Qj8
        8CRlGq1SypOlqIjf1vNrINCQHRobUmjeRraqDQKyJ/8DRubVGlCy/s8MIG22FowcsVSipNr2
        nEfWNNxASH2rAyObX027fMZSQfgWql0zjVG1HfM8yqi7hVKdDx5j1F2TDlAtpjU+tWzcFYld
        EMni6eSkDFoVHBYnSrxXd0eQqhVl/qjJRXNAL14AcBwSh+CnRhcKcQnxCMD3o7sLgMjFKwCW
        fJ4G3GMZQOfSbYx1sYFxfZWAGzwEcEZt4m1GptrZiRBHiVBYsFiAsuxDhMO6+imUNSHEOg9W
        2F9vmLyJU9BR3rXBfGIP7Bwq57EsJmRwtanWvc4fNrW8QFgWEsdgUY4DYz+CRBUGtf1at+kk
        1I/aUI694YLV5NZ3wvX2ah4XyAPw3UCzO10I4EiuGnCuo/CldUjA1oEQ+6HBEszJx+GTLh3g
        WvKE9kUvVkZcWNJWgXCyGN7Ml3DuvVBj1W+u7RocRjimoN4y5W6oyNWjpg8rAv6a/8u0AOiA
        L53OKBJoJlRJXwti5AomXZkQdDlFYQSui+lbs343A+fwpW5A4EC6VRypCImVCOQZTJaiG0Ac
        kfqIJ+eDYyXieHnWdVqVclGVnkwz3WAHzpf6irM9ZqMlRII8jb5K06m06t+Uhwv9csCJr5bA
        5Mr+rrPfAibnYyoPSqMqmn7zTWM8Kj6iQjY3UGz2Or8cEz3rNbbq3zF4uNi5nf8xLpgfwUhz
        GpHqZ+nm8SXBlfCwCQQmlSpRjwDnwpEz5gZVFGLXLKjLnCfQn44vvvv6EU9dmj1ztSx1buV+
        79OJt3jkudOyxiHTGymfSZSHHkBUjPwvmYcCGS0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsVy+t/xe7rrqg1jDbZfELHYOGM9q8Wxtifs
        Fs2L17NZLP17j9Hi/PkN7BaXd81hs5hxfh+TxaJlrcwW6zbeYrdYe+QuUN2mKawO3B47Z91l
        91i85yWTx6ZVnWwe++euYffo27KK0WPDln8sHp83yQWwR+nZFOWXlqQqZOQXl9gqRRtaGOkZ
        WlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlzFzSy1qwgKvi26ImtgbGUxxdjJwcEgIm
        EtfXzWPtYuTiEBJYyihxaN9hFoiEjMTJaQ2sELawxJ9rXWwQRZ8YJbpudDCCJNgEDCW63oIk
        ODlEBJwkOteeBitiFmhllujecYMZJCEs4C5xa9pBsEksAqoS+y9OYwKxeQVsJP6sXswOsUFe
        YvWGA2D1nAK2EhMaboHFhYBq1j46xziBkW8BI8MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2M
        wJDfduzn5h2MlzYGH2IU4GBU4uENyDWIFWJNLCuuzD3EKMHBrCTCe/ulfqwQb0piZVVqUX58
        UWlOavEhRlOgoyYyS4km5wPjMa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoR
        TB8TB6dUA2P/Oz0ZnbWNF76+OeYW8eGCmeLeQBuhezwh/txHxZ//e2N9VT3JLa/8wX1O7s0h
        J9PfBk9oW1l5ImtVt+W5v+ybbz++xa6z/rT8IhfhJzzy3gdmfBDSvjhRp6VxDldZnOMTkb0S
        Fn3eku8VDU+Hq9l69HBkf+Pdb78jP7v75SbnuHuLLVd91lJiKc5INNRiLipOBAA7sX+QjwIA
        AA==
X-CMS-MailID: 20190719081334eucas1p1fd614e56c1ec0dfa654d0bb77f17ba5d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719081334eucas1p1fd614e56c1ec0dfa654d0bb77f17ba5d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719081334eucas1p1fd614e56c1ec0dfa654d0bb77f17ba5d
References: <20190719081212.9249-1-m.szyprowski@samsung.com>
        <CGME20190719081334eucas1p1fd614e56c1ec0dfa654d0bb77f17ba5d@eucas1p1.samsung.com>
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

