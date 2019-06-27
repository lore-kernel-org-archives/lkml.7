Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8378BC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC012086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V7Uh1+8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfF0M6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:58:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42331 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0M6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:58:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190627125804euoutp0139dea79672e8e403c8e01b3ee2b2c9c4~sD5CqrU5X2785327853euoutp01z
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 12:58:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190627125804euoutp0139dea79672e8e403c8e01b3ee2b2c9c4~sD5CqrU5X2785327853euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561640284;
        bh=fgQPkZ+qNSfjVPEvknAlGgFpuJaobLYqy/q5w+0niyc=;
        h=From:Subject:To:Cc:Date:References:From;
        b=V7Uh1+8OCd7DU5GBWm4ds1WVWfRKXD8bzOlWl6WMKe09th6oVWdAyyIZGkJXd0b0R
         WaYKUDGmlZT+ITMf8F6Vq2fC460404vvTWmhAXh5ftSHyPgujR+eiErAvoEwNIpzrf
         7DOcCIWNAzqE6KbXATfghCpuO6dU6I6eEcHiEmzk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190627125804eucas1p179796d899992baa418afa5ccb5c94114~sD5CLmXTJ0314703147eucas1p1f;
        Thu, 27 Jun 2019 12:58:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CB.7B.04377.B5DB41D5; Thu, 27
        Jun 2019 13:58:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190627125803eucas1p1eb6a37f5fa96fd732e41ab1501367de5~sD5BVZ0ad1266112661eucas1p1t;
        Thu, 27 Jun 2019 12:58:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190627125803eusmtrp16e6dbba330708606e66c4b391ccbc292~sD5BUyRWI0648206482eusmtrp1S;
        Thu, 27 Jun 2019 12:58:03 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-ae-5d14bd5b2501
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.73.04140.B5DB41D5; Thu, 27
        Jun 2019 13:58:03 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190627125803eusmtip1017d6b7cd9a96311891678170d0aefdb~sD5BEy9-Z0970609706eusmtip1_;
        Thu, 27 Jun 2019 12:58:03 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: s3c-fb: fix sparse warnings about using
 incorrect types
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jingoo Han <jingoohan1@gmail.com>
Message-ID: <908fc26e-3bfa-c204-6c32-7d814fdcb37b@samsung.com>
Date:   Thu, 27 Jun 2019 14:58:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7rRe0ViDT5eN7e48vU9m8WKLzPZ
        LU70fWC1uLxrDpsDi8fOWXfZPe53H2fy+LxJLoA5issmJTUnsyy1SN8ugStj0sNe9oINPBX3
        T51kbmBcz9XFyMkhIWAiselTC1MXIxeHkMAKRon+b0uZIZwvjBKfN05ng3A+M0psXbSBCaZl
        78ludojEckaJ95eOM0I4bxklFrf/YAepYhOwkpjYvgoowcEhLBAhseKHCkhYRCBBYsX0GYwg
        NrOAqsSu5qVgJbwCdhJ7ZrCAhFmAwi9PXmIGsUWBOu8f28AKYvMKCEqcnPmEBaJVXOLWk/lM
        ELa8xPa3c8CulhD4zCax5dlpVohDXSSOXvvHAmELS7w6voUdwpaROD25hwWiYR2jxN+OF1Dd
        2xkllk/+xwZRZS1x+PhFVpDrmAU0Jdbv0ocIO0o0zj3HBhKWEOCTuPFWEOIIPolJ26YzQ4R5
        JTrahCCq1SQ2LNvABrO2a+dKZgjbQ2LVng7GCYyKs5C8NgvJa7OQvDYL4YYFjCyrGMVTS4tz
        01OLjfJSy/WKE3OLS/PS9ZLzczcxAhPK6X/Hv+xg3PUn6RCjAAejEg+vwk6RWCHWxLLiytxD
        jBIczEoivPlhQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTByc
        Ug2MIZ9ythfKflbk32T1rbbQlfOE81/rKlfzJncfqz1Xl5ueUIpo/ZPe7iL6Zce2GcUGDg8S
        +1Nn/rW6kbjA8XKuj/b7ST+ONrKeWOuldpbZcMWuvOQzJjZfl7+1mNBxUX17xsUL05xWGNy4
        7rdA23L6qU1fLjZ+q4885lV0X++bsEWJTOlzdUkNJZbijERDLeai4kQAiDCosiQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4Xd3ovSKxBisnCltc+fqezWLFl5ns
        Fif6PrBaXN41h82BxWPnrLvsHve7jzN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJcx6WEve8EGnor7p04yNzCu5+pi5OSQEDCR2Huy
        mx3EFhJYyijxbGphFyMHUFxG4vj6MogSYYk/17rYuhi5gEpeM0ocOLyHCSTBJmAlMbF9FSNI
        vbBAhMSKHyogYRGBBImnr+ezgdjMAqoSu5qXgpXwCthJ7JnBAhJmAQq/PHmJGcQWBeo8834F
        WJxXQFDi5MwnLBCt6hJ/5kHUMAuIS9x6Mp8JwpaX2P52DvMERoFZSFpmIWmZhaRlFpKWBYws
        qxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJjYduxn1t2MHa9Cz7EKMDBqMTDq7BTJFaINbGs
        uDL3EKMEB7OSCG9+GFCINyWxsiq1KD++qDQntfgQoynQQxOZpUST84FxmlcSb2hqaG5haWhu
        bG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgVFyySIOtQvPD2ztKVpsVH7oe7TIgkmq
        aVP3ls32XdnsVu7cWBtwfeNf4wC/jzWHncX3WK1UOxnA/+FYxcHUKbdY99nnWL2+vlG+sb8x
        r/a7xYy+Js6CvY+81xzVPtrKorW3ddfOvF28942e/W7itj5+7PLVkEt6XUs2hGeVsShZv/gh
        NTMjZ5YSS3FGoqEWc1FxIgCo9uCVmwIAAA==
