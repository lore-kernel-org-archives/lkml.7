Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBA5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C8921906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LErg4eJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408865AbfJXJYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:24:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40131 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393061AbfJXJYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:24:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id p59so9673865edp.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 02:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Fg4OORdS56GYlEdlxxKyHlR08HjtyPW5mXDJkHAU3c=;
        b=LErg4eJHixvsMHo3T4UdsdOcjyo5lbO9XudSeZq6rpgNnkVpGr/b0G90t4XOSP66/E
         yPiEP9VtvxDCkUlH7d1janZhA4XnWhbkjvm/cOE2ToCJXuDoxd+uba3V89MU7eceWGgo
         3dPD97YPgwTyy5neIrYaAT8SNNB8krsO2ClP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Fg4OORdS56GYlEdlxxKyHlR08HjtyPW5mXDJkHAU3c=;
        b=gr+QAlo5VzN4dduBfhFSSxLXOi03cTy/V06FvIm4vlHOzZFCQZgA10etsRAQu6aLx9
         xXy6glPh7OzxBSDoz5OL5i8i+UdtatJHQdS5bgZp9+jmQ4tHdHIHXiF6BOGMvSlTCJqx
         uVAVJhK0q7rr9j1TrzYxGsHmqbb1eI89j7wFzp+J2nY61CEzFA9LYhXGCSv0JnywkOr4
         ZtMJoxHsH3loq7Ng/vm2fF3RAge3t91ecFNKL9i2zWL6FTgKPlvLRl64U+6cpalaKLrF
         5sWOxNCQ3gAK5CfKL2a3UhKhFzI46iVoLoGB7UpZEVjowKPZ52zEKcexNpZlZkh+3DQj
         PNPA==
X-Gm-Message-State: APjAAAXzc99P+XkS9Ek/OOwi7cRKSaYgESL9AUIptgxXPNYQhvi7IsMb
        xB+c0s0tHl5N5Wecz7BZhscZ+6va86VygA==
X-Google-Smtp-Source: APXvYqw3txxyJiEko6MOc1GOa9NGSdJTMjS4hTdHYvm5LQ50wTRHehrl8Ad85o5/OO1BerKp363zMg==
X-Received: by 2002:a17:906:7094:: with SMTP id b20mr37286315ejk.134.1571909038413;
        Thu, 24 Oct 2019 02:23:58 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id l49sm434653edb.3.2019.10.24.02.23.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 02:23:56 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id t16so20076735wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 02:23:55 -0700 (PDT)
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr2809593wrw.155.1571909035112;
 Thu, 24 Oct 2019 02:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191017084033.28299-1-xia.jiang@mediatek.com>
 <20191017084033.28299-6-xia.jiang@mediatek.com> <20191023103945.GA41089@chromium.org>
 <1571906317.6254.64.camel@mhfsdcap03>
