Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52E3C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BFC2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kgfHvSRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfC1HrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:47:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37654 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfC1HrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:47:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id v21so16318563edq.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 00:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9mzbBif/k3CxFq/iNFPCaqY1M5SLNwtMDfAM4jh8TBY=;
        b=kgfHvSRjEiqnpQUitMhzlrgGG/RFWMEAMOJ9XHpo01TD8VhSViwcROvU9bxScR7m6W
         pjm9M4WYoDNuMLQUtIcoGiHQErYrbUf/ehJ3ufgqfNjaumDENjJAf4Aw7xPQAVMzZUBx
         kuKHRRaoLYsX6lrA8G1kRL3RsFw8q6qS70+zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9mzbBif/k3CxFq/iNFPCaqY1M5SLNwtMDfAM4jh8TBY=;
        b=BnGc82sxUdWDWRVSZweBckgDGRXEdZXuQy+iAu5mYrNEWnFEJW+l+DinlQhtJLOiZ2
         Ex8ZAsRPXWukQ3MLtq4r3xF9KKocSKHwV/0Pv57+Xk5nRls0TlHjY9/aKDMkN2CQxV0T
         E59VnQZ0uubAraoaNsON2VqOaQvO5CiaZS5yrQe+f5wtz6AVBcqEnXWJidD2USSjXYWC
         5thfCWK5168sH38PlYDptKSfJhcv6kznHGd7Qdyzf+DrH7Vh2Ke5GNjjlDHEjLKXRHA5
         jgWaIfvuVsr7KKYal7y0fVGdbE8v3PmdAFAKAYvXCWlYcInYU2cs5/C0B1Sh4VgBB3vU
         7qlQ==
X-Gm-Message-State: APjAAAWuSQpCFS6WYpquKTE2JjCoHq0RI6pFidPN1scIVcX6Gn2C6LH+
        8UHHiyv1nVxpzJlfJbu9hua0oivZHWk=
X-Google-Smtp-Source: APXvYqyoGenHthBUUGaATl9Gtz3bgHID4Lj+yZYRXH1ATEPl+dRL5W3Wel+lXzK/oLby7xItjb/4eQ==
X-Received: by 2002:a17:906:3c3:: with SMTP id c3mr22488595eja.181.1553759235760;
        Thu, 28 Mar 2019 00:47:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w24sm7753558edb.72.2019.03.28.00.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 00:47:14 -0700 (PDT)
Date:   Thu, 28 Mar 2019 08:47:12 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 14/68] vfs: Convert drm to use the new mount API
Message-ID: <20190328074712.GQ2665@phenom.ffwll.local>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        viro@zeniv.linux.org.uk, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
 <155373013865.7602.4323790421889477990.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155373013865.7602.4323790421889477990.stgit@warthog.procyon.org.uk>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:42:18PM +0000, David Howells wrote:
> Convert the drm filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
> 
> See Documentation/filesystems/mount_api.txt for more information.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: David Airlie <airlied@linux.ie>
> cc: Daniel Vetter <daniel@ffwll.ch>
> cc: dri-devel@lists.freedesktop.org

No clue about vfs, but feel free to merge through whatever tree this is
suitable for.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
> 
>  drivers/gpu/drm/drm_drv.c |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 381581b01d48..9eead5a478de 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -31,6 +31,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/mount.h>
> +#include <linux/fs_context.h>
>  #include <linux/slab.h>
>  #include <linux/srcu.h>
>  
> @@ -413,20 +414,17 @@ static const struct super_operations drm_fs_sops = {
>  	.statfs		= simple_statfs,
>  };
>  
> -static struct dentry *drm_fs_mount(struct file_system_type *fs_type, int flags,
> -				   const char *dev_name, void *data)
> +static int drm_fs_init_fs_context(struct fs_context *fc)
>  {
> -	return mount_pseudo(fs_type,
> -			    "drm:",
> -			    &drm_fs_sops,
> -			    &drm_fs_dops,
> -			    0x010203ff);
> +	return vfs_init_pseudo_fs_context(fc, "drm:",
> +					  &drm_fs_sops, NULL,
> +					  &drm_fs_dops, 0x010203ff);
>  }
>  
>  static struct file_system_type drm_fs_type = {
>  	.name		= "drm",
>  	.owner		= THIS_MODULE,
> -	.mount		= drm_fs_mount,
> +	.init_fs_context = drm_fs_init_fs_context,
>  	.kill_sb	= kill_anon_super,
>  };
>  
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
