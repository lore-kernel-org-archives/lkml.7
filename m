Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590F3C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9AD20862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGrIHGsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfJDMrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:47:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41006 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfJDMrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:47:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id q9so7019821wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SnebWYdJq5RJ8cEGOskgzENwcS3jAgltFMpNIZXBTo4=;
        b=bGrIHGsJyA0Ku8gQIGnulfy2eoAecu7Xnx4vhgTr1CTIIh2mWqpFMN+hktK7ZH/ZDF
         2vqwflC2++y0bDvYfmv+FnUKt/hfuQSamUhZxXF+viicwwhX8uIzYnfQ62rAPQ1JhGtV
         0fex/UsHZZ3DhnMk9Syvl0Dpxl4hklf22sGum4BbDlOAY5+NWdZVA2okrLswTzfyDpio
         p4N8DNu3eToUV0BaxtTy/i8jjK1GVitURbxsv8t1xGzBVoZ1ULMo80g2CwIFiV9pUSK5
         l3EBOtXK+6klcsVi4hwp0DF2MHCQ0tPwl80wQD3OPbV4GIb9qvI0B6aEM3JZ6GK7ennF
         Dh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SnebWYdJq5RJ8cEGOskgzENwcS3jAgltFMpNIZXBTo4=;
        b=sW4+YlH2nVInEGdW/xmIDeYkkQfL+mr+TltGLpUpcMzvqecTEXzH2+Ny835jdzaWYr
         GFpJSg0rbmURKILhzl3/KXzrBspSlrBOXz4yiVXF0KEilIPWtnDDRmrETYrS+u2BfOMM
         ECkgwoD9kxBlcVnxEYA55NqzklBjoTEkmLTPsMqrLUvpLBnDWLobPL1N2SM4pbG9vj/E
         ywbsRfH4XMbyJSqvcXfaWw12Y/QZTnzNT00aZAZN8Cnmope+N6jWL8H6jFgr0SpEulqO
         gCmpzJGHoqGV7Rf+iLlOUAEBCxpkxSx9qHe9lBGX4tS7gKWPxmObw3BiM3K5Cqr+VaYb
         /WmA==
X-Gm-Message-State: APjAAAX9GvVS5iSoKa9/jXJ+xnSZqQH+6/StORbJCzSe1/QCsmRyRWLW
        YYzjpGe3/R9w+PAIahqzzoc6PzgY3G0OboyGUDM=
X-Google-Smtp-Source: APXvYqyHGplE6tzKrXPkrAcz3R4MEH3r4IEGdZQAC3Z2CzFZCEIhK4LND+A4dyFM5Qjrm3e4tXbYRQvmcyVdbJjIvsU=
X-Received: by 2002:adf:f287:: with SMTP id k7mr12034831wro.206.1570193236775;
 Fri, 04 Oct 2019 05:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191003142423.v3.1.I5c52c59b731fe266252588ab2b32c0e3d4d808f1@changeid>
In-Reply-To: <20191003142423.v3.1.I5c52c59b731fe266252588ab2b32c0e3d4d808f1@changeid>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 4 Oct 2019 08:47:04 -0400
Message-ID: <CADnq5_OzUR12aLNgF1fO2JNZOwK=7z8SP8GvsWtSZo9bjnOVKg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd/display: fix struct init in update_bounding_box
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

On Thu, Oct 3, 2019 at 4:35 PM Raul E Rangel <rrangel@chromium.org> wrote:
>
> dcn20_resource.c:2636:9: error: missing braces around initializer [-Werror=missing-braces]
>   struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {0};
>          ^
>
> Fixes: 7ed4e6352c16f ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Applied.  thanks!

Alex

>
> ---
>
> Changes in v3:
> - Use memset
>
> Changes in v2:
> - Use {{0}} instead of {}
>
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index b949e202d6cb7..f72c26ae41def 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -2633,7 +2633,7 @@ static void cap_soc_clocks(
>  static void update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb,
>                 struct pp_smu_nv_clock_table *max_clocks, unsigned int *uclk_states, unsigned int num_states)
>  {
> -       struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {0};
> +       struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES];
>         int i;
>         int num_calculated_states = 0;
>         int min_dcfclk = 0;
> @@ -2641,6 +2641,8 @@ static void update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_
>         if (num_states == 0)
>                 return;
>
> +       memset(calculated_states, 0, sizeof(calculated_states));
> +
>         if (dc->bb_overrides.min_dcfclk_mhz > 0)
>                 min_dcfclk = dc->bb_overrides.min_dcfclk_mhz;
>         else
> --
> 2.23.0.444.g18eeb5a265-goog
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
