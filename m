Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B357C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB1C21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NcJ+cu+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfEUKwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:52:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48317 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfEUKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:52:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190521105219euoutp02b05c9b08a1d03a60be3c740ac8c68c67~grTrdA_6I1480014800euoutp02N
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 10:52:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190521105219euoutp02b05c9b08a1d03a60be3c740ac8c68c67~grTrdA_6I1480014800euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558435939;
        bh=a4rhZ7HDvqEXTse02KOkCIPOpiX/GoXFahUQjVRjFLg=;
        h=From:Subject:To:Cc:Date:References:From;
        b=NcJ+cu+aKZ3+h5RKQrrpUzr0mvBakOdHXoTYYtfxF609Eqv5N1Hq3heFaFm0fh2ue
         VqxXojXBwlTfohpZlVBgeciVnvatgkSCgS+Asv/O8xtuRLa0i84KjiP2nkR6XD0DFr
         WYeMXfZGd+8uIbNGoTbsK8ze1nmOqMFXuYYbM17U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190521105218eucas1p223bcb596e0f5151933429035226d649c~grTqvaKul3024630246eucas1p2B;
        Tue, 21 May 2019 10:52:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CE.05.04298.268D3EC5; Tue, 21
        May 2019 11:52:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190521105217eucas1p19796d2969c1a568fecb0750818226241~grTp_qUlh0212202122eucas1p1L;
        Tue, 21 May 2019 10:52:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190521105217eusmtrp10af3bb8c9b7bf448b194ab3dfa026eef~grTpvH-dp1584715847eusmtrp1S;
        Tue, 21 May 2019 10:52:17 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-79-5ce3d86229b6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DA.F4.04140.168D3EC5; Tue, 21
        May 2019 11:52:17 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190521105217eusmtip13906abf5ab5422044daf75a93ee3213b~grTpZV8cU2619726197eusmtip1F;
        Tue, 21 May 2019 10:52:17 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] video: fbdev: atmel_lcdfb: add COMPILE_TEST support
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <f9d56fc1-3e02-9716-b764-82e9600e5919@samsung.com>
Date:   Tue, 21 May 2019 12:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djP87pJNx7HGFz7LmLR/m4Zu8WVr+/Z
        LDY9vsZqcaLvA6vF5V1z2CxerL3OarF980JmB3aPeWuqPe53H2fy2Lyk3uPOj6WMHp83yQWw
        RnHZpKTmZJalFunbJXBlbL62kqVgNlvFmy8rmBsYZ7N2MXJySAiYSJy8d5Spi5GLQ0hgBaPE
        8msTmCGcL4wSO9dNZAGpEhL4zCjRdtAPpmPh+ensEPHljBLHbopBNLxllDjw6TfYWDYBK4mJ
        7asYQWxhAXeJOY33gFZwcIgI6Ev86VIEqWcW+MQo0T5rLVgNr4CdxNRzO9hAbBYBVYnJP6aB
        zREViJC4f2wDK0SNoMTJmU/ADmIWEJe49WQ+E4QtL7H97RywqyUEprNLnF54ixniUheJL22v
        2CFsYYlXx7dA2TISpyf3sEA0rGOU+NvxAqp7OzAAJv9jg6iyljh8/CIryNnMApoS63fpQ4Qd
        JV48/MkIEpYQ4JO48VYQ4gg+iUnbpjNDhHklOtqEIKrVJDYs28AGs7Zr50qo0zwk3qz4xz6B
        UXEWktdmIXltFpLXZiHcsICRZRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZg+jn97/in
        HYxfLyUdYhTgYFTi4c2Y8ihGiDWxrLgy9xCjBAezkgjv6VNAId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYzsulFGexkWLFRn4yw+x3/z5KOqUqcapTi7
        GPYDdezTA5ds7teOvLG2+NrbMP+lfz5omq6M8mubu+HUg4WbWvY8k34Yd/1vRLWNkd3TdL39
        F/09vOTy3wRZhfpM3jUnnv91xffGx++2iXxuLepr/BbHk2rSdShL6rBVmNa88BkNsqfWPuxt
        V1JiKc5INNRiLipOBAA6lT9SOwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xu7qJNx7HGLxskLdof7eM3eLK1/ds
        FpseX2O1ONH3gdXi8q45bBYv1l5ntdi+eSGzA7vHvDXVHve7jzN5bF5S73Hnx1JGj8+b5AJY
        o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyNl9b
        yVIwm63izZcVzA2Ms1m7GDk5JARMJBaen87excjFISSwlFHi26ajjF2MHEAJGYnj68sgaoQl
        /lzrYoOoec0osaN1AxNIgk3ASmJi+ypGEFtYwF1iTuM9JpBeEQF9iT9diiD1zAKfGCV+PW8H
        q+EVsJOYem4HG4jNIqAqMfnHNLAjRAUiJM68X8ECUSMocXLmEzCbWUBd4s+8S8wQtrjErSfz
        mSBseYntb+cwT2AUmIWkZRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMj
        MH62Hfu5ZQdj17vgQ4wCHIxKPLwZUx7FCLEmlhVX5h5ilOBgVhLhPX0KKMSbklhZlVqUH19U
        mpNafIjRFOihicxSosn5wNjOK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTT
        x8TBKdXA2Ljyua/uNWaHaZsOxvNvPSk/e5V3/nYjS4dyhT0Cse97nmYk6N9JOO78O9ljWm4m
        L8+a4/XcGtHrf0/ROz8pfOf9T04dS3+tVp+rtnv1br5FAvOYQhMkFkxdt44ht599/vbkoLnq
        6SY1Ly0uXPO41/pxukmOxP0J1l9VrcoNZAOLc4032ZpqKbEUZyQaajEXFScCADhftqO1AgAA
X-CMS-MailID: 20190521105217eucas1p19796d2969c1a568fecb0750818226241
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190521105217eucas1p19796d2969c1a568fecb0750818226241
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521105217eucas1p19796d2969c1a568fecb0750818226241
References: <CGME20190521105217eucas1p19796d2969c1a568fecb0750818226241@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to atmel_lcdfb driver for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2: add missing HAVE_CLK && HAS IOMEM dependencies

 drivers/video/fbdev/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/video/fbdev/Kconfig
===================================================================
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -856,7 +856,8 @@ config FB_S1D13XXX
 
 config FB_ATMEL
 	tristate "AT91 LCD Controller support"
-	depends on FB && OF && HAVE_FB_ATMEL
+	depends on FB && OF && HAVE_CLK && HAS_IOMEM
+	depends on HAVE_FB_ATMEL || COMPILE_TEST
 	select FB_BACKLIGHT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
