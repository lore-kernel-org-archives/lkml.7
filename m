Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0EEC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B3C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4zAdL5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfD2T33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:29:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40927 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2T33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:29:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id h11so718987wmb.5;
        Mon, 29 Apr 2019 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fu7eQcZhZjRVoS/wShHhIhqTGtzVNJ/jmSgibktML2U=;
        b=I4zAdL5oLAq22/O4l+6TyiatsNqlUcugaPuIZ8lUjmkSdeO4pv0veAUfHNWKpU5Gu8
         yqv+bgqqESmsfkKJzMuWdOZJac/gNZPvCO/Gj9yniMMtbJF0HTVEjKOQzdWE5Zi6T0Hh
         HYj+qHzm6wx03A5YrF4w0Gd9vdA6YBhMtgGndHOlIeRUUpJrhsd0o0Hu6Cghx1jjxjYd
         SHCnv7/WgoksixJzUhtR1U2tcOMukCOD4fQ/UiY+rp/UXhhQllrEGmSIR6VyXi4F6zEw
         7IUUzuZo80SN0teniLcVD1HkyBf3SsenocxNHx9EZbaL7jt2UG7zFMWTiuJ8tgzZ1FwL
         oN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fu7eQcZhZjRVoS/wShHhIhqTGtzVNJ/jmSgibktML2U=;
        b=icq8cRQUK/WBDq7cIi/JuwpXULLL1xE6Mlj4thWu2gNihCk8rhvVqfxLlf/LX01UOg
         rpka5x0ZdaZC0OIbIXFpK3JcdnO7+wQTwN20KbLqxE8iyDNuNCTn1Fhgzz6GzSCWofn5
         UWNhkOtDsf8xlC9IRXAjsPcRpDwgvltMr5Uq5uxYI1wnSSMV7xBGjFdiSL5EjHtswhUC
         RoIJGJHL1Ac9HWrBYHoT+l2Fq8W3fBbzGdVMb7Wt73+PFJc0peW3oi5S0Lg6Pob+fgjD
         Scduj8F8Hsr9tEuf8p+e3so6eqlyzZQUxNriDywcdJmuDHmTmbBPGYuVVE2B1CwaW5qv
         tc5w==
X-Gm-Message-State: APjAAAVAN4Xgu1jM6rLPoJl+yRAd0IhE6CGlsLCtYh9eDnjOm9vaLuv5
        CT/0oEFrjATqUL7bqxeGzffFM/XjcpRgJQa3Ay/elqy8
X-Google-Smtp-Source: APXvYqy6SvYqmyecCCwULfVSMylZ+b9+WddC1smsVpRCtxfgUCHspjfmenMrxifEgdCKsO2TZEA1HZZSzL2uy/nr8Q4=
X-Received: by 2002:a1c:2e89:: with SMTP id u131mr477818wmu.82.1556566167084;
 Mon, 29 Apr 2019 12:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190426214811.12310-1-colin.king@canonical.com>
In-Reply-To: <20190426214811.12310-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 29 Apr 2019 15:29:14 -0400
Message-ID: <CADnq5_PwaZkbQ24vO=zi4HvMXTjayUKV3mnTiBt6X9AV=fXEBg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix incorrect null check on pointer
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
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

On Fri, Apr 26, 2019 at 5:48 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently an allocation is being made but the allocation failure
> check is being performed on another pointer. Fix this by checking
> the correct pointer. Also use the normal kernel idiom for null
> pointer checks.
>
> Addresses-Coverity: ("Resource leak")
> Fixes: 43e3ac8389ef ("drm/amd/display: Add function to copy DC streams")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index 6200df3edcd0..96e97d25d639 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -168,7 +168,7 @@ struct dc_stream_state *dc_copy_stream(const struct dc_stream_state *stream)
>         struct dc_stream_state *new_stream;
>
>         new_stream = kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
> -       if (stream == NULL)
> +       if (!new_stream)
>                 return NULL;
>
>         memcpy(new_stream, stream, sizeof(struct dc_stream_state));
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
