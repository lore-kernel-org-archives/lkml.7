Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D5BC0650E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD402080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxSAFUyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405509AbfFKQB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:01:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37151 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbfFKQBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:01:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id 131so12213920ljf.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 09:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26bbmtxXOJyY8N47HEW02fS/RJ36aAsn2edvgu3kR/Q=;
        b=kxSAFUyXCR/ZITQ4nMHjx72+UcwqH6Em59goohv6EvmNVmO1iPWvQKrlj48FEaWjzF
         HfWTfoSHrvqI2pueWXSMZH6jycHd7lF+btC2PWymdR/SKr12C1KnhbQd5QMcZshr6Xh7
         BiB7KQjnvAx2yJbfD8rvyPIyMPB0LhgluCZmRwn10iW0uFEOZmkeaCj8HLNQRGpGqaKU
         vMFtp0pWXYF/hSLGdgRRz/iM3gUG2b/se6Vsej8EBx7ab6E1qRhzZ5bhexwVvK17hHCI
         QajxmMBKso5WuHHaJWHNqFdVQCzsQn5N8qjyoStQPyhgHtU133V1l9PiBYfYOme2qucF
         se0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26bbmtxXOJyY8N47HEW02fS/RJ36aAsn2edvgu3kR/Q=;
        b=HErdDxjwVDw/udosUAO1MzYbi+YhE+Zw//IW/kN1+ksGN5qQJ5IfnOSnKwgFiF7R63
         78Gkl931pZN1iFsrnjoXP2oAmqJSIJv+4Al18RnklFe39bbZjjf7ewZWSky5Tudo54q7
         ZzZS4Spt5+GMX6hCasQqVCDImvlvIpZ0W/yyhz2psgLQ4xJVEfUe8muhinBbW+/0T5Wn
         vgUMzjeHDCbfFGmHrvxBIZQYA05lAya+B+lwLZA7JE4O87TBvUeCmT+BbrIkGqid+wOb
         41x/pdKmmDS78qcXPWSXmNYAEdTtGp7U8Ux+VHPQTQygwZs3kdRx+See8nOEUtoR3gJP
         mBJA==
X-Gm-Message-State: APjAAAWoCUGojJvTySz2Nj51sU/tgmt4oiTTELnudZaJrsnXlUtikPhq
        tPpSpzE3DO7NtAxerVDlGYSEFXZnrY7oxcqEaDoZCA==
X-Google-Smtp-Source: APXvYqx6Zyw6k7ktWfeFF2r+YwhlBxFZxaQiK+x6AhML42vVuWgezfZ5idk+Li58YpSowx4YLXEIM/M85D3+c+YcaXY=
X-Received: by 2002:a2e:5c88:: with SMTP id q130mr11691520ljb.176.1560268910098;
 Tue, 11 Jun 2019 09:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190606094722.23816-1-anders.roxell@linaro.org>
 <d6b79ee0-07c6-ad81-16b0-8cf929cc214d@xs4all.nl> <CADYN=9KY5=FzrkC7MKj9QnG-eM1NVuL00w8Xv4yU2r05rhr7WQ@mail.gmail.com>
 <c2ff2c77-5c14-4bc4-f59c-7012d272ec76@thinci.com> <1560240943.13886.1.camel@pengutronix.de>
 <221c8ef8-7adc-4383-93c9-9031dca590f0@xs4all.nl>
In-Reply-To: <221c8ef8-7adc-4383-93c9-9031dca590f0@xs4all.nl>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 11 Jun 2019 18:01:39 +0200
Message-ID: <CADYN=9K7GwPGM_Eh5q-OZ9rcEPAjXw4BXy-m3a=QxmGuVruCUw@mail.gmail.com>
Subject: Re: [PATCH 5/8] drivers: media: coda: fix warning same module names
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matt Redfearn <matt.redfearn@thinci.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "marex@denx.de" <marex@denx.de>,
        "stefan@agner.ch" <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 at 10:21, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 6/11/19 10:15 AM, Philipp Zabel wrote:
> > Hi,
> >
> > On Mon, 2019-06-10 at 13:14 +0000, Matt Redfearn wrote:
> >>
> >> On 10/06/2019 14:03, Anders Roxell wrote:
> >>> On Thu, 6 Jun 2019 at 12:13, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >>>>
> >>>> On 6/6/19 11:47 AM, Anders Roxell wrote:
> >>>>> When building with CONFIG_VIDEO_CODA and CONFIG_CODA_FS enabled as
> >>>>> loadable modules, we see the following warning:
> >>>>>
> >>>>> warning: same module names found:
> >>>>>    fs/coda/coda.ko
> >>>>>    drivers/media/platform/coda/coda.ko
> >>>>>
> >>>>> Rework so media coda matches the config fragment. Leaving CODA_FS as is
> >>>>> since thats a well known module.
> >>>>>
> >>>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> >>>>> ---
> >>>>>   drivers/media/platform/coda/Makefile | 4 ++--
> >>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/media/platform/coda/Makefile b/drivers/media/platform/coda/Makefile
> >>>>> index 54e9a73a92ab..588e6bf7c190 100644
> >>>>> --- a/drivers/media/platform/coda/Makefile
> >>>>> +++ b/drivers/media/platform/coda/Makefile
> >>>>> @@ -1,6 +1,6 @@
> >>>>>   # SPDX-License-Identifier: GPL-2.0-only
> >>>>>
> >>>>> -coda-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
> >>>>> +video-coda-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
> >>>>>
> >>>>> -obj-$(CONFIG_VIDEO_CODA) += coda.o
> >>>>> +obj-$(CONFIG_VIDEO_CODA) += video-coda.o
> >>>>
> >>>> How about imx-coda? video-coda suggests it is part of the video subsystem,
> >>>> which it isn't.
> >>>
> >>> I'll resend a v2 shortly with imx-coda instead.
> >
> > I'd be in favor of calling it "coda-vpu" instead.
>
> Fine by me!
>
> >
> >> What about other vendor SoCs implementing the Coda IP block which are
> >> not an imx? I'd prefer a more generic name - maybe media-coda.
> >
> > Right, this driver can be used on other SoCs [1].
>
> Good point.

OK, so I'll change it to 'media-coda'.

Cheers,
Anders

>
> Regards,
>
>         Hans
>
> >
> > [1] https://www.mail-archive.com/linux-media@vger.kernel.org/msg146498.html
> >
> > regards
> > Philipp
> >
>
