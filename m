Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0800C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7FF2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hjXGLQ40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfF0OIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:08:49 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35348 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfF0OIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:08:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190627140846euoutp024356187142413105860ed05d4a3e6861~sE2wu8oHK2347823478euoutp02r
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:08:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190627140846euoutp024356187142413105860ed05d4a3e6861~sE2wu8oHK2347823478euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561644526;
        bh=QUHj+ijud0YQLnEdLNjj5as4RJcIrXVoCpYGX7Oob0I=;
        h=From:Subject:To:Date:References:From;
        b=hjXGLQ40zKF7EdNNWi9tJhTcCQy38IlVdPY+KyofyCyjifFGfMDMF8AFOQDjnSE2b
         9GrCPuknPQud6d94g8epKpPe7q+uAhh+KJOnBuRHr97/S1GTbEMRIpD1mR49f4ARHO
         xLbfC64PwkYAYBhQzQ6QzIGAjg5qhafDz5Sn7hiA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190627140845eucas1p1f76ae8049ca9593a2c793f7b25b6b0c5~sE2wHY7ME1952719527eucas1p1E;
        Thu, 27 Jun 2019 14:08:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6A.1F.04325.DEDC41D5; Thu, 27
        Jun 2019 15:08:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190627140844eucas1p1fac4e639a3445c6ae1a51b0743289f1c~sE2vXXMAD1952319523eucas1p1V;
        Thu, 27 Jun 2019 14:08:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190627140844eusmtrp21af8ea6f188e6e7cca07acb6122d7237~sE2vF1gWa0820108201eusmtrp2O;
        Thu, 27 Jun 2019 14:08:44 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-be-5d14cdedba30
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 29.D3.04146.CEDC41D5; Thu, 27
        Jun 2019 15:08:44 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190627140844eusmtip1fcbf84fd2dbe0c477b25fffcf6a8d1b6~sE2uyf4xl2147321473eusmtip10;
        Thu, 27 Jun 2019 14:08:44 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3/3] video: fbdev: mmp: fix sparse warnings about using
 incorrect types
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <ee796b43-f200-d41a-b18c-ae3d6bcaaa67@samsung.com>
Date:   Thu, 27 Jun 2019 16:08:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduznOd23Z0ViDXZ/4bG48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApigum5TUnMyy1CJ9uwSujI/3jzMWvLat2LCktoFxkkkXIyeH
        hICJxPW3O1m7GLk4hARWMEoc/rWVDcL5wihxYvc6JgjnM6PEqlu7WGBavixbDNWynFFi0uLV
        zBDOW0aJ6/3/WEGq2ASsJCa2r2IEsYUFIiW2HnvLDmKLCCRIrJg+AyzOK2AnseHYEjYQm0VA
        VWLfjp9gcVGBCIn7xzawQtQISpyc+QRsM7OAuMStJ/OZIGx5ie1v5zBDXHSdTWLmWQEI20Vi
        y7c2JghbWOLV8S3sELaMxP+d88HekRBYxyjxt+MFM4SznVFi+eR/bBBV1hKHj18E2swBtEFT
        Yv0ufYiwo8TatsOMIGEJAT6JG28FIW7gk5i0bTozRJhXoqNNCKJaTWLDsg1sMGu7dq6EOtND
        4un6uWCvCAnESrxuvss6gVFhFpIvZyH5chaSL2ch3LOAkWUVo3hqaXFuemqxcV5quV5xYm5x
        aV66XnJ+7iZGYPI4/e/41x2M+/4kHWIU4GBU4uFV2CkSK8SaWFZcmXuIUYKDWUmENz8MKMSb
        klhZlVqUH19UmpNafIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNTqoGxRCSAYWXEuZqX
        DHsOvzC48+/xukW+rBzTfikEef/NP9ZkeUtZ73r9k0Ozlc0vfS3d43DwUrhAtZxK5z3R18yT
        ns7tmcVwXcy+wYDtyQOxt/9nPOSo8TnyYPKv/xsWPzmo59FubSnYnVF/QzvL903gZ6nmiWff
        ymcrh/dyiYt4aXUwtp1sb36qxFKckWioxVxUnAgA3FldIhoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xu7pvzorEGkw/zW9x5et7NosTfR9Y
        LS7vmsPmwOxxv/s4k8fnTXIBTFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkam
        Svp2NimpOZllqUX6dgl6GR/vH2cseG1bsWFJbQPjJJMuRk4OCQETiS/LFrN2MXJxCAksZZR4
        ee0MUxcjB1BCRuL4+jKIGmGJP9e62EBsIYHXjBJ7diqA2GwCVhIT21cxgtjCApESW4+9ZQex
        RQQSJJ6+ng9WzytgJ7Hh2BIwm0VAVWLfjp9g9aICERJn3q9ggagRlDg58wmYzSygLvFn3iVm
        CFtc4taT+UwQtrzE9rdzmCcw8s9C0jILScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqX
        rpecn7uJERjg24793LyD8dLG4EOMAhyMSjy8CjtFYoVYE8uKK3MPMUpwMCuJ8OaHAYV4UxIr
        q1KL8uOLSnNSiw8xmgI9NJFZSjQ5Hxh9eSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1Kz
        U1MLUotg+pg4OKUaGBV+ZbVPEl4hb9pzhaPre7TB7NVOcu0972JuLHm8U6zXJsx4wcTnU/YI
        3591tEIpUyb119zOtIONXdv2bw6cr1mzR2HN9+ZvRZ6bfYSL9f9vFLv/K1wlP4xzb6NdXIDT
        Zgn5NYxLBSQZJKd/cj/kOMP6Rz83q+u2K/0T7HTjIlZOrXm8j+HZUiWW4oxEQy3mouJEAPzc
        fS6GAgAA
