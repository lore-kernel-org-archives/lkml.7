Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EA8C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202F32085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pHXCTvsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgACLwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:52:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48615 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbgACLwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:52:14 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200103115213euoutp0253d8a66167367cd7e635a31a6fa86259~mXjxrGicl0840608406euoutp02D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 11:52:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200103115213euoutp0253d8a66167367cd7e635a31a6fa86259~mXjxrGicl0840608406euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578052333;
        bh=8jQ3cuY/d6Z486X1G8DpwlnkzTMBLHNOXBERyHou3ts=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pHXCTvswi5JlVzne7Q0mPt3WJT7nxDEliLsgaCero1S/h77s7C37aqebVm4sPf6b/
         F++7cPzfxOUIeozTstQ/rSviEn6pdmSMqK76ZHdMcoEAsVbWA3elie2/aLcw0NYUOu
         6PFR7kks0xnCs9kPe23RfMSUj35r4s+0NuOhdnN0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200103115212eucas1p240ddd5874883e732e51c03a3170a8883~mXjxeLgvs0464504645eucas1p2D;
        Fri,  3 Jan 2020 11:52:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AD.84.60679.CEA2F0E5; Fri,  3
        Jan 2020 11:52:12 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200103115212eucas1p2052ad4c8d2a460c664aae681174a05a2~mXjxMCEKe0464504645eucas1p2C;
        Fri,  3 Jan 2020 11:52:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200103115212eusmtrp186b67c7e9aad7971cc13821b70b86841~mXjxLUe3K1010210102eusmtrp1_;
        Fri,  3 Jan 2020 11:52:12 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-e6-5e0f2aec937f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5F.C1.07950.CEA2F0E5; Fri,  3
        Jan 2020 11:52:12 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200103115211eusmtip20fe8bea92566f1374eaa31f71f8f92fa~mXjwo8bFN2156621566eusmtip2q;
        Fri,  3 Jan 2020 11:52:11 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] fbdev: fbmem: allow overriding the number of
 bootup logos
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <125aee26-ad81-163e-eedb-7e772d802a22@samsung.com>
Date:   Fri, 3 Jan 2020 12:52:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827110854.12574-3-peda@axentia.se>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87pvtPjjDNrPa1s8OdDOaHHl63s2
        i2e39jJZLGxbwmJxou8Dq8XlXXPYLPYems9o8fvHHDYHDo9pB2aze2xeoeVx6HAHo8f97uNM
        Hov7JrN6fN4kF8AWxWWTkpqTWZZapG+XwJVxcs9XxoJtMhXv1j5hbGB8KNbFyMkhIWAi8etJ
        G0sXIxeHkMAKRolbXQvYIZwvjBLdlzsZIZzPjBIr1x9hhWm58WwNE0RiOaPEofv7WCGct0D9
        7++wg1QJC4RLPLzxnRnEFhFQlFiwaxYzSBGzwE8mif61p5hAEmwCVhIT21cB7eDg4BWwk5j3
        0AAkzCKgIjFv6UKwElGBCIlPDw6DbeYVEJQ4OfMJC4jNKWAqsW1FP1gNs4C4xK0n86FseYnt
        b+eA7ZIQOMUu8ePMVxaIs10kpqzfwwxhC0u8Or6FHcKWkTg9uYcFomEdo8TfjhdQ3dsZJZZP
        /scGUWUtcefcLzaQS5kFNCXW79KHCDtKzP90EywsIcAnceOtIMQRfBKTtk1nhgjzSnS0CUFU
        q0lsWLaBDWZt186VzBMYlWYheW0WkndmIXlnFsLeBYwsqxjFU0uLc9NTi43yUsv1ihNzi0vz
        0vWS83M3MQIT0+l/x7/sYNz1J+kQowAHoxIPb4Iyf5wQa2JZcWXuIUYJDmYlEd7yQN44Id6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhg9Ht19cnzjcaXd
        9swMHuU8m9vrHk1J2Wlz/2jx/CXKAqqTN8+YsZDhO+vK0Lq3hhd1e9zv5W499sMx4kxBZkWe
        p2vSmguuh59avFVwmmHEt+REnoC1U2v7F36v12d6WO+7ri7smbVuiVzj7Jz3yi8Fjv3Qua3V
        KhWz+8zyPh4xC+nqYP73OqxKLMUZiYZazEXFiQCRB7s4SAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7pvtPjjDJ5tFrd4cqCd0eLK1/ds
        Fs9u7WWyWNi2hMXiRN8HVovLu+awWew9NJ/R4vePOWwOHB7TDsxm99i8Qsvj0OEORo/73ceZ
        PBb3TWb1+LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUn
        syy1SN8uQS/j5J6vjAXbZCrerX3C2MD4UKyLkZNDQsBE4sazNUxdjFwcQgJLGSW+HdjN3sXI
        AZSQkTi+vgyiRljiz7UuNhBbSOA1o8TmC/YgtrBAuMTDG9+ZQWwRAUWJBbtmMYPMYRb4zSQx
        feF7doihmxklLvz8ww5SxSZgJTGxfRUjyAJeATuJeQ8NQMIsAioS85YuZAKxRQUiJA7vmMUI
        YvMKCEqcnPmEBcTmFDCV2LaiH6yGWUBd4s+8S8wQtrjErSfzoeLyEtvfzmGewCg0C0n7LCQt
        s5C0zELSsoCRZRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgFG479nPLDsaud8GHGAU4GJV4
        eDkU+eOEWBPLiitzDzFKcDArifCWB/LGCfGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MEHk
        lcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgjOVp7gl3mS43jblt
        v2G6EHPdAqvvFxpE+zm4pU5bsackzYnZ6OnE/d78dWJVV8ssRlXZyc8Ps9qZFOZ2bUoM3zZR
        he1DAJts4Rv+2/f05nl1vnj36Ojq5UlMQpW16lVin6TftrGw7foheeNQve9v9sMlE3WO8zY9
        f3A7a2/zsgcxmoLf/WqUWIozEg21mIuKEwFrmTjb2AIAAA==
