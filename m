Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12977C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35F62071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jMlY2xqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKVQA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:00:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35298 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKVQA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:00:26 -0500
Received: by mail-ed1-f66.google.com with SMTP id r16so6480252edq.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 08:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o/W4ayAOoACKQZVXBLP2Z/cgRT7wVm7u2PBZdtOrT5o=;
        b=jMlY2xqV1U4GP7NURAVPe7R9M0XRzk21qdvgXiCy5WaPBW/haBCpJXOt0hccpIbKpe
         yZOeBm+fYdAMGqoSFsMQGijq8Jpf5mgze83nD+dW4wrqmoE+DyRjZkonzlFprHEjuPen
         2eYXyMwCOyLUaqisdC/+8UftZHcskza9UjbXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o/W4ayAOoACKQZVXBLP2Z/cgRT7wVm7u2PBZdtOrT5o=;
        b=jhJVrxYTp0ndhlqDsBCKilbj8ZRPlKJ2sIElFYdxq7kpe359fTcDULhwNmEtyf92UO
         GP/y0in4JAgzPDSBTeyH7IJwU9AizOs/Mb3QqCK9QHMrG+mAyCrB+r7eSMKokWQcRrhQ
         2MFgsNQzTpMWuO5qwqbuogO9h51JIRlR/FSccD1uB4TdDzat/i5du5N+1kfVNemGQMhd
         K2kggPZEvcE6N1tsr/RH3IHpr9S78BGdKcBIBJrqFGspmnYww3awGW5WuskKcxbl7W+g
         WQC78AQ985BaLZ1N8umVth6CZUJcEkG1Xf5y/ZLXDIEwzB7gXGOsFvWrep/fiKbA5Sfg
         Cfvg==
X-Gm-Message-State: APjAAAUQN1bDdsIBicBft0yRUZ2VdoH4ugOErHMpFFGq/qBMMsHjFgnK
        vIA4JTYQfsirYAZHxuk5FGl6JdhN04U=
X-Google-Smtp-Source: APXvYqy7/ipZlF/TsQL7tzGcfsBJ+F32sZnF8doG56Qa9hrQGAyst3n/cH+R7yZb6t8+9hUTUZfykQ==
X-Received: by 2002:aa7:d2cf:: with SMTP id k15mr1935627edr.267.1574438419730;
        Fri, 22 Nov 2019 08:00:19 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id r22sm328201edt.47.2019.11.22.08.00.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2019 08:00:18 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id t26so8174244wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 08:00:17 -0800 (PST)
X-Received: by 2002:a1c:40c1:: with SMTP id n184mr17914395wma.116.1574438417276;
 Fri, 22 Nov 2019 08:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20191122051608.128717-1-hiroh@chromium.org> <767528be59275265072896e5c679e97575615fdd.camel@ndufresne.ca>
In-Reply-To: <767528be59275265072896e5c679e97575615fdd.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Sat, 23 Nov 2019 01:00:06 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D3OpAAtX7_0ktz4-aAgWN_G4YBQMR=Vwp7JPopjvRkRA@mail.gmail.com>
Message-ID: <CAAFQd5D3OpAAtX7_0ktz4-aAgWN_G4YBQMR=Vwp7JPopjvRkRA@mail.gmail.com>
Subject: Re: [PATCH] media: hantro: Support H264 profile control
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Hirokazu Honda <hiroh@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 12:09 AM Nicolas Dufresne <nicolas@ndufresne.ca> wr=
ote:
>
> Le vendredi 22 novembre 2019 =C3=A0 14:16 +0900, Hirokazu Honda a =C3=A9c=
rit :
> > The Hantro G1 decoder supports H.264 profiles from Baseline to High, wi=
th
> > the exception of the Extended profile.
> >
> > Expose the V4L2_CID_MPEG_VIDEO_H264_PROFILE control, so that the
> > applications can query the driver for the list of supported profiles.
>
> Thanks for this patch. Do you think we could also add the LEVEL control
> so the profile/level enumeration becomes complete ?
>
> I'm thinking it would be nice if the v4l2 compliance test make sure
> that codecs do implement these controls (both stateful and stateless),
> it's essential for stack with software fallback, or multiple capable
> codec hardware but with different capabilities.
>

Level is a difficult story, because it also specifies the number of
macroblocks per second, but for decoders like this the number of
macroblocks per second it can handle depends on things the driver
might be not aware of - clock frequencies, DDR throughput, system
load, etc.

My take on this is that the decoder driver should advertise the
highest resolution the decoder can handle due to hardware constraints.
Performance related things depend on the integration details and
should be managed elsewhere. For example Android and Chrome OS manage
expected decoding performance in per-board configuration files.

> >
> > Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
> > ---
> >  drivers/staging/media/hantro/hantro_drv.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/stagin=
g/media/hantro/hantro_drv.c
> > index 6d9d41170832..9387619235d8 100644
> > --- a/drivers/staging/media/hantro/hantro_drv.c
> > +++ b/drivers/staging/media/hantro/hantro_drv.c
> > @@ -355,6 +355,16 @@ static const struct hantro_ctrl controls[] =3D {
> >                       .def =3D V4L2_MPEG_VIDEO_H264_START_CODE_ANNEX_B,
> >                       .max =3D V4L2_MPEG_VIDEO_H264_START_CODE_ANNEX_B,
> >               },
> > +     }, {
> > +             .codec =3D HANTRO_H264_DECODER,
> > +             .cfg =3D {
> > +                     .id =3D V4L2_CID_MPEG_VIDEO_H264_PROFILE,
> > +                     .min =3D V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
> > +                     .max =3D V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
> > +                     .menu_skip_mask =3D
> > +                     BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
> > +                     .def =3D V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
> > +             }
> >       }, {
> >       },
> >  };
>
