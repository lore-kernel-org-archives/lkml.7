Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5102DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221F4208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaYhnKDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbfISVxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:53:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34926 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733028AbfISVxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:53:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so78444wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 14:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LiC9VN7bT0DhZf+NDDCV4pCQeBnob2CMZdKYzKfRqZ0=;
        b=oaYhnKDkjDxXym+93Odu9FpUTOdlhuHb8kuDPqWfRctTObozWL0ag7B813jgRBMJOU
         +u3mGWZzJN/mkF0K6KgrVuOM3rg55ekWS+7yGes8kRYwShE/eytEz92+LrJ/h3FffDwa
         /uggRDfS1E2cFBiolgeYh2EH5Af7/LidAfakt3ONCkcoKEmZCJooaHR9hbrp/2n8/LQM
         eV4rh2I4HjOjhQ8Em6RJnd+HXP5i1UqEE2qw5+z3GIvJpVXSjW0/45FMoCvBoNgvi9rF
         geO8EweVTzW4EftTrhvaWaaTTw2PDU4RBy7t6CS/E3G7W2tG9U9NpeHDQf/d6nnglTfL
         UMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LiC9VN7bT0DhZf+NDDCV4pCQeBnob2CMZdKYzKfRqZ0=;
        b=tZIIDtB5wCZff4vONEqBF4uJf68Ytfcna2uWihBTy8WVd+LFIlQeLILj2UnXibnsBU
         9VJAhQVaxgmzLXk4EPbXUXrxPLtGADA74/+joCo+a/05bOV1mI1DKMh1Ra1cM20cGa24
         90yhjmZhlr4Pjr52zZcOHxMFjk8ycjYijUMtdOEZ6bOJk8cANT7poy70FxGKlcOc/gjH
         9gZDBplVW6KXA95FzB/AjhFoBWUXmiIIJD8KSAnkcjIO7Der4j37r9jehuTMRy7IAaxC
         339AF3im5ceyUrbc+BmZrjq+c+rMAS4DhRNqIcLF++gmTAb0dRm7LJPP4YOnFE1BBA2w
         RVZQ==
X-Gm-Message-State: APjAAAWQWylW7ozoU6CcyX7Vi8N/rGdHlaZv3g8AwmYV+sdYPlLWUf/m
        AzWnA6OBm3tV8axMP1NYwiJwHELnY3sUzbrUfMc=
X-Google-Smtp-Source: APXvYqzCZrQwLmXjxRuxnOhumLlCYo6qgQJXs/Z6uJi0aOfkJzfbJHNfp6YkfvlarLb0VyyjE0MnAkEX4K1sDTbMxxo=
X-Received: by 2002:a05:600c:54a:: with SMTP id k10mr29584wmc.127.1568929982740;
 Thu, 19 Sep 2019 14:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190828183758.11553-1-rrangel@chromium.org>
In-Reply-To: <20190828183758.11553-1-rrangel@chromium.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 19 Sep 2019 17:52:50 -0400
Message-ID: <CADnq5_PX852kyFtBX_caTfZyfW6agt90qWQ1m-csW37o-uNL6g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: fix struct init in update_bounding_box
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

On Wed, Aug 28, 2019 at 2:51 PM Raul E Rangel <rrangel@chromium.org> wrote:
>
> dcn20_resource.c:2636:9: error: missing braces around initializer [-Werror=missing-braces]
>   struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {0};
>          ^
> Fixes: 7ed4e6352c16f ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> So apparently `{}` is a gcc extension. The C standard requires at least
> one expression. So {{0}} is correct. I got a lint error about {{0}}
> needing a space, so i use `{ {0} }`.

I think there were issues with {{}} as well.  How about just a memset?

Alex

>
> Changes in v2:
> - Use { {0} } instead of {}
>
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index b949e202d6cb..8e6433be2252 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -2633,7 +2633,7 @@ static void cap_soc_clocks(
>  static void update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb,
>                 struct pp_smu_nv_clock_table *max_clocks, unsigned int *uclk_states, unsigned int num_states)
>  {
> -       struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {0};
> +       struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = { {0} };
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
