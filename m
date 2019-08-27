Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF16C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309452053B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5TOl98i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfH0SCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:02:40 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45305 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0SCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:02:39 -0400
Received: by mail-yb1-f196.google.com with SMTP id u32so8528154ybi.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 11:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XR6/sqrx3cd2fMLsbifvUJ8ua+YMdiSTj/B5AHiQ/oo=;
        b=I5TOl98iut1jtvrrC0COedDbhwBOFmzUo6dIk8ajzgy6yhTjI8CfubfiZQcp94YzPR
         0YeziR8YP3Qi8QhuHV6XEzVgPFK7+kM4a8Q0+5an/Q+UQjDRQOVspbzmmt4B9XE9wFck
         UKwfqXUYhDvuDFZLRCpm31LM6XIUgzLVJKbQBsL5Pfc+Vu3Xqo/flnIugVNJQI7nOsX6
         uBdXhkB4DmMIP7dwvhYAY+fUS+9FLRbD0HMyj3/Aw6ca+Sq8HynGTxHLTeoygY1pjsg2
         wSTZA2c6IG5PLwnNU2Zlgnr5w0RQlIK3W1Gc84n51/pm74QCrV8d2OPgRRJjxDwp0Tj7
         cI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XR6/sqrx3cd2fMLsbifvUJ8ua+YMdiSTj/B5AHiQ/oo=;
        b=HBRhp1Wex8TW5wCo2HDTyxWqSroC9ZNeBOYi1qKMDkrfvmwinzIJneaJdamQBQ8Ssg
         mel74LjKLF2jRZ8p79mOL56R2COcXjSc2A+0n1bgZhdNJNiyP4d0u2Vn6JOBlCaAqo21
         bXXnyf6f+y88OwW0gxnwZJXzAA8UoxI27qk6DSDGvKNpUzlzxbuVMuxLBPHHV5XIom45
         767Kpy0DnGvvpJgNc0seV7Oky9C24wq/5D8bEYHZWEa0IYILKg5+zi33wccjoKp2VbiN
         nbyRE+byrbSTNGXSJ67meVIQ7FFgr1qlaCeKDlc4TydL6TtLIgjU7a+7Qh89spnf3cvz
         uWiA==
X-Gm-Message-State: APjAAAWNP3/EBwB2nQEvBTwRsNCgFl53G1P8Row1X2yGDHnN5giPG/cL
        63QWnWQoO+d3rYOiRvI8doXEMZpXL4qOm4a9LKo=
X-Google-Smtp-Source: APXvYqxd6NcDOYtY7Ak3XIp6fVqXbHG9XSq7Jyq7V1p+lifxpjKe5DCXK3UfYi6O9dmpCKvle1L+kvbJoVRQ2HYcryQ=
X-Received: by 2002:a25:bec5:: with SMTP id k5mr33069ybm.259.1566928958725;
 Tue, 27 Aug 2019 11:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190827162924.88524-1-rrangel@chromium.org>
In-Reply-To: <20190827162924.88524-1-rrangel@chromium.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 27 Aug 2019 14:02:18 -0400
Message-ID: <CADnq5_ME=erztEhDhW5Z2RYr7kpMT_OOHm2xyJDPGd8a2d3LuA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix struct init in update_bounding_box
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 1:33 PM Raul E Rangel <rrangel@chromium.org> wrote:
>
> dcn20_resource.c:2636:9: error: missing braces around initializer [-Werror=missing-braces]
>   struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {0};
>          ^
>
> Fixes: 7ed4e6352c16f ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
>
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index b949e202d6cb..d8dd99bfa275 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -2633,7 +2633,7 @@ static void cap_soc_clocks(
>  static void update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb,
>                 struct pp_smu_nv_clock_table *max_clocks, unsigned int *uclk_states, unsigned int num_states)
>  {
> -       struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {0};
> +       struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {};

I think it would be better to just use a memset.  Different compilers
seems to do the wrong thing with these sort of initializations.

Alex

>         int i;
>         int num_calculated_states = 0;
>         int min_dcfclk = 0;
> --
> 2.23.0.187.g17f5b7556c-goog
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
