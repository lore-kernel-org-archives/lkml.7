Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DF1C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF6E20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QUoqhl67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgAHRff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:35:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55642 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgAHRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:35:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so3380758wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=qwg5hibFRVywSqJ0shEP5dA8R4/hDi63ijsidIVUsnI=;
        b=QUoqhl67fBgCPzU+SawnnCIxZ4VeUk3dj6RARmd4tvkb3zuVnoidILFVGwXsN5UE2I
         /F5RA4m/Ts5DWqtPY4fbEwVrFuGLvTj3ZvxdZY/KfsHA/92XiLTWNxlRvAT/l38OSrBg
         2KSwA4YLo8d/FXx89+AyH9Iiffz0+7TqE5dms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=qwg5hibFRVywSqJ0shEP5dA8R4/hDi63ijsidIVUsnI=;
        b=oP5Zv1aKM6bHJO4zT2T7lNAogu+og8/4GBU+XIQrF6TC3YqscAv0SZwi0Js1bcPCWg
         zvO/T+CcBUvwrx6+kaB54jC1dAogKFSenblXzLPDhx6tcqbpb4RtOWP4IJT7D4hSdAyG
         ijZvYCoA2qpYhR6co43K+dNBYb93K3o9kQIixSVroVxAi4JgPvxsqxHCSeL5ZHZcOgY6
         4wMa4HNvYX/SwC8bdT8licY/3nrocyaAE4xmBclW1+3Bfo0Kg7iwqwLJo46pjdUA8A+n
         q7Y3N3SV2+T2W5p2fZ3C7+KDIeSknfq8iCLteVlMN7eXglnIENGFcIn74FfosK9Eeq2B
         DCYw==
X-Gm-Message-State: APjAAAV7hacxu/E0rYNqD98cTsePeCNcCZ82qbk2hE1r+MhwArMUebFg
        5o//E2vGnvaNRSGJjM16APV1NQ==
X-Google-Smtp-Source: APXvYqzL8iJjlAP6Ht35NUvrFJlYJCBylU7frfkVj8GVw/wQ1xkS3qZdMpeM79IbBg2pFJtR30DPRQ==
X-Received: by 2002:a1c:a382:: with SMTP id m124mr5324133wme.90.1578504932671;
        Wed, 08 Jan 2020 09:35:32 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:564b:0:7567:bb67:3d7f:f863])
        by smtp.gmail.com with ESMTPSA id h17sm5044566wrs.18.2020.01.08.09.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 09:35:31 -0800 (PST)
Date:   Wed, 8 Jan 2020 18:35:29 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/omapdrm: use BUG_ON macro for error debugging.
Message-ID: <20200108173529.GG43062@phenom.ffwll.local>
Mail-Followup-To: Wambui Karuga <wambui.karugax@gmail.com>,
        tomi.valkeinen@ti.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200102095515.7106-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102095515.7106-1-wambui.karugax@gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 12:55:15PM +0300, Wambui Karuga wrote:
> Since the if statement only checks for the value of the `id` variable,
> it can be replaced by the more concise BUG_ON() macro for error
> reporting.
> Issue found using coccinelle.
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Tomi said he's ok with this landing in drm-misc-next on irc, so merged.
Thanks for your patch!
-Daniel

> ---
>  drivers/gpu/drm/omapdrm/dss/dispc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
> index 413dbdd1771e..dbb90f2d2ccd 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
> @@ -393,8 +393,7 @@ static void dispc_get_reg_field(struct dispc_device *dispc,
>  				enum dispc_feat_reg_field id,
>  				u8 *start, u8 *end)
>  {
> -	if (id >= dispc->feat->num_reg_fields)
> -		BUG();
> +	BUG_ON(id >= dispc->feat->num_reg_fields);
>  
>  	*start = dispc->feat->reg_fields[id].start;
>  	*end = dispc->feat->reg_fields[id].end;
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
