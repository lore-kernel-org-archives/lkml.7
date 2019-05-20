Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED92C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ED020675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8SLxhFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390641AbfETRSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:18:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41984 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390145AbfETRSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:18:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so15492859wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQbDIy8UjviDfDxju8ALldRPMrrWAP6vGdw+VPh2bvA=;
        b=s8SLxhFvvdMKyTPB9YXA6VjEISJQIeQ2sbCPiw41ijsXFpBkkeO1Iy6BLIWvRCh+Uq
         R9KL1585aPQpNYdH3/vXFkkT19vEhBU+3z8dTobrQuqNnbtNw5SrKgPOQv1ZOzdQmchG
         edkrSf+d0iyAl3LmhWVIyG92wtFW9Yugs67YqDSsBj6IdqfRpbXdt+rAFLzq/RPmqV0a
         6Kr7byYJW9OruxPq6yqQmEV0XkQZtNSVtrDO9YtatlDEZK4Sl4ndqbR7YO3FzVv0UUaH
         9k/SyZtIYUFkP9bDhFxPpcnhQj9HpeM6+agMKMwGHIUaSzEUYgJ16hfKpHDEfXS38759
         +ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQbDIy8UjviDfDxju8ALldRPMrrWAP6vGdw+VPh2bvA=;
        b=nDQ1HLzcNj5rbF9V4VsA15sFxgbr9elSm43zw07lvna0dEqLKo/sxiZI6GbsGyAo+8
         ztmWzMH4VE3pNKYb2VrvGFkFwG8AVt4BWpV1oyvsAMDgto3A1b5qdyKOTJdkjYRkhNW7
         j9hBNefuGGvbb2UnI2YZw6ypmdokl4TGLvAQKomA4VcsQap48nUZTzFgxavq86IOr6ty
         lqTa7DW0jGrb+6nDl/Gj3ZWI8kHJUcQiK6+yqA+HHp65Yx9M8BZcYm3JgziBPNWnmdFv
         gJKoasWrfVjuszG7qBNvps/lXb/ZOrOHxxpXiHRtcEGjA+sdS0pMwS5jS1J0hesdWJzJ
         mP9Q==
X-Gm-Message-State: APjAAAWqs8j5t92/38+VJqIVXQVB0ReN29r7HQsAshus43a3hQbeJQYu
        HNZsemDl5mEPNn0BdYEe7ge4yQlI3e5Ii8VJE6Y=
X-Google-Smtp-Source: APXvYqxI7bGtQgHqVry3QKsocdaEEQXUxiplX99tuHTRPLmGsC32Ze8R94RVDLoM2a9g1r5b+ZnniOJSSxPynslqqGE=
X-Received: by 2002:adf:cd11:: with SMTP id w17mr13496033wrm.83.1558372733581;
 Mon, 20 May 2019 10:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190518134141.23214-1-houweitaoo@gmail.com>
In-Reply-To: <20190518134141.23214-1-houweitaoo@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 20 May 2019 13:18:40 -0400
Message-ID: <CADnq5_OURX-qSsendCS9qOfi1CoWUK9BV9HJgTkFzB87bgjMmA@mail.gmail.com>
Subject: Re: [PATCH] gpu: fix typos in code comments
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        "Daenzer, Michel" <michel.daenzer@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Ken Chalmers <ken.chalmers@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 1:04 PM Weitao Hou <houweitaoo@gmail.com> wrote:
>
> fix eror to error
>
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index f70437aae8e0..df422440845b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -183,8 +183,8 @@ static bool calculate_fb_and_fractional_fb_divider(
>  *RETURNS:
>  * It fills the PLLSettings structure with PLL Dividers values
>  * if calculated values are within required tolerance
> -* It returns   - true if eror is within tolerance
> -*              - false if eror is not within tolerance
> +* It returns   - true if error is within tolerance
> +*              - false if error is not within tolerance
>  */
>  static bool calc_fb_divider_checking_tolerance(
>                 struct calc_pll_clock_source *calc_pll_cs,
> --
> 2.18.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
