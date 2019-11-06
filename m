Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA557C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02B8222C9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kjeez8xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbfKFRYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:24:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42761 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbfKFRYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:24:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id q17so2138642pgt.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=12yzcHf1qZ16w0lmbe/z8YOyijtRMnml2sd6alF7R5E=;
        b=Kjeez8xg9w1G0Sz1XNlqaJiqB+5U+nf27WRtq9ESx/wrXx9XWIlBYGf3N+a1s30Lqf
         PO9E2S/zhEHf1DsS35YdbMoLwH66sXNTBbln/nDtH4nNulV3cDyG24+euda4cLAG+myE
         aM2/vQI5JXoWUGhG8qnNOmPeigi3l2obzYdKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=12yzcHf1qZ16w0lmbe/z8YOyijtRMnml2sd6alF7R5E=;
        b=S6u5gb/CpY14+rKzSv708SzwdLlQ7kLFxOS3m4hgrR1cRzFYs+dtsbMuVQhXaslEGM
         vt19VV36gIOEdiIykTvT65AmeeflKozAEzo+OWz32nejMptfJwr1BtHlEQXmr9XbeAlj
         zEMwqMWpQa3KIJNwbS6cAZCMf9Q9KRmAgGRFiR8SuIH5hCu4PD0NyUUpjHNUDjKoDPZw
         JH5aMmv/nhTujWI7fHso6sWayKO7fe7ZNYIBOP0TFsvywyvz2jrVS1JkVAVVrVJEypIa
         QE+qiKO8VHW1d7oXdf0hdf0Rwn7HEhp22r7XiutVBeWU/IzdT5E/1k8n8Is9xKbB80Al
         w7xA==
X-Gm-Message-State: APjAAAW96e0VBCIC26NRIJgDMHxmbqFHPIn70YQmRtjJZyl0WmmIOmvs
        afXbk0vv0Pd6UHyyipK9cfjUcw==
X-Google-Smtp-Source: APXvYqy7xuqTPQAOe29RalAbDCQZWFanMlY7Ggk5BBqItrUCBBl297x/gKwCqPK8O48UCRtYXi9sLw==
X-Received: by 2002:a63:9a09:: with SMTP id o9mr4197481pge.276.1573061060339;
        Wed, 06 Nov 2019 09:24:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7sm3606496pjz.12.2019.11.06.09.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 09:24:19 -0800 (PST)
Date:   Wed, 6 Nov 2019 09:24:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] drm: Limit to INT_MAX in create_blob ioctl
Message-ID: <201911060920.71D7E76E@keescook>
References: <20191106164755.31478-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106164755.31478-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 05:47:55PM +0100, Daniel Vetter wrote:
> The hardened usercpy code is too paranoid ever since:
> 
> commit 6a30afa8c1fbde5f10f9c584c2992aa3c7f7a8fe
> Author: Kees Cook <keescook@chromium.org>
> Date:   Wed Nov 6 16:07:01 2019 +1100
> 
>     uaccess: disallow > INT_MAX copy sizes
> 
> Code itself should have been fine as-is.

I had to go read the syzbot report to understand what was actually being
fixed here. Can you be a bit more verbose in this commit log? It sounds
like huge usercopy sizes were allowed by drm (though I guess they would
fail gracefully in some other way?) but after 6a30afa8c1fb, the copy
would yell about sizes where INT_MAX < size < ULONG_MAX - sizeof(...) ?

What was the prior failure mode that made the existing ULONG_MAX check
safe? Your patch looks fine, though:

Reviewed-by: Kees Cook <keescook@chromium.org>

> Reported-by: syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com
> Fixes: 6a30afa8c1fb ("uaccess: disallow > INT_MAX copy sizes")
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> --
> Kees/Andrew,
> 
> Since this is -mm can I have a stable sha1 or something for
> referencing? Or do you want to include this in the -mm patch bomb for
> the merge window?

Traditionally these things live in akpm's tree when they are fixes for
patches in there. I have no idea how the Fixes tags work in that case,
though...

-Kees

> -Daniel
> ---
>  drivers/gpu/drm/drm_property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
> index 892ce636ef72..6ee04803c362 100644
> --- a/drivers/gpu/drm/drm_property.c
> +++ b/drivers/gpu/drm/drm_property.c
> @@ -561,7 +561,7 @@ drm_property_create_blob(struct drm_device *dev, size_t length,
>  	struct drm_property_blob *blob;
>  	int ret;
>  
> -	if (!length || length > ULONG_MAX - sizeof(struct drm_property_blob))
> +	if (!length || length > INT_MAX - sizeof(struct drm_property_blob))
>  		return ERR_PTR(-EINVAL);
>  
>  	blob = kvzalloc(sizeof(struct drm_property_blob)+length, GFP_KERNEL);
> -- 
> 2.24.0.rc2
> 

-- 
Kees Cook
