Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E48C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296F121D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hgVkJr0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgACLjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:39:11 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50130 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgACLjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:39:10 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200103113908euoutp0110c6326641e36381d16aeb0011223f2e~mXYWmfX4u0815508155euoutp01N
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 11:39:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200103113908euoutp0110c6326641e36381d16aeb0011223f2e~mXYWmfX4u0815508155euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578051548;
        bh=BT23iouCo9z0H0VJHysswuoM0hOFFJ9tu2Vze4pDIJk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hgVkJr0yNWTp97z1etztnBScJuY8NEp+TVY3j5I3oC5PmMaO+4PulMUOiOsVqYR4j
         mNBU+pPTqOOI7Sm7ZB+of/r7YwKvswvHmhLlz5/HkTQHSUPRdocwemqNaHnHgZcZ5X
         M+QKMVlvY/nGnu2GUuQZTUsaFh1bSPlTSg7vi34g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200103113907eucas1p2b5900e50f187c88b925b2c3e40503452~mXYWaOqll1943019430eucas1p22;
        Fri,  3 Jan 2020 11:39:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5D.26.60698.BD72F0E5; Fri,  3
        Jan 2020 11:39:07 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200103113907eucas1p188ae917f99b8cfe66d857976dcee63b9~mXYV_b0Xr2516025160eucas1p1b;
        Fri,  3 Jan 2020 11:39:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200103113907eusmtrp20e3e41c3ad79ac5e61a8c8d039c64087~mXYV92gpF0328203282eusmtrp2V;
        Fri,  3 Jan 2020 11:39:07 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-c5-5e0f27dbbb28
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8A.51.08375.BD72F0E5; Fri,  3
        Jan 2020 11:39:07 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200103113907eusmtip2991640ecd1e1887b66b9016a82e94af3~mXYVsk3iN1131411314eusmtip2a;
        Fri,  3 Jan 2020 11:39:07 +0000 (GMT)
Subject: Re: [PATCH 3/3] video: fbdev: mmp: fix sparse warnings about using
 incorrect types
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <3fb650f8-1201-78ce-81f0-2039eb584bd1@samsung.com>
Date:   Fri, 3 Jan 2020 12:39:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bb23a213-e86f-8057-566d-926c1b5eb10b@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87q31fnjDE68MLC4te4cq8WVr+/Z
        LE70fWC1uLxrDpsDi8f97uNMHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJXx/sgs1oJjbhWX
        9r5ibWC8ZNXFyMkhIWAiMePQH+YuRi4OIYEVjBIPJ/UwQjhfGCUuXdvDDuF8ZpQ4u/w6M0zL
        pVvfWCESyxklXq9eDVX1llHiyOseJpAqYYFYiVWrvjOC2CIC6hKzT94B62YWSJD4cvMzmM0m
        YCUxsX0VWA2vgJ3Eht/LWEBsFgEViV0PToPZogIREp8eHGaFqBGUODnzCVicU8Beovn4TDaI
        meISt57MZ4Kw5SWat84Ge0hCoJtdYuH9ZqizXSSW3Ghlg7CFJV4d38IOYctI/N8J0gzSsI5R
        4m/HC6ju7YwSyyf/g+qwlrhz7heQzQG0QlNi/S59iLCjxNq2w4wgYQkBPokbbwUhjuCTmLRt
        OjNEmFeio00IolpNYsOyDWwwa7t2rmSewKg0C8lrs5C8MwvJO7MQ9i5gZFnFKJ5aWpybnlps
        nJdarlecmFtcmpeul5yfu4kRmFRO/zv+dQfjvj9JhxgFOBiVeHgTlPnjhFgTy4orcw8xSnAw
        K4nwlgfyxgnxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXA
        WHdI4JmMwIn6N/mJJa8mMjX8jw6besVzUfXx6zGqWX/jH5UUOmimm3/oMu2s4fWy2/qQ6eX0
        F41FT3OK32tt/7/qrI7sqq1X3+1OeJ4e5VVXqRV1qLPIpYZninlB+V0xOxsnnlL12JLTJzYe
        eTqt2ZvtDMP1KUd9ajf1LeDjFmXZe2Lj4dPcSizFGYmGWsxFxYkAutzXLSYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7q31fnjDDY+FLS4te4cq8WVr+/Z
        LE70fWC1uLxrDpsDi8f97uNMHn1bVjF6fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfx/sgs1oJjbhWX9r5ibWC8ZNXFyMkhIWAicenW
        N9YuRi4OIYGljBK7Fj1k72LkAErISBxfXwZRIyzx51oXG0TNa0aJlgltLCAJYYFYiVWrvjOC
        2CIC6hKzT95hhig6zijx/cR0NpAEs0CCxKb7U8FsNgEriYntq8AaeAXsJDb8XgY2iEVARWLX
        g9NgtqhAhMThHbOgagQlTs58AhbnFLCXaD4+E2qmusSfeZeYIWxxiVtP5jNB2PISzVtnM09g
        FJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzCGth37uXkH46WN
        wYcYBTgYlXh4E5T544RYE8uKK3MPMUpwMCuJ8JYH8sYJ8aYkVlalFuXHF5XmpBYfYjQFem4i
        s5Rocj4wvvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTAq3Vvy
        sVzEdIpor+lZNW6F6Y//HrtsUZtx2yt55XeZF6G7674tzIrun6PmkfrmUVDWBSWn6CDXanuG
        DFX777NrTjzdfmrn/CMK52z3CZzLutl05eHzbpHbm78tfVlRaf8kWl8gYt7RD1O+xk2RXOby
        +vM99fLVJ23Xvfm2+IWkX/GkWAsjj/UvlFiKMxINtZiLihMBqiMBxLcCAAA=
