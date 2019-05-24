Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2C8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F395720851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JPasq2t0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391438AbfEXL6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:58:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54224 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390961AbfEXL6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:58:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190524115840euoutp0135f0f54db7ba5029460dd6815f0eab43~hnJeU2TJC0189601896euoutp01U
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 11:58:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190524115840euoutp0135f0f54db7ba5029460dd6815f0eab43~hnJeU2TJC0189601896euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558699120;
        bh=Sf8ZhnMAfsbeP6S3yEjJ583D1xTFd6vdafcy+8uGB6I=;
        h=From:Subject:To:Date:References:From;
        b=JPasq2t0LFWj+dLN1GL8Pm2W6/gljdepKdZacqNm2rGYS/xo1er1KNoLRUho+S4AI
         do0N0DzVRmC1c+IFoefDz++xXbZ+A2aNri3sfuaCZInOy6a2bqedgghpgKBRGsX3Jk
         iJzdaHQ4ndYwFrSPE5xAxfry71TKfBcOZbDOdp84=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190524115840eucas1p130f43e49052abedfd67df94aa17fc0ec~hnJd9nypr2422524225eucas1p1c;
        Fri, 24 May 2019 11:58:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6F.F7.04298.07CD7EC5; Fri, 24
        May 2019 12:58:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190524115839eucas1p135f0a6814fa1a163d903c60e602723f6~hnJdIHups1135211352eucas1p1h;
        Fri, 24 May 2019 11:58:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190524115839eusmtrp2322c404afe6f08b8401c89e8fb92a560~hnJc6I9_A2432224322eusmtrp2r;
        Fri, 24 May 2019 11:58:39 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-2f-5ce7dc70e139
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 42.B2.04140.F6CD7EC5; Fri, 24
        May 2019 12:58:39 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190524115839eusmtip1d65e42812df16d0e2a17475726e55777~hnJcqhcvP3051530515eusmtip1N;
        Fri, 24 May 2019 11:58:39 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 2/2] video: fbdev: pvr2fb: add COMPILE_TEST support
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <e59b45f6-b8a5-ed99-f294-072df1a1d222@samsung.com>
Date:   Fri, 24 May 2019 13:58:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzned2CO89jDFau4be48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApigum5TUnMyy1CJ9uwSujBdnJzIV7NarWH6gi7mB8aRqFyMn
        h4SAicTayYuZuhi5OIQEVjBK/Jj2nAXC+cIoseTZcSjnM6PE3hm32WBaXs+czw5iCwksZ5T4
        cN8aougto8Sj3Q1MIAk2ASuJie2rGEFsYQE3iTW3L4LFRQQSJFZMnwEW5xWwk7i/4yEziM0i
        oCrxYcMWsLioQITE/WMbWCFqBCVOznzCAmIzC4hL3HoynwnClpfY/nYOM8RBt9kkLh706mLk
        ALJdJK50uUKEhSVeHd/CDmHLSPzfOR/sTQmBdYwSfzteMEM42xkllk/+B/WZtcTh4xdZQQYx
        C2hKrN+lDxF2lHi2agoTxHw+iRtvBSFO4JOYtG06M0SYV6KjTQiiWk1iw7INbDBru3auhLrS
        Q2JT80I2SLDFSpxs/8I8gVFhFpInZyF5chaSJ2ch3LOAkWUVo3hqaXFuemqxYV5quV5xYm5x
        aV66XnJ+7iZGYOo4/e/4px2MXy8lHWIU4GBU4uFNuPw8Rog1say4MvcQowQHs5IIb+z+ZzFC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGCN9mfo+VV4y
        +xDW3CGk+Wha6jLl2pWnr1v/adD62CZS36++2GB2Q+uSfT8dUhiKCr4febo8vt9utalRhExR
        ZcKj3LwtEUwLWd7k7pveG9z7l39m7yaHZ6ekuLZ3bnw2S8dH8/n2irNpoX1pDsYndXasPTux
        ueH+2/snyz5y/0mUk93A5aMfoMRSnJFoqMVcVJwIACJzcVkZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t/xu7r5d57HGJzZLmRx5et7NosTfR9Y
        LS7vmsPmwOxxv/s4k8fnTXIBTFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkam
        Svp2NimpOZllqUX6dgl6GS/OTmQq2K1XsfxAF3MD40nVLkZODgkBE4nXM+ezdzFycQgJLGWU
        6Ft0n62LkQMoISNxfH0ZRI2wxJ9rXWwQNa8ZJTqXbWcGSbAJWElMbF/FCGILC7hJrLl9kQnE
        FhFIkHj6ej4biM0rYCdxf8dDsHoWAVWJDxu2gNWLCkRInHm/ggWiRlDi5MwnYDazgLrEn3mX
        mCFscYlbT+YzQdjyEtvfzmGewMg/C0nLLCQts5C0zELSsoCRZRWjSGppcW56brGRXnFibnFp
        Xrpecn7uJkZgkG879nPLDsaud8GHGAU4GJV4eBMuP48RYk0sK67MPcQowcGsJMIbu/9ZjBBv
        SmJlVWpRfnxRaU5q8SFGU6CHJjJLiSbnAyMwryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpi
        SWp2ampBahFMHxMHp1QDo8hDwb7pseqcmunOC68UXP/Pt1vb/JqQg1Tg3tRJXDkWwXGqu/fk
        tLHe+Fx59/S/HbK3T59w7q2yZnh8RfuQK0tG0PsprZaTDbbs73WYK7J/La8em7r1NNFFc7nW
        3zhz5vWWjekeHjuOzbzztZ99U87pIyyZKjyXO2dFJ8y/o8TU7eg0/6uLhxJLcUaioRZzUXEi
        AGN2KFOIAgAA
X-CMS-MailID: 20190524115839eucas1p135f0a6814fa1a163d903c60e602723f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190524115839eucas1p135f0a6814fa1a163d903c60e602723f6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190524115839eucas1p135f0a6814fa1a163d903c60e602723f6
References: <CGME20190524115839eucas1p135f0a6814fa1a163d903c60e602723f6@eucas1p1.samsung.com>
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
v3: fix 'space prohibited before that close parenthesis ')'
    checkpatch errors
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
+	for (i = 0 ; i < size; i++) {
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
+	for (i = 0 ; i < size; i++) {
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
