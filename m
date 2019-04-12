Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9590C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B9A20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jXWi15g7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfDLLx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:53:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51144 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfDLLxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:53:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190412115352euoutp0259cd4af4003ecbb0984d33d3458ccb7d~Ut-SrysjS0074600746euoutp02S
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 11:53:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190412115352euoutp0259cd4af4003ecbb0984d33d3458ccb7d~Ut-SrysjS0074600746euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555070032;
        bh=XQi+n7chrXYCoDL4kmcMW7YdI864PqL/geuUawA9zTw=;
        h=To:From:Subject:Date:References:From;
        b=jXWi15g7onpJarqFLnbCR9aLuC8LfTZ7qlk+y4NOJKPdnucXfimB6R8MGpWCkwg0E
         k+2sh3jXbntNjRySu+11tkBwoF+GW0gN5rX4fdUCR8gQLp6Ap6l/mp0/C7wSh4B9aq
         hRL7zqngwdJ+mEWAkOHUsyYmF9KeVOyTEcTNONVk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190412115352eucas1p1baed94fca055142609f46ba9915a52d8~Ut-SYfwOa1606816068eucas1p1W;
        Fri, 12 Apr 2019 11:53:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D3.96.04298.05C70BC5; Fri, 12
        Apr 2019 12:53:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190412115351eucas1p1dc215edd8d8c3d2dda99663925939290~Ut-Rra0jL0376903769eucas1p1J;
        Fri, 12 Apr 2019 11:53:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190412115351eusmtrp11d6cb1a3b70f4e46cadaf9d332f4d4a2~Ut-RdgYx02074820748eusmtrp1U;
        Fri, 12 Apr 2019 11:53:51 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-aa-5cb07c50a44d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.1F.04140.F4C70BC5; Fri, 12
        Apr 2019 12:53:51 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190412115351eusmtip2cafcdb72f292314a51a471ba6e6b19e6~Ut-RRjDhT1136411364eusmtip2k;
        Fri, 12 Apr 2019 11:53:51 +0000 (GMT)
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: gbefb: add COMPILE_TEST support
Message-ID: <daeed9ce-710b-cf70-88b5-8a493a082211@samsung.com>
Date:   Fri, 12 Apr 2019 13:53:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djPc7oBNRtiDB7/4LK48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApigum5TUnMyy1CJ9uwSujJOXJrMXHBWo+LZ0OmMD4yPeLkZO
        DgkBE4nGzetZuhi5OIQEVjBKLG6fxgbhfGGUmNbXCpX5zCix48pnNpiWJdMWMUIklgMlTq5m
        gnDeMkqs+HmXGaRKRCBBYsX0GYwgNpuAlcTE9lVgtrCAncT8e+0sIDYvkL1jRw+YzSKgKnFs
        31OgGg4OUYEIif4z6hAlghInZz4BK2EWkJfY/nYOM8guCYEjbBJv1s5ihrjIReLMvK3sELaw
        xKvjW6BsGYnTk3tYIBrWMUr87XgB1b2dUWL55H9Q/1hLHD5+kRVkM7OApsT6XfoQYUeJjYve
        soOEJQT4JG68FYQ4gk9i0rbpzBBhXomONiGIajWJDcs2sMGs7dq5Euo0D4mF/1vAXhcSiJWY
        92oO8wRG+VlIXpuF5LVZCDcsYGRexSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZgOTv87
        /mkH49dLSYcYBTgYlXh4NzivjxFiTSwrrsw9xCjBwawkwhvCAhTiTUmsrEotyo8vKs1JLT7E
        KM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXAyPXbr5/98jK+jldvnu9jDJt5Pfxf2Y+r
        stfuX/JKUlOvu/V89rHpJt+ctTkzjtSr/e5dMYNpV/qkxiq/+kt/xa1ca7tOv53wLHK9wXfF
        ehmOtbznbSJ0nvkxGs/9fzNeOmupzozCB+3GR7edmf3p3/ywO/NZWfakR2/JYrgY/WzDxAfZ
        nL90LiqxFGckGmoxFxUnAgAIdHbRAwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsVy+t/xe7r+NRtiDF6ckbO48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNT
        JX07m5TUnMyy1CJ9uwS9jJOXJrMXHBWo+LZ0OmMD4yPeLkZODgkBE4kl0xYxdjFycQgJLGWU
        uH3hLVMXIwdQQkbi+PoyiBphiT/XuthAbCGB14wSra+zQGwRgQSJp6/ng8XZBKwkJravYgSx
        hQXsJObfa2cBsXmB7B07esBsFgFViWP7noLViApESNx62AFVIyhxcuYTMJtZQF3iz7xLzBC2
        vMT2t3OYJzDyzUJSNgtJ2SwkZQsYmVcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEhuy2Yz+3
        7GDsehd8iFGAg1GJhzfAan2MEGtiWXFl7iFGCQ5mJRHeEBagEG9KYmVValF+fFFpTmrxIUZT
        oMMnMkuJJucD4ymvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwenVAOj
        S8x6zXCPHV4qTgLq6wyfO9ft+8z3aseP79ZvDwpZ77p8ov700TWPshbfEPzIa75LMKn1iO2U
        N8mTeYI29E11PMAjmjclpezd3bjpcwVPrw0Si7H6kea/wXDFr5839Pi1Ztt9iKxh0uG+ZfRX
        zmRX2SV+xX53p8nbXzVx6e8U3vnSWjPif8RpJZbijERDLeai4kQAYXh+2W8CAAA=
