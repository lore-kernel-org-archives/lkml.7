Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40E2C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA1920868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Kq7OToEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfEVKQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:16:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36109 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfEVKQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:16:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190522101652euoutp0228dbc674bf41bf2b3309d32f74ef7469~g_eA0gWo20096400964euoutp02x
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 10:16:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190522101652euoutp0228dbc674bf41bf2b3309d32f74ef7469~g_eA0gWo20096400964euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558520212;
        bh=oCncskAnrdgh5DuLw8OQaOlD6EWhWD31JIykVZ3fx9E=;
        h=From:Subject:To:Date:References:From;
        b=Kq7OToEEVqtGrhgTN/dOAPq93aVnWmOhDolsYbnEe22KlW/oiZ1BPwSXDB7IzUGVL
         60cjNlnYvvCb/IEuhI6k5H0cetBlx1Q6S2pfkh6OOPVF7zRYqO4gL4c8HcjlMIQ+Av
         hJkhbOVQ7vZq9QNiXlqnH6HaF6v0TJgtXx+Y9oRc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190522101652eucas1p24116cc89a6cbbb09eb4362bffea8afc1~g_eAiODEw2076820768eucas1p2B;
        Wed, 22 May 2019 10:16:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D1.7A.04325.39125EC5; Wed, 22
        May 2019 11:16:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190522101651eucas1p18b5ce16f065cc83125b4bd97e141bdcd~g_d-nN1WP0802608026eucas1p1c;
        Wed, 22 May 2019 10:16:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190522101650eusmtrp1544f819395d5213933e9dcf3cb0a6557~g_d-ZNwY61575615756eusmtrp1j;
        Wed, 22 May 2019 10:16:50 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-11-5ce52193cb80
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 15.44.04146.29125EC5; Wed, 22
        May 2019 11:16:50 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190522101650eusmtip1538beca633b2f218a1f248f6afcaaa5c~g_d-Kx9AT1737217372eusmtip1I;
        Wed, 22 May 2019 10:16:50 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/2] video: fbdev: pvr2fb: add COMPILE_TEST support
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <2d2b283e-a5c5-3c94-423c-8cb085492921@samsung.com>
Date:   Wed, 22 May 2019 12:16:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduznOd3Jik9jDJ52Gllc+fqezeJE3wdW
        i8u75rA5MHvc7z7O5PF5k1wAUxSXTUpqTmZZapG+XQJXRvtPr4KXshWL9n5lbWC8INHFyMkh
        IWAise/jeyYQW0hgBaPE331OXYxcQPYXRonmHZNZIZzPjBKf/09kh+nY8aiNGSKxnFFi+Z59
        UFVvGSWefp0DNotNwEpiYvsqRhBbWMBZ4t/XLmYQW0QgQWLF9BlgcV4BO4mNS2aDTWURUJX4
        s3EHWK+oQITE/WMbWCFqBCVOznzCAmIzC4hL3HoynwnClpfY/nYO2BUSArfZJF6cfc8GcZ6L
        xIHWa0wQtrDEq+NboM6WkTg9uYcFomEd0KMdL6C6twP9MPkfVLe1xOHjF4FWcwCt0JRYv0sf
        Iuwo0b9gEjtIWEKAT+LGW0GII/gkJm2bzgwR5pXoaBOCqFaT2LBsAxvM2q6dK5khbA+JE5N3
        sEPCOlbiz5P9rBMYFWYheXMWkjdnIXlzFsI9CxhZVjGKp5YW56anFhvnpZbrFSfmFpfmpesl
        5+duYgQmj9P/jn/dwbjvT9IhRgEORiUeXouHj2OEWBPLiitzDzFKcDArifCePvUoRog3JbGy
        KrUoP76oNCe1+BCjNAeLkjhvNcODaCGB9MSS1OzU1ILUIpgsEwenVAPjhvzMO/fu3XqWt47L
        tPeOF4vb5Np9qd4uM1lf9RcdY9B5mdqxZsa2l81bLh7hvHVIX9VTmEV1Z0hD+rHthy9n1ud4
        bOeo117ZuFfu/prs3x1vy6US9dvcb5cHvlvKo3bvSu6ORG6uTZ/6p/+dlbxAduqnmMULbJRW
        nLpxPIjtZKoiQ9OF3gevlFiKMxINtZiLihMBQO+FIxoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xu7qTFJ/GGFw7ZGxx5et7NosTfR9Y
        LS7vmsPmwOxxv/s4k8fnTXIBTFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkam
        Svp2NimpOZllqUX6dgl6Ge0/vQpeylYs2vuVtYHxgkQXIyeHhICJxI5HbcwgtpDAUkaJ44el
        uhg5gOIyEsfXl0GUCEv8udbF1sXIBVTymlHi4MINjCAJNgEriYntq8BsYQFniX9fu8DmiAgk
        SDx9PZ8NxOYVsJPYuGQ2O4jNIqAq8WfjDiYQW1QgQuLM+xUsEDWCEidnPgGzmQXUJf7Mu8QM
        YYtL3HoynwnClpfY/nYO8wRG/llIWmYhaZmFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS
        9ZLzczcxAgN827Gfm3cwXtoYfIhRgINRiYf3wb3HMUKsiWXFlbmHGCU4mJVEeE+fehQjxJuS
        WFmVWpQfX1Sak1p8iNEU6KGJzFKiyfnA6MsriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliS
        mp2aWpBaBNPHxMEp1cA44cHJ+8fNeB0fMjyb0Wb06MMevkNCW9us1h1Usj/jqHMn+0qFstVB
        edepT63Em/4yGkU63f82x8Ki7OKVc4WfJ3nNVI8qqJ7X3eBycNnH6M9HHQzUp2k7K2aVLLbk
        reNb/lOd+e2777tmL1w0/dOmu+fSFnc/yZN4bSTS29Rubrz+pifrQ479SizFGYmGWsxFxYkA
        OGcmnYYCAAA=
