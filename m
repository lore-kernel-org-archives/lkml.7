Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F62C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1AB25193
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HTnrnE85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfE3MaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:30:20 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57145 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfE3MaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:30:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190530123017euoutp028ce34a08cfef189aa26adcbf778a5474~jdcygxhGV1413514135euoutp02M
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 12:30:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190530123017euoutp028ce34a08cfef189aa26adcbf778a5474~jdcygxhGV1413514135euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559219417;
        bh=rRfb4nIQIlulai7VhUp6tUgeds7+T13bxgzJ6lGHQr0=;
        h=From:Subject:To:Cc:Date:References:From;
        b=HTnrnE85RKKW4euGLPzcyYUYxL/R+LhA6OJiSSo1VrdcnvSUHr2qAy8nsdo43L+zP
         BnVorvltXUY0QdH0KIhkqh61tS82mHxtNAp5hCQoeWwZ6PgB1iOcP9UWab9jyC6Kt3
         hGgK3F0cIpGhX5mswgfuE9plJUAXGbLRdofQ9M3M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190530123017eucas1p2c5af602281ac3b3f30663bd705a5986f~jdcx3d3852345123451eucas1p2P;
        Thu, 30 May 2019 12:30:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 19.2F.04325.8DCCFEC5; Thu, 30
        May 2019 13:30:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190530123016eucas1p2e18747b8ac1d156657232eab52876a61~jdcxGWxd90451604516eucas1p2a;
        Thu, 30 May 2019 12:30:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190530123015eusmtrp195d81c13e4784a1c2aef07b057426f84~jdcw22ISC1402014020eusmtrp17;
        Thu, 30 May 2019 12:30:15 +0000 (GMT)
X-AuditID: cbfec7f5-fbbf09c0000010e5-4b-5cefccd852ad
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B7.88.04146.7DCCFEC5; Thu, 30
        May 2019 13:30:15 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190530123015eusmtip2b655394a251cc6ef2a9636882a39000a~jdcwYkvkm2162821628eusmtip2H;
        Thu, 30 May 2019 12:30:15 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3] video: fbdev: atmel_lcdfb: add COMPILE_TEST support
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <69cd6b8b-1fd1-86fa-2070-99d0ce15a868@samsung.com>
Date:   Thu, 30 May 2019 14:30:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djP87o3zryPMehaqmvR/m4Zu8WVr+/Z
        LDY9vsZqcaLvA6vF5V1z2CxerL3OarF980JmB3aPeWuqPe53H2fy2Lyk3uPOj6WMHp83yQWw
        RnHZpKTmZJalFunbJXBlHP2xmK3gFn/F/c5JzA2M83m7GDk5JARMJO7+bmfpYuTiEBJYwSjR
        /Og/E4TzhVHi9srprBDOZ0aJNe+72WBaJlzrZYNILGeUOPXtB1TVW0aJV5OnsoJUsQlYSUxs
        X8UIYgsLuEu8bfkMNJeDQ0RAX+JPlyJIPbPAJ0aJ9llrwWp4Bewkfp1bCraBRUBVonHnPxYQ
        W1QgQuL+sQ2sEDWCEidnPgGLMwuIS9x6Mp8JwpaX2P52DjPIUAmB6ewSD1q2s0Kc6iKx7cVa
        JghbWOLV8S3sELaMxOnJPSwQDesYJf52vIDq3s4osXzyP6hHrSUOH7/ICnI2s4CmxPpd+hBh
        R4kfXR8ZQcISAnwSN94KQhzBJzFp23RmiDCvREebEES1msSGZRvYYNZ27VzJDGF7SLzY+YZ1
        AqPiLCSvzULy2iwkr81CuGEBI8sqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwBR0+t/x
        rzsY9/1JOsQowMGoxMMrcPB9jBBrYllxZe4hRgkOZiUR3p/L38UI8aYkVlalFuXHF5XmpBYf
        YpTmYFES561meBAtJJCeWJKanZpakFoEk2Xi4JRqYEzblCu+7eCjLJPZUgu7n7Ht8m9bPtFG
        uWJeBe/Bsxp+bXf39z6/o1F86JfY1/ZP3rZ+ffq+6de3NO9TD9EW2fGOc3n3j35LkVMS01xi
        qzK/Mz7b7VEx460jz9yj6ivcXi9XFrJfp+g8z2HqmfgqY/dcZwXVLT88jsTMSGs5I/pu6veI
        Sx7JD5RYijMSDbWYi4oTAbcRiMo9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7rXz7yPMZi339ii/d0ydosrX9+z
        WWx6fI3V4kTfB1aLy7vmsFm8WHud1WL75oXMDuwe89ZUe9zvPs7ksXlJvcedH0sZPT5vkgtg
        jdKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOPpj
        MVvBLf6K+52TmBsY5/N2MXJySAiYSEy41svWxcjFISSwlFFiZ+Me9i5GDqCEjMTx9WUQNcIS
        f651QdW8ZpTYun8DK0iCTcBKYmL7KkYQW1jAXeJty2cmkF4RAX2JP12KIPXMAp8YJX49bwer
        4RWwk/h1bikbiM0ioCrRuPMfC4gtKhAhceb9ChaIGkGJkzOfgNnMAuoSf+ZdYoawxSVuPZnP
        BGHLS2x/O4d5AqPALCQts5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiB
        8bPt2M/NOxgvbQw+xCjAwajEwytw8H2MEGtiWXFl7iFGCQ5mJRHen8vfxQjxpiRWVqUW5ccX
        leakFh9iNAV6aCKzlGhyPjC280riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB
        9DFxcEo1MOavrM9Tz6twK9dhe+n6QnzP5X+PXUoeHVTp5mMOUeL5+H5Ni4RlymG22nkKveFX
        eZX/t0tHVd8SO7lZ2+XKyVVPv9ZYm/zce93pLsMV501X153fvDMtXfRNdMbribNUjZQutvBM
        m/j2iEZMCAvT9Gc1ZRJn2GKPaBXnfPd/9HX2UgVv1cyWJUosxRmJhlrMRcWJAIrKAuG1AgAA
