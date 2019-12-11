Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3CCC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F1F214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B3eaRYB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfLKOqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:46:54 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55191 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfLKOqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:46:50 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191211144649euoutp029094d1b6d64a6985012091044aa0d021~fWGqGd1po0993509935euoutp02R
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:46:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191211144649euoutp029094d1b6d64a6985012091044aa0d021~fWGqGd1po0993509935euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576075609;
        bh=XB9Dsgs+MX/AW0zv105VApQLwH1V9mP5dnZl5ja9Fws=;
        h=From:To:Cc:Subject:Date:References:From;
        b=B3eaRYB5Mr5X1qoQKjpAxqQ+/m+bFucthlmfslL7uK4t2T56Rnc4I+gqKXDSvbEZf
         koSrdW0qg9CccebV2zHfS6EXlRLe/RLoUBYHRm6aNB3VNs41I0c7jDESUTylIJWB2j
         Jg7xhD1QbFizIWDASrrUBTUBAG8v+5VWmkxpRvSA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191211144648eucas1p1f40add69b0d3c98ea90cc7eb58bfaa21~fWGpnfauJ0132701327eucas1p1t;
        Wed, 11 Dec 2019 14:46:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 79.19.60679.85101FD5; Wed, 11
        Dec 2019 14:46:48 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191211144647eucas1p23d85dee21029f864076eece98aadd525~fWGpBdiL80793007930eucas1p2g;
        Wed, 11 Dec 2019 14:46:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191211144647eusmtrp2d8491073638ef673156b058d2fc4659a~fWGpAmAX10169801698eusmtrp20;
        Wed, 11 Dec 2019 14:46:47 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-35-5df101584de4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9C.9A.07950.75101FD5; Wed, 11
        Dec 2019 14:46:47 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191211144647eusmtip1c700ac96bfe3e4b5c78b020d9f2807c5~fWGoV4f1Q0906009060eusmtip1p;
        Wed, 11 Dec 2019 14:46:47 +0000 (GMT)
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 0/4] USB3503: correct GPIOs polarity and update the
 driver
Date:   Wed, 11 Dec 2019 15:46:34 +0100
Message-Id: <20191211144638.24676-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRzGe3fOzjmOZscp+WKlsDBIyEuKvJlJSdApAqMPJcWopSc1ncrm
        LP1Q6rzkKqkVZtLKpml5d96XaM1yedu8lOxDSlMoDWZ4gTS7OY/at+f//H8Pz5+Xl8JETXwP
        Ki4xhZUnShPEhABv6Vk274sEcxL/6fdiZJ5awVFDUR0f9XfN4iivU4sjVWkdgSyWehLpp8b4
        aNTwmECjqmGAiiydPKQrz8FQzdtxEmVlB6Lc/HI+aqzNI9Gy0cI7TDOlPyYwpn6yis+0F4+T
        jL4yn2A+jXUQTJe2mmQay24w2b1dOFPQVAmYBb3nKcE5QWg0mxCXysr9wi4KYjVLbfzkTpdr
        Vo2VzACZzmrgREE6CE5PaEg1EFAi+gWAQ4O1PG5YBHBwrAJ3UCJ6AUBz+/GNhM30CuOgCgC7
        p5/gm4llk3otQdABUG1XE46FG10N4MqdojUKo80Y1KqG1yhXOgJW6mw8h8Zpb7iiyiIcWkgf
        gq1lH3CuzwtW1b9e64O0gYRf5tsAtzgKDRlz65Ar/GZqIjm9E/5tf8rjAioAbeYakhtuAzia
        VbSePgi7TcN8NaBWb9oL6wx+nH0EagdWcIcNaWdotbs4bGxValoeYpwthDdzRRy9Bxabajdr
        3wyNrCMM1FqiuKeTwL7Z57y7wLP4f1UJAJXAnVUqZDGsYn8ie9VXIZUplIkxvlFJMj1Y/Uv9
        f0yLbcDw65IR0BQQbxWWtH6XiPjSVEWazAgghYndhKbcWYlIGC1NS2flSRfkygRWYQQ7KFzs
        LgzUzUhEdIw0hY1n2WRWvrHlUU4eGeCELNX95MtGSXrUrivKxUcd0c278z529xYr4ye3LTkL
        +3p4QcHXBzSlx2L0D7T2yLrgwu2kt83ZHnFLTzTr5l2Q+fy83HAWZaVPPSND6S1KGwDN78IP
        NPxeVlpnxJfvF/p3iX6G+fr4FRhGzthPh+e4Z4aoaS/83ufYr/MhEjGuiJUG+GByhfQfFhoT
        TkcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4Xd1wxo+xBm2bzS3OPf7NYrFxxnpW
        i9P737FYtO+by2LRvHg9m8X58xvYLTY9vsZqcXnXHDaLy80XGS1mnN/HZLFoWSuzxdojd9kt
        mlqMLdo6l7FabF7Xzm7x89B5JgcBj8Xf7zF7bHi0mtVj56y77B6bVnWyedy5tofNY//cNewe
        m5fUe7Sc3M/i0bdlFaPH501yAVxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZG
        pkr6djYpqTmZZalF+nYJehmTfuxgLdgnWHFj0g32BsZGvi5GTg4JAROJh8d3M3cxcnEICSxl
        lJj9/wUTREJG4uS0BlYIW1jiz7UuNoiiT4wS8zu2MIIk2AQMJbreQiREBDYwSpx5/4QFJMEs
        cI1ZYtlmaRBbWMBXYs3fOWBTWQRUJX43N7GB2LwCthLbl1xhgdggL7F6wwHmCYw8CxgZVjGK
        pJYW56bnFhvpFSfmFpfmpesl5+duYgTGw7ZjP7fsYOx6F3yIUYCDUYmHd8H297FCrIllxZW5
        hxglOJiVRHiPt72LFeJNSaysSi3Kjy8qzUktPsRoCrR8IrOUaHI+MFbzSuINTQ3NLSwNzY3N
        jc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwbvbm4rSVmnjpzYlNcyNPlhgpPPm1Tf1r
        w43JkecrC5z2JzV3L/oa7DSpws8vbppG5iF9zV0yE28e98mRnzdBd8nd0mbVnx/7Xv03+nL0
        0Mpq/+f3DV515sc9W5s11ajhXq3DvTT1cIfVp54xfzuUeffcBw+/d5MWJAU9fFa1Tc30wF/z
        pqd9z5RYijMSDbWYi4oTAfL3nrmdAgAA
