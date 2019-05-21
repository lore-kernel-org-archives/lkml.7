Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403C0C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D300921773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P9dDqqOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfEULvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:51:18 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53242 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfEULvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:51:18 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190521115116euoutp018befcc59e367eecf2157b018dd5b0fdb~gsHJ8tCLo2546225462euoutp01y
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 11:51:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190521115116euoutp018befcc59e367eecf2157b018dd5b0fdb~gsHJ8tCLo2546225462euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558439476;
        bh=McR1GDMAHsgfj9BNJCIvg1qAy7nbsGqAV/WHwwNePas=;
        h=From:Subject:To:Date:References:From;
        b=P9dDqqOlhLaJcQ0kANjPMQrQImBc++mOISs/gPK9mDoVAAroIX2cvdgO1Lz+tRM79
         S/3nRZ8SQg/KSXyLNqCxqAZ3IQ2UOYiNoyY0WARk5DxjfgYWvvuuzaSd6swgpAeWvn
         iUfE6mMq6Ldoi4Fnv4sPCQi975XPKMCgRpHGhXqk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190521115116eucas1p29c97d95ab45a06d53aeadba6413ff9e7~gsHJl2xNL2796627966eucas1p2l;
        Tue, 21 May 2019 11:51:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 05.ED.04298.336E3EC5; Tue, 21
        May 2019 12:51:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190521115115eucas1p28c5743b756e359791a3efcce1e2e16b8~gsHIq_AP_1774117741eucas1p2R;
        Tue, 21 May 2019 11:51:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190521115115eusmtrp1679bc4f202d72af8ce50b39a31da952d~gsHIbUbSc1853818538eusmtrp1F;
        Tue, 21 May 2019 11:51:15 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-9c-5ce3e6331af9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9B.DC.04140.336E3EC5; Tue, 21
        May 2019 12:51:15 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190521115114eusmtip2f83fce1eb1ac9575da3d732ba70f435b~gsHINyeLz2402824028eusmtip2N;
        Tue, 21 May 2019 11:51:14 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] video: fbdev: gbefb: add COMPILE_TEST support
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <8bcfd5b8-347b-89e4-5faf-8569a3d00115@samsung.com>
Date:   Tue, 21 May 2019 13:51:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduznOV3jZ49jDC5ctrK48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApigum5TUnMyy1CJ9uwSujB9t65kKzkpXXH8wjb2Bcb5YFyMH
        h4SAicTfGXxdjJwcQgIrGCXOfUrtYuQCsr8wSsy9/5gdwvnMKNE9cQMzTMPNJi2I+HJGic0v
        HzJCOG8ZJWYuu8EOMopNwEpiYvsqRhBbWMBR4urN+ywgtohAgsSK6TPA4rwCdhJbL20Ai7MI
        qEp8WPiZFcQWFYiQuH9sAytEjaDEyZlPwGqYBcQlbj2ZzwRhy0tsfzuHGWSxhMBtNolvu5vB
        hkoIuEhMn/CPFcIWlnh1fAs7hC0jcXpyDwtEwzpGib8dL6C6tzNKLJ/8jw2iylri8PGLrCB/
        MgtoSqzfpQ8RdpQ49m41O8T7fBI33gpCHMEnMWnbdGio8Ep0tAlBVKtJbFi2gQ1mbdfOlcwQ
        tofEi/PbGCFBHSsx+VcP6wRGhVlI3pyF5M1ZSN6chXDPAkaWVYziqaXFuempxYZ5qeV6xYm5
        xaV56XrJ+bmbGIGp4/S/4592MH69lHSIUYCDUYmH1+Lh4xgh1sSy4srcQ4wSHMxKIrynTz2K
        EeJNSaysSi3Kjy8qzUktPsQozcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cDIZiQkmPax
        a1tNnUn3nXkCjzarThNMjY2ZHd144OWkC0pl0QEvitd6a6+Yd+DunGaeu2ldolc3u/Xqzgu/
        ceqR9aEmbv4y11VHPlTELrHPuLjLojg90msT/6opRidU1fs9zSfL/J/z6LeisXbSzGnTutYs
        8Txy3O6/6d8M1oozLwSP5pdcLYlTYinOSDTUYi4qTgQAULBMDxkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xe7rGzx7HGEy7yGlx5et7NosTfR9Y
        LS7vmsPmwOxxv/s4k8fnTXIBTFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkam
        Svp2NimpOZllqUX6dgl6GT/a1jMVnJWuuP5gGnsD43yxLkYODgkBE4mbTVpdjFwcQgJLGSU+
        X9nEDBGXkTi+vqyLkRPIFJb4c62LDaLmNaPEwu0LmEASbAJWEhPbVzGC2MICjhJXb95nAbFF
        BBIknr6ezwZi8wrYSWy9tAEsziKgKvFh4WdWEFtUIELizPsVLBA1ghInZz4Bs5kF1CX+zLvE
        DGGLS9x6Mp8JwpaX2P52DvMERv5ZSFpmIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz
        0vWS83M3MQJDfNuxn1t2MHa9Cz7EKMDBqMTD++De4xgh1sSy4srcQ4wSHMxKIrynTz2KEeJN
        SaysSi3Kjy8qzUktPsRoCvTQRGYp0eR8YPzllcQbmhqaW1gamhubG5tZKInzdggcjBESSE8s
        Sc1OTS1ILYLpY+LglGpg3GXc9HLnMp7ONZOflm/U27fxhWwdx+HT7/fYyqddC37aKzr9Ulhn
        jQqDOHfypa2+X7a97rv91312mUK0kl8a61Gfq6GvCk0vvZRqNneyZ3i96LKrUuPDxSEMW5f9
        18iS1EpmY33cd2B1Z+CXC1Wr7nctNwzdZ7Cd2et72P5rguW2PebbhZ+oKrEUZyQaajEXFScC
        AMvD2j6HAgAA
