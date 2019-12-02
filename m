Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A4EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8802420684
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7chfm3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLBVjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:39:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35495 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfLBVjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:39:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so1151138wro.2;
        Mon, 02 Dec 2019 13:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UY7Cgt/HHbMQf0k0lCTcwkYlvT/3f+PbQ7R+5FrroJk=;
        b=s7chfm3+NiM53pTX/biaEdej5othUb91+knoYHrtDzVY329+Y3nrxfFjxX+3GOZVAZ
         0EMZOmm0Ve/WdcrRS185uvrmSh3kM1+G2/gblrr9/jYCwAgq0HAOc92+fHPC4hjaPjFz
         qtamQOzOUeazrRxUZ7sn2Xz/paAL28NH0tHbKyrNn6QDf2WArTa7HdslHaTb7HWlnVD9
         ljUhJZx+A0dvNxO7tCZ0Yv0OZ+NEZg7eJRattmzXHIOueHA2Qq4hrcToMME1dBuxKlVS
         qVgZXuX6Fp46I3jjCW/wTI+2wu1pz0g9p3D8b5wFwdb2nz8YkosfnP+whoSGGyvsOi7J
         bo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UY7Cgt/HHbMQf0k0lCTcwkYlvT/3f+PbQ7R+5FrroJk=;
        b=SuOeVlvK0xSkqluT1O/Sn1z4EnZiUyfWd4puv2SzX5LxDAptjr+TuJbp/UpPlvHUFb
         ktrbjT4SBQc+/2YKjqgD/cY2eBVFgihKOQ05khWnfBsn9/sgGtx7J+2tjqw9Ba/vWu/9
         EzlPQpJjeY1lL2ZOqGi4Jvbblb5OegXJBTnAhgobHEtQwI77A9pc6MgBw2DiLOeZDPID
         JWORD8DoQW+kynim80eo5049nYjrNTWvycJFvrS/4xwfyGZh2h7pHDTcpN7lsc/lNgem
         kmY/QWjEZIRo2D4uumH1cnfVPMHjJEKkezY1wmGf3fBVioGqS+vy16Yh7i/VIfTGbmRJ
         5RkQ==
X-Gm-Message-State: APjAAAUaD3JznQ3jTDGdQSmd1Ler7CPkdAUkXwtCdxRHqRSo/eIfX7yx
        2d/zLMSoiTa9SHsmiFpyupfm/dyAU/FhbMcxLqQ=
X-Google-Smtp-Source: APXvYqyPXuAHZoIz3Nn0IQ/EHpeMnI4NckHiE/hs2YARA1G052OhgZkNuyP7oXg26gFkZU7g4h3eUDBXwumPOYpu3uk=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr1239920wrs.11.1575322747719;
 Mon, 02 Dec 2019 13:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20191202154738.56812-1-colin.king@canonical.com>
In-Reply-To: <20191202154738.56812-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 2 Dec 2019 16:38:56 -0500
Message-ID: <CADnq5_Mtos36z7vp92ep4hQtW3KFeGb8EbWsGbhOGXJSebdVDA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove redundant assignment to variable v_total
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

Applied.  thanks!

Alex

On Mon, Dec 2, 2019 at 10:47 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable v_total is being initialized with a value that is never
> read and it is being updated later with a new value.  The initialization
> is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 16e69bbc69aa..fa57885503d4 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -122,7 +122,7 @@ static unsigned int calc_v_total_from_refresh(
>                 const struct dc_stream_state *stream,
>                 unsigned int refresh_in_uhz)
>  {
> -       unsigned int v_total = stream->timing.v_total;
> +       unsigned int v_total;
>         unsigned int frame_duration_in_ns;
>
>         frame_duration_in_ns =
> --
> 2.24.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