X-CMS-MailID: 20190627140844eucas1p1fac4e639a3445c6ae1a51b0743289f1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190627140844eucas1p1fac4e639a3445c6ae1a51b0743289f1c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627140844eucas1p1fac4e639a3445c6ae1a51b0743289f1c
References: <CGME20190627140844eucas1p1fac4e639a3445c6ae1a51b0743289f1c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ->screen_buffer instead of ->screen_base in mmpfb driver.

[ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
  pointer") for details. ]

Also fix all other sparse warnings about using incorrect types in
mmp display subsystem.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/mmp/fb/mmpfb.c    |    2 -
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c |   55 +++++++++++++++++++---------------
 drivers/video/fbdev/mmp/hw/mmp_ctrl.h |   10 +++---
 drivers/video/fbdev/mmp/hw/mmp_spi.c  |    6 +--
 4 files changed, 41 insertions(+), 32 deletions(-)

Index: b/drivers/video/fbdev/mmp/fb/mmpfb.c
===================================================================
--- a/drivers/video/fbdev/mmp/fb/mmpfb.c
+++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
@@ -522,7 +522,7 @@ static int fb_info_setup(struct fb_info
 		info->var.bits_per_pixel / 8;
 	info->fbops = &mmpfb_ops;
 	info->pseudo_palette = fbi->pseudo_palette;
-	info->screen_base = fbi->fb_start;
+	info->screen_buffer = fbi->fb_start;
 	info->screen_size = fbi->fb_size;
 
 	/* For FB framework: Allocate color map and Register framebuffer*/
Index: b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
===================================================================
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -136,19 +136,26 @@ static void overlay_set_win(struct mmp_o
 	mutex_lock(&overlay->access_ok);
 
 	if (overlay_is_vid(overlay)) {
-		writel_relaxed(win->pitch[0], &regs->v_pitch_yc);
-		writel_relaxed(win->pitch[2] << 16 |
-				win->pitch[1], &regs->v_pitch_uv);
-
-		writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->v_size);
-		writel_relaxed((win->ydst << 16) | win->xdst, &regs->v_size_z);
-		writel_relaxed(win->ypos << 16 | win->xpos, &regs->v_start);
+		writel_relaxed(win->pitch[0],
+				(void __iomem *)&regs->v_pitch_yc);
+		writel_relaxed(win->pitch[2] << 16 | win->pitch[1],
+				(void __iomem *)&regs->v_pitch_uv);
+
+		writel_relaxed((win->ysrc << 16) | win->xsrc,
+				(void __iomem *)&regs->v_size);
+		writel_relaxed((win->ydst << 16) | win->xdst,
+				(void __iomem *)&regs->v_size_z);
+		writel_relaxed(win->ypos << 16 | win->xpos,
+				(void __iomem *)&regs->v_start);
 	} else {
-		writel_relaxed(win->pitch[0], &regs->g_pitch);
+		writel_relaxed(win->pitch[0], (void __iomem *)&regs->g_pitch);
 
-		writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->g_size);
-		writel_relaxed((win->ydst << 16) | win->xdst, &regs->g_size_z);
-		writel_relaxed(win->ypos << 16 | win->xpos, &regs->g_start);
+		writel_relaxed((win->ysrc << 16) | win->xsrc,
+				(void __iomem *)&regs->g_size);
+		writel_relaxed((win->ydst << 16) | win->xdst,
+				(void __iomem *)&regs->g_size_z);
+		writel_relaxed(win->ypos << 16 | win->xpos,
+				(void __iomem *)&regs->g_start);
 	}
 
 	dmafetch_set_fmt(overlay);
@@ -233,11 +240,11 @@ static int overlay_set_addr(struct mmp_o
 	memcpy(&overlay->addr, addr, sizeof(struct mmp_addr));
 
 	if (overlay_is_vid(overlay)) {
-		writel_relaxed(addr->phys[0], &regs->v_y0);
-		writel_relaxed(addr->phys[1], &regs->v_u0);
-		writel_relaxed(addr->phys[2], &regs->v_v0);
+		writel_relaxed(addr->phys[0], (void __iomem *)&regs->v_y0);
+		writel_relaxed(addr->phys[1], (void __iomem *)&regs->v_u0);
+		writel_relaxed(addr->phys[2], (void __iomem *)&regs->v_v0);
 	} else
-		writel_relaxed(addr->phys[0], &regs->g_0);
+		writel_relaxed(addr->phys[0], (void __iomem *)&regs->g_0);
 
 	return overlay->addr.phys[0];
 }
@@ -268,16 +275,18 @@ static void path_set_mode(struct mmp_pat
 	tmp |= dsi_rbswap & CFG_INTFRBSWAP_MASK;
 	writel_relaxed(tmp, ctrl_regs(path) + intf_rbswap_ctrl(path->id));
 
-	writel_relaxed((mode->yres << 16) | mode->xres, &regs->screen_active);
+	writel_relaxed((mode->yres << 16) | mode->xres,
+		(void __iomem *)&regs->screen_active);
 	writel_relaxed((mode->left_margin << 16) | mode->right_margin,
-		&regs->screen_h_porch);
+		(void __iomem *)&regs->screen_h_porch);
 	writel_relaxed((mode->upper_margin << 16) | mode->lower_margin,
-		&regs->screen_v_porch);
+		(void __iomem *)&regs->screen_v_porch);
 	total_x = mode->xres + mode->left_margin + mode->right_margin +
 		mode->hsync_len;
 	total_y = mode->yres + mode->upper_margin + mode->lower_margin +
 		mode->vsync_len;
