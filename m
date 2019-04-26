Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBF7C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE3C2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lA7nJrH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfDZMOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:14:20 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39872 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfDZMOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:14:20 -0400
Received: by mail-it1-f195.google.com with SMTP id e13so5390550itk.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jEZC4634H5eB+vQttfaoxFWaSWHQi83ITvScTvXOvk=;
        b=lA7nJrH3VAr6jItwric0zrfC2Uv3RAcbRFteY6UFShp0ol8YtZ4QftaZ0uBk38QPNG
         L5bvH1ti51iIyl0daHfva2ZGIcvWxAuAL+mNwRA5fDhhWUkI1WTuSSGG2PpcU1KxvkOt
         qPlIAufvbmrKXycK9hyNfJ36G4PatJ2Qinn+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jEZC4634H5eB+vQttfaoxFWaSWHQi83ITvScTvXOvk=;
        b=ghHasKN/u04oZp8bR+YTY2Vavs6EuqohohQvEMSO7pMmsF8rMBBO2RnKyLP4j1n2dH
         JNTzN4q+4jQYJxaMoiVhagGLbQPMgiBiE+5rnkrvbuKO69R9O1D1yOXMMym7mnxT6bTP
         WY/4vWgPJ/YwIDOreqHmBxhI3ww+VZ0eKiAGUfFl/shLXs2NPAM7wtQ9N8pV24nb619D
         EbtYmwux5RBKA9CAiWX8XsLitbLEmd+fxmJNuPbHP/KL3XkS61rB7PoQlShOgOqXnyXU
         doEm8ts/iUZFkV4PqiEpKXL7nS+GJgW803flYd/HZkb8DHpBZCmoTvwAvrzfEXkfd9su
         3zjQ==
X-Gm-Message-State: APjAAAW1fTCo4ZSNrke/IBGZf+YWekg90WiaefP8A8g0nBP58ZLHYR1X
        uid2vKXVkC0KJpwgqsYcJD5z5gfoVvpgH9IVV3FoyQ==
X-Google-Smtp-Source: APXvYqyrqxkYKjUBIrcVxhdNVXp2++vQO/i79an4OSWxmIm1Ch6v1nPEGPkInCgmd9VkDm9Y3lBkfcCeNLEt/k9Fisk=
X-Received: by 2002:a02:7f81:: with SMTP id r123mr7220699jac.85.1556280859722;
 Fri, 26 Apr 2019 05:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190118100828.GA5143@kroah.com> <20190118112028.GG3271@phenom.ffwll.local>
 <20190426004229.GC21072@darkstar.musicnaut.iki.fi>
In-Reply-To: <20190426004229.GC21072@darkstar.musicnaut.iki.fi>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 26 Apr 2019 14:14:08 +0200
Message-ID: <CAKMK7uE72n-jSF1ZWTidMAUJUKMfqcVi-4zQd7hRrKTp-Skjqg@mail.gmail.com>
Subject: Re: [PATCH] staging: xgifb: delete the driver
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnaud Patard <arnaud.patard@rtp-net.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 2:42 AM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> On Fri, Jan 18, 2019 at 12:20:28PM +0100, Daniel Vetter wrote:
> > On Fri, Jan 18, 2019 at 11:08:28AM +0100, Greg Kroah-Hartman wrote:
> > > There has not been any real work done on cleaning this driver up and
> > > getting it out of the staging tree in years.  Also, no new fb drivers
> > > are being added to the tree, so it should be converted into a drm driver
> > > as well.
> > >
> > > Due to the lack of interest in this codebase, just drop it.
> > >
> > > Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> > > Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Because of this I just lost fb/display on two of my computers...
>
> So I guess to reintroduce the support for this HW I need to write a new
> DRM driver and no staging work anymore. Which of the current DRM drivers
> would be best to be used as a template/example for a new driver?

For a simple driver pick any of the recently merged ones using the
drm_simple_display_pipe helpers, those will get rid of all the
boilerplate for you. If you have vram, you might need the in-flight
vram helpers that currently are worked on by Thomas Zimmermann (they
refactor simple vram handling from about 5 drivers into a new helper,
with the goal to make porting fbdev drivers even easier).
-Daniel




--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
