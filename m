Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61025C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C0120644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxZh6+94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEIOvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:51:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34230 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIOvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:51:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so3497148wrq.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NnIVSTbXkxS0yhKtK5Xl2+rccguXdwwJsXkxd/ssJco=;
        b=gxZh6+94YVMwo9tSjmQcnBR5/SHN/gMgGTviBNlpNv8ZSYHK6QRWULthr4xYwlzSkO
         i414W6PFW9Lhca7FNfRjJ4Lq8LaXbeOuHiFNdpkZwRzRDvorreq1lhUdvwZkD9Fk3Mze
         cWQhYZ7OGmivg9v+eOEHtTXxmzxuKJXmCSQDGc91mOX6i7DM2wtbpEThOXPc+OCSapt+
         mtQOhu87HRGuH9CLBh6LFi+cecMnGgRArya4MmFXuUNIeZckQNDqQWaS1JSKBA/NnyzR
         rTImp4xFd0zWOe7j4lCwL/60O7jgMp52Cgi5dTvfMAq6SY1P50CqFX18H51pjeB89XVT
         RtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NnIVSTbXkxS0yhKtK5Xl2+rccguXdwwJsXkxd/ssJco=;
        b=NTuTt823TdeVWsTbIshh4rx5k5yTt/edKSGtSU64VsSIGwJFqdWNx7B88Plso7dCnD
         p+QHt8Pz5I60umooAjiLdd8GjR7Wf5xd+2YNkuBI3nORpVB5vNVBpkfVMdT7eGG/38lN
         uWFSnyPD3EGQfPQMjiavSYjbGndDIqMP6CgQBCKhwxC1BPevHZCAwA/SHtWkmdrQYkx9
         ts8lX1NT+odXlgEUCHFeKTMdYfsASDKLEm84wvRwzgW1mS5cUiIgY/sA1J2rRgMjJfJ5
         20nKQ7ePSJebaPC1iANeTQC2p0chNxgel3yJV/MEKERIDeDcI9jJsXSQqld5q+fL26hF
         1bVQ==
X-Gm-Message-State: APjAAAWJJt0GM0WIZcYGHOCXD18FeCIPAIClcoGPAP7P9ix9VEMdvh/j
        TXroaiMlT3altTr7X4n+u9zMaAaIjcP8hv7/lQTOlg==
X-Google-Smtp-Source: APXvYqyw6AVan6W+w1LMEkfKYRd7eqcaBqO4NEiGhzTMOQ4FZpcP8d/2DdivQSG357GbKZTLP20eNWPdroaESd+DEno=
X-Received: by 2002:a5d:4b0b:: with SMTP id v11mr3401996wrq.317.1557413508636;
 Thu, 09 May 2019 07:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190508125516.16732-1-wanghai26@huawei.com>
In-Reply-To: <20190508125516.16732-1-wanghai26@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 9 May 2019 10:51:36 -0400
Message-ID: <CADnq5_NmbWQWjYe5DnGJAPh-uA6Fwi+xZ4FJq-tJWYDuXp6teg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Make some functions static
To:     Wang Hai <wanghai26@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        David Francis <David.Francis@amd.com>, Jun.Lei@amd.com,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 10:47 AM Wang Hai <wanghai26@huawei.com> wrote:
>
> Fix the following sparse warnings:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:483:21: warning: symbol 'dce120_clock_source_create' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:506:6: warning: symbol 'dce120_clock_source_destroy' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:513:6: warning: symbol 'dce120_hw_sequencer_create' was not declared. Should it be static?
>
> Fixes: b8fdfcc6a92c ("drm/amd/display: Add DCE12 core support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai26@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> index 312a0aebf91f..0948421219ef 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> @@ -458,7 +458,7 @@ static const struct dc_debug_options debug_defaults = {
>                 .disable_clock_gate = true,
>  };
>
> -struct clock_source *dce120_clock_source_create(
> +static struct clock_source *dce120_clock_source_create(
>         struct dc_context *ctx,
>         struct dc_bios *bios,
>         enum clock_source_id id,
> @@ -481,14 +481,14 @@ struct clock_source *dce120_clock_source_create(
>         return NULL;
>  }
>
> -void dce120_clock_source_destroy(struct clock_source **clk_src)
> +static void dce120_clock_source_destroy(struct clock_source **clk_src)
>  {
>         kfree(TO_DCE110_CLK_SRC(*clk_src));
>         *clk_src = NULL;
>  }
>
>
> -bool dce120_hw_sequencer_create(struct dc *dc)
> +static bool dce120_hw_sequencer_create(struct dc *dc)
>  {
>         /* All registers used by dce11.2 match those in dce11 in offset and
>          * structure
> --
> 2.17.1
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
