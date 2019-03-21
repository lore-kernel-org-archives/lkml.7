Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D10C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F1B218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JgfmZGZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfCUJBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:01:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43875 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUJBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:01:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190321090121euoutp025705c2b4454308e09a78c8c51adc59eb~N7cYgXD-f1403714037euoutp02l;
        Thu, 21 Mar 2019 09:01:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190321090121euoutp025705c2b4454308e09a78c8c51adc59eb~N7cYgXD-f1403714037euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553158881;
        bh=8+yQppJTTe/pk5v0k1esXlWZMsBnCPEdRVOFWj5sSpc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JgfmZGZPskedRNLFZRPOsqP+hlBgKgGOhd6/UKr+/6Nj++uUEcvGagY0ohQxLLH5p
         3pDgdlxS2PSMyRJHVTAQty89rc8PVKtArTLWc3Edd8WMrWFRWByC309zWGwhDyFvkp
         dTm0IGNlHZPieXV/IGwlbjWzP6LKiDK3aGLVDH5g=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190321090121eucas1p14596fdf5f851e2a120fcabe8e6015627~N7cYACYDV2911429114eucas1p10;
        Thu, 21 Mar 2019 09:01:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EA.54.04294.0E2539C5; Thu, 21
        Mar 2019 09:01:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190321090120eucas1p1d5122777e84f4e3c965946a8c5aead8b~N7cXco60s1997819978eucas1p19;
        Thu, 21 Mar 2019 09:01:20 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-47-5c9352e07b23
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E8.36.04128.0E2539C5; Thu, 21
        Mar 2019 09:01:20 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.120.51.73]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0POP00FDEL24A020@eusync1.samsung.com>;
        Thu, 21 Mar 2019 09:01:20 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>
Subject: [PATCH] PM / devfreq: exynos-bus: Suspend all devices on system
 shutdown
Date:   Thu, 21 Mar 2019 10:01:10 +0100
Message-id: <20190321090110.26506-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7djPc7oPgibHGKxebGWxccZ6VovrX56z
        Wpw/v4Hd4laDjMXlXXPYLD73HmG0mHF+H5PFyyM/GC3WHrnLbnG7cQWbA5fHrTv1HptWdbJ5
        HHy3h8mjb8sqRo/Pm+QCWKO4bFJSczLLUov07RK4Mk7uPcRS8Jm7ovn6CbYGxj+cXYycHBIC
        JhJvXq9h7WLk4hASWMEoMXnNdkYI5zOjxNau6ywwVVs3PmKCSCxjlDjw+C6U859R4lxLLxtI
        FZuAoUTX2y4wW0QgXuL6n2MsIEXMAluZJLpb5zCDJIQFgiX2PLsDVsQioCpxedEeJhCbV8BW
        4tTfc0wQ6+QlVm84wAzSLCHQwSax+f0cNoiEi0T7ha+sELaMxOXJ3SwQRc2MEg/PrWWHcHoY
        JS43zWCEqLKWOHz8IlgHswCfxKRt04HGcgDFeSU62oQgSjwkts28C7ZZSCBW4srCL0wTGMUX
        MDKsYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECIy30/+Of9nBuOtP0iFGAQ5GJR7eCIdJ
        MUKsiWXFlbmHGCU4mJVEeE1sJ8cI8aYkVlalFuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKa
        nZpakFoEk2Xi4JRqYPThnGvufi6sanE7W0GdhsWO+MYpKXFv8uw43Pbz3n3uLPliE9sBI+Wb
        YQ9ebF0YnlI+6e7U2Fuye1beWCwu/dutqvmTTMLO35s0ngj4vZqTfuXbgvhlOd9O/p3deTRM
        sbTKRunD+hltcVpVE0WfqTx963ki9LIhX+StnbmdzbP2s4s2GvaeDldiKc5INNRiLipOBAAP
        oajlswIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNJMWRmVeSWpSXmKPExsVy+t/xy7oPgibHGDyYqWSxccZ6VovrX56z
        Wpw/v4Hd4laDjMXlXXPYLD73HmG0mHF+H5PFyyM/GC3WHrnLbnG7cQWbA5fHrTv1HptWdbJ5
        HHy3h8mjb8sqRo/Pm+QCWKO4bFJSczLLUov07RK4Mk7uPcRS8Jm7ovn6CbYGxj+cXYycHBIC
        JhJbNz5i6mLk4hASWMIosWTqTnaQhJBAI5PE5te1IDabgKFE19suti5GDg4RgXiJk9NqQeqZ
        BbYzSex9+oEJpEZYIFhiz7M7bCA2i4CqxOVFe8DivAK2Eqf+nmOCWCYvsXrDAeYJjFwLGBlW
        MYqklhbnpucWG+kVJ+YWl+al6yXn525iBAbJtmM/t+xg7HoXfIhRgINRiYd3gcmkGCHWxLLi
        ytxDjBIczEoivCa2k2OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8543qIwSEkhPLEnNTk0tSC2C
        yTJxcEo1MCZ92m1wz1in1eDkDg/n19lX/u9+HtE+fX7ahEau9TNzt05+q/Ps22u1ZaeE9zSu
        4l9oo7JVml3h2/8LR9YfWz9DSolHWGmDzHoFV8Nl0s/fRc8WPvck1vv44ch0+eRlE9YcnmIl
        fe6J/OdrrecUNxyf7qW0YdLK1Ru/+vgs57laf/Hv76s7LI5fUGIpzkg01GIuKk4EAEZWvMcO
        AgAA
X-CMS-MailID: 20190321090120eucas1p1d5122777e84f4e3c965946a8c5aead8b
CMS-TYPE: 201P
X-CMS-RootMailID: 20190321090120eucas1p1d5122777e84f4e3c965946a8c5aead8b
References: <CGME20190321090120eucas1p1d5122777e84f4e3c965946a8c5aead8b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force all Exynos buses to safe operation points before doing the system
reboot operation. There are board on which some aggressive power saving
operation points are behind the capabilities of the bootloader to properly
reset the hardware and boot the board. This way one can avoid board crash
early after reboot.

This fixes reboot issue on OdroidU3 board both with eMMC and SD boot.

Reported-by: Markus Reichl <m.reichl@fivetechno.de>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This is an alternative to https://patchwork.kernel.org/patch/10781433/
limited only to Exynos-bus driver.
---
 drivers/devfreq/exynos-bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index c25658b26598..486cc5b422f1 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -514,6 +514,13 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void exynos_bus_shutdown(struct platform_device *pdev)
+{
+	struct exynos_bus *bus = dev_get_drvdata(&pdev->dev);
+
+	devfreq_suspend_device(bus->devfreq);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int exynos_bus_resume(struct device *dev)
 {
@@ -556,6 +563,7 @@ MODULE_DEVICE_TABLE(of, exynos_bus_of_match);
 
 static struct platform_driver exynos_bus_platdrv = {
 	.probe		= exynos_bus_probe,
+	.shutdown	= exynos_bus_shutdown,
 	.driver = {
 		.name	= "exynos-bus",
 		.pm	= &exynos_bus_pm,
-- 
2.17.1