X-CMS-MailID: 20190627125803eucas1p1eb6a37f5fa96fd732e41ab1501367de5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190627125803eucas1p1eb6a37f5fa96fd732e41ab1501367de5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627125803eucas1p1eb6a37f5fa96fd732e41ab1501367de5
References: <CGME20190627125803eucas1p1eb6a37f5fa96fd732e41ab1501367de5@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ->screen_buffer instead of ->screen_base to fix sparse warnings.

[ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
  pointer") for details. ]

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/s3c-fb.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: b/drivers/video/fbdev/s3c-fb.c
===================================================================
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1105,14 +1105,14 @@ static int s3c_fb_alloc_memory(struct s3
 
 	dev_dbg(sfb->dev, "want %u bytes for window\n", size);
 
-	fbi->screen_base = dma_alloc_wc(sfb->dev, size, &map_dma, GFP_KERNEL);
-	if (!fbi->screen_base)
+	fbi->screen_buffer = dma_alloc_wc(sfb->dev, size, &map_dma, GFP_KERNEL);
+	if (!fbi->screen_buffer)
 		return -ENOMEM;
 
 	dev_dbg(sfb->dev, "mapped %x to %p\n",
-		(unsigned int)map_dma, fbi->screen_base);
+		(unsigned int)map_dma, fbi->screen_buffer);
 
-	memset(fbi->screen_base, 0x0, size);
+	memset(fbi->screen_buffer, 0x0, size);
 	fbi->fix.smem_start = map_dma;
 
 	return 0;
@@ -1129,9 +1129,9 @@ static void s3c_fb_free_memory(struct s3
 {
 	struct fb_info *fbi = win->fbinfo;
 
-	if (fbi->screen_base)
+	if (fbi->screen_buffer)
 		dma_free_wc(sfb->dev, PAGE_ALIGN(fbi->fix.smem_len),
-		            fbi->screen_base, fbi->fix.smem_start);
+			    fbi->screen_buffer, fbi->fix.smem_start);
 }
 
 /**
