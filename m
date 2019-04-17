Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCF1C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0281A20693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FJ3gOqAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbfDQHsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:48:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40694 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbfDQHsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:48:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190417074837euoutp024a7169fc4b594ea5bc9c09ed0828908e~WM3lOc90a0488604886euoutp02P
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:48:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190417074837euoutp024a7169fc4b594ea5bc9c09ed0828908e~WM3lOc90a0488604886euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555487317;
        bh=DYDvjBZVL6sxzkf5UpTzzrSynrTk6h2kigPuEB7raUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJ3gOqAcU8bcdCbkL06wHOIkeFLjmZ/ikF/CoUi8LsnT0A0uwu1AIn9afVB96SMrm
         JMJB8dNdgxA5v+FRT+kWSSg+WUetMb+PrEvi32tn8z0KxT1aJiVj9prMmDWX79u2U/
         T3JY9WxeXwFSX7WD/cV8l5jvlK+rRhJROGjdEu+E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190417074836eucas1p187361f4b6d6a961c8464cf6e05e8f13e~WM3kjIWYZ0763207632eucas1p1h;
        Wed, 17 Apr 2019 07:48:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5A.C8.04298.45AD6BC5; Wed, 17
        Apr 2019 08:48:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190417074835eucas1p19319bedd176d55e10b272881b7c68919~WM3jbKOoy0044400444eucas1p1E;
        Wed, 17 Apr 2019 07:48:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190417074835eusmtrp2fe677ab59dfdb696b0d58c58ff1d9e3d~WM3jLFMyO2697626976eusmtrp2K;
        Wed, 17 Apr 2019 07:48:35 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-6a-5cb6da54505f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.69.04146.35AD6BC5; Wed, 17
        Apr 2019 08:48:35 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190417074834eusmtip16c1ff37602f19f9e71ff0754d669177a~WM3ihm0t13147631476eusmtip1v;
        Wed, 17 Apr 2019 07:48:34 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com
Subject: [PATCH 3/3] Documentation: devicetree: add PPMU events description
Date:   Wed, 17 Apr 2019 09:48:08 +0200
Message-Id: <1555487288-4777-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfSyUcRzvd8899zzo9DiW3xDbNVtqkantt2WNlu3oj6wXM2k6eUJxdI+X
        0LjIa4kQt8odvaDD1HVJJhUnS3mLiNiMhuWl5VwxG3l6rvXfZ5/X7bsviYmqcDsyUhZHy2XS
        KLHAnN/4brV378nRxuB9Gb9t0VNlA46Gl2dwpNb34Khgag5Dvb1PCNSdPk+gUYUD0k4N4Wig
        +Z4AGfL1ACl7W3moXj9OoEfD/Tz09WqNAGW+0hOofT4b96Ikdao6INFqcgWSZw/TJG8XW3iS
        mzoNkBi0jv6CIHPPMDoqMoGWux06ax6x0jIHYkssLpdV3icUQGuWB8xISO2HRl0XkQfMSRFV
        A+BqRzGPFUTUMoBV84gTDAB+zF4S/EuotCrACdUAzpaOm+Kbibtaw6ZCkgLKFTZpLrEBG+oB
        gL/ag1gPRuXy4GJxy98ma+ooLFKm4yzmU84w+/Zngs0KKV+o3gjgxhzhSE8uxmIzyg+qJrp4
        HN9MwKHWJNYOqSNQO8nnaGv4vVNHcNgBbrxUm+wMVORXAg5fgVMF5SbPQdje2Y+zNRjlAhua
        3TjaG/4YyeZz7Zbwy4IVS2ObsKixDONoIczJEnHuXVB3o880tB1W15WayiVwbb2D4K5ZDuDA
        zJ5C4HTn/1YFABpgS8cz0eE04y6jE10ZaTQTLwt3PRcTrQWb3/NhvXOpCRg/hbYBigTircKa
        1efBIlyawCRFtwFIYmIboXeYLlgkDJMmJdPymBB5fBTNtAF7ki+2FaZsmTgtosKlcfRFmo6l
        5f9UHmlmpwD1F/w9N9IMosBJyxRwxmfM9/W0rfuad0i7fYHHt5HA632zUUt+CZkBdokHSpVv
        XFJPCXbWHg81Wr1Pdd6IH5Rl5FbJPLw6NcrDkwtG4/QOfWDOeQtHG9WxbbWxj8daa64Nuvmd
        KPy5OOOtLHlhUXErWeHk070idsRjsnyK1MgmVMxnIqTuuzE5I/0D8LWbGTkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e/4Xd3gW9tiDLYu5LLYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ3UQ8Fgzbw2jx6ZVnWwem5fUexx8t4fJo2/LKkaPz5vkAtii
        9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ+7HnN
        WDCFu2L6wkXsDYybOLsYOTkkBEwk5m2ax9jFyMUhJLCUUeLC2h3MEAkxiUn7trND2MISf651
        sUEUfWKUOHLoMVARBwebgJ7EjlWFIHERgeWMEsdWvWUGcZgFpjNJ3Hl3hQWkW1jAW2LSjCZW
        EJtFQFWifepVdpBmXgFPifn/wyAWyEncPNcJtphTwEti3oNTTCC2EFDJ1gMLWCYw8i1gZFjF
        KJJaWpybnltsqFecmFtcmpeul5yfu4kRGBXbjv3cvIPx0sbgQ4wCHIxKPLwrfm6NEWJNLCuu
        zD3EKMHBrCTC65iyJUaINyWxsiq1KD++qDQntfgQoynQTROZpUST84ERm1cSb2hqaG5haWhu
        bG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgVG8+9Ph3YEVCYbxX3kia0KlXhgG/5tg
        5bhQml2svsRj//mlt6V/KrD+jku/x36cYX23yYtDqyannJ9SXTbh84N1V02KzTtE35wM9fk9
        Q9rbbcvmbC3R/FvhK/Sy3NZtuMt5N9eNjVlMN2A26yz9vjPyGboXixU5FnGWBFRna8w3vfVf
        v9+xU4mlOCPRUIu5qDgRACZuz/ygAgAA
X-CMS-MailID: 20190417074835eucas1p19319bedd176d55e10b272881b7c68919
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190417074835eucas1p19319bedd176d55e10b272881b7c68919
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190417074835eucas1p19319bedd176d55e10b272881b7c68919
References: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190417074835eucas1p19319bedd176d55e10b272881b7c68919@eucas1p1.samsung.com>
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