X-CMS-MailID: 20200103113907eucas1p188ae917f99b8cfe66d857976dcee63b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190627140844eucas1p1fac4e639a3445c6ae1a51b0743289f1c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627140844eucas1p1fac4e639a3445c6ae1a51b0743289f1c
References: <CGME20190627140844eucas1p1fac4e639a3445c6ae1a51b0743289f1c@eucas1p1.samsung.com>
        <ee796b43-f200-d41a-b18c-ae3d6bcaaa67@samsung.com>
        <bb23a213-e86f-8057-566d-926c1b5eb10b@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/20/19 1:07 PM, Andrzej Hajda wrote:
> On 27.06.2019 16:08, Bartlomiej Zolnierkiewicz wrote:
>> Use ->screen_buffer instead of ->screen_base in mmpfb driver.
>>
>> [ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
>>   pointer") for details. ]
>>
>> Also fix all other sparse warnings about using incorrect types in
>> mmp display subsystem.
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Thanks, I've queued the patch for v5.6.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>  --
> Regards
> Andrzej
> 
> 
>> ---
>>  drivers/video/fbdev/mmp/fb/mmpfb.c    |    2 -
>>  drivers/video/fbdev/mmp/hw/mmp_ctrl.c |   55 +++++++++++++++++++---------------
>>  drivers/video/fbdev/mmp/hw/mmp_ctrl.h |   10 +++---
>>  drivers/video/fbdev/mmp/hw/mmp_spi.c  |    6 +--
>>  4 files changed, 41 insertions(+), 32 deletions(-)
>>
>> Index: b/drivers/video/fbdev/mmp/fb/mmpfb.c
>> ===================================================================
>> --- a/drivers/video/fbdev/mmp/fb/mmpfb.c
>> +++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
>> @@ -522,7 +522,7 @@ static int fb_info_setup(struct fb_info
>>  		info->var.bits_per_pixel / 8;
>>  	info->fbops = &mmpfb_ops;
>>  	info->pseudo_palette = fbi->pseudo_palette;
>> -	info->screen_base = fbi->fb_start;
>> +	info->screen_buffer = fbi->fb_start;
>>  	info->screen_size = fbi->fb_size;
>>  
>>  	/* For FB framework: Allocate color map and Register framebuffer*/
>> Index: b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
>> ===================================================================
>> --- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
>> +++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
>> @@ -136,19 +136,26 @@ static void overlay_set_win(struct mmp_o
>>  	mutex_lock(&overlay->access_ok);
>>  
>>  	if (overlay_is_vid(overlay)) {
>> -		writel_relaxed(win->pitch[0], &regs->v_pitch_yc);
>> -		writel_relaxed(win->pitch[2] << 16 |
>> -				win->pitch[1], &regs->v_pitch_uv);
>> -
>> -		writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->v_size);
>> -		writel_relaxed((win->ydst << 16) | win->xdst, &regs->v_size_z);
>> -		writel_relaxed(win->ypos << 16 | win->xpos, &regs->v_start);
>> +		writel_relaxed(win->pitch[0],
>> +				(void __iomem *)&regs->v_pitch_yc);
>> +		writel_relaxed(win->pitch[2] << 16 | win->pitch[1],
>> +				(void __iomem *)&regs->v_pitch_uv);
>> +
>> +		writel_relaxed((win->ysrc << 16) | win->xsrc,
>> +				(void __iomem *)&regs->v_size);
>> +		writel_relaxed((win->ydst << 16) | win->xdst,
>> +				(void __iomem *)&regs->v_size_z);
>> +		writel_relaxed(win->ypos << 16 | win->xpos,
>> +				(void __iomem *)&regs->v_start);
>>  	} else {
>> -		writel_relaxed(win->pitch[0], &regs->g_pitch);
>> +		writel_relaxed(win->pitch[0], (void __iomem *)&regs->g_pitch);
>>  
>> -		writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->g_size);
>> -		writel_relaxed((win->ydst << 16) | win->xdst, &regs->g_size_z);
>> -		writel_relaxed(win->ypos << 16 | win->xpos, &regs->g_start);
>> +		writel_relaxed((win->ysrc << 16) | win->xsrc,
>> +				(void __iomem *)&regs->g_size);
>> +		writel_relaxed((win->ydst << 16) | win->xdst,
>> +				(void __iomem *)&regs->g_size_z);
>> +		writel_relaxed(win->ypos << 16 | win->xpos,
>> +				(void __iomem *)&regs->g_start);
>>  	}
>>  
>>  	dmafetch_set_fmt(overlay);
>> @@ -233,11 +240,11 @@ static int overlay_set_addr(struct mmp_o
>>  	memcpy(&overlay->addr, addr, sizeof(struct mmp_addr));
>>  
>>  	if (overlay_is_vid(overlay)) {
>> -		writel_relaxed(addr->phys[0], &regs->v_y0);
>> -		writel_relaxed(addr->phys[1], &regs->v_u0);
>> -		writel_relaxed(addr->phys[2], &regs->v_v0);
>> +		writel_relaxed(addr->phys[0], (void __iomem *)&regs->v_y0);
>> +		writel_relaxed(addr->phys[1], (void __iomem *)&regs->v_u0);
>> +		writel_relaxed(addr->phys[2], (void __iomem *)&regs->v_v0);
>>  	} else
>> -		writel_relaxed(addr->phys[0], &regs->g_0);
>> +		writel_relaxed(addr->phys[0], (void __iomem *)&regs->g_0);
>>  
>>  	return overlay->addr.phys[0];
>>  }
>> @@ -268,16 +275,18 @@ static void path_set_mode(struct mmp_pat
>>  	tmp |= dsi_rbswap & CFG_INTFRBSWAP_MASK;
>>  	writel_relaxed(tmp, ctrl_regs(path) + intf_rbswap_ctrl(path->id));
>>  
>> -	writel_relaxed((mode->yres << 16) | mode->xres, &regs->screen_active);
>> +	writel_relaxed((mode->yres << 16) | mode->xres,
>> +		(void __iomem *)&regs->screen_active);
>>  	writel_relaxed((mode->left_margin << 16) | mode->right_margin,
>> -		&regs->screen_h_porch);
>> +		(void __iomem *)&regs->screen_h_porch);
>>  	writel_relaxed((mode->upper_margin << 16) | mode->lower_margin,
>> -		&regs->screen_v_porch);
>> +		(void __iomem *)&regs->screen_v_porch);
>>  	total_x = mode->xres + mode->left_margin + mode->right_margin +
>>  		mode->hsync_len;
>>  	total_y = mode->yres + mode->upper_margin + mode->lower_margin +
>>  		mode->vsync_len;
>> -	writel_relaxed((total_y << 16) | total_x, &regs->screen_size);
>> +	writel_relaxed((total_y << 16) | total_x,
>> +		(void __iomem *)&regs->screen_size);
>>  
>>  	/* vsync ctrl */
>>  	if (path->output_type == PATH_OUT_DSI)
>> @@ -285,7 +294,7 @@ static void path_set_mode(struct mmp_pat
>>  	else
>>  		vsync_ctrl = ((mode->xres + mode->right_margin) << 16)
>>  					| (mode->xres + mode->right_margin);
>> -	writel_relaxed(vsync_ctrl, &regs->vsync_ctrl);
>> +	writel_relaxed(vsync_ctrl, (void __iomem *)&regs->vsync_ctrl);
>>  
>>  	/* set pixclock div */
>>  	sclk_src = clk_get_rate(path_to_ctrl(path)->clk);
>> @@ -366,9 +375,9 @@ static void path_set_default(struct mmp_
>>  	writel_relaxed(dma_ctrl1, ctrl_regs(path) + dma_ctrl(1, path->id));
>>  
>>  	/* Configure default register values */
>> -	writel_relaxed(0x00000000, &regs->blank_color);
>> -	writel_relaxed(0x00000000, &regs->g_1);
>> -	writel_relaxed(0x00000000, &regs->g_start);
>> +	writel_relaxed(0x00000000, (void __iomem *)&regs->blank_color);
>> +	writel_relaxed(0x00000000, (void __iomem *)&regs->g_1);
>> +	writel_relaxed(0x00000000, (void __iomem *)&regs->g_start);
>>  
>>  	/*
>>  	 * 1.enable multiple burst request in DMA AXI
>> Index: b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
>> ===================================================================
>> --- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
>> +++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
>> @@ -1393,7 +1393,7 @@ struct mmphw_ctrl {
>>  	/* platform related, get from config */
>>  	const char *name;
>>  	int irq;
>> -	void *reg_base;
>> +	void __iomem *reg_base;
>>  	struct clk *clk;
>>  
>>  	/* sys info */
>> @@ -1429,7 +1429,7 @@ static inline struct mmphw_ctrl *overlay
>>  	return path_to_ctrl(overlay->path);
>>  }
>>  
>> -static inline void *ctrl_regs(struct mmp_path *path)
>> +static inline void __iomem *ctrl_regs(struct mmp_path *path)
>>  {
>>  	return path_to_ctrl(path)->reg_base;
>>  }
>> @@ -1438,11 +1438,11 @@ static inline void *ctrl_regs(struct mmp
>>  static inline struct lcd_regs *path_regs(struct mmp_path *path)
>>  {
>>  	if (path->id == PATH_PN)
>> -		return (struct lcd_regs *)(ctrl_regs(path) + 0xc0);
>> +		return (struct lcd_regs __force *)(ctrl_regs(path) + 0xc0);
>>  	else if (path->id == PATH_TV)
>> -		return (struct lcd_regs *)ctrl_regs(path);
>> +		return (struct lcd_regs __force  *)ctrl_regs(path);
>>  	else if (path->id == PATH_P2)
>> -		return (struct lcd_regs *)(ctrl_regs(path) + 0x200);
>> +		return (struct lcd_regs __force *)(ctrl_regs(path) + 0x200);
>>  	else {
>>  		dev_err(path->dev, "path id %d invalid\n", path->id);
>>  		BUG_ON(1);
>> Index: b/drivers/video/fbdev/mmp/hw/mmp_spi.c
>> ===================================================================
>> --- a/drivers/video/fbdev/mmp/hw/mmp_spi.c
>> +++ b/drivers/video/fbdev/mmp/hw/mmp_spi.c
>> @@ -31,7 +31,7 @@ static inline int lcd_spi_write(struct s
>>  {
>>  	int timeout = 100000, isr, ret = 0;
>>  	u32 tmp;
>> -	void *reg_base =
>> +	void __iomem *reg_base = (void __iomem *)
>>  		*(void **)spi_master_get_devdata(spi->master);
>>  
>>  	/* clear ISR */
>> @@ -80,7 +80,7 @@ static inline int lcd_spi_write(struct s
>>  
>>  static int lcd_spi_setup(struct spi_device *spi)
>>  {
>> -	void *reg_base =
>> +	void __iomem *reg_base = (void __iomem *)
>>  		*(void **)spi_master_get_devdata(spi->master);
>>  	u32 tmp;
>>  
>> @@ -146,7 +146,7 @@ int lcd_spi_register(struct mmphw_ctrl *
>>  		return -ENOMEM;
>>  	}
>>  	p_regbase = spi_master_get_devdata(master);
>> -	*p_regbase = ctrl->reg_base;
>> +	*p_regbase = (void __force *)ctrl->reg_base;
>>  
>>  	/* set bus num to 5 to avoid conflict with other spi hosts */
>>  	master->bus_num = 5;
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
