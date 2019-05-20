Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C89DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04624208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MxkyDNPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390715AbfETRZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:25:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42890 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388761AbfETRZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:25:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id i2so8364059otr.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p+IGewVPK/3sUNtWjN0J1v9qG0o9ZctDOQFJRjZs3v4=;
        b=MxkyDNPTF+GcBwtvga785KdKzkeJok9neVtLb0YWhEJFqdZvQ3jCn1KUbxAtA/EC7e
         ikhd2kpZAoHjIzLMMH9EWQ3PMGbYb4S8mIo2pyOdOdW338UMv3Ze/uuBHSwaQNk49O6k
         CaXpO9mH/y6qSHuYZ+HZtmDe2Tw/P5rQssSV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p+IGewVPK/3sUNtWjN0J1v9qG0o9ZctDOQFJRjZs3v4=;
        b=t96+XfPF7FtM30NqkoK74m14mj4RNk1YD+Fyuu27/5dP/774ZCKY2DrPNQBdSluODV
         8fp392moulP8ll3BQFJ7xZW/gIbzPgtqYxSMXfefidPoeI1Qb+FzuGXm88zdC8uDhUqQ
         DmMUktq36Ss+C5dBskQoeyIZsU74X0qcf96z6xG7VCJXiZVz+DB8u3aB4hQTiMFhYhe0
         Y/kWgaaU0iWBlyapJDROSI9taJyraOSOyVXn7s6Z9NpY7dilG0VCUwJ22ELvwBS485rC
         WrDIGMxW2pmYKJ5FNiKn95DOmuOJVppF7996ulu7mJqbskURtvJKCCvmA/71Uyy1+1d1
         efkg==
X-Gm-Message-State: APjAAAWAWEw3OmkUhS3kIZZ9DiF4c7+Hkwmrlh1C5gY73gRoeBjoR5iT
        +1EOBTXc2UEqAhnsSqovOuEvnW68qcHsX+sBwJ0jqQ==
X-Google-Smtp-Source: APXvYqzVxIgdQlO/YdvYOV5mGXBZTR4aGXDhff4jSmBlpuQLUW6acY4OVOfHwYJiTVqpqlqr4sTv4zfSpLMjUvn/RH0=
X-Received: by 2002:a9d:7414:: with SMTP id n20mr18557548otk.106.1558373139972;
 Mon, 20 May 2019 10:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-11-daniel.vetter@ffwll.ch> <20190520170820.GA27230@ravnborg.org>
In-Reply-To: <20190520170820.GA27230@ravnborg.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 20 May 2019 19:25:28 +0200
Message-ID: <CAKMK7uHQo83UZmkV=gd3hHCMpusSdK_6O_UQnnHdSm+kLMgmmA@mail.gmail.com>
Subject: Re: [PATCH 10/33] fbcon: call fbcon_fb_(un)registered directly
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Yisheng Xie <ysxie@foxmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 7:08 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Daniel.
>
> While browsing this nice patch series I stumbled upon a detail.
>
> On Mon, May 20, 2019 at 10:21:53AM +0200, Daniel Vetter wrote:
> > With
> >
> > commit 6104c37094e729f3d4ce65797002112735d49cd1
> > Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Date:   Tue Aug 1 17:32:07 2017 +0200
> >
> >     fbcon: Make fbcon a built-time depency for fbdev
> >
> > we have a static dependency between fbcon and fbdev, and we can
> > replace the indirection through the notifier chain with a function
> > call.
> >
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Noralf Tr=C3=B8nnes" <noralf@tronnes.org>
> > Cc: Yisheng Xie <ysxie@foxmail.com>
> > Cc: Peter Rosin <peda@axentia.se>
> > Cc: "Micha=C5=82 Miros=C5=82aw" <mirq-linux@rere.qmqm.pl>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: linux-fbdev@vger.kernel.org
> > ---
> > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > index f52ef0ad6781..701abaf79c87 100644
> > --- a/include/linux/fb.h
> > +++ b/include/linux/fb.h
> > @@ -136,10 +136,6 @@ struct fb_cursor_user {
> >  #define FB_EVENT_RESUME                      0x03
> >  /*      An entry from the modelist was removed */
> >  #define FB_EVENT_MODE_DELETE            0x04
> > -/*      A driver registered itself */
> > -#define FB_EVENT_FB_REGISTERED          0x05
> > -/*      A driver unregistered itself */
> > -#define FB_EVENT_FB_UNREGISTERED        0x06
> >  /*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
> >  #define FB_EVENT_GET_CONSOLE_MAP        0x07
> >  /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
>
> This breaks build of arch/arm/mach-pxa/am200epd.c thats uses
> FB_EVENT_FB_*REGISTERED:
>
>
>        if (event =3D=3D FB_EVENT_FB_REGISTERED)
>                 return am200_share_video_mem(info);
>         else if (event =3D=3D FB_EVENT_FB_UNREGISTERED)
>                 return am200_unshare_video_mem(info);
>
>
> Found while grepping for "FB_EVENT" so this is not a build
> error I triggered.

Oh this is glorious :-/

Thanks a lot for spotting this, I guess I need to hack around on
metronomefb a bit ...
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
