Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44481C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96BC2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G3Bcx7xJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfHTLHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:07:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50692 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHTLHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:07:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190820110751euoutp02b91c59bb9be33426f3e3c9d42e7218a8~8nONwFKa32200822008euoutp02S
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 11:07:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190820110751euoutp02b91c59bb9be33426f3e3c9d42e7218a8~8nONwFKa32200822008euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566299271;
        bh=s1zXpaWAXznZ2hou+6eOI4S1UhWtvJQ9miZnfjkAEso=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=G3Bcx7xJHhKVN0U0CkjyLXzZ6KUzkIWg0scLok08D6lJhizwhl5/U6EZHFx+4JxsP
         NqfyZpapLcxAWUGk3x4UyH9/LVa/+6BjGI6kUnBplqcArJ1FsyHGHON1rpAcZTLpoz
         WBFeOjJ8eOxBiGJpniwN7G6CI4+4OePF63TJ8UiA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190820110750eucas1p1d3eaa90e58d8729893c6fe915f1db1bd~8nONVDpjP0614106141eucas1p1j;
        Tue, 20 Aug 2019 11:07:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 46.7C.04469.684DB5D5; Tue, 20
        Aug 2019 12:07:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190820110749eucas1p26649f88fe25ed807e6b0bb36735ce2f0~8nOMjI17v0186901869eucas1p2w;
        Tue, 20 Aug 2019 11:07:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190820110749eusmtrp13e782941a26072cd40bad7e7f0d8613b~8nOMU7Lm-0473404734eusmtrp1T;
        Tue, 20 Aug 2019 11:07:49 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-47-5d5bd486e80b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 20.C3.04117.584DB5D5; Tue, 20
        Aug 2019 12:07:49 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190820110749eusmtip23aec2e7c1b03a6955b93bb08f55ed8b9~8nOMFNytf0243902439eusmtip2X;
        Tue, 20 Aug 2019 11:07:49 +0000 (GMT)
Subject: Re: [PATCH 3/3] video: fbdev: mmp: fix sparse warnings about using
 incorrect types
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <bb23a213-e86f-8057-566d-926c1b5eb10b@samsung.com>
Date:   Tue, 20 Aug 2019 13:07:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:69.0) Gecko/20100101
        Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <ee796b43-f200-d41a-b18c-ae3d6bcaaa67@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87ptV6JjDe6/ELLYOGM9q8WVr+/Z
        LE70fWC1uLxrDpsDi8f97uNMHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJVx7fUqtoLNzhWL
        HsQ3ML4w72Lk5JAQMJHY8H0DUxcjF4eQwApGiR1r5zFDOF8YJXZ2bmKHcD4zSlxtncQI07J7
        4VKoluWMEidW/IVy3jJKnF7exARSJSwQK7Fq1XdGkISIwAxGiV/z9rCAJNgENCX+br7JBmLz
        CthJLOj7DRZnEVCV2HrqDCuILSoQJrF24WYWiBpBiZMznwDZHBycAvYSJy7IgoSZBeQlmrfO
        ZoawxSVuPZkPdoSEwH82icvXFrNBnOoi8bB5NROELSzx6vgWdghbRuL05B4WCLte4v6KFmaI
        5g5Gia0bdjJDJKwlDh+/yAqymBno6PW79CHCjhJr2w4zgoQlBPgkbrwVhLiBT2LStunMEGFe
        iY42IYhqRYn7Z7dCDRSXWHrhK9RlHhJP189lmcCoOAvJk7OQfDYLyWezEG5YwMiyilE8tbQ4
        Nz212DAvtVyvODG3uDQvXS85P3cTIzChnP53/NMOxq+Xkg4xCnAwKvHwekyLihViTSwrrsw9
        xCjBwawkwlsxByjEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2ampBahFMlomD
        U6qBUeqZ2oItqp37epItDyxzsBC98F1s02EO5zl7ynWrmJpveVo/n5TVG80+wdBk5deII0rX
        F7Jeawg6dprzYvaiKuZFF27Hr5gnJT1/kbOIRGHnisVap7YJfqx9xin0PjtL//OR+yzWXT4q
        h+v3n/R6/HhJcES2XbtFkxvfnNV8HF1GhxgWHdNJU2Ipzkg01GIuKk4EACy7iM0kAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7qtV6JjDdYdkLPYOGM9q8WVr+/Z
        LE70fWC1uLxrDpsDi8f97uNMHn1bVjF6fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJdx7fUqtoLNzhWLHsQ3ML4w72Lk5JAQMJHYvXAp
        UxcjF4eQwFJGiablTWwQCXGJ3fPfMkPYwhJ/rnWxQRS9ZpSYc3orO0hCWCBWYtWq74wgCRGB
        GYwSD88vZIWomsQo8fTMYbAqNgFNib+bb4KN5RWwk1jQ95sFxGYRUJXYeuoMK4gtKhAmcePe
        PUaIGkGJkzOfANVwcHAK2EucuCALEmYWUJf4M+8SM4QtL9G8dTaULS5x68l8pgmMgrOQdM9C
        0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbKtmM/t+xg7HoXfIhRgINR
        iYfXY1pUrBBrYllxZe4hRgkOZiUR3oo5QCHelMTKqtSi/Pii0pzU4kOMpkC/TWSWEk3OB8Zx
        Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxtL+789b/170FZLl
        mluQ1cz2fvmdlZVR2SICAvYRPGfOOjfvTZ3Zo8pU6CF5Yf4HqTtlehfPhansCPvbPvHzizyX
        pI/7l7MWe/50+Xn1YOWTj1sdL1f/+Ny0Qnf1QYMaiYAb6a4BO6I0Tp75Mv/W5AAzrxWMD3T2
        8iQtUKkP3r7uUrqP9uoXDUosxRmJhlrMRcWJAAzTSWKrAgAA
