Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4DAC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ED620883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FpcZQCd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfE0L5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:57:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40705 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfE0L5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:57:01 -0400
Received: by mail-oi1-f193.google.com with SMTP id r136so11704316oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 04:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqMfg6OHmKKEB+7R/k2mN5jX74nLf2tODcyGqdJKodU=;
        b=FpcZQCd+yUainAstvP1yxc+17OcnChNGqTLXsysGDBaXKdGMDd6Htb8Ys97/PVyWWk
         2dDkk0d7ahb5BX+NBxNbMk9dxe2Co6GuXgZlPVZBET28ScnhUF/KeFm5OvidwSI28fTy
         24rT9rCGSqykbg+wbqgIVubVQ9w3Hy97uj/So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqMfg6OHmKKEB+7R/k2mN5jX74nLf2tODcyGqdJKodU=;
        b=SOV+sdQBxW4rXmM9E1Ri1+1+HP1ZZr5xoWq62iC7Z/1fI0oNCPyxt24GN6aekJuXld
         Ize8t7pyn/WHkrYqD1LQf5G1SxKhyA45kqng9zuiBDfPV8UZQ+XhzCLhbhAYFyVihLLB
         LHqWJ1v4++uVtojum4mjx8CNZsOwA+1IwPHoUKAFFxm/w88XRAwQL+yxovpIfsnHN+Gp
         Di8QW2iLj+eavao6o0O+FPsGnkUjqZQexQuyboowyxKEY4Fzg7FwxlTcdr9sJarDZ8vc
         6Vu7FBWQCzJouh19cb4akcFBrDLnoIPin42fOXQaB71I0wFSmYsIHNxUTjPQymjk/How
         MOTg==
X-Gm-Message-State: APjAAAXMjnA1Q6hSvNhXFWXCenWSAfl25ziMgIIh6C4yT/m+W/nTywIb
        z3ODv7Jqy3dFz3wBRhMRurmDPP83T3gb3KfOfEuwthJn
X-Google-Smtp-Source: APXvYqyhtBF+UewTKbHphm9QcAI2HxUut96Wu+pGPpBFNdH/WsetPUDvvAeMMnEWk5E4LXy3BEk5tAHzLhjy0nawfVQ=
X-Received: by 2002:aca:31cf:: with SMTP id x198mr14016323oix.132.1558958220929;
 Mon, 27 May 2019 04:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190525171928.GA13526@ravnborg.org> <20190527071729.GM21222@phenom.ffwll.local>
In-Reply-To: <20190527071729.GM21222@phenom.ffwll.local>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 27 May 2019 13:56:48 +0200
Message-ID: <CAKMK7uEikzt0VRk-9nAScw1ppoOUs4Ay_L4KqHRD5FJBJAWmMQ@mail.gmail.com>
Subject: Re: [PATCH 00/33] fbcon notifier begone!
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 9:17 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Sat, May 25, 2019 at 07:19:28PM +0200, Sam Ravnborg wrote:
> > Hi Daniel.
> >
> > Good work, nice cleanup all over.
> >
> > A few comments to a few patches - not something that warrant a
> > new series to be posted as long as it is fixed before the patches are
> > applied.
>
> Hm yeah good idea, I'll add that to the next version.

Actually I thought a bit more about the locking story, and it's a bit
worse than my simple plan here. I think better to just have that
floating around, and not make it look like it's an easy simple
cleanup.

The case I forgot about is that any places that has a printk can
recurse through the console_lock, which means we need a lot more
try_lock than I originally thought we'd need.
-Daniel

>
> > > btw for future plans: I think this is tricky enough (it's old code and all
> > > that) that we should let this soak for 2-3 kernel releases. I think the
> > > following would be nice subsequent cleanup/fixes:
> > >
> > > - push the console lock completely from fbmem.c to fbcon.c. I think we're
> > >   mostly there with prep, but needs to pondering of corner cases.
> > I wonder - should this code consistently use __acquire() etc so we could
> > get a little static analysis help for the locking?
> >
> > I have not played with this for several years and I do not know the
> > maturity of this today.
>
> Ime these sparse annotations are pretty useless because too inflexible. I
> tend to use runtime locking checks based on lockdep. Those are more
> accurate, and work even when the place the lock is taken is very far away
> from where you're checking, without having to annoate all functions in
> between. We need that for something like console_lock which is a very big
> lock. Only downside is that only paths you hit at runtime are checked.
>
> > > - move fbcon.c from using indices for tracking fb_info (and accessing
> > >   registered_fbs without proper locking all the time) to real fb_info
> > >   pointers with the right amount of refcounting. Mostly motivated by the
> > >   fun I had trying to simplify fbcon_exit().
> > >
> > > - make sure that fbcon call lock/unlock_fb when it calls fbmem.c
> > >   functions, and sprinkle assert_lockdep_held around in fbmem.c. This
> > >   needs the console_lock cleanups first.
> > >
> > > But I think that's material for maybe next year or so.
> > Or maybe after next kernel release.
> > Could we put this nice plan into todo.rst or similar so we do not have
> > to hunt it down by asking google?
> >
> > For the whole series you can add my:
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> >
> > Some parts are reviewed as "this looks entirely correct", other parts
> > I would claim that I actually understood.
> > And after having spend some hours on this a r-b seems in order.
>
> Thanks, Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
