Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBFEC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A742189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563986725;
	bh=oK5t/PL8WcOVCFcv86Gw02DGqzqgmltoUOuxGNqt6Zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NWLDZnyVu2uY/rwlIEgUNzstkvytssRNnaN4/tFxn/JUPq6Fgabr/spbzr1oWDISo
	 xaZc/3E4HR6WsGSKePRq6Ri8mybuDn83QZEwtsimnGuiYDyel8UlyZ+gMJLEp+krPg
	 6dWJb+5T8Xk6n+GkPMwFNXAdtr2DFV4SlAh1rApY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbfGXQpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387587AbfGXQpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:45:24 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53B6821951
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563986723;
        bh=oK5t/PL8WcOVCFcv86Gw02DGqzqgmltoUOuxGNqt6Zc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m8VMnvraXywFQynfV8V3aXOYEnGYm741q6++csDVAfQDWzNSrzMOXX2FPtus/HCMT
         p9cc03h+ORrk6+h+ooxu/GmU+b3duUc01qQmVvKeGQ036aE7jcP5Cr3mwARAzIH7p6
         HRwqCbKuxSe4MmnlUD3GoFva2hyc/Xanj97WWIW8=
Received: by mail-qt1-f171.google.com with SMTP id a15so46120184qtn.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:45:23 -0700 (PDT)
X-Gm-Message-State: APjAAAWCfzO6HBjn9FZJWIL37SJ7QQsCrKsJBcJanMMj422wjvfu9loF
        ZdjvrNqKQ/ONGmXxyeheUg0+IqOPtJEqqJwHkw==
X-Google-Smtp-Source: APXvYqyCNZd8sLbz/UaQBpNaOntVldKJOFDIAKknv8f9hE6ETbDZiRfRG83c+wEdJMfXUbzA73OQCzHtkVc5LaOtHE0=
X-Received: by 2002:aed:3f10:: with SMTP id p16mr58310435qtf.110.1563986722543;
 Wed, 24 Jul 2019 09:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190724105626.53552-1-steven.price@arm.com> <CAL_JsqLkxKe=feVQDb3VXqOnA7fvDBEKWgLf2suOHhNLnR704Q@mail.gmail.com>
 <20190724164004.GA8255@kevin>
In-Reply-To: <20190724164004.GA8255@kevin>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 24 Jul 2019 10:45:11 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+cLg5R=SJ0zjfVqYB_So-gHT3qb16wcOCbrHuufSZgLw@mail.gmail.com>
Message-ID: <CAL_Jsq+cLg5R=SJ0zjfVqYB_So-gHT3qb16wcOCbrHuufSZgLw@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Export all GPU feature registers
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:40 AM Alyssa Rosenzweig
<alyssa.rosenzweig@collabora.com> wrote:
>
> This is definitely helpful!
>
> My one concern is, supposing userspace really does need all of this
> information, is it wasteful to have to do 30+ ioctls just to get this?
> kbase had a single ioctl to grab all of the properties, whether
> userspace wanted them or not. I'm not sure if that's better -- the two
> approaches are rather polar opposites.

I think this ship already sailed when we added the first one with
GPU_ID. Also, at least etnaviv works the same way.

>
> Granted this would be on driver init so not a critical path.

Exactly.

>
> On Wed, Jul 24, 2019 at 10:27:03AM -0600, Rob Herring wrote:
> > Adding Alyssa's Collabora email.
> >
> > On Wed, Jul 24, 2019 at 4:56 AM Steven Price <steven.price@arm.com> wrote:
> > >
> > > Midgard/Bifrost GPUs have a bunch of feature registers providing details
> > > of what the hardware supports. Panfrost already reads these, this patch
> > > exports them all to user space so that the jobs created by the user space
> > > driver can be tuned for the particular hardware implementation.
> > >
> > > Signed-off-by: Steven Price <steven.price@arm.com>
> > > ---
> > >  drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
> > >  drivers/gpu/drm/panfrost/panfrost_drv.c    | 38 +++++++++++++++++++--
> > >  drivers/gpu/drm/panfrost/panfrost_gpu.c    |  2 ++
> > >  include/uapi/drm/panfrost_drm.h            | 39 ++++++++++++++++++++++
> > >  4 files changed, 77 insertions(+), 3 deletions(-)
> >
> > LGTM. I'll give it a bit more time to see if there are any comments
> > before I apply it.
> >
> > Rob
