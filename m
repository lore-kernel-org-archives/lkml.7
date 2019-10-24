Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F19ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F166521655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OC7T25s1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501961AbfJXMjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:39:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33584 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJXMi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:38:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so17136138wro.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 05:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DJ9YPx7+n1PCdyUhZ2dP1UoOL9smelF9iCjqcb3ACuQ=;
        b=OC7T25s1P6P+UU4+3mI+CNjv0Ku6/AuM5iNGxza+4kgK+zIgYufjMaQgvJdsHJ8Sr2
         MdDenmU891PzzJpPKN6NhBcOOlQEtUQXxu/FPHDFBBC9FQrCVtbsXgxBELTZ6F5XC/ax
         nMpELi2hZ20KJDv3LvlzfxBVWH0CHLXa1ta0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DJ9YPx7+n1PCdyUhZ2dP1UoOL9smelF9iCjqcb3ACuQ=;
        b=bR0C9jg8ZFybzdyWx1jpjB0hxtxgKjAbC02z5NLajcZrMSygY2JmrBWLn5C0NeL8Xk
         Yik5oaAnc9vA3CpXsbtVt8DzVy8tC14HfiWydsQns8lZVGWhGvm9pKF8D1h7YDQbQtjq
         +ia5dChrxFZALZCQqk2Tfz6o/xyI7by5u4nJd0vOdSxoOI5gmSHYetTd8Fg1WjFwhaZf
         OJF+G/T6vzrPo1WmBZs6vcdFA34HPmApF9D3DuC7JNLGkwEgpI3M7Mc+3gvKSI6d5tuM
         q/aUqMCx/F2z9lBG34crl22ZD5CqqNC+GURIt6mBX3aYARuXivGaRzftyTvcnX4ZUEVm
         Tlag==
X-Gm-Message-State: APjAAAXBWhgSq9LYyPqXD42aHWZUnRY5/YBwZD62EE1no9YwLco87bWg
        fD8zHRrkh6rB8MdKBoIjNlCUGw==
X-Google-Smtp-Source: APXvYqzJz9HtesuNFtknXFUbo5uGWFpCON0/JuQdLXmV+NUQ5T2p0OSvCdnTHV2dFr2Z4sMGd+CjlQ==
X-Received: by 2002:adf:d190:: with SMTP id v16mr3844066wrc.64.1571920735886;
        Thu, 24 Oct 2019 05:38:55 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id l6sm2465278wmg.2.2019.10.24.05.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 05:38:54 -0700 (PDT)
Date:   Thu, 24 Oct 2019 14:38:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Colin King <colin.king@canonical.com>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Iago Toral Quiroga <itoral@igalia.com>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/v3d: fix double free of bin
Message-ID: <20191024123853.GH11828@phenom.ffwll.local>
Mail-Followup-To: Colin King <colin.king@canonical.com>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Iago Toral Quiroga <itoral@igalia.com>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191024104801.3122-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024104801.3122-1-colin.king@canonical.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 11:48:01AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Two different fixes have addressed the same memory leak of bin and
> this now causes a double free of bin.  While the individual memory
> leak fixes are fine, both fixes together are problematic.
> 
> Addresses-Coverity: ("Double free")
> Fixes: 29cd13cfd762 ("drm/v3d: Fix memory leak in v3d_submit_cl_ioctl")
> Fixes: 0d352a3a8a1f (" rm/v3d: don't leak bin job if v3d_job_init fails.")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

That sounds like wrong merge resolution somewhere, and we don't have those
patches merged together in any final tree yet anywhere. What's this based
on?
-Daniel

> ---
>  drivers/gpu/drm/v3d/v3d_gem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 549dde83408b..37515e47b47e 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -568,7 +568,6 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>  		ret = v3d_job_init(v3d, file_priv, &bin->base,
>  				   v3d_job_free, args->in_sync_bcl);
>  		if (ret) {
> -			kfree(bin);
>  			v3d_job_put(&render->base);
>  			kfree(bin);
>  			return ret;
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
