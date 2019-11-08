Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0034C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67CB21848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPdcyNPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKHQfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:35:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50333 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfKHQfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:35:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id l17so6020177wmh.0;
        Fri, 08 Nov 2019 08:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdiR2KXB5KOv1vRWAi9zbSMhjMQO3TugKSv7PhltGHo=;
        b=FPdcyNPg3AHLlfW9P7emzQuQyIQgLbYD3jPmeXWi9VWB8W7Bd0blQ0eAy3u4laIYAP
         GfNV6rJMFtkXEJO4hYO/eMXN92Kbi0+TrbNdmlMRu78mu875Z6TLOvVU1esvQHXn2iiN
         rWHrHL4/j6ei3ZR2kDb1BvgVDiqc244PPRdTdt/2j//R5W6K4DVvQbo1N4Z1Tm9jMxt7
         wXrmGGP28Qccm2hj4Rf3SgmEYNZ43TZ5lZfY2Be/GN+NkrkOxujdCE1NMenaamTC9rWe
         76gTWwx3AIfz+qLAI1uoHqjH7PaiZnDa5fE1jRvr1Wyub2sRt8aBx1oFyuyTJBVt/b2y
         tUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdiR2KXB5KOv1vRWAi9zbSMhjMQO3TugKSv7PhltGHo=;
        b=iuKHHCOAARC996pOclNIgkABSDJbOCOp9HBEdCaeL3DTChT7pRbjRWNMFfCCnDJi9S
         OuzLr4/a7okCwNdikoBACSOjk4M5lRG+Br+YF6zGF5dK4MxqD5yqYD3qYx2vZ5OHzM7h
         UpqEl2VAcPoIN73hxRAt0/QNoLqNNa2lX3FvkaJlKTftIffjDq3DzM3a+3jK9SXythCk
         /CFqA0VPbv/PO6McjZgWVaElS4KF0UaetsrKJbui8WEC/NjNT1iasQBLyZ01nrrNSYxF
         7W3vQJ/GykzWWtL0g4Q1/ruoRc7khGiuJDa+oCfPTvKB8SDesWwwQSGExCvMQQzPeaIA
         IU1Q==
X-Gm-Message-State: APjAAAVBNifgUjSrJWOO/5LgtFxHCQsEBFFCpr7RMZ5mZocrFO6/B+lN
        j50a/vvkgK9Sa6e6hwNwRE6Lr3el2DX4Y+862Ns=
X-Google-Smtp-Source: APXvYqy79GaOiYFhmmdQPjwdGH/T4YJb7x2vCs27cZMUUrGqW4IIX1akQO5yVBzR1MBUYXToBBj0vgVl4kAlOJl4yXY=
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr9004173wmi.141.1573230897685;
 Fri, 08 Nov 2019 08:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20191108162945.180624-1-colin.king@canonical.com>
In-Reply-To: <20191108162945.180624-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Nov 2019 11:34:45 -0500
Message-ID: <CADnq5_NC1znSqvSUDkABAkb9VwAF9F1qdZ+JdRQZLMwoptjsDg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: remove redundant variable status
To:     Colin King <colin.king@canonical.com>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 11:29 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable status is redundant, it is being initialized with a value
> that is over-written later and this is being returned immediately
> after the assignment.  Clean up the code by removing status and
> just returning the value returned from the call to function
> dc->hwss.dmdata_status_done.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index 371d49e9b745..88a84bfaea6f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -565,7 +565,6 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
>
>  bool dc_stream_dmdata_status_done(struct dc *dc, struct dc_stream_state *stream)
>  {
> -       bool status = true;
>         struct pipe_ctx *pipe = NULL;
>         int i;
>
> @@ -581,8 +580,7 @@ bool dc_stream_dmdata_status_done(struct dc *dc, struct dc_stream_state *stream)
>         if (i == MAX_PIPES)
>                 return true;
>
> -       status = dc->hwss.dmdata_status_done(pipe);
> -       return status;
> +       return dc->hwss.dmdata_status_done(pipe);
>  }
>
>  bool dc_stream_set_dynamic_metadata(struct dc *dc,
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
