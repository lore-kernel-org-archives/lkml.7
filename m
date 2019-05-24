Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B42C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77C520673
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EwweVXR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391302AbfEXLz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:55:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53395 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391080AbfEXLz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:55:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190524115554euoutp01e5271d4db9734978a5321953c56101d4~hnHDj1-ky3240832408euoutp01w
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 11:55:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190524115554euoutp01e5271d4db9734978a5321953c56101d4~hnHDj1-ky3240832408euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558698954;
        bh=ABqkO9dr5QlBiYgkJtRqhKZ1Tq/7+M7c1WoLkY6X0TA=;
        h=From:Subject:To:Date:References:From;
        b=EwweVXR/iraj7fHUZ/Aq+2ldY0PRx9OTDsPbNrEKFvv/2Kb4bMVsnY5ejFxNyHlxl
         50h+sulwUeXrSZdQABX8kS4iD5Fp0UfAvnXj3CyArYRlX0jrMc6PpeUFioFABkjSB3
         YB3eWVct/dpMj+BKHhZ+v97hzBIgyc1mbTKBEeEU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190524115554eucas1p12a4c4b881103feb9d0a9f51facecaeaa~hnHDPn_jL1979619796eucas1p1b;
        Fri, 24 May 2019 11:55:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 02.F6.04377.ACBD7EC5; Fri, 24
        May 2019 12:55:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190524115553eucas1p2f900901e65f06ec33e478d433f96e34f~hnHCSHdSq0669206692eucas1p2D;
        Fri, 24 May 2019 11:55:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190524115553eusmtrp23fa8bd166566a05d1dfba220843011ae~hnHCEHcGg2266222662eusmtrp2U;
        Fri, 24 May 2019 11:55:53 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-a8-5ce7dbca658b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C2.D5.04146.9CBD7EC5; Fri, 24
        May 2019 12:55:53 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190524115552eusmtip1478386dc08562181a9dfba06b617e1b4~hnHB3sWDl2814828148eusmtip1C;
        Fri, 24 May 2019 11:55:52 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 2/2] video: fbdev: pvr2fb: add COMPILE_TEST support
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <a8ba0a36-b9b3-4039-5f49-ddc1d900a9d1@samsung.com>
Date:   Fri, 24 May 2019 13:55:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduznOd1Tt5/HGPz7xW5x5et7NosTfR9Y
        LS7vmsPmwOxxv/s4k8fnTXIBTFFcNimpOZllqUX6dglcGfN2mRW81K34t3oScwNjm2oXIyeH
        hICJRO+JvcxdjFwcQgIrGCX2/ellhXC+MEoc/PkdKvOZUWLFzpfMMC2rvqxjgUgsZ5R43boY
        quUto8SZzlXsIFVsAlYSE9tXMYLYwgJuEqfm7AGLiwgkSKyYPgMszitgJzH3yzGwOIuAqsSx
        459ZQGxRgQiJ+8c2sELUCEqcnPkELM4sIC5x68l8JghbXmL72zlg50kI3GaT+DhzCiPEeS4S
        e39PYIWwhSVeHd/CDmHLSPzfCdIM0rCOUeJvxwuo7u2MEssn/2ODqLKWOHz8IlA3B9AKTYn1
        u/Qhwo4S0468YQYJSwjwSdx4KwhxBJ/EpG3TocK8Eh1tQhDVahIblm1gg1nbtXMlNOQ8JLqe
        3waLCwnESux+95V1AqPCLCRvzkLy5iwkb85CuGcBI8sqRvHU0uLc9NRio7zUcr3ixNzi0rx0
        veT83E2MwPRx+t/xLzsYd/1JOsQowMGoxMObcPl5jBBrYllxZe4hRgkOZiUR3tj9z2KEeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1MGq+FZvqPfd5nHPP
        eqa28wwr9xQ3e2dy3SvL+5ygdDuM7+WGqf8si/5Ie3W/etrZtftbfOHC6jylbW6LyypuR0g1
        fzbP0Fzvy98esOXIo86vFmePfU8RjGma+ONR4Sf+PRbrt7ssOmvT9vdI5O3yU3JlNe1FwQ8Y
        Vvp1xjXm/vpl+/voWbHMRUosxRmJhlrMRcWJAGpuuiobAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xu7onbz+PMXh+j9Xiytf3bBYn+j6w
        WlzeNYfNgdnjfvdxJo/Pm+QCmKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxM
        lfTtbFJSczLLUov07RL0MubtMit4qVvxb/Uk5gbGNtUuRk4OCQETiVVf1rF0MXJxCAksZZTY
        dqWDqYuRAyghI3F8fRlEjbDEn2tdbBA1rxkl3n25xASSYBOwkpjYvooRxBYWcJM4NWcPO4gt
        IpAg8fT1fDYQm1fATmLul2NgcRYBVYljxz+zgNiiAhESZ96vYIGoEZQ4OfMJmM0soC7xZ94l
        ZghbXOLWk/lMELa8xPa3c5gnMPLPQtIyC0nLLCQts5C0LGBkWcUoklpanJueW2yoV5yYW1ya
        l66XnJ+7iREY4tuO/dy8g/HSxuBDjAIcjEo8vAmXn8cIsSaWFVfmHmKU4GBWEuGN3f8sRog3
        JbGyKrUoP76oNCe1+BCjKdBDE5mlRJPzgfGXVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2x
        JDU7NbUgtQimj4mDU6qBUaGvX37t2dcaD+cyZsktsGU49uWl7r49Gy1nNUyvP7KzoUu64b2l
        0uuk3Zrn0l/yGQdbfkpacuDMjm2HFESVO4qCl9XsTOeIFrL6sl9ttchEZvfZtowPVqd9l9Nh
        ObhiUatPzLfHsi9PRLvVTndgF5oePCuiSnP16i9XZH1/K/1RFNm2lMXysBJLcUaioRZzUXEi
        AMIc+qOHAgAA