X-CMS-MailID: 20190530123016eucas1p2e18747b8ac1d156657232eab52876a61
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190530123016eucas1p2e18747b8ac1d156657232eab52876a61
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190530123016eucas1p2e18747b8ac1d156657232eab52876a61
References: <CGME20190530123016eucas1p2e18747b8ac1d156657232eab52876a61@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to atmel_lcdfb driver for better compile
testing coverage.

While at it fix improper use of UL (to silence build warnings on
x86_64).

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v3: fix build warnings on x86_64

v2: add missing HAVE_CLK && HAS IOMEM dependencies

 drivers/video/fbdev/Kconfig       |    3 ++-
 drivers/video/fbdev/atmel_lcdfb.c |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

Index: b/drivers/video/fbdev/Kconfig
===================================================================
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -855,7 +855,8 @@ config FB_S1D13XXX
 
 config FB_ATMEL
 	tristate "AT91 LCD Controller support"
-	depends on FB && OF && HAVE_FB_ATMEL
+	depends on FB && OF && HAVE_CLK && HAS_IOMEM
+	depends on HAVE_FB_ATMEL || COMPILE_TEST
 	select FB_BACKLIGHT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
Index: b/drivers/video/fbdev/atmel_lcdfb.c
===================================================================
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -673,7 +673,7 @@ static int atmel_lcdfb_set_par(struct fb
 	lcdc_writel(sinfo, ATMEL_LCDC_MVAL, 0);
 
 	/* Disable all interrupts */
-	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0UL);
+	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0U);
 	/* Enable FIFO & DMA errors */
 	lcdc_writel(sinfo, ATMEL_LCDC_IER, ATMEL_LCDC_UFLWI | ATMEL_LCDC_OWRI | ATMEL_LCDC_MERI);
 
@@ -1291,7 +1291,7 @@ static int atmel_lcdfb_suspend(struct pl
 	 * We don't want to handle interrupts while the clock is
 	 * stopped. It may take forever.
 	 */
-	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0UL);
+	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0U);
 
 	sinfo->saved_lcdcon = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_CTR);
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, 0);
