Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1330BC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E2F2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jSNLMANJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfE0HRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:17:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36920 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0HRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:17:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so25224998edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 00:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QwuBQ1X+pSV3hALrqNIHUzC0vaq4QLHWjQ6iDVz7qqA=;
        b=jSNLMANJhUtiZO1sfreZI8f4UbUaZzz2BbU0j83vksvqO51XfHUOq995cZTVgnbJJ1
         ggiJyDzSHqG4bQyAFah7qIr4Z8QBj9pmHuHpFH9ad2uH5zJfglL1zkKXWW0pVwo0en9i
         km816R9F+OIYB4w5SBNI1vMIzhzODBDITe+xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=QwuBQ1X+pSV3hALrqNIHUzC0vaq4QLHWjQ6iDVz7qqA=;
        b=Ct/eHKtBumV1dZSmR5If4HVdyB/OFXrMJI1zvsmyEtm8JaZXzD3CQtBxAsH9QAX1Nl
         ZvNCfKwq8u/+fZtKVaSMXLqggn2Q935smZIYpwYZkgz8cFcWkftixDmMrrTkT4FsM0FX
         6DoLwhoETQIc3nyM4n+gAGlRKpg7xXLfLbUFFZ+oBX3Q0a+Y5g66EYaftT6MDpcikI5Q
         HcFiqRivWH9H2VoRQ2Z56RlMWh8P76oU6TG+byTclcUsvZmlARDjE7AfjVGB/QrCsw8h
         PChAxdR+aEavILA3vmjccTewkvrtFzRHph60P4Y1KBwqGvDCt9xvVbjZeqAW+rI+PJHK
         NqPw==
X-Gm-Message-State: APjAAAWZXZYZle7y9Y4SVjhnhZtHSkOOqTf2OSQ+fmybrmzgpw/PsDkp
        aTeSpDh7/hsC5aNN6DV5PrS+Bg==
X-Google-Smtp-Source: APXvYqyajJVzug0/cOZboL2gRmo5k48fYzLzelbPSB9nBVL3vfoMbrW3Svg7HlgWB+pN8HC2Ve1zaA==
X-Received: by 2002:a50:9765:: with SMTP id d34mr121806735edb.195.1558941452773;
        Mon, 27 May 2019 00:17:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a17sm2992004edt.63.2019.05.27.00.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 00:17:31 -0700 (PDT)
Date:   Mon, 27 May 2019 09:17:29 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 00/33] fbcon notifier begone!
Message-ID: <20190527071729.GM21222@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190525171928.GA13526@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525171928.GA13526@ravnborg.org>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 07:19:28PM +0200, Sam Ravnborg wrote:
> Hi Daniel.
> 
> Good work, nice cleanup all over.
> 
> A few comments to a few patches - not something that warrant a
> new series to be posted as long as it is fixed before the patches are
> applied.

Hm yeah good idea, I'll add that to the next version.

> > btw for future plans: I think this is tricky enough (it's old code and all
> > that) that we should let this soak for 2-3 kernel releases. I think the
> > following would be nice subsequent cleanup/fixes:
> > 
> > - push the console lock completely from fbmem.c to fbcon.c. I think we're
> >   mostly there with prep, but needs to pondering of corner cases.
> I wonder - should this code consistently use __acquire() etc so we could
> get a little static analysis help for the locking?
> 
> I have not played with this for several years and I do not know the
> maturity of this today.

Ime these sparse annotations are pretty useless because too inflexible. I
tend to use runtime locking checks based on lockdep. Those are more
accurate, and work even when the place the lock is taken is very far away
from where you're checking, without having to annoate all functions in
between. We need that for something like console_lock which is a very big
lock. Only downside is that only paths you hit at runtime are checked.

> > - move fbcon.c from using indices for tracking fb_info (and accessing
> >   registered_fbs without proper locking all the time) to real fb_info
> >   pointers with the right amount of refcounting. Mostly motivated by the
> >   fun I had trying to simplify fbcon_exit().
> > 
> > - make sure that fbcon call lock/unlock_fb when it calls fbmem.c
> >   functions, and sprinkle assert_lockdep_held around in fbmem.c. This
> >   needs the console_lock cleanups first.
> > 
> > But I think that's material for maybe next year or so.
> Or maybe after next kernel release.
> Could we put this nice plan into todo.rst or similar so we do not have
> to hunt it down by asking google?
> 
> For the whole series you can add my:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Some parts are reviewed as "this looks entirely correct", other parts
> I would claim that I actually understood.
> And after having spend some hours on this a r-b seems in order.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