X-CMS-MailID: 20190820110749eucas1p26649f88fe25ed807e6b0bb36735ce2f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190627140844eucas1p1fac4e639a3445c6ae1a51b0743289f1c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627140844eucas1p1fac4e639a3445c6ae1a51b0743289f1c
References: <CGME20190627140844eucas1p1fac4e639a3445c6ae1a51b0743289f1c@eucas1p1.samsung.com>
        <ee796b43-f200-d41a-b18c-ae3d6bcaaa67@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.06.2019 16:08, Bartlomiej Zolnierkiewicz wrote:
> Use ->screen_buffer instead of ->screen_base in mmpfb driver.
>
> [ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
>   pointer") for details. ]
>
> Also fix all other sparse warnings about using incorrect types in
> mmp display subsystem.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


> ---
>  drivers/video/fbdev/mmp/fb/mmpfb.c    |    2 -
>  drivers/video/fbdev/mmp/hw/mmp_ctrl.c |   55 +++++++++++++++++++---------------
>  drivers/video/fbdev/mmp/hw/mmp_ctrl.h |   10 +++---
>  drivers/video/fbdev/mmp/hw/mmp_spi.c  |    6 +--
>  4 files changed, 41 insertions(+), 32 deletions(-)
>
> Index: b/drivers/video/fbdev/mmp/fb/mmpfb.c
> ===================================================================
> --- a/drivers/video/fbdev/mmp/fb/mmpfb.c
> +++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
> @@ -522,7 +522,7 @@ static int fb_info_setup(struct fb_info
>  		info->var.bits_per_pixel / 8;
>  	info->fbops = &mmpfb_ops;
>  	info->pseudo_palette = fbi->pseudo_palette;
> -	info->screen_base = fbi->fb_start;
> +	info->screen_buffer = fbi->fb_start;
>  	info->screen_size = fbi->fb_size;
>  
>  	/* For FB framework: Allocate color map and Register framebuffer*/
> Index: b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> ===================================================================
> --- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> +++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> @@ -136,19 +136,26 @@ static void overlay_set_win(struct mmp_o
>  	mutex_lock(&overlay->access_ok);
>  
>  	if (overlay_is_vid(overlay)) {
> -		writel_relaxed(win->pitch[0], &regs->v_pitch_yc);
> -		writel_relaxed(win->pitch[2] << 16 |
> -				win->pitch[1], &regs->v_pitch_uv);
> -
> -		writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->v_size);
> -		writel_relaxed((win->ydst << 16) | win->xdst, &regs->v_size_z);
> -		writel_relaxed(win->ypos << 16 | win->xpos, &regs->v_start);
> +		writel_relaxed(win->pitch[0],
> +				(void __iomem *)&regs->v_pitch_yc);
> +		writel_relaxed(win->pitch[2] << 16 | win->pitch[1],
> +				(void __iomem *)&regs->v_pitch_uv);
> +
> +		writel_relaxed((win->ysrc << 16) | win->xsrc,
> +				(void __iomem *)&regs->v_size);
> +		writel_relaxed((win->ydst << 16) | win->xdst,
> +				(void __iomem *)&regs->v_size_z);
> +		writel_relaxed(win->ypos << 16 | win->xpos,
> +				(void __iomem *)&regs->v_start);
>  	} else {
> -		writel_relaxed(win->pitch[0], &regs->g_pitch);
> +		writel_relaxed(win->pitch[0], (void __iomem *)&regs->g_pitch);
>  
> -		writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->g_size);
> -		writel_relaxed((win->ydst << 16) | win->xdst, &regs->g_size_z);
> -		writel_relaxed(win->ypos << 16 | win->xpos, &regs->g_start);
> +		writel_relaxed((win->ysrc << 16) | win->xsrc,
> +				(void __iomem *)&regs->g_size);
> +		writel_relaxed((win->ydst << 16) | win->xdst,
> +				(void __iomem *)&regs->g_size_z);
> +		writel_relaxed(win->ypos << 16 | win->xpos,
> +				(void __iomem *)&regs->g_start);
>  	}
>  
>  	dmafetch_set_fmt(overlay);
> @@ -233,11 +240,11 @@ static int overlay_set_addr(struct mmp_o
>  	memcpy(&overlay->addr, addr, sizeof(struct mmp_addr));
>  
>  	if (overlay_is_vid(overlay)) {
> -		writel_relaxed(addr->phys[0], &regs->v_y0);
> -		writel_relaxed(addr->phys[1], &regs->v_u0);
> -		writel_relaxed(addr->phys[2], &regs->v_v0);
> +		writel_relaxed(addr->phys[0], (void __iomem *)&regs->v_y0);
> +		writel_relaxed(addr->phys[1], (void __iomem *)&regs->v_u0);
> +		writel_relaxed(addr->phys[2], (void __iomem *)&regs->v_v0);
>  	} else
> -		writel_relaxed(addr->phys[0], &regs->g_0);
> +		writel_relaxed(addr->phys[0], (void __iomem *)&regs->g_0);
>  
>  	return overlay->addr.phys[0];
>  }
> @@ -268,16 +275,18 @@ static void path_set_mode(struct mmp_pat
>  	tmp |= dsi_rbswap & CFG_INTFRBSWAP_MASK;
>  	writel_relaxed(tmp, ctrl_regs(path) + intf_rbswap_ctrl(path->id));
>  
> -	writel_relaxed((mode->yres << 16) | mode->xres, &regs->screen_active);
> +	writel_relaxed((mode->yres << 16) | mode->xres,
> +		(void __iomem *)&regs->screen_active);
>  	writel_relaxed((mode->left_margin << 16) | mode->right_margin,
> -		&regs->screen_h_porch);
> +		(void __iomem *)&regs->screen_h_porch);
>  	writel_relaxed((mode->upper_margin << 16) | mode->lower_margin,
> -		&regs->screen_v_porch);
> +		(void __iomem *)&regs->screen_v_porch);
>  	total_x = mode->xres + mode->left_margin + mode->right_margin +
>  		mode->hsync_len;
>  	total_y = mode->yres + mode->upper_margin + mode->lower_margin +
>  		mode->vsync_len;
> -	writel_relaxed((total_y << 16) | total_x, &regs->screen_size);
> +	writel_relaxed((total_y << 16) | total_x,
> +		(void __iomem *)&regs->screen_size);
>  
>  	/* vsync ctrl */
>  	if (path->output_type == PATH_OUT_DSI)
> @@ -285,7 +294,7 @@ static void path_set_mode(struct mmp_pat
>  	else
>  		vsync_ctrl = ((mode->xres + mode->right_margin) << 16)
>  					| (mode->xres + mode->right_margin);
> -	writel_relaxed(vsync_ctrl, &regs->vsync_ctrl);
> +	writel_relaxed(vsync_ctrl, (void __iomem *)&regs->vsync_ctrl);
>  
>  	/* set pixclock div */
>  	sclk_src = clk_get_rate(path_to_ctrl(path)->clk);
> @@ -366,9 +375,9 @@ static void path_set_default(struct mmp_
>  	writel_relaxed(dma_ctrl1, ctrl_regs(path) + dma_ctrl(1, path->id));
>  
>  	/* Configure default register values */
> -	writel_relaxed(0x00000000, &regs->blank_color);
> -	writel_relaxed(0x00000000, &regs->g_1);
> -	writel_relaxed(0x00000000, &regs->g_start);
> +	writel_relaxed(0x00000000, (void __iomem *)&regs->blank_color);
> +	writel_relaxed(0x00000000, (void __iomem *)&regs->g_1);
> +	writel_relaxed(0x00000000, (void __iomem *)&regs->g_start);
>  
>  	/*
>  	 * 1.enable multiple burst request in DMA AXI
> Index: b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
> ===================================================================
> --- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
> +++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
> @@ -1393,7 +1393,7 @@ struct mmphw_ctrl {
>  	/* platform related, get from config */
>  	const char *name;
>  	int irq;
> -	void *reg_base;
> +	void __iomem *reg_base;
>  	struct clk *clk;
>  
>  	/* sys info */
> @@ -1429,7 +1429,7 @@ static inline struct mmphw_ctrl *overlay
>  	return path_to_ctrl(overlay->path);
>  }
>  
> -static inline void *ctrl_regs(struct mmp_path *path)
> +static inline void __iomem *ctrl_regs(struct mmp_path *path)
>  {
>  	return path_to_ctrl(path)->reg_base;
>  }
> @@ -1438,11 +1438,11 @@ static inline void *ctrl_regs(struct mmp
>  static inline struct lcd_regs *path_regs(struct mmp_path *path)
>  {
>  	if (path->id == PATH_PN)
> -		return (struct lcd_regs *)(ctrl_regs(path) + 0xc0);
> +		return (struct lcd_regs __force *)(ctrl_regs(path) + 0xc0);
>  	else if (path->id == PATH_TV)
> -		return (struct lcd_regs *)ctrl_regs(path);
> +		return (struct lcd_regs __force  *)ctrl_regs(path);
>  	else if (path->id == PATH_P2)
> -		return (struct lcd_regs *)(ctrl_regs(path) + 0x200);
> +		return (struct lcd_regs __force *)(ctrl_regs(path) + 0x200);
>  	else {
>  		dev_err(path->dev, "path id %d invalid\n", path->id);
>  		BUG_ON(1);
> Index: b/drivers/video/fbdev/mmp/hw/mmp_spi.c
> ===================================================================
> --- a/drivers/video/fbdev/mmp/hw/mmp_spi.c
> +++ b/drivers/video/fbdev/mmp/hw/mmp_spi.c
> @@ -31,7 +31,7 @@ static inline int lcd_spi_write(struct s
>  {
>  	int timeout = 100000, isr, ret = 0;
>  	u32 tmp;
> -	void *reg_base =
> +	void __iomem *reg_base = (void __iomem *)
>  		*(void **)spi_master_get_devdata(spi->master);
>  
>  	/* clear ISR */
> @@ -80,7 +80,7 @@ static inline int lcd_spi_write(struct s
>  
>  static int lcd_spi_setup(struct spi_device *spi)
>  {
> -	void *reg_base =
> +	void __iomem *reg_base = (void __iomem *)
>  		*(void **)spi_master_get_devdata(spi->master);
>  	u32 tmp;
>  
> @@ -146,7 +146,7 @@ int lcd_spi_register(struct mmphw_ctrl *
>  		return -ENOMEM;
>  	}
>  	p_regbase = spi_master_get_devdata(master);
> -	*p_regbase = ctrl->reg_base;
> +	*p_regbase = (void __force *)ctrl->reg_base;
>  
>  	/* set bus num to 5 to avoid conflict with other spi hosts */
>  	master->bus_num = 5;
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


