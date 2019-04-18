Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A82C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6682083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lYvoiR7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbfDRNjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:39:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34225 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389110AbfDRNi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:38:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190418133856euoutp01d54e2de1bac0e55aa95c898cc21daa34~WlSu2BNbK0269202692euoutp01k
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 13:38:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190418133856euoutp01d54e2de1bac0e55aa95c898cc21daa34~WlSu2BNbK0269202692euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555594736;
        bh=DYDvjBZVL6sxzkf5UpTzzrSynrTk6h2kigPuEB7raUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYvoiR7MrNUoStFDYUecafAsRoX9jdpT3nNNWQXTPbxJ0i02WBB1D6Gw/IJNJ2GSD
         pqgumh1IXpQHx1qHxgnUVD9SY4KWpvxLdEF5tqPdKYElBjHjDzJEYrCM5MOE2bOuRi
         07AtlT11AY2PFzQeEdiNQKLmspFnMA/Q/QXzP/U8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190418133855eucas1p2e7fa0afe3cd772dea9e3719a822cea65~WlSt6kqm-0131901319eucas1p2H;
        Thu, 18 Apr 2019 13:38:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C0.D2.04298.EED78BC5; Thu, 18
        Apr 2019 14:38:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190418133854eucas1p11bd927755163f0030a1748a023099a06~WlStLLo440775607756eucas1p1n;
        Thu, 18 Apr 2019 13:38:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190418133854eusmtrp298b195b065f07e9dfc8e88a4382c2fdb~WlSs9H3t52812628126eusmtrp2-;
        Thu, 18 Apr 2019 13:38:54 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-90-5cb87deea383
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D9.55.04140.EED78BC5; Thu, 18
        Apr 2019 14:38:54 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190418133853eusmtip2f01ec64a6e63024cc71e827bd84e4554~WlSsOeYQF1998719987eusmtip2b;
        Thu, 18 Apr 2019 13:38:53 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: [PATCH v2 3/4] Documentation: devicetree: add PPMU events
 description
Date:   Thu, 18 Apr 2019 15:38:31 +0200
Message-Id: <1555594712-18341-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSbUhTURju7O7uXs3FdUa+qRiuwjLSpKATmmQFXcsfQtCHSbX0YuJmtqum
        mTSbpZNMCUuRcvlRylCquWyaLnJDJdFpWVYifdinsyg1UQPNuVn/nvf5OM97DocmJAbSi05I
        SuGUSTK5VOQqbGyftm78kWWM2aT6tA3fL71L4oGJLyTWWnpIXDhsI7DVeo/C3RdGKfxG5YP1
        wy9J/Lz5hgiPF1gQLrWaBLjeMkTh2wN9AjyYXSvCF1stFDaP5pJ4svMD2uHO1pXXIbapbIhi
        9TqNiG2oPs8++dEiYK8YdIgd1/tGUdGuoXGcPCGNUwaFHXc9OdViQ8nFS9NLKiopFdK75CMX
        GpgtkF3VifKRKy1hahGoh0yUY5hAoCnSOIdxBE/fjooWI4XtBSKHUIOgUztG/ov0VBYS+Yim
        RUwgGHWn7YHlTBWCSXO03UMwdwRgUo8J7IIHEwXq8gGR3S9k1sKjud12WszsBWttI+ko84XX
        PRrCjl2YfTDRbFroAqadgge2XOdGu2HQUu8MeMBIh4FyYB+Ya9IKHJgHVUEFcuBzMFx40+kJ
        AXNHH2nfgWDWw93mIAcdDr1/ihauAswyePXd3U4T8/BqY4mTFkPeJYnDvQ4Ml3udRSugpu66
        83AWzC/0zjcsR9CtqSKL0Kqy/2W3ENIhTy6VV8RzfHASdyaQlyn41KT4wNhTCj2a/0tdsx1j
        RvT72Yk2xNBI6iaGBGOMhJSl8RmKNgQ0IV0uDo8zxEjEcbKMs5zy1DFlqpzj25A3LZR6ijOX
        vDsiYeJlKVwixyVzykVVQLt4qdC6X7ZBUxOr7Y+KXTmz/14r+dAnuA9PhhwlIzfseu/un3dQ
        1cB1KXJbzDB1aM2Mauvj0cmKyjad/nOmPKXB5u0ftOpdpEFNxczuJL/mVyeav4VeiziQdVi5
        Z7Xcrfojr/YTpvf7aXMitnu8LzNOh/3EJdqAbmtO7Izfg80jacVSIX9SFhxAKHnZX0l5XUNH
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xe7rvanfEGNzp5bLYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jB97XjMWTOGumL5wEXsD4ybOLkZODgkBE4n+Y71sILaQwFJGiZmTAyDiYhKT9m1n
        h7CFJf5c64Kq+cQo8W1WWhcjBwebgJ7EjlWFXYxcHCICyxkljq16ywziMAtsY5LYc2U3I0iD
        sICfxNHd31lAGlgEVCV2/3cBCfMKeEmcX7GNFWK+nMTNc53MIDangLfEl137WCF2eUns2/GD
        ZQIj3wJGhlWMIqmlxbnpucVGesWJucWleel6yfm5mxiBUbLt2M8tOxi73gUfYhTgYFTi4ZXI
        3BEjxJpYVlyZe4hRgoNZSYTXMWVLjBBvSmJlVWpRfnxRaU5q8SFGU6CbJjJLiSbnAyM4ryTe
        0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QDI6vLGt6Fi+Xfb1i9OSZp
        rsq1bwz8Drw/u09VLtKQklQxXHv3O0tmonqvXWLg6yBjng++IZuO+01p/6zXGK9jvUqpQc57
        3bHbsVKnxFnYlPlf36q+erG8ezfj09NLHvv8eeo7w6P8T1q8YOWeS3XGK+ev/zk7YXVgamXa
        c++fHzuzdszV4GsrVGIpzkg01GIuKk4EAGjjQUioAgAA
X-CMS-MailID: 20190418133854eucas1p11bd927755163f0030a1748a023099a06
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190418133854eucas1p11bd927755163f0030a1748a023099a06
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190418133854eucas1p11bd927755163f0030a1748a023099a06
References: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190418133854eucas1p11bd927755163f0030a1748a023099a06@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the documenation by events description with new 'event-data-type'
field. Add example how the event might be defined in DT.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../devicetree/bindings/devfreq/event/exynos-ppmu.txt  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
index 3e36c1d..47feb5f 100644
--- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
+++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
@@ -145,3 +145,21 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
 			reg = <0x104d0000 0x2000>;
 			status = "disabled";
 		};
+
+The 'event' type specified in the PPMU node defines 'event-name'
+which also contains 'id' number and optionally 'event-data-type'.
+
+Example:
+
+		events {
+			ppmu_leftbus_0: ppmu-event0-leftbus {
+				event-name = "ppmu-event0-leftbus";
+				event-data-type = <PPMU_RO_DATA_CNT>;
+			};
+		};
+
+The 'event-data-type' defines the type of data which shell be counted
+by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
+all possible type, i.e. count read requests, count write data in bytes,
+etc. This field is optional and when it is missing, the driver code will
+use default data type.
-- 
2.7.4