In-Reply-To: <1571906317.6254.64.camel@mhfsdcap03>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 24 Oct 2019 18:23:43 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DUF90daBAe96Vu46z9HD43AYG+9rK-_r_aWYey8GxpmQ@mail.gmail.com>
Message-ID: <CAAFQd5DUF90daBAe96Vu46z9HD43AYG+9rK-_r_aWYey8GxpmQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] media: platform: Add jpeg dec/enc feature
To:     Xia Jiang <xia.jiang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 5:38 PM Xia Jiang <xia.jiang@mediatek.com> wrote:
>
> On Wed, 2019-10-23 at 19:39 +0900, Tomasz Figa wrote:
> > Hi Xia,
> >
> > On Thu, Oct 17, 2019 at 04:40:38PM +0800, Xia Jiang wrote:
> > > Add mtk jpeg encode v4l2 driver based on jpeg decode, because that jp=
eg
> > > decode and encode have great similarities with function operation.
> > >
> > > Signed-off-by: Xia Jiang <xia.jiang@mediatek.com>
> > > ---
> > > v4: split mtk_jpeg_try_fmt_mplane() to two functions, one for encoder=
,
> > >     one for decoder.
> > >     split mtk_jpeg_set_default_params() to two functions, one for
> > >     encoder, one for decoder.
> > >     add cropping support for encoder in g/s_selection ioctls.
> > >     change exif mode support by using V4L2_JPEG_ACTIVE_MARKER_APP1.
> > >     change MTK_JPEG_MAX_WIDTH/MTK_JPEG_MAX_HEIGH from 8192 to 65535 b=
y
> > >     specification.
> > >     move width shifting operation behind aligning operation in
> > >     mtk_jpeg_try_enc_fmt_mplane() for bug fix.
> > >     fix user abuseing data_offset issue for DMABUF in
> > >     mtk_jpeg_set_enc_src().
> > >     fix kbuild warings: change MTK_JPEG_MIN_HEIGHT/MTK_JPEG_MAX_HEIGH=
T
> > >                         and MTK_JPEG_MIN_WIDTH/MTK_JPEG_MAX_WIDTH fro=
m
> > >                         'int' type to 'unsigned int' type.
> > >                         fix msleadingly indented of 'else'.
> > >
> > > v3: delete Change-Id.
> > >     only test once handler->error after the last v4l2_ctrl_new_std().
> > >     seperate changes of v4l2-ctrls.c and v4l2-controls.h to new patch=
.
> > >
> > > v2: fix compliance test fail, check created buffer size in driver.
> > > ---
> > >  drivers/media/platform/mtk-jpeg/Makefile      |   5 +-
> > >  .../media/platform/mtk-jpeg/mtk_jpeg_core.c   | 731 +++++++++++++++-=
--
> > >  .../media/platform/mtk-jpeg/mtk_jpeg_core.h   | 123 ++-
> > >  .../media/platform/mtk-jpeg/mtk_jpeg_dec_hw.h |   7 +-
> > >  .../media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c | 175 +++++
> > >  .../media/platform/mtk-jpeg/mtk_jpeg_enc_hw.h |  60 ++
> > >  .../platform/mtk-jpeg/mtk_jpeg_enc_reg.h      |  49 ++
> > >  7 files changed, 1004 insertions(+), 146 deletions(-)
> > >  create mode 100644 drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c
> > >  create mode 100644 drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.h
> > >  create mode 100644 drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_reg.=
h
> > >
> >
> > First of all, thanks for the patch!
> >
> > Please check my comments below.
> >
> > My general feeling about this code is that the encoder hardware block i=
s
> > completely orthogonal from the decoder block and there is very little c=
ode
> > reuse from the original decoder driver.
> >
> > Moreover, a lot of existing code now needs if (decoder) { ... } else {.=
.. }
> > segments, which complicates the code.
> >
> > Would it perhaps make sense to instead create a separate mtk-jpeg-enc
> > driver?
> >
> Dear Tomasz,
>
> Thanks for your comments.
>
> My reasons about the architecture of jpeg enc driver are as follows:
>
> The first internal design and realization of jpeg enc driver was a
> separate driver, but found that mtk_jpeg_core.c and mtk_jpeg_enc_core.c
> have lots of reuse.Because that  the core.c mainly contains realization
> of v4L2 ioctl functions and some logic which are high similarity between
> encoder and decoder.
>
> The jpeg encoder and decoder are two independent hardwares exactly, so
> the code about hardware specification(register setting) are
> separated(mtk_jpeg_enc_hw.c and mtk_jpeg_dec_hw.c).
>
> As for 17 existing code segments contain if(decoder){} else {}, they are
> not complicated IMHO.The complicated(multilayer nested) functions are
> separated in V4 version as Hans recommendation.
>
> By the way,the upstreamed module s5p-jpeg
> (https://elixir.bootlin.com/linux/latest/source/drivers/media/platform/s5=
p-jpeg/jpeg-core.c#L1998) also use encoder and decoder mode in the common c=
ore.c, but their encoder and decoder are the same hardware.Maybe our jpeg e=
nc and dec are designed into one hardware in the future.In that case the cu=
rrent architecture is more compatible.
>
> So I prefer the current design.
>

Would you be able to give some numbers to show the code reuse to
justify using the same driver? From my observation, a new driver would
result in a significantly cleaner code. If there is a further hardware
architecture change, that would likely require another driver, because
it wouldn't be compatible with existing programming model anyway.

Regardless of that, if we end up with reusing the same driver, I'd
like you to fix the issues existing in the current base before adding
the encoder functionality.

Best regards,
Tomasz
