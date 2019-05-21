Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF93C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6DC21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfEUKxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:53:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:7619 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfEUKxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:53:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 03:53:07 -0700
X-ExtLoop1: 1
Received: from asaudi-mobl.ger.corp.intel.com (HELO [10.249.47.52]) ([10.249.47.52])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2019 03:53:00 -0700
Subject: Re: [PATCH 19/33] fbdev: unify unlink_framebufer paths
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Rosin <peda@axentia.se>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-20-daniel.vetter@ffwll.ch>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <f3d7a95e-358b-1181-7a62-ce364003a8d6@linux.intel.com>
Date:   Tue, 21 May 2019 12:52:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520082216.26273-20-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

^Typo in subject.

Op 20-05-2019 om 10:22 schreef Daniel Vetter:
> For some reasons the pm_vt_switch_unregister call was missing from the
> direct unregister_framebuffer path. Fix this.
>
> v2: fbinfo->dev is used to decided whether unlink_framebuffer has been
> called already. I botched that in v1. Make this all clearer by
> inlining __unlink_framebuffer.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> ---
>  drivers/video/fbdev/core/fbmem.c | 47 ++++++++++++++------------------
>  1 file changed, 20 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 032506576aa0..f059b0b1a030 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1714,15 +1714,30 @@ static void unbind_console(struct fb_info *fb_info)
>  	console_unlock();
>  }
>  
> -static void __unlink_framebuffer(struct fb_info *fb_info);
> -
> -static void do_unregister_framebuffer(struct fb_info *fb_info)
> +void unlink_framebuffer(struct fb_info *fb_info)
>  {
> -	unbind_console(fb_info);
> +	int i;
> +
> +	i = fb_info->node;
> +	if (WARN_ON(i < 0 || i >= FB_MAX || registered_fb[i] != fb_info))
> +		return;
> +
> +	if (!fb_info->dev)
> +		return;
> +
> +	device_destroy(fb_class, MKDEV(FB_MAJOR, i));
>  
>  	pm_vt_switch_unregister(fb_info->dev);
>  
> -	__unlink_framebuffer(fb_info);
> +	unbind_console(fb_info);
> +
> +	fb_info->dev = NULL;
> +}
> +EXPORT_SYMBOL(unlink_framebuffer);
> +
> +static void do_unregister_framebuffer(struct fb_info *fb_info)
> +{
> +	unlink_framebuffer(fb_info);
>  	if (fb_info->pixmap.addr &&
>  	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
>  		kfree(fb_info->pixmap.addr);
> @@ -1738,28 +1753,6 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
>  	put_fb_info(fb_info);
>  }
>  
> -static void __unlink_framebuffer(struct fb_info *fb_info)
> -{
> -	int i;
> -
> -	i = fb_info->node;
> -	if (WARN_ON(i < 0 || i >= FB_MAX || registered_fb[i] != fb_info))
> -		return;
> -
> -	if (fb_info->dev) {
> -		device_destroy(fb_class, MKDEV(FB_MAJOR, i));
> -		fb_info->dev = NULL;
> -	}
> -}
> -
> -void unlink_framebuffer(struct fb_info *fb_info)
> -{
> -	__unlink_framebuffer(fb_info);
> -
> -	unbind_console(fb_info);
> -}
> -EXPORT_SYMBOL(unlink_framebuffer);
> -
>  /**
>   * remove_conflicting_framebuffers - remove firmware-configured framebuffers
>   * @a: memory range, users of which are to be removed