-	writel_relaxed((total_y << 16) | total_x, &regs->screen_size);
+	writel_relaxed((total_y << 16) | total_x,
+		(void __iomem *)&regs->screen_size);
 
 	/* vsync ctrl */
 	if (path->output_type == PATH_OUT_DSI)
@@ -285,7 +294,7 @@ static void path_set_mode(struct mmp_pat
 	else
 		vsync_ctrl = ((mode->xres + mode->right_margin) << 16)
 					| (mode->xres + mode->right_margin);
-	writel_relaxed(vsync_ctrl, &regs->vsync_ctrl);
+	writel_relaxed(vsync_ctrl, (void __iomem *)&regs->vsync_ctrl);
 
 	/* set pixclock div */
 	sclk_src = clk_get_rate(path_to_ctrl(path)->clk);
@@ -366,9 +375,9 @@ static void path_set_default(struct mmp_
 	writel_relaxed(dma_ctrl1, ctrl_regs(path) + dma_ctrl(1, path->id));
 
 	/* Configure default register values */
-	writel_relaxed(0x00000000, &regs->blank_color);
-	writel_relaxed(0x00000000, &regs->g_1);
-	writel_relaxed(0x00000000, &regs->g_start);
+	writel_relaxed(0x00000000, (void __iomem *)&regs->blank_color);
+	writel_relaxed(0x00000000, (void __iomem *)&regs->g_1);
+	writel_relaxed(0x00000000, (void __iomem *)&regs->g_start);
 
 	/*
 	 * 1.enable multiple burst request in DMA AXI
Index: b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
===================================================================
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
@@ -1393,7 +1393,7 @@ struct mmphw_ctrl {
 	/* platform related, get from config */
 	const char *name;
 	int irq;
-	void *reg_base;
+	void __iomem *reg_base;
 	struct clk *clk;
 
 	/* sys info */
@@ -1429,7 +1429,7 @@ static inline struct mmphw_ctrl *overlay
 	return path_to_ctrl(overlay->path);
 }
 
-static inline void *ctrl_regs(struct mmp_path *path)
+static inline void __iomem *ctrl_regs(struct mmp_path *path)
 {
 	return path_to_ctrl(path)->reg_base;
 }
@@ -1438,11 +1438,11 @@ static inline void *ctrl_regs(struct mmp
 static inline struct lcd_regs *path_regs(struct mmp_path *path)
 {
 	if (path->id == PATH_PN)
-		return (struct lcd_regs *)(ctrl_regs(path) + 0xc0);
+		return (struct lcd_regs __force *)(ctrl_regs(path) + 0xc0);
 	else if (path->id == PATH_TV)
-		return (struct lcd_regs *)ctrl_regs(path);
+		return (struct lcd_regs __force  *)ctrl_regs(path);
 	else if (path->id == PATH_P2)
-		return (struct lcd_regs *)(ctrl_regs(path) + 0x200);
+		return (struct lcd_regs __force *)(ctrl_regs(path) + 0x200);
 	else {
 		dev_err(path->dev, "path id %d invalid\n", path->id);
 		BUG_ON(1);
Index: b/drivers/video/fbdev/mmp/hw/mmp_spi.c
===================================================================
--- a/drivers/video/fbdev/mmp/hw/mmp_spi.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_spi.c
@@ -31,7 +31,7 @@ static inline int lcd_spi_write(struct s
 {
 	int timeout = 100000, isr, ret = 0;
 	u32 tmp;
-	void *reg_base =
+	void __iomem *reg_base = (void __iomem *)
 		*(void **)spi_master_get_devdata(spi->master);
 
 	/* clear ISR */
@@ -80,7 +80,7 @@ static inline int lcd_spi_write(struct s
 
 static int lcd_spi_setup(struct spi_device *spi)
 {
-	void *reg_base =
+	void __iomem *reg_base = (void __iomem *)
 		*(void **)spi_master_get_devdata(spi->master);
 	u32 tmp;
 
@@ -146,7 +146,7 @@ int lcd_spi_register(struct mmphw_ctrl *
 		return -ENOMEM;
 	}
 	p_regbase = spi_master_get_devdata(master);
-	*p_regbase = ctrl->reg_base;
+	*p_regbase = (void __force *)ctrl->reg_base;
 
 	/* set bus num to 5 to avoid conflict with other spi hosts */
 	master->bus_num = 5;

