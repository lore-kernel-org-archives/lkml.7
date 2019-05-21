Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6812C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632A6217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ow/1QQWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfEUMAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:00:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45960 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbfEUMAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:00:19 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190521120017euoutp0291349957f11232965456b95e25be6671~gsPBi8lJf1873318733euoutp02T
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:00:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190521120017euoutp0291349957f11232965456b95e25be6671~gsPBi8lJf1873318733euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558440017;
        bh=RrQ0ZCpdVs97gZ7K9+8F0dNC/Ig6KHAEPZ/t/RRTOv4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Ow/1QQWZOJcc6oEB+N564vrjHLsF2MY0imj7r1eoJ2GypzMHb5vYLn+z8mpbDKjgW
         pcvjzm8HUKSZ/yj3rghaBe/jaXLb8IqV/nNWdV2fgZrVbBucEUbqTH+Op0hPbYpC3A
         MojMbCGBH04XYALemPWa43JTFYWwAh5vLd8G/t4M=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190521120016eucas1p135965dbdc9f2ddb42718ec766ef7c257~gsPAyQ-Nh2114221142eucas1p1y;
        Tue, 21 May 2019 12:00:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AE.AA.04377.058E3EC5; Tue, 21
        May 2019 13:00:16 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190521120015eucas1p1da2f3f32d6b8af8cb550463686fd4e12~gsPAAmFc71859418594eucas1p1J;
        Tue, 21 May 2019 12:00:15 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-e0-5ce3e8509ac1
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2C.02.04146.F48E3EC5; Tue, 21
        May 2019 13:00:15 +0100 (BST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PRU006F4RY90T20@eusync4.samsung.com>;
        Tue, 21 May 2019 13:00:15 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/5] Exynos EHCI/OHCI: resolve conflict with the generic USB
 device bindings
Date:   Tue, 21 May 2019 13:58:44 +0200
Message-id: <20190521115849.9882-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA/Xa2c46zE19r6YddrEFYRpZScGJqQv04RD/sb1q29KDmNmVz
        pvYjbVg6LMXyguXdRC2bd4ah6Zoas1wqXVxT1P3I8IK1EbNMax4l/73v9zwv74WPxETZAl8y
        QZnCqpQyuQQX8rsGVyzHI+bsUScr2n3o1lK9gK40jQhoba0epy2WFoIe736C06WWXh5dU5+N
        0d9MLkA3myYJ2jVTwqNXp2wCOrvHRNAFv9/j4RRjtd1m2ppyceZV+XOCWRg2E0zrkoHHPJ50
        AeZBRxNgHG0HIsjLwpBYVp6QyqpOhF0Txo9lWYnkAXFaa7mNnwkMUAc8SQRPoXytFtcBISmC
        DQDZq+Z5XOIAqL3TLNiyiteWCQ7UA+QoKcPdgIK7kOvhFF8HSBKDfsg0luh+xuBR1PlSv+mv
        A5Rn6MDcAIdBSLeo26gVw3BU99S20RqDIxiqXcnhucFueBU1DBby3TEfHkYfaj7xuWYhqKIj
        B+Mm8kPPWvowdzGC8zgyv7u/Cc4j88QSzsX7UG5OP4+TtADNjDQTXJIH0PidUsBZUvR6aFTA
        Db4TFXaVYO59EKRQzl0RpzBo+vvYhi6CV1D+YhFeAHzLtl2g7P8FyrZdoApgTcCH1agVcaw6
        WMneDFTLFGqNMi4wJknRBv59juG1IacBdK9eNwJIAskOip6xR4kEslR1usIIEIlJxNSweTZK
        RMXK0jNYVVK0SiNn1Uawl+RLfKhbHtORIhgnS2ETWTaZVW1RHunpmwkE2DlnVmDdH53n24w5
        0rs/Ov+zOPiI5pe1V+xlT/yiqNxTKF/9GFktHYjpCfNIE0r73hT+OLhQFOpYNlrKQ7y95p2X
        /E0ThKLRcz2gsUd6ef+92a8/9aqzi040V1xP+V8YCK3wSwuD0tNnJDHsoYsvikdtNwqOUdb2
        1OpKv0cSvjpeFhSAqdSyv60mkegYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t/xa7r+Lx7HGBzrMLTYOGM9q8X8I+dY
        LZoXr2ezOH9+A7vF5V1z2CxmnN/HZLFoWSuzxcsjPxgt1h65y27x4+F0Jos/9+6wWrTuPcJu
        MeH3BTYHXo9bd+o9Nq3qZPPYP3cNu8eb06fYPTa+28HkMfvuD0aPvi2rGD0+b5IL4IjisklJ
        zcksSy3St0vgyrjUeIu94KhIxca5d1gaGHcIdDFyckgImEhM+/eBvYuRi0NIYAmjROudj0wg
        CV4BQYkfk++xdDFycDALyEscuZQNEmYWUJeYNG8RM0R9I5NE7/0PLCAJNgFDia63XWwgtoiA
        g8SSpXfYQIqYBS4wS3Tu+MMOkhAWiJNYcWwSWAOLgKrE1UXXWSCW2UjM29LBDHGRvMTqDQeY
        JzDyzkJyxyyEO2YhuWMBI/MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwJDfduzn5h2MlzYG
        H2IU4GBU4uF9cO9xjBBrYllxZe4hRgkOZiUR3tOnHsUI8aYkVlalFuXHF5XmpBYfYpTmYFES
        5+0QOBgjJJCeWJKanZpakFoEk2Xi4JRqYCwrus0+/W9ew8M1t5fPeFEb4rdm9oIVCw/qxQuw
        FDPH3e1mvfa3MPF10+QJtsGqP2bGzmV68+nui8Mv3m0ST3gzrzwgpy11W1Lg25iNOY6v/1TF
        aKzlZZ44r+uk6LKXU78sTgq4vEbLXqYs8J3ijJLg0CN/ds0XzH8fU1E8yfft7ao1l5q9uHmV
        WIozEg21mIuKEwEmYL5ndQIAAA==
