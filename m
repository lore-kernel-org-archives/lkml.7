Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FB5FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000BD222C6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GjMU9TWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390664AbfKHLw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:52:28 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33937 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388922AbfKHLwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:52:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id b72so4805466edf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 03:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOnxCFh4YN+0QSSZGQhAPojghrwSZUgGpZPmxcpF31E=;
        b=GjMU9TWSMias72NYZf8/pIAPsYqBU2Md+VpsSiGnnatFFveAw6xtOCFAzEi4WXWZHz
         nRfnfimUDj7TuifnpQh3avxk4E2EOp9sjleGFUPM5EGuAX5M85TUlLhYwm1B4mQl9a2c
         0QMn+HUckzrpkgHa6z0QEbNfrdWxRlJE0y1OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOnxCFh4YN+0QSSZGQhAPojghrwSZUgGpZPmxcpF31E=;
        b=kfjY7YF+LXScjv7ByGyE5e5Mo4/NWY8VV0f/fH2GuP2C3lAK/4MYeSV05hz5OIW4/T
         S+TCUi6es8xM2IBJCBbvDSOuaYxHlAYFswlzMDT+aiPlgWyriQXraFZkGLI/4ASt3afE
         6U7tu0O1HzBymRQVxiEBF+jEqOoWj06xjrjzKpo/sgkbe0mREeo6Zml1ptggGgUeQYou
         Ul/CHhGFUD5JozsQL2FRM2oMtH5SNFpzsAxhbR2+RnDFDrlHK1w1AsxYEa3E9pUhpLny
         LUCtwAEflUN+uHk1oBhgc2aCvaJYjMobJOfEHS2ReoM55KIf7W6RaKhtXUca5BHXXPEU
         mRWA==
X-Gm-Message-State: APjAAAWnwLO8i1GMbGLM+SoyoxVpSJhxkwGiXGT6yUNmdwgD8geWyKYS
        mS2ihxYdcrxh/tg+Scw9PSvK9rlQwrFtRg==
X-Google-Smtp-Source: APXvYqz6Fid30lwxDwW5QQJsfkWwM18p2rCiP4kn7cGshbM1fsnvg/h5inSs+aci/J4bqRsdNABkag==
X-Received: by 2002:a17:906:7c4e:: with SMTP id g14mr8043591ejp.150.1573213935779;
        Fri, 08 Nov 2019 03:52:15 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id e13sm129724edv.42.2019.11.08.03.52.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 03:52:14 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id f2so6672292wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 03:52:14 -0800 (PST)
X-Received: by 2002:adf:e505:: with SMTP id j5mr7683403wrm.46.1573213933783;
 Fri, 08 Nov 2019 03:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20191007174505.10681-1-ezequiel@collabora.com>
 <20191007174505.10681-2-ezequiel@collabora.com> <20191108111950.717db5ce@collabora.com>
In-Reply-To: <20191108111950.717db5ce@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 8 Nov 2019 20:52:02 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DiAnP5pc4SoPV3aDM7k71wYmPtAHzN7thquf47EOioHw@mail.gmail.com>
Message-ID: <CAAFQd5DiAnP5pc4SoPV3aDM7k71wYmPtAHzN7thquf47EOioHw@mail.gmail.com>
Subject: Re: [PATCH v2 for 5.4 1/4] media: hantro: Fix s_fmt for dynamic
 resolution changes
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Courbot <acourbot@chromium.org>,
        fbuergisser@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 7:20 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Mon,  7 Oct 2019 14:45:02 -0300
> Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> > Commit 953aaa1492c53 ("media: rockchip/vpu: Prepare things to support decoders")
> > changed the conditions under S_FMT was allowed for OUTPUT
> > CAPTURE buffers.
> >
> > However, and according to the mem-to-mem stateless decoder specification,
> > in order to support dynamic resolution changes, S_FMT should be allowed
> > even if OUTPUT buffers have been allocated.
> >
> > Relax decoder S_FMT restrictions on OUTPUT buffers, allowing a resolution
> > modification, provided the pixel format stays the same.
> >
> > Tested on RK3288 platforms using ChromiumOS Video Decode/Encode Accelerator Unittests.
> >
> > Fixes: 953aaa1492c53 ("media: rockchip/vpu: Prepare things to support decoders")
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > --
> > v2:
> > * Call try_fmt_out before using the format,
> >   pointed out by Philipp.
> >
> >  drivers/staging/media/hantro/hantro_v4l2.c | 28 +++++++++++++++-------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
> > index 3dae52abb96c..586d243cc3cc 100644
> > --- a/drivers/staging/media/hantro/hantro_v4l2.c
> > +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> > @@ -367,19 +367,26 @@ vidioc_s_fmt_out_mplane(struct file *file, void *priv, struct v4l2_format *f)
> >  {
> >       struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> >       struct hantro_ctx *ctx = fh_to_ctx(priv);
> > +     struct vb2_queue *vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
> >       const struct hantro_fmt *formats;
> >       unsigned int num_fmts;
> > -     struct vb2_queue *vq;
> >       int ret;
> >
> > -     /* Change not allowed if queue is busy. */
> > -     vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
> > -     if (vb2_is_busy(vq))
> > -             return -EBUSY;
> > +     ret = vidioc_try_fmt_out_mplane(file, priv, f);
> > +     if (ret)
> > +             return ret;
> >
> >       if (!hantro_is_encoder_ctx(ctx)) {
> >               struct vb2_queue *peer_vq;
> >
> > +             /*
> > +              * In other to support dynamic resolution change,
>
>                       ^ order
>
> > +              * the decoder admits a resolution change, as long
> > +              * as the pixelformat remains. Can't be done if streaming.
> > +              */
> > +             if (vb2_is_streaming(vq) || (vb2_is_busy(vq) &&
> > +                 pix_mp->pixelformat != ctx->src_fmt.pixelformat))
> > +                     return -EBUSY;
>
> Sorry to chime in only now, but I'm currently looking at the VP9 spec
> and it seems the resolution is allowed to change dynamically [1] (I
> guess the same applies to VP8). IIU the spec correctly, coded frames
> using the new resolution can reference decoded frames using the old
> one (can be higher or lower res BTW). If we force a streamoff to change
> the resolution (as seems to be the case here), we'll lose those ref
> frames (see the hantro_return_bufs() in stop streaming), right?
> Hans, Tomasz, any idea how this dynamic resolution change could/should
> be supported?

The same problem applies to stateful decoders as well. This is an
inherent limitation of the current V4L2 API. To handle this kind of
streams we would have to make the format a per-buffer parameter,
rather than per-queue as it is defined currently.

Best regards,
Tomasz

>
> >               /*
> >                * Since format change on the OUTPUT queue will reset
> >                * the CAPTURE queue, we can't allow doing so
> > @@ -389,12 +396,15 @@ vidioc_s_fmt_out_mplane(struct file *file, void *priv, struct v4l2_format *f)
> >                                         V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> >               if (vb2_is_busy(peer_vq))
> >                       return -EBUSY;
> > +     } else {
> > +             /*
> > +              * The encoder doesn't admit a format change if
> > +              * there are OUTPUT buffers allocated.
> > +              */
> > +             if (vb2_is_busy(vq))
> > +                     return -EBUSY;
> >       }
> >
> > -     ret = vidioc_try_fmt_out_mplane(file, priv, f);
> > -     if (ret)
> > -             return ret;
> > -
> >       formats = hantro_get_formats(ctx, &num_fmts);
> >       ctx->vpu_src_fmt = hantro_find_format(formats, num_fmts,
> >                                             pix_mp->pixelformat);
>
> [1] Section "5.16 Reference frame scaling" of
>     https://storage.googleapis.com/downloads.webmproject.org/docs/vp9/vp9-bitstream-specification-v0.6-20160331-draft.pdf