X-CMS-MailID: 20191211144647eucas1p23d85dee21029f864076eece98aadd525
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191211144647eucas1p23d85dee21029f864076eece98aadd525
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191211144647eucas1p23d85dee21029f864076eece98aadd525
References: <CGME20191211144647eucas1p23d85dee21029f864076eece98aadd525@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

A few days ago a patch for USB3503 driver has been posted (see v1 in the
changelog below), which changes the GPIO API used by the driver to the
new one (descriptor based). It turned out that this conversion broke USB
HUB operation on some boards (observed on Arndale5250).

Further analysis revealed that the existing code ignored the GPIO
polarity flags in the device tree. On the other hand the current GPIO
polarity flags used by various boards were simply incorrect, as it was
not possible to test them properly.

This patchset provides some standardisation for the GPIO polarity flags
for USB3503 chips in various DTS files and adds matching logic to USB3503
driver. For more information and rationale behind this approach, see the
thread linked as v1 below.

This patchset has been tested on the following boards:
Odroid X2, U3, XU and Arndale5250.

The patch for USB3503 driver should be merged one release later than the
DTS changes to keep the affected boards working in meantime.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:
v2:
- added DTS fixes, assumed that RESET GPIO should be ACTIVE_LOW and all
  other GPIOs ACTIVE_HIGH
- integrated a fixup for USB3503 driver inverting the logic behind the
  RESET GPIO to match the standardised GPIOs polarity

v1: https://lore.kernel.org/linux-usb/20191205145633.187511-1-linus.walleij@linaro.org/T/
- initial version, contains only USB3503 driver patch


Patch summary:

Linus Walleij (1):
  usb: usb3503: Convert to use GPIO descriptors

Marek Szyprowski (3):
  ARM: dts: exynos: Correct USB3503 GPIOs polarity
  ARM: dts: qcom: Correct USB3503 GPIOs polarity
  ARM: dts: sun8i: a83t: Correct USB3503 GPIOs polarity

 .../boot/dts/exynos4412-odroid-common.dtsi    |  2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts      |  2 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts     |  2 +-
 .../dts/qcom-mdm9615-wp8548-mangoh-green.dts  |  2 +-
 .../boot/dts/sun8i-a83t-cubietruck-plus.dts   |  2 +-
 drivers/usb/misc/usb3503.c                    | 94 +++++++------------
 include/linux/platform_data/usb3503.h         |  3 -
 7 files changed, 40 insertions(+), 67 deletions(-)

-- 
2.17.1

