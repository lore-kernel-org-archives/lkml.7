Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D699AC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B2220863
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfEUHAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:00:55 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:47279 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbfEUHAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:00:55 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 May 2019 03:00:54 EDT
Received: from erd987 (erd987.prtnl [192.168.237.3])
        by sparta (Postfix) with ESMTP id 1FD2344A00B2;
        Tue, 21 May 2019 08:56:16 +0200 (CEST)
Date:   Tue, 21 May 2019 08:55:47 +0200
From:   Robin van der Gracht <robin@protonic.nl>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     miguel.ojeda.sandonis@gmail.com, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH 2/2] auxdisplay/ht16k33.c: Convert to use
 vm_map_pages_zero()
Message-ID: <20190521085547.58e1650c@erd987>
In-Reply-To: <1558366258-3808-1-git-send-email-jrdr.linux@gmail.com>
References: <1558366258-3808-1-git-send-email-jrdr.linux@gmail.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 21:00:58 +0530
Souptick Joarder <jrdr.linux@gmail.com> wrote:

> While using mmap, the incorrect value of length and vm_pgoff are
> ignored and this driver go ahead with mapping fbdev.buffer
> to user vma.
> 
> Convert vm_insert_pages() to use vm_map_pages_zero(). We could later
> "fix" these drivers to behave according to the normal vm_pgoff
> offsetting simply by removing the _zero suffix on the function name
> and if that causes regressions, it gives us an easy way to revert.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/auxdisplay/ht16k33.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> index 21393ec..9c0bb77 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -223,9 +223,9 @@ static int ht16k33_bl_check_fb(struct backlight_device *bl, struct fb_info *fi)
>  static int ht16k33_mmap(struct fb_info *info, struct vm_area_struct *vma)
>  {
>  	struct ht16k33_priv *priv = info->par;
> +	struct page *pages = virt_to_page(priv->fbdev.buffer);
>  
> -	return vm_insert_page(vma, vma->vm_start,
> -			      virt_to_page(priv->fbdev.buffer));
> +	return vm_map_pages_zero(vma, &pages, 1);
>  }
>  
>  static struct fb_ops ht16k33_fb_ops = {

Acked-by: Robin van der Gracht <robin@protonic.nl>
