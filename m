Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CEFC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D7D205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SA30rmEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfGOP4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:56:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44685 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbfGOP4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:56:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so17478965otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxdnANqifDB1z1Ih8rPgPPFQ52+wPGcxB0Lct34ID5Q=;
        b=SA30rmEvAAB/UeWM0cJpboyXWomGji7I7a5x3X8IC2z8RDCcu48fRpx3oXaTPieM78
         hMUBvyfACXuvhVyl7122TsYzmlo3PSQz9JgHl3IzAfFzF4LUSFpBOVOTOS1B1L4yygl7
         QOOGtMtHFpJt8B1LZKpTsfOdvejMLuCIDQCalifs34k7ukv+KzyMS3/rAXEkr2VMjwP1
         SBtlOVlmpKFktDXSl32r68WJn6RZP964o2hS1wrBNhCu42BpzNeAZYsIqnpYlDH19pdT
         IooGaAqomRnAwqqNrb8iHZz4u/RbyBz6uQU3gz+bKjgxr0xq0hFlSy/JRzbwLlHSQ+Nf
         EO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxdnANqifDB1z1Ih8rPgPPFQ52+wPGcxB0Lct34ID5Q=;
        b=mqm2iCYzXvmdpc/cFMtak0E+dJaCrf0C52s/9q7S4DHikU/W1C5xE6O1SXK7T2kvr0
         kOCKApMJU5wHzBaGGqUDkRGGcPtA3AZabcB/HR5CamqRa5/ZkEjsRgAAIyQI+0FQS8Vh
         Us9TL/XpsceLVHHtOd2NQs4axzB1hNNOcnLx35hvNn/uZ0vdw6g43H5QKVA+UokF40eN
         rbDf9ueSIsodscM+9w6jyKTKExc+TNAWuFu9N0Hkh4nCKqu7S4xcGIf82cPbJSWtNLOv
         GB4qrhqr8/8Y/9U0ao/7SnjKEKxSV9syPY5YXO0W8RERDQldIp1RXFeQ9Z9lnilD+9Nv
         oxSw==
X-Gm-Message-State: APjAAAVNepUGPW56PejeW3mcJQs/w75cxBmn1YLRiAGLSTtemh7yFXTT
        2tFFfHeE0zni1J/8Lqan7FD9GpKeyTj4lXt0wvLrzg==
X-Google-Smtp-Source: APXvYqwsZvLcK5LidkOK7j4XvKdYHFQb2nVh/AtXUYin5kr5W0WlZFyIM9UGzPAW85pcfSoyZbDk7ZxnfK/q+cptnb0=
X-Received: by 2002:a05:6830:1cd:: with SMTP id r13mr8619272ota.99.1563206191242;
 Mon, 15 Jul 2019 08:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190712100443.221322-1-cychiang@chromium.org>
 <20190712100443.221322-2-cychiang@chromium.org> <20190712105745.xr7jxc626lwoaajx@shell.armlinux.org.uk>
In-Reply-To: <20190712105745.xr7jxc626lwoaajx@shell.armlinux.org.uk>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 15 Jul 2019 23:56:19 +0800
Message-ID: <CA+Px+wWbmUemETY3OMk1T9XS2w8ZXvZUhVEGzw_w6AxtU8R0rw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ASoC: hdmi-codec: Add an op to set callback
 function for plug event
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, tzungbi@chromium.org,
        Jaroslav Kysela <perex@perex.cz>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>, dgreid@chromium.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 6:58 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Jul 12, 2019 at 06:04:39PM +0800, Cheng-Yi Chiang wrote:
> > Add an op in hdmi_codec_ops so codec driver can register callback
> > function to handle plug event.
> >
> > Driver in DRM can use this callback function to report connector status.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  include/sound/hdmi-codec.h    | 16 +++++++++++++
> >  sound/soc/codecs/hdmi-codec.c | 45 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 61 insertions(+)
> >
> > diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> > index 7fea496f1f34..9a8661680256 100644
> > --- a/include/sound/hdmi-codec.h
> > +++ b/include/sound/hdmi-codec.h
> > @@ -47,6 +47,9 @@ struct hdmi_codec_params {
> >       int channels;
> >  };
> >
> > +typedef void (*hdmi_codec_plugged_cb)(struct device *dev,
> > +                                   bool plugged);
> > +
>
> I'd like to pose a question for people to think about.
>
> Firstly, typedefs are generally shunned in the kernel.  However, for
> these cases it seems to make sense.
>
> However, should the "pointer"-ness be part of the typedef or not?  To
> see what I mean, consider:
>
>         typedef void (*hdmi_foo)(void);
>
>         int register_foo(hdmi_foo foo);
>
> vs
>
>         typedef void hdmi_foo(void);
>
>         int register_foo(hdmi_foo *foo);
>
> which is more in keeping with how we code non-typedef'd code - it's
> obvious that foo is a pointer while reading the code.
I have a different opinion.  Its suffix "_cb" self-described it is a
callback function.  Since function and function pointer are equivalent
in the language, I think we don't need to emphasize that it is a
function "pointer".


> It seems to me that the latter better matches what is in the kernel's
> coding style, which states:
>
>   In general, a pointer, or a struct that has elements that can
>   reasonably be directly accessed should **never** be a typedef.
>
> or maybe Documentation/process/coding-style.rst needs updating?
