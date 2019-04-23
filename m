Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1822CC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E322B21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfDWROt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:14:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46298 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWROt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:14:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id d1so13295211edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 10:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4GjQlZ1oFxu5MT0XgR6xTEyfU79BmY4ZX0e6ibx3HGk=;
        b=lRKfyvW9kHK0jYyPXsf9N+NlKNey4Ein27grkYhjkQg7F/vWBG+AhbbnEL+96Stlt9
         zWMGoHkJ8h/f5lzfG2WBdULh1EWXDgR0NFZasHzGghh+VHpuNe6MKc6DcRyFNKSXNhV6
         nfgbYbZW8h/cqxSph1vkK/rc2JLESrCP0UQ8Ixb/gc6FYuVeRKCnQIg7nSKeA4y0rWbl
         q5bKYO51Au6hpYdcifBXacTICPGsHgnXSjk8HWjCm0XupUeGBOP5ud2itJ+hcV6vqzRL
         xkXox9HZKdMpUbgOWUgqRucTSaA671dvNinxnGjl3v1P6Mj30nd/ANErPcBB6YSo8NiQ
         0x8w==
X-Gm-Message-State: APjAAAVBTcwO71W0NuH4a+NXjxybTbInm68kg16aq6d0EgoQS1cdV7sE
        74Lb4bQ/QeJlZugO7hEAczI2myXV
X-Google-Smtp-Source: APXvYqy8KJLcUCUi7CrCy33MK+Z75d5HYKuj7YgMIYmPzw4FGnOfGuC6oYyqqR9Xcfx5GYMapHAR/w==
X-Received: by 2002:aa7:c2c3:: with SMTP id m3mr14690586edp.22.1556039687063;
        Tue, 23 Apr 2019 10:14:47 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id y19sm4676029edq.53.2019.04.23.10.14.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 10:14:46 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id y197so1035957wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 10:14:46 -0700 (PDT)
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr2881217wma.99.1556039685945;
 Tue, 23 Apr 2019 10:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190419080235.24396-1-paul.kocialkowski@bootlin.com>
 <CAGb2v64iFwqPJ-me2KOWUjGuObg2brjRNvD_pkPw98Y60hnwQg@mail.gmail.com>
 <1fcd1b7b1b52e67e4f0a28fca567bf3243fe0ada.camel@bootlin.com> <41c94d93321b10ee9173e0b5bce9bc37a1ea7532.camel@bootlin.com>
In-Reply-To: <41c94d93321b10ee9173e0b5bce9bc37a1ea7532.camel@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 23 Apr 2019 10:14:34 -0700
X-Gmail-Original-Message-ID: <CAGb2v65n2KVUi8YQoo92bQAWUehzMisahah28VtQoJZd3WbC6w@mail.gmail.com>
Message-ID: <CAGb2v65n2KVUi8YQoo92bQAWUehzMisahah28VtQoJZd3WbC6w@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] drm/sun4i: Unbind components before
 releasing DRM and mem at master unbind
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 10:06 AM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> Le vendredi 19 avril 2019 à 19:10 +0200, Paul Kocialkowski a écrit :
> > Hi,
> >
> > On Fri, 2019-04-19 at 09:02 -0700, Chen-Yu Tsai wrote:
> > > On Fri, Apr 19, 2019 at 1:03 AM Paul Kocialkowski
> > > <paul.kocialkowski@bootlin.com> wrote:
> > > > Our components may still be using the DRM device driver (if only to
> > > > access our driver's private data), so make sure to unbind them before
> > > > the final drm_dev_put.
> > > >
> > > > Also release our resserved memory adter unbind to match reverse
> > >
> > > typos...
> >
> > I'll probably spin up a v2 to fix them, they annoy me as well.
> >
> > > > creation order.
> > > >
> > > > Fixes: f5a9ed867c83 ("drm/sun4i: Fix component unbinding and component master deletion")
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  drivers/gpu/drm/sun4i/sun4i_drv.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > > > index 843b86661833..29258b404e54 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > > > @@ -149,10 +149,11 @@ static void sun4i_drv_unbind(struct device *dev)
> > > >         drm_kms_helper_poll_fini(drm);
> > > >         drm_atomic_helper_shutdown(drm);
> > > >         drm_mode_config_cleanup(drm);
> > > > -       of_reserved_mem_device_release(dev);
> > > > -       drm_dev_put(drm);
> > > >
> > > >         component_unbind_all(dev, NULL);
> > > > +       of_reserved_mem_device_release(dev);
> > >
> > > You should probably mention this change in the commit log as well.
> >
> > That's what I meant with the line that has typos. Maybe I should make
> > it slightly more explicit as:
> >
> > Also released our reserved memory after component unbind instead of
> > before to match reverse creation order.
> >
> > What do you think?

Forgot to reply ...

Looking again, the original already made sense. I'm not sure what I
was doing ...

> > > Otherwise,
> > >
> > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> >
> > Thanks for the review!
>
> Unless you have objections at this point, I'll send out the patch with
> your Reviewed-by soon to get the patch out ASAP.

Works for me. Thanks!

ChenYu

> Cheers,
>
> Paul
>
> > Cheers,
> >
> > Paul
> >
> > > > +
> > > > +       drm_dev_put(drm);
> > > >  }
> > > >
> > > >  static const struct component_master_ops sun4i_drv_master_ops = {
> > > > --
> > > > 2.21.0
> > > >
> > > > --
> > > > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > > > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > > > For more options, visit https://groups.google.com/d/optout.
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
