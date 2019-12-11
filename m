Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703D9C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468B721556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mb8i57rO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfLKOwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:52:16 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35313 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKOwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:52:16 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191211145214euoutp01ca8bd9a0ac587a30d623852843b7ca8d~fWLZG-TOp2200222002euoutp01Z
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:52:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191211145214euoutp01ca8bd9a0ac587a30d623852843b7ca8d~fWLZG-TOp2200222002euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576075934;
        bh=qTaGKuC9cCAB+1j7GCP6On5IHmid3yqkEWyTajSdyOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mb8i57rOTKdqMiFgX8p5YDI8YqNT+740uzElwlU95aaj0Sc85UjitjIzCDagHpvbn
         /6AI1IJU9Nx1snXAlV41sFf4C3ENQjXFRSDJ65mO54C8mrYTeEAWW5twEoWMGCk3Sq
         Oc1kSlYkKHqHRim9PZAvBWeHA60WwcZSHvrEpMvE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191211145214eucas1p2b19c265b185e2ac4c73d146201a443e8~fWLYv5LWD0707307073eucas1p2O;
        Wed, 11 Dec 2019 14:52:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 42.DE.60698.E9201FD5; Wed, 11
        Dec 2019 14:52:14 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191211145213eucas1p2c438f848ba705fa407331bb31b03b626~fWLYd1P7J1065910659eucas1p2R;
        Wed, 11 Dec 2019 14:52:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191211145213eusmtrp2c30d1e464771e3d3f4d441d8d5275168~fWLYdCsMM0450404504eusmtrp2M;
        Wed, 11 Dec 2019 14:52:13 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-94-5df1029ea016
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7E.D9.08375.D9201FD5; Wed, 11
        Dec 2019 14:52:13 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191211145213eusmtip1f8bac6888c5908f6393dfadf01ec598f~fWLXzNfb-1276212762eusmtip1N;
        Wed, 11 Dec 2019 14:52:13 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 2/4] ARM: dts: qcom: Correct USB3503 GPIOs polarity
