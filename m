Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084AAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC16520657
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfC2UVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:21:43 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38447 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbfC2UVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:21:43 -0400
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1C9CEC0003;
        Fri, 29 Mar 2019 20:21:38 +0000 (UTC)
Message-ID: <22030c6eab5b054290ccce433e9a30d27af09c2c.camel@bootlin.com>
Subject: Re: [PATCH v2 1/2] drm/file: Rehabilitate the firstopen hook for
 non-legacy drivers
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Daniel Stone <daniel@fooishbar.org>, Eric Anholt <eric@anholt.net>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Fri, 29 Mar 2019 21:21:37 +0100
In-Reply-To: <CAPj87rMJGUGFpYaBf=itf1A7jeEzOjPcnDDS-6m69kJN_mGnww@mail.gmail.com>
References: <20190320154809.14823-1-paul.kocialkowski@bootlin.com>
         <20190320154809.14823-2-paul.kocialkowski@bootlin.com>
         <87zhpph4c2.fsf@anholt.net>
         <82618ee8c2a2380a62b1fb894e5c35c602e20f3d.camel@bootlin.com>
         <20190328185307.GZ2665@phenom.ffwll.local>
         <CAPj87rMmW_7Kiy==ZxvvmHXhQLWC+F=uxed442HpMMZr=MwjRA@mail.gmail.com>
         <5ed7c5f361bca47d3f9771f9ed27e28e2fccb179.camel@bootlin.com>
         <20190329152502.GO2665@phenom.ffwll.local>
         <901ea65c770c80e22c69032affe3b1a22652b608.camel@bootlin.com>
         <87r2appmz2.fsf@anholt.net>
         <CAPj87rMJGUGFpYaBf=itf1A7jeEzOjPcnDDS-6m69kJN_mGnww@mail.gmail.com>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2019-03-29 at 18:42 +0000, Daniel Stone wrote:
> Hi,
> 
> On Fri, 29 Mar 2019 at 18:14, Eric Anholt <eric@anholt.net> wrote:
> > Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> > > I'm not totally convinced that it's okay to have a delay outside of
> > > init/enumeration, even if it's a smaller delay.
> > 
> > You'll have non-dumb buffers created during GL context creation, so
> > early in xserver or other KMS-and-GL-using application init anyway.
> > Seems like a perfectly fine plan to me.
> 
> Yeah. The alternative is doing it once when Plymouth starts, and then
> maybe again when Weston/GNOME/Xorg/... starts, which isn't really
> ideal (or maybe even udev helpers). Doing it on probe also complicates
> profiling startup for those: if GL context or surface creation takes a
> long time, that's easy to reason about. If opening an FD takes ages,
> that makes figuring out why stuff is slow a lot more complicated. This
> used to happen with RPM resume for PCI devices to read the device ID &
> revision, which is why we now have an API that persists that to avoid
> the delay.

Sounds like we have a plan then, I'll spin up a new series allocating
the binner BO at the first non-dumb BO alloc. Thanks for your input!

> Sorry this feedback is coming quite late into development.

The feedback is definitely quite welcome! I tried a few things that
didn't pan out before using firstopen/lastclose and it's really
interesting to refine the implementation based on the shortcomings of
previous ideas.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