X-CMS-MailID: 20190524115553eucas1p2f900901e65f06ec33e478d433f96e34f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190524115553eucas1p2f900901e65f06ec33e478d433f96e34f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190524115553eucas1p2f900901e65f06ec33e478d433f96e34f
References: <CGME20190524115553eucas1p2f900901e65f06ec33e478d433f96e34f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to pvr2fb driver for better compile
testing coverage.

While at it:

- mark pvr2fb_interrupt() and pvr2fb_common_init() with
  __maybe_unused tag (to silence build warnings when
  !SH_DREAMCAST)

- convert mmio_base in struct pvr2fb_par to 'void __iomem *'
  from 'unsigned long' (needed to silence build warnings on
  ARM).

- split pvr2_get_param() on pvr2_get_param_name() and
  pvr2_get_param_val() (needed to silence build warnings on
  x86).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2: fix build warnings on x86 reported by kbuild test robot

patch #1/2 is unchanged so I'm not sending it again

 drivers/video/fbdev/Kconfig  |    3 +-
 drivers/video/fbdev/pvr2fb.c |   61 +++++++++++++++++++++++--------------------
 2 files changed, 36 insertions(+), 28 deletions(-)

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
 
@@ -722,23 +722,30 @@ static struct fb_ops pvr2fb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static int pvr2_get_param(const struct pvr2_params *p, const char *s, int val,
-			  int size)
+static int pvr2_get_param_val(const struct pvr2_params *p, const char *s,
+			      int size)
 {
 	int i;
 
-	for (i = 0 ; i < size ; i++ ) {
-		if (s != NULL) {
-			if (!strncasecmp(p[i].name, s, strlen(s)))
-				return p[i].val;
-		} else {
-			if (p[i].val == val)
-				return (int)p[i].name;
-		}
+	for (i = 0 ; i < size; i++ ) {
+		if (!strncasecmp(p[i].name, s, strlen(s)))
+			return p[i].val;
 	}
 	return -1;
 }
 
+static char *pvr2_get_param_name(const struct pvr2_params *p, int val,
+			  int size)
+{
+	int i;
+
+	for (i = 0 ; i < size; i++ ) {
+		if (p[i].val == val)
+			return p[i].name;
+	}
+	return NULL;
+}
+
 /**
  * pvr2fb_common_init
  *
@@ -757,7 +764,7 @@ static int pvr2_get_param(const struct p
  * in for flexibility anyways. Who knows, maybe someone has tv-out on a
  * PCI-based version of these things ;-)
  */
-static int pvr2fb_common_init(void)
+static int __maybe_unused pvr2fb_common_init(void)
 {
 	struct pvr2fb_par *par = currentpar;
 	unsigned long modememused, rev;
@@ -770,8 +777,8 @@ static int pvr2fb_common_init(void)
 		goto out_err;
 	}
 
-	par->mmio_base = (unsigned long)ioremap_nocache(pvr2_fix.mmio_start,
-							pvr2_fix.mmio_len);
+	par->mmio_base = ioremap_nocache(pvr2_fix.mmio_start,
+					 pvr2_fix.mmio_len);
 	if (!par->mmio_base) {
 		printk(KERN_ERR "pvr2fb: Failed to remap mmio space\n");
 		goto out_err;
@@ -819,8 +826,8 @@ static int pvr2fb_common_init(void)
 		fb_info->var.xres, fb_info->var.yres,
 		fb_info->var.bits_per_pixel,
 		get_line_length(fb_info->var.xres, fb_info->var.bits_per_pixel),
-		(char *)pvr2_get_param(cables, NULL, cable_type, 3),
-		(char *)pvr2_get_param(outputs, NULL, video_output, 3));
+		pvr2_get_param_name(cables, cable_type, 3),
+		pvr2_get_param_name(outputs, video_output, 3));
 
 #ifdef CONFIG_SH_STORE_QUEUES
 	fb_notice(fb_info, "registering with SQ API\n");