Date:   Wed, 11 Dec 2019 15:52:08 +0100
Message-Id: <20191211145208.24976-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211145054.24835-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+XbOzjkbzU5T9Esjc1Rg4A2NPii1oMv5IyKDwgTRmadpOZNN
        zYLInJc2LM07orbUNLxteU2peUldEWxeYBk2SyXpglbMDC9km8fsv9/7vO/zPS8vH4WJh/ju
        VHxiMqtIlCZICCHeObxs8qni/Yz0f1eII9PsKo6elun46E3vAo5yDJU4UtXoCGQ260lUtFbP
        Q62zFj4a76kg0LhqFKAys4GHquuyMNQ8aCVRRmYgylbX8VFbSw6JlgfMvKM7mJrfUxijn2nk
        M93lVpJpbVATzHvLc4LprWwimbba20zm616cud/eABhb6+6zwgjhkVg2IT6VVfiFRAvjTLn9
        eNKwIG3EtoSngxVSAwQUpIOgaXV6g8X0EwANXZQGCO28CGCtvgrjChuAfbaMLUd37Q/ANeoB
        VM+pCc5ut8x8cXEwQQdAzbyGcAy50E0Art4rwx0FRq9gsNNSv+Fwpk9CrXXd3qAonN4Hh/I8
        HbKIDobT+V2AS/OEjfo+zMECOgRqllo23oH0FAkn7szj3NBxWKLTbrIz/Gps31x1F1zvfsjj
        DCoAp03NJFfkAjieUbYZcRi+NI7yHVtgtDfU9fhx8jFYUGzYkCHtBCfmdzhkzI4FnaUYJ4vg
        3WwxN70flhtbtmL7R8Ywjhmo7bbyuWs9AFClt5L5wLP8f5gWgAbgxqYo5TJWGZjIXvdVSuXK
        lESZ76Vr8lZg/1xv/hh/PQOGtZgBQFNAsk2k7foeKeZLU5U35AMAUpjERWTMXogUi2KlN26y
        imtRipQEVjkAPChc4iYKrP4SKaZl0mT2KssmsYp/XR4lcE8HF3rCdE8s20+ZY4bbG+W20ovV
        Xq5F5ywdeWq1qOIyDHlMTFY6AQUzF/12LD948UTYN+GPWx5swunSIJ/ivDTJ5J7K5dAPuMiS
        9/lQx8GsKHynoOXVlc/E4MTIozGVt+Lj3vMLEYVeHrP6tGX/MzVOroKS0BrfTy9kPeHhuSVx
        WgmujJMGHMAUSulfCwmYblgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7pzmT7GGlxZpm9x7vFvFouNM9az
        Wpze/47Fon3fXBaL5sXr2SzOn9/AbjHlz3Imi02Pr7FaXN41h83icvNFRosZ5/cxWSxa1sps
        sfbIXXaLphZji7bOZawWm9e1s1v8PHSeyUHQY/H3e8weGx6tZvXYOesuu8emVZ1sHneu7WHz
        2D93DbvH5iX1Hi0n97N49G1ZxejxeZNcAFeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWe
        obF5rJWRqZK+nU1Kak5mWWqRvl2CXsa5noMsBcc4Ky58/sbSwPiLvYuRk0NCwERi55IPjF2M
        XBxCAksZJY4032GBSMhInJzWwAphC0v8udbFBlH0iVFi38NHYN1sAoYSXW8hEiICGxglzrx/
        wgLiMAs0sUhMnfWYCaRKWMBNYsHd/0AJDg4WAVWJo/3yIGFeAVuJhxO2M0JskJdYveEAM4jN
        KWAn0fVtHdgVQkA1n263sU1g5FvAyLCKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMJK2Hfu5
        eQfjpY3BhxgFOBiVeHgXbH8fK8SaWFZcmXuIUYKDWUmE93jbu1gh3pTEyqrUovz4otKc1OJD
        jKZAN01klhJNzgdGeV5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6p
        BkYhs8pfCx+buiwpq/+1h0dywZkpDj+3fuFyPM8v5u4nUOKz22pvgtDmmJfqMxfMUdt9PrM5
        fPeBzDiPexF5r8P7dJ6U+vxaXFq5RiZxw9LgZt/8f3WfZr/7mlo3ITx0766TxTudShr7esyC
        A3aYWzdnL1ix98Wt72+cBfn+Sn7T2mIaekRGRUeJpTgj0VCLuag4EQDc3CIRugIAAA==
X-CMS-MailID: 20191211145213eucas1p2c438f848ba705fa407331bb31b03b626
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191211145213eucas1p2c438f848ba705fa407331bb31b03b626
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191211145213eucas1p2c438f848ba705fa407331bb31b03b626
References: <20191211145054.24835-1-m.szyprowski@samsung.com>
        <CGME20191211145213eucas1p2c438f848ba705fa407331bb31b03b626@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current USB3503 driver ignores GPIO polarity and always operates as if the
GPIO lines were flagged as ACTIVE_HIGH. Fix the polarity for the existing
USB3503 chip applications to match the chip specification and common
convention for naming the pins. The only pin, which has to be ACTIVE_LOW
is the reset pin. The remaining are ACTIVE_HIGH. This change allows later
to fix the USB3503 driver to properly use generic GPIO bindings and read
polarity from DT.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
index 26160c324802..942e3a2cac35 100644
--- a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
+++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
@@ -143,7 +143,7 @@
 				compatible = "smsc,usb3503a";
 				reg = <0x8>;
 				connect-gpios = <&gpioext2 1 GPIO_ACTIVE_HIGH>;
-				intn-gpios = <&gpioext2 0 GPIO_ACTIVE_LOW>;
+				intn-gpios = <&gpioext2 0 GPIO_ACTIVE_HIGH>;
 				initial-mode = <1>;
 			};
 		};
-- 
2.17.1