X-CMS-MailID: 20190412115351eucas1p1dc215edd8d8c3d2dda99663925939290
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190412115351eucas1p1dc215edd8d8c3d2dda99663925939290
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190412115351eucas1p1dc215edd8d8c3d2dda99663925939290
References: <CGME20190412115351eucas1p1dc215edd8d8c3d2dda99663925939290@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to gbefb driver for better compile
testing coverage.

While at it remove dead x86 specific code.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig |    2 +-
 drivers/video/fbdev/gbefb.c |    9 ++-------
 2 files changed, 3 insertions(+), 8 deletions(-)

Index: b/drivers/video/fbdev/Kconfig
===================================================================
--- a/drivers/video/fbdev/Kconfig	2019-04-12 13:34:54.000000000 +0200
+++ b/drivers/video/fbdev/Kconfig	2019-04-12 13:40:48.246274115 +0200
@@ -673,7 +673,7 @@ config FB_HGA
 
 config FB_GBE
 	bool "SGI Graphics Backend frame buffer support"
-	depends on (FB = y) && SGI_IP32
+	depends on (FB = y) && (SGI_IP32 || COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
Index: b/drivers/video/fbdev/gbefb.c
===================================================================
--- a/drivers/video/fbdev/gbefb.c	2019-04-12 11:39:45.266091209 +0200
+++ b/drivers/video/fbdev/gbefb.c	2019-04-12 13:48:00.142284992 +0200
@@ -39,9 +39,7 @@ struct gbefb_par {
 	int valid;
 };
 
-#ifdef CONFIG_SGI_IP32
 #define GBE_BASE	0x16000000 /* SGI O2 */
-#endif
 
 /* macro for fastest write-though access to the framebuffer */
 #ifdef CONFIG_MIPS
@@ -51,10 +49,6 @@ struct gbefb_par {
 #define pgprot_fb(_prot) (((_prot) & (~_CACHE_MASK)) | _CACHE_CACHABLE_NO_WA)
 #endif
 #endif
-#ifdef CONFIG_X86
-#define pgprot_fb(_prot) (((_prot) & ~_PAGE_CACHE_MASK) |	\
-			  cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS))
-#endif
 
 /*
  *  RAM we reserve for the frame buffer. This defines the maximum screen
@@ -1018,9 +1012,10 @@ static int gbefb_mmap(struct fb_info *in
 
 	/* remap using the fastest write-through mode on architecture */
 	/* try not polluting the cache when possible */
+#ifdef CONFIG_MIPS
 	pgprot_val(vma->vm_page_prot) =
 		pgprot_fb(pgprot_val(vma->vm_page_prot));
-
+#endif
 	/* VM_IO | VM_DONTEXPAND | VM_DONTDUMP are set by remap_pfn_range() */
 
 	/* look for the starting tile */