X-CMS-MailID: 20190521115115eucas1p28c5743b756e359791a3efcce1e2e16b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190521115115eucas1p28c5743b756e359791a3efcce1e2e16b8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521115115eucas1p28c5743b756e359791a3efcce1e2e16b8
References: <CGME20190521115115eucas1p28c5743b756e359791a3efcce1e2e16b8@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to gbefb driver for better compile
testing coverage.

While at it convert bogus udelay() calls to mdelay() (needed to
build driver on ARM) and remove dead x86 specific code.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- add missing HAS_IOMEM dependency
- fix build on ARM by converting bogus udelay() calls to mdelay()

 drivers/video/fbdev/Kconfig |    3 ++-
 drivers/video/fbdev/gbefb.c |   19 +++++++------------
 2 files changed, 9 insertions(+), 13 deletions(-)

Index: b/drivers/video/fbdev/Kconfig
===================================================================
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -670,7 +670,8 @@ config FB_HGA
 
 config FB_GBE
 	bool "SGI Graphics Backend frame buffer support"
-	depends on (FB = y) && SGI_IP32
+	depends on (FB = y) && HAS_IOMEM
+	depends on SGI_IP32 || COMPILE_TEST
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
Index: b/drivers/video/fbdev/gbefb.c
===================================================================
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
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
@@ -279,7 +273,7 @@ static void gbe_turn_off(void)
 	val = 0;
 	SET_GBE_FIELD(VT_XY, FREEZE, val, 1);
 	gbe->vt_xy = val;
-	udelay(10000);
+	mdelay(10);
 	for (i = 0; i < 10000; i++) {
 		val = gbe->vt_xy;
 		if (GET_GBE_FIELD(VT_XY, FREEZE, val) != 1)
@@ -294,7 +288,7 @@ static void gbe_turn_off(void)
 	val = gbe->dotclock;
 	SET_GBE_FIELD(DOTCLK, RUN, val, 0);
 	gbe->dotclock = val;
-	udelay(10000);
+	mdelay(10);
 	for (i = 0; i < 10000; i++) {
 		val = gbe->dotclock;
 		if (GET_GBE_FIELD(DOTCLK, RUN, val))
@@ -331,7 +325,7 @@ static void gbe_turn_on(void)
 	val = gbe->dotclock;
 	SET_GBE_FIELD(DOTCLK, RUN, val, 1);
 	gbe->dotclock = val;
-	udelay(10000);
+	mdelay(10);
 	for (i = 0; i < 10000; i++) {
 		val = gbe->dotclock;
 		if (GET_GBE_FIELD(DOTCLK, RUN, val) != 1)
@@ -346,7 +340,7 @@ static void gbe_turn_on(void)
 	val = 0;
 	SET_GBE_FIELD(VT_XY, FREEZE, val, 0);
 	gbe->vt_xy = val;
-	udelay(10000);
+	mdelay(10);
 	for (i = 0; i < 10000; i++) {
 		val = gbe->vt_xy;
 		if (GET_GBE_FIELD(VT_XY, FREEZE, val))
@@ -547,7 +541,7 @@ static void gbe_set_timing_info(struct g
 	SET_GBE_FIELD(DOTCLK, P, val, timing->pll_p);
 	SET_GBE_FIELD(DOTCLK, RUN, val, 0);	/* do not start yet */
 	gbe->dotclock = val;
-	udelay(10000);
+	mdelay(10);
 
 	/* setup pixel counter */
 	val = 0;
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