X-CMS-MailID: 20190522101651eucas1p18b5ce16f065cc83125b4bd97e141bdcd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190522101651eucas1p18b5ce16f065cc83125b4bd97e141bdcd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190522101651eucas1p18b5ce16f065cc83125b4bd97e141bdcd
References: <CGME20190522101651eucas1p18b5ce16f065cc83125b4bd97e141bdcd@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to pvr2fb driver for better compile
testing coverage.

While at it mark pvr2fb_interrupt() and pvr2fb_common_init()
with __maybe_unused tag (to silence build warnings when
!SH_DREAMCAST), also convert mmio_base in struct pvr2fb_par to
'void __iomem *' from 'unsigned long' (needed to silence
build warnings on ARM).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig  |    3 ++-
 drivers/video/fbdev/pvr2fb.c |   26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 14 deletions(-)

Index: b/drivers/video/fbdev/Kconfig
===================================================================
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -807,7 +807,8 @@ config FB_XVR1000
 
 config FB_PVR2
 	tristate "NEC PowerVR 2 display support"
-	depends on FB && SH_DREAMCAST
+	depends on FB && HAS_IOMEM
+	depends on SH_DREAMCAST || COMPILE_TEST
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
Index: b/drivers/video/fbdev/pvr2fb.c
===================================================================
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -139,7 +139,7 @@ static struct pvr2fb_par {
 	unsigned char is_doublescan;	/* Are scanlines output twice? (doublescan) */
 	unsigned char is_lowres;	/* Is horizontal pixel-doubling enabled? */
 
-	unsigned long mmio_base;	/* MMIO base */
+	void __iomem *mmio_base;	/* MMIO base */
 	u32 palette[16];
 } *currentpar;
 
@@ -325,9 +325,9 @@ static int pvr2fb_setcolreg(unsigned int
  * anything if the cable type has been overidden (via "cable:XX").
  */
 
-#define PCTRA 0xff80002c
-#define PDTRA 0xff800030
-#define VOUTC 0xa0702c00
+#define PCTRA ((void __iomem *)0xff80002c)
+#define PDTRA ((void __iomem *)0xff800030)
+#define VOUTC ((void __iomem *)0xa0702c00)
 
 static int pvr2_init_cable(void)
 {
@@ -619,7 +619,7 @@ static void pvr2_do_blank(void)
 	is_blanked = do_blank > 0 ? do_blank : 0;
 }
 
-static irqreturn_t pvr2fb_interrupt(int irq, void *dev_id)
+static irqreturn_t __maybe_unused pvr2fb_interrupt(int irq, void *dev_id)
 {
 	struct fb_info *info = dev_id;
 
@@ -757,7 +757,7 @@ static int pvr2_get_param(const struct p
  * in for flexibility anyways. Who knows, maybe someone has tv-out on a
  * PCI-based version of these things ;-)
  */
-static int pvr2fb_common_init(void)
+static int __maybe_unused pvr2fb_common_init(void)
 {
 	struct pvr2fb_par *par = currentpar;
 	unsigned long modememused, rev;
@@ -770,8 +770,8 @@ static int pvr2fb_common_init(void)
 		goto out_err;
 	}
 
-	par->mmio_base = (unsigned long)ioremap_nocache(pvr2_fix.mmio_start,
-							pvr2_fix.mmio_len);
+	par->mmio_base = ioremap_nocache(pvr2_fix.mmio_start,
+					 pvr2_fix.mmio_len);
 	if (!par->mmio_base) {
 		printk(KERN_ERR "pvr2fb: Failed to remap mmio space\n");
 		goto out_err;
@@ -838,7 +838,7 @@ out_err:
 	if (fb_info->screen_base)
 		iounmap(fb_info->screen_base);
 	if (par->mmio_base)
-		iounmap((void *)par->mmio_base);
+		iounmap(par->mmio_base);
 
 	return -ENXIO;
 }
@@ -905,8 +905,8 @@ static void __exit pvr2fb_dc_exit(void)
 		fb_info->screen_base = NULL;
 	}
 	if (currentpar->mmio_base) {
-		iounmap((void *)currentpar->mmio_base);
-		currentpar->mmio_base = 0;
+		iounmap(currentpar->mmio_base);
+		currentpar->mmio_base = NULL;
 	}
 
 	free_irq(HW_EVENT_VSYNC, fb_info);
@@ -955,8 +955,8 @@ static void pvr2fb_pci_remove(struct pci
 		fb_info->screen_base = NULL;
 	}
 	if (currentpar->mmio_base) {
-		iounmap((void *)currentpar->mmio_base);
-		currentpar->mmio_base = 0;
+		iounmap(currentpar->mmio_base);
+		currentpar->mmio_base = NULL;
 	}
 
 	pci_release_regions(pdev);
