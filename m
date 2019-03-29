Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E08AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF17D2184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="UJKg6Gmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbfC2Smm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:42:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45671 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbfC2Smm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:42:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id 5so2106519lft.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 11:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+rx95t+EhwS04d2yRrivqTHz9lHMbzp2fHRpXzzn+zo=;
        b=UJKg6Gmz1JfvpkKafRkHlWHvMwws5n6RqQOO22Ej8ifpKjC2D1xteT63sd/HykWaG+
         i3eQs+bxRsM0qAUrVKJZkVWWn23oF5Le/lGeGX8cVOgkrt1qigI/K2+yBSq1SzmtOfVe
         NM5cU3MT7+9IPceZynePSHGYOsXjPhbXjDoN06DlJHPPpc6sJ0Hswmwq+K/YOrZ0byEb
         676inPp3On9ojkP3iup1quSzkHMax5VHHBByvMxkk24Sa/6hlGWcCWA6fIjnl1cHgz5Z
         qQreCqVVuJMf6bhlRpIHScQW63s0SyWpHtzOAE2p0+RbnYJvBvQXqklagWOzdLhovNdP
         sAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+rx95t+EhwS04d2yRrivqTHz9lHMbzp2fHRpXzzn+zo=;
        b=EzzqguVjOSRiHbfQYCvNSrYtabGgklxSZd59yqnSFkge+oUcQe/aZjoSIvFFN1bneO
         JvqJqfjIphUwVz3A9DKNZYWM01sx8n9L1MGUbwav8wUynYpl+847ibghD1UM7EJOepw2
         kdyLVzX9pFiHAFVQSkF0++IEMWvaNBUKHCEjtsFIME++zrPKCXQ2Zx2YZZ5TWb52nqAQ
         JJbrcjpTFlZaPZYz1Gooyf9byuu8kLcJalBp0Hgz9oYhEUY7g9g6RgSjJo6QeZTieYIZ
         eFzyYeF+ibaSaBm1UBkzkRUPvROoaQpeTLqqzX9vUeaz2ZClGjdrGx/AfeSQisvGfMKY
         w9LA==
X-Gm-Message-State: APjAAAURMbJn6cikYDhLIKAW1qdZdK0E1cGMo4Uc5O6k9pSsH9gp08Gx
        9TtaOpxoKU9JOVqUIDChQvvEqzkif9PDZjlp22tuDYV8
X-Google-Smtp-Source: APXvYqyMcaqPartmzGHy3tEyEniNYLpE5slvD9jXH3GXlGSj86zfhc3GjTtmU20vLot1hirIgmOfsnrawNOSXFnL3aE=
X-Received: by 2002:ac2:4561:: with SMTP id k1mr21064909lfm.95.1553884959960;
 Fri, 29 Mar 2019 11:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190320154809.14823-1-paul.kocialkowski@bootlin.com>
 <20190320154809.14823-2-paul.kocialkowski@bootlin.com> <87zhpph4c2.fsf@anholt.net>
 <82618ee8c2a2380a62b1fb894e5c35c602e20f3d.camel@bootlin.com>
 <20190328185307.GZ2665@phenom.ffwll.local> <CAPj87rMmW_7Kiy==ZxvvmHXhQLWC+F=uxed442HpMMZr=MwjRA@mail.gmail.com>
 <5ed7c5f361bca47d3f9771f9ed27e28e2fccb179.camel@bootlin.com>
 <20190329152502.GO2665@phenom.ffwll.local> <901ea65c770c80e22c69032affe3b1a22652b608.camel@bootlin.com>
 <87r2appmz2.fsf@anholt.net>
In-Reply-To: <87r2appmz2.fsf@anholt.net>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Fri, 29 Mar 2019 18:42:28 +0000
Message-ID: <CAPj87rMJGUGFpYaBf=itf1A7jeEzOjPcnDDS-6m69kJN_mGnww@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/file: Rehabilitate the firstopen hook for
 non-legacy drivers
To:     Eric Anholt <eric@anholt.net>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 29 Mar 2019 at 18:14, Eric Anholt <eric@anholt.net> wrote:
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> > I'm not totally convinced that it's okay to have a delay outside of
> > init/enumeration, even if it's a smaller delay.
>
> You'll have non-dumb buffers created during GL context creation, so
> early in xserver or other KMS-and-GL-using application init anyway.
> Seems like a perfectly fine plan to me.

Yeah. The alternative is doing it once when Plymouth starts, and then
maybe again when Weston/GNOME/Xorg/... starts, which isn't really
ideal (or maybe even udev helpers). Doing it on probe also complicates
profiling startup for those: if GL context or surface creation takes a
long time, that's easy to reason about. If opening an FD takes ages,
that makes figuring out why stuff is slow a lot more complicated. This
used to happen with RPM resume for PCI devices to read the device ID &
revision, which is why we now have an API that persists that to avoid
the delay.

Sorry this feedback is coming quite late into development.

Cheers,
Daniel