X-CMS-MailID: 20190521120015eucas1p1da2f3f32d6b8af8cb550463686fd4e12
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521120015eucas1p1da2f3f32d6b8af8cb550463686fd4e12
References: <CGME20190521120015eucas1p1da2f3f32d6b8af8cb550463686fd4e12@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Commit 69bec7259853 ("USB: core: let USB device know device node") added
support for attaching devicetree node for USB devices. Those nodes are
children of their USB host controller. However Exynos EHCI and OHCI
driver bindings already define child-nodes for each physical root hub
port and assigns respective PHY controller and parameters to them. This
leads to the conflict. A workaround for it has been merged as commit
01d4071486fe ("usb: exynos: add workaround for the USB device bindings
conflict"), but it disabled support for USB device binding for Exynos
EHCI/OHCI controllers.

This patchset tries to resolve this binding conflict by changing Exynos
EHCI/OHCI bindings: PHYs are moved from the sub-nodes to a standard array
under the 'phys' property. Such solution has been suggested by Måns
Rullgård in the following thread: https://lkml.org/lkml/2019/5/13/228

To keep everything working during the transitional time, the changes has
been split into 2 steps. First step (patches 1-3) need to be merged before
the second one (patches 4-5). Patches from each step can be merged to
respective trees without any dependencies - the only requirement is that
second step has to be merged after merging all patches from the first one.

This patchset has been tested on various Exynos4 boards with different
USB host controller configurations (Odroids family: X2, U3, XU3).

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Marek Szyprowski (5):
  dt-bindings: switch Exynos EHCI/OHCI bindings to use array of generic
    PHYs
  ARM: dts: exynos: Add array of generic PHYs to EHCI/OHCI devices
  usb: exynos: add support for getting PHYs from the standard dt array
  ARM: dts: exynos: Remove obsolete port sub-nodes from EHCI/OHCI
    devices
  usb: exynos: Remove support for legacy PHY bindings

 .../devicetree/bindings/usb/exynos-usb.txt    | 41 ++++++----------
 arch/arm/boot/dts/exynos4.dtsi                | 28 ++---------
 .../boot/dts/exynos4210-universal_c210.dts    |  8 +---
 arch/arm/boot/dts/exynos4412-itop-elite.dts   |  9 +---
 arch/arm/boot/dts/exynos4412-odroidu3.dts     |  8 +---
 arch/arm/boot/dts/exynos4412-odroidx.dts      |  5 +-
 arch/arm/boot/dts/exynos4412-origen.dts       |  9 +---
 arch/arm/boot/dts/exynos5250.dtsi             | 16 ++-----
 arch/arm/boot/dts/exynos54xx.dtsi             | 18 ++-----
 drivers/usb/host/ehci-exynos.c                | 48 +++----------------
 drivers/usb/host/ohci-exynos.c                | 48 +++----------------
 11 files changed, 50 insertions(+), 188 deletions(-)

-- 
2.17.1

