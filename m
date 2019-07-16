Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52A5C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D099206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WkIXGD93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbfGPIAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:00:06 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42806 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfGPIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:00:05 -0400
Received: by mail-vs1-f68.google.com with SMTP id 190so13259591vsf.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0k1aHf58/gxem57t+/HJk9SNpX74KfXqdFRssCgasHQ=;
        b=WkIXGD93vnc7/jgdUJCOyAhWfQWj4JwZxZhvfijDRISLuLx4yflZHTDWWSxx7WAFgi
         P/75eR1ocFjiim/HAtaQ/hHHMdj/AJhGCoGv3O1KDMwV3amytYQ+kgBq/LAKt+YymIQH
         cgPBdjhd4eTA/OcE54ml3PqvteVAcATrUZsBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0k1aHf58/gxem57t+/HJk9SNpX74KfXqdFRssCgasHQ=;
        b=AmwHsDPEII/3viYQ/FC62d/ByjNuW0kTWDBtoY3U97S3RVAyxhq57t4ADQ9GsOJID9
         kpOHHd24D00KSUAeAoBXuEK8WUGIBmaefTxKlvkUNdJEZ9SddrU66T7NWYRlDh9HeDXi
         e79xPftXzmj7psvbAaNXnZpew8LVdL0tZMYeWYyrXFoBLuadgZPLUyKP5iDpL7Dqbp9R
         qBQmouRN8BhuR9ROwfekDJNjFCEBgKAFSx9/aBmHJb90B8Vhe5apxM2I97cM4hz31GJC
         dBbGZT0M/igRQXXpONI1GOfT833s1tTDToZJSqjbiVIS3EejwHPhJKDeS3d+fVC1AtPp
         YTzg==
X-Gm-Message-State: APjAAAVb21LfE+yg0x6lFnlWheoBe7EdrxUgoYZnMNQ7J2VJ2ixvYa1o
        RhlFUpppsOnjBDogrUG4QKbRCjHC9Y/bD+kdlZU1iQ==
X-Google-Smtp-Source: APXvYqz3UlcLWtTzFizosrgSxqzhf3bbaJZCfMhWBpiXfCrTTv26BLTLvewBhZnAiR6udq4k9bpOekTvU0tfbVw4RAQ=
X-Received: by 2002:a67:ebcb:: with SMTP id y11mr9527514vso.138.1563264004214;
 Tue, 16 Jul 2019 01:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190712100443.221322-1-cychiang@chromium.org>
 <20190712100443.221322-2-cychiang@chromium.org> <20190712105745.xr7jxc626lwoaajx@shell.armlinux.org.uk>
 <CA+Px+wWbmUemETY3OMk1T9XS2w8ZXvZUhVEGzw_w6AxtU8R0rw@mail.gmail.com>
In-Reply-To: <CA+Px+wWbmUemETY3OMk1T9XS2w8ZXvZUhVEGzw_w6AxtU8R0rw@mail.gmail.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 16 Jul 2019 15:59:36 +0800
Message-ID: <CAFv8NwKwd8Yf4UmqUhcaP1pL2K_d_FSZm9JyY_Azy13017RWgg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ASoC: hdmi-codec: Add an op to set callback
 function for plug event
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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
        Daniel Vetter <daniel@ffwll.ch>,
        Dylan Reid <dgreid@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 11:56 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Fri, Jul 12, 2019 at 6:58 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Fri, Jul 12, 2019 at 06:04:39PM +0800, Cheng-Yi Chiang wrote:
> > > Add an op in hdmi_codec_ops so codec driver can register callback
> > > function to handle plug event.
> > >
> > > Driver in DRM can use this callback function to report connector status.
> > >
> > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > ---
> > >  include/sound/hdmi-codec.h    | 16 +++++++++++++
> > >  sound/soc/codecs/hdmi-codec.c | 45 +++++++++++++++++++++++++++++++++++
> > >  2 files changed, 61 insertions(+)
> > >
> > > diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> > > index 7fea496f1f34..9a8661680256 100644
> > > --- a/include/sound/hdmi-codec.h
> > > +++ b/include/sound/hdmi-codec.h
> > > @@ -47,6 +47,9 @@ struct hdmi_codec_params {
> > >       int channels;
> > >  };
> > >
> > > +typedef void (*hdmi_codec_plugged_cb)(struct device *dev,
> > > +                                   bool plugged);
> > > +
> >
> > I'd like to pose a question for people to think about.
> >
> > Firstly, typedefs are generally shunned in the kernel.  However, for
> > these cases it seems to make sense.
> >
> > However, should the "pointer"-ness be part of the typedef or not?  To
> > see what I mean, consider:
> >
> >         typedef void (*hdmi_foo)(void);
> >
> >         int register_foo(hdmi_foo foo);
> >
> > vs
> >
> >         typedef void hdmi_foo(void);
> >
> >         int register_foo(hdmi_foo *foo);
> >
> > which is more in keeping with how we code non-typedef'd code - it's
> > obvious that foo is a pointer while reading the code.
> I have a different opinion.  Its suffix "_cb" self-described it is a
> callback function.  Since function and function pointer are equivalent
> in the language, I think we don't need to emphasize that it is a
> function "pointer".
>
>

Hi Russell and Tzungbi, thank you for the review.
Regarding this typedef of callback function, I found a thread
discussing this very long time ago:

https://yarchive.net/comp/linux/typedefs.html

From that thread, Linus gave an example of using typedef for function
pointer that is following to this pattern.
I also looked around how other driver use it:
$ git grep typedef | grep _cb | less | wc -l
138
$ git grep typedef | grep _cb | grep "(\*" | wc -l
115
Most of the typedef of callback function use this pattern.
So I think this should be fine.
Thanks!


> > It seems to me that the latter better matches what is in the kernel's
> > coding style, which states:
> >
> >   In general, a pointer, or a struct that has elements that can
> >   reasonably be directly accessed should **never** be a typedef.
> >
> > or maybe Documentation/process/coding-style.rst needs updating?
