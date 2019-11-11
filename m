Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F811C17447
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532B320659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXCmfpX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfKKU2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:28:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39223 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfKKU2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:28:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id l7so4517422wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 12:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjO3wpyXChJA5PmnGO3S7mu0IDsvrhSOfFW6HY6JRng=;
        b=MXCmfpX6xIgnpHdiLiAp/jGtPQ/WGqtKNl6J4jKMXpkR+et+hixwSZjPLAufCBsHRe
         pcN6DW3AbQPYF7tswU6BrhK5emQLx6k8FR9WbcSCQicH9phvbHnpeUzUvYAIpLlkTw74
         QThBUnDM/pfY9lD2yc2fcjdQdmHaf8XYDbmF2M3wn1/zlS7wdXt/BiSOdu+LC6aN8pXt
         UxX8MIxAOvp87WZCkBe2Z7/Cmkm5/4ViFktvOcLSrByfoICRxwXXP4NNR0kTLRMMCSyl
         exUUXBCZDywur0uL5alEsqmsgQHFiKmHxmpf0ZAlCurJyo1fkKb5XlRBe06/AaLoxYFT
         l/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjO3wpyXChJA5PmnGO3S7mu0IDsvrhSOfFW6HY6JRng=;
        b=CY0iOZ+vDmnLo2OUtR+5nOhxcp0etFezTQY8zraEnrh7FP5aldhr82h43UOfEE3TyF
         Bha0FTxMgrOUQH82e+632XEwCmadrhG6bXGCC/NM6eGYbE5vubIL/z090zRGzBWOGFbS
         cBivqoBox4cCmE7a3S2UY7IXX1XHnnPS8mvxY+7hLrGU5HEjfBPsCY4QK5ruSy5YtKYA
         aruL/VCxgjME8M8qf5f3xWnfLC59VDkDXqwk181vaUE6qEJD6Z7AwpHFtome0Dar3wXO
         MQdcyKLYY/R1tCStulZaX1ftnQf0QNCLm2kXr6tmlrP5kWrRLBnUHqHej0iN9JYIeSl4
         8kZg==
X-Gm-Message-State: APjAAAVxBTdymICvOvWSyo8BO8azwDg8ALl+7U/b8qXa8Rt0rDtEz9e+
        3Qfterb/+o4l0SdJj2Vhp0MSRPAVQ8AtkQxuAWM7TBn4
X-Google-Smtp-Source: APXvYqyzkmEt6fi7JOGp2anojIJLKQx7itUXqg21AcQlR+RI6alcVjkV6y6iLzku5qGFU2JWFHn8ifqUKm9QifF2ofI=
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr23322063wrr.50.1573504077928;
 Mon, 11 Nov 2019 12:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20191109093538.23964-1-yuehaibing@huawei.com> <CADnq5_O7JwQd4+ncEe+KusqNqPBGXgkcUBX6VHP5OjhNwUseWg@mail.gmail.com>
In-Reply-To: <CADnq5_O7JwQd4+ncEe+KusqNqPBGXgkcUBX6VHP5OjhNwUseWg@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Nov 2019 15:27:45 -0500
Message-ID: <CADnq5_NoPmDe-aVZbk5H-212C=hPDytZ35DrOi5k_rU671_LaA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove set but not used variable 'bpc'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
        Zhan Liu <Zhan.Liu@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 1:01 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Applied.  Thanks!

I've dropped this as it leads to a warning in the code since
get_color_depth is no longer used.  Care to fix that up as well?

Thanks!

Alex

>
> Alex
>
> On Sun, Nov 10, 2019 at 9:30 PM YueHaibing <yuehaibing@huawei.com> wrote:
> >
> > Fixes gcc '-Wunused-but-set-variable' warning:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c: In function get_pbn_from_timing:
> > drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2364:11: warning:
> >  variable bpc set but not used [-Wunused-but-set-variable]
> >
> > It is not used since commit e49f69363adf ("drm/amd/display: use
> > proper formula to calculate bandwidth from timing")
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > index bdc8be3..53394e2 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > @@ -2653,13 +2653,11 @@ static int get_color_depth(enum dc_color_depth color_depth)
> >
> >  static struct fixed31_32 get_pbn_from_timing(struct pipe_ctx *pipe_ctx)
> >  {
> > -       uint32_t bpc;
> >         uint64_t kbps;
> >         struct fixed31_32 peak_kbps;
> >         uint32_t numerator;
> >         uint32_t denominator;
> >
> > -       bpc = get_color_depth(pipe_ctx->stream_res.pix_clk_params.color_depth);
> >         kbps = dc_bandwidth_in_kbps_from_timing(&pipe_ctx->stream->timing);
> >
> >         /*
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
