Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB747C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ED1214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oUC90SXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfLKOw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:52:27 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35387 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKOwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:52:25 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191211145223euoutp01a39223ef92c7c42ae1462c937746cca1~fWLhgj0nQ2410224102euoutp01I
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:52:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191211145223euoutp01a39223ef92c7c42ae1462c937746cca1~fWLhgj0nQ2410224102euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576075943;
        bh=G6e9bRQSJqszd1aQwd52ZOX8/ksTctU4pV8j86XTo3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oUC90SXCFVcOLJV8pritfcW+PZOoU6c+WfmaCARp6Tiel1SxYgqDUyHvMCl+pzosB
         1GQ+q0DQ8z0CKz/vrnl5khSWo4sXDpbBNeOWWKcv4DFia2aZrmKfXhpjqoqDyQedZh
         hUURUH1j8MZgbKU1VRcJVMhEsxxRbPjoXtHaTPdM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191211145222eucas1p2d6430e07a3ef5d59d68f1fbe612cf0c1~fWLg7Vwo92757227572eucas1p2D;
        Wed, 11 Dec 2019 14:52:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 47.F9.60679.6A201FD5; Wed, 11
        Dec 2019 14:52:22 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191211145222eucas1p1d761af59e04017ddadbdbd1cceb59b1f~fWLgd3r6x1209212092eucas1p1P;
        Wed, 11 Dec 2019 14:52:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191211145222eusmtrp29491b3876f290c709fbbe27d17c8d7c1~fWLgc2eWW0452204522eusmtrp2A;
        Wed, 11 Dec 2019 14:52:22 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-62-5df102a61dd7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B0.7B.07950.6A201FD5; Wed, 11
        Dec 2019 14:52:22 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191211145221eusmtip15e0632ba3893c653ea497e46b0dc3a7c~fWLfn9mX51278512785eusmtip1O;
        Wed, 11 Dec 2019 14:52:21 +0000 (GMT)
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
Subject: [PATCH v2 3/4] ARM: dts: sun8i: a83t: Correct USB3503 GPIOs
 polarity
Date:   Wed, 11 Dec 2019 15:52:17 +0100
Message-Id: <20191211145217.25025-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211145054.24835-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0gUURjl7szOjIsb4yp5U1HaXlikmYVXKlEIHOhHRYRgiW45qKmr7Khl
        JJpvJx9ZmYsmiYaWz1W39ZGorY8lNM0USVLxQWCCj1B8pGnujtm/893vfOec7+NSmKxbbEOF
        KKNYlVIRJickuK5no/90meiX3xn+yXnUP7OJozp1rRj1ti/gKK2tCEdJpbUEGhjQkOjFVrkI
        1c+MiNFQyysCDSUNAqQeaBOhkrIUDFV3jZMoMdkVpWaUiVFDTRqJNvQDIk8LpnRtAmM005Vi
        prlgnGTqKzIIZmyklWDai6pIpuFNPJP8qR1nsrUVgFmut78m8ZVcDGTDQmJYlbNHgCR4wuAW
        mSN5MLNeJ0oAjRQPzChIn4Pbf/IJHkgoGf0WQN7QD4RiBcCUrjGRUCwD2DiWiPGAMo3kFgYI
        7+UA9s1l4PsTlVMpmFGXoF0gP8+bdK3oKgA3s9QmFkb/xqBupJwwsizpq/DxTg4wYpw+BkvX
        NWIjltKX4LC2BwgJHWClpsOkakZ7QH61xiQE6WkSpi2lYQLpMszTGHMYsSWcM2hJAdvBnebX
        ImEgCcCp/mpSKDIBHEpU71lcgJ2GQbFxO4x2hLUtzsKiXnCw56AAD8Bv8xZGMrYLn+ny904h
        hempMkHjOCww1Oy7fvzydS8ZAzcWq/cOnAvgu5Ii7ClwKPjvVQxABbBmo7nwIJY7q2TvO3GK
        cC5aGeR0NyK8Hux+rt5tw0oTaNm6owc0BeTm0uLGRT+ZWBHDxYbrAaQwuZXUkLrgJ5MGKmIf
        sqoIf1V0GMvpgS2Fy62lriU//WR0kCKKDWXZSFb1ryuizGwSQL6b46NVaBiFNzoLOyy0ddeH
        h5YiO+L8lUfi/UmHMNJ9dMnTt3hS+7zge3fmIVn84flOe378qNrRK86/e/WKj/f4WnaozsIn
        2b4vYtK28+bLWfPugA9Fs2OuWXY/zO7dykt2J5q26dZCwuU9R3p/vh2yNcumN/ZwVqeidOnt
        J+Q4F6xwOYmpOMVf+1GqIFgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7rLmD7GGuxbLWZx7vFvFouNM9az
        Wpze/47Fon3fXBaL5sXr2SzOn9/AbjHlz3Imi02Pr7FaXN41h83icvNFRosZ5/cxWSxa1sps
        sfbIXXaLphZji7bOZawWm9e1s1v8PHSeyUHQY/H3e8weGx6tZvXYOesuu8emVZ1sHneu7WHz
        2D93DbvH5iX1Hi0n97N49G1ZxejxeZNcAFeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWe
        obF5rJWRqZK+nU1Kak5mWWqRvl2CXsa94+YF/VwVj39sZGpg3M7RxcjBISFgIjFxdkIXIxeH
        kMBSRok1X3sYuxg5geIyEienNbBC2MISf651sYHYQgKfGCXWz/UEsdkEDCW63oLEuThEBDYw
        Spx5/4QFxGEWaGKRmDrrMRNIlbCAr8T+PUvBprIIqEos/rEBbCqvgK3ElS3HoLbJS6zecIAZ
        xOYUsJPo+raOBWKbrcSn221sExj5FjAyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMom3H
        fm7Zwdj1LvgQowAHoxIP74Lt72OFWBPLiitzDzFKcDArifAeb3sXK8SbklhZlVqUH19UmpNa
        fIjRFOioicxSosn5wAjPK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TB
        KdXA6Lz8/uLv/+7KrHX1D+1eUBe14N2tqA0TtdbKa3zW+8Ar7/GjSOHjbbfnNha81hwmZ8+z
        nroteCq2OLSeWy1x7fUXGx4U6zPtFm74eNv/7GKbSet55s34ocQrvWvz/0cBByZWHvwnVPzi
        ZIPM+va9p6YH65xsnGfk8OOVR0CLfYmVjtG2P7dYDimxFGckGmoxFxUnAgCVn2aYuAIAAA==
X-CMS-MailID: 20191211145222eucas1p1d761af59e04017ddadbdbd1cceb59b1f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191211145222eucas1p1d761af59e04017ddadbdbd1cceb59b1f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191211145222eucas1p1d761af59e04017ddadbdbd1cceb59b1f
References: <20191211145054.24835-1-m.szyprowski@samsung.com>
        <CGME20191211145222eucas1p1d761af59e04017ddadbdbd1cceb59b1f@eucas1p1.samsung.com>
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
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index fb928503ad45..d9be511f054f 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -101,7 +101,7 @@
 		initial-mode = <1>; /* initialize in HUB mode */
 		disabled-ports = <1>;
 		intn-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
-		reset-gpios = <&pio 4 16 GPIO_ACTIVE_HIGH>; /* PE16 */
+		reset-gpios = <&pio 4 16 GPIO_ACTIVE_LOW>; /* PE16 */
 		connect-gpios = <&pio 4 17 GPIO_ACTIVE_HIGH>; /* PE17 */
 		refclk-frequency = <19200000>;
 	};
-- 
2.17.1