X-CMS-MailID: 20200103115212eucas1p2052ad4c8d2a460c664aae681174a05a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190827110929epcas2p215cddf4dc991560026f7eda688d46c46
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190827110929epcas2p215cddf4dc991560026f7eda688d46c46
References: <20190827110854.12574-1-peda@axentia.se>
        <CGME20190827110929epcas2p215cddf4dc991560026f7eda688d46c46@epcas2p2.samsung.com>
        <20190827110854.12574-3-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/27/19 1:09 PM, Peter Rosin wrote:
> Probably most useful if you want no logo at all, or if you only want one
> logo regardless of how many CPU cores you have.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  Documentation/fb/fbcon.rst       |  5 +++++
>  drivers/video/fbdev/core/fbcon.c |  7 +++++++
>  drivers/video/fbdev/core/fbmem.c | 12 +++++++++---
>  include/linux/fb.h               |  1 +
>  4 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
> index 65ba40255137..e57a3d1d085a 100644
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@ -174,6 +174,11 @@ C. Boot options
>  	displayed due to multiple CPUs, the collected line of logos is moved
>  	as a whole.
>  
> +9. fbcon=logo-count:<n>
> +
> +	The value 'n' overrides the number of bootup logos. 0 disables the
> +	logo, and -1 gives the default which is the number of online CPUs.
> +
>  C. Attaching, Detaching and Unloading
>  
>  Before going on to how to attach, detach and unload the framebuffer console, an
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index c9235a2f42f8..bb6ae995c2e5 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -536,6 +536,13 @@ static int __init fb_console_setup(char *this_opt)
>  				fb_center_logo = true;
>  			continue;
>  		}
> +
> +		if (!strncmp(options, "logo-count:", 11)) {
> +			options += 11;
> +			if (*options)
> +				fb_logo_count = simple_strtol(options, &options, 0);
> +			continue;
> +		}
>  	}
>  	return 1;
>  }
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 64dd732021d8..c7ddcb72025b 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -56,6 +56,8 @@ EXPORT_SYMBOL(num_registered_fb);
>  bool fb_center_logo __read_mostly;
>  EXPORT_SYMBOL(fb_center_logo);
>  
> +int fb_logo_count __read_mostly = -1;
> +
>  static struct fb_info *get_fb_info(unsigned int idx)
>  {
>  	struct fb_info *fb_info;
> @@ -620,7 +622,7 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
>  	memset(&fb_logo, 0, sizeof(struct logo_data));
>  
>  	if (info->flags & FBINFO_MISC_TILEBLITTING ||
> -	    info->fbops->owner)
> +	    info->fbops->owner || !fb_logo_count)
>  		return 0;
>  
>  	if (info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
> @@ -686,10 +688,14 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
>  
>  int fb_show_logo(struct fb_info *info, int rotate)
>  {
> +	unsigned int count;
>  	int y;
>  
> -	y = fb_show_logo_line(info, rotate, fb_logo.logo, 0,
> -			      num_online_cpus());
> +	if (!fb_logo_count)
> +		return 0;
> +
> +	count = fb_logo_count < 0 ? num_online_cpus() : fb_logo_count;
> +	y = fb_show_logo_line(info, rotate, fb_logo.logo, 0, count);
>  	y = fb_show_extra_logos(info, y, rotate);
>  
>  	return y;
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 303771264644..e37f72b2efca 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -630,6 +630,7 @@ extern int fb_new_modelist(struct fb_info *info);
>  extern struct fb_info *registered_fb[FB_MAX];
>  extern int num_registered_fb;
>  extern bool fb_center_logo;
> +extern int fb_logo_count;
>  extern struct class *fb_class;
>  
>  #define for_each_registered_fb(i)		\
> 