@@ -838,7 +845,7 @@ out_err:
 	if (fb_info->screen_base)
 		iounmap(fb_info->screen_base);
 	if (par->mmio_base)
-		iounmap((void *)par->mmio_base);
+		iounmap(par->mmio_base);
 
 	return -ENXIO;
 }
@@ -905,8 +912,8 @@ static void __exit pvr2fb_dc_exit(void)
 		fb_info->screen_base = NULL;
 	}
 	if (currentpar->mmio_base) {
-		iounmap((void *)currentpar->mmio_base);
-		currentpar->mmio_base = 0;
+		iounmap(currentpar->mmio_base);
+		currentpar->mmio_base = NULL;
 	}
 
 	free_irq(HW_EVENT_VSYNC, fb_info);
@@ -955,8 +962,8 @@ static void pvr2fb_pci_remove(struct pci
 		fb_info->screen_base = NULL;
 	}
 	if (currentpar->mmio_base) {
-		iounmap((void *)currentpar->mmio_base);
-		currentpar->mmio_base = 0;
+		iounmap(currentpar->mmio_base);
+		currentpar->mmio_base = NULL;
 	}
 
 	pci_release_regions(pdev);
@@ -1027,9 +1034,9 @@ static int __init pvr2fb_setup(char *opt
 	}
 
 	if (*cable_arg)
-		cable_type = pvr2_get_param(cables, cable_arg, 0, 3);
+		cable_type = pvr2_get_param_val(cables, cable_arg, 3);
 	if (*output_arg)
-		video_output = pvr2_get_param(outputs, output_arg, 0, 3);
+		video_output = pvr2_get_param_val(outputs, output_arg, 3);
 
 	return 0;
 }
