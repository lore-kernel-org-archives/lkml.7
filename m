Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1A6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A50206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpQYBnfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbfHAQDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:03:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35041 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731613AbfHAQDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:03:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id w20so69650298edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bv7pMvKKkwIVkPngNqkQL32dHUrGECTsk1mbuiRZ6Y=;
        b=cpQYBnfEwZGYGSuEI2Ta4BNuagzeeveyUz78G9FTN/tEe0rihxa0KsOcTqnGSxQNRf
         dj4Cf9pzh7oWs8AYlaBz0ofguT7UGDU7TtKIT+WpbHaYXrC9s89pSKJ2WGlYdnQ7lOY/
         KRAOd4GNhuLR+xbgjoWetjCgl//kZ55tckwtc0oHXCm8GCu7b+fG5t//mOtL5IrAb1bC
         0LfUCA691M+CFnBBDYy48eNc4LflS+Oxz5WO4h4mO40KGl8daErq80zimXP8vyo65gox
         FDvsLqNFNUo6YlMFC+Vke9U3nG6yVZBhdofiu2gdUP5cpecifP7ZOsqxar3TS2/rS9qK
         Onlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bv7pMvKKkwIVkPngNqkQL32dHUrGECTsk1mbuiRZ6Y=;
        b=QXVUWzIAFQu7vnBfYymCHh4XpAAAkHQ832eF2t6sWMco2x2mxPB2OFrSuYCh9Moo6V
         P/i6jSoZPa7XoDAUPTl/+s07pkf883cRaCAbvmnAuZoE0yRobBlxUHo6XKYcuKUyNiP2
         JWq7hW7jkFUHkLebOOa5R+3UXCBm0n64MPc1ej7AJsPlR0k9qhGVSIuy/FdTbz+K/dwF
         JvFau8OGKPPqooUOVA+O4nnRgJmePYuFoeFl/BlWIqYttAZieRgeFEdk8kvyjZYX+tNU
         wP7BqNut6/cpmxwGr5te2eLDMS/GjaW2gGGRKOu/BF1o/I1iIA9KwAn9WVHRjZQTq42k
         AMTA==
X-Gm-Message-State: APjAAAX/hdqWOO8AMjjabir5CsY2/2UwFAtSqbCjRh5X4pCbdGjhlMeJ
        1ISeubGxPCvJ4Sg4WDTXc0QoQGXg0YNm6NkDVBs=
X-Google-Smtp-Source: APXvYqyGeWsq0Dm8RWkVsJdPxFY3QFmMuo8dBAKnYybjIiTjJZ5h1AzW8BLjHa9mjAuOwTiw16GRr4MzNTZoOO8pVdU=
X-Received: by 2002:a17:906:6bc4:: with SMTP id t4mr103366912ejs.256.1564675074054;
 Thu, 01 Aug 2019 08:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190717211542.30482-1-robdclark@gmail.com> <20190719092153.GJ15868@phenom.ffwll.local>
 <20190731192331.GT104440@art_vandelay> <156466322613.6045.7313079853087889718@skylake-alporthouse-com>
 <CAF6AEGu8K+PwRyY738aFyv+fdZ_UZDhY3XcFY-w4uLMW+w6X9Q@mail.gmail.com> <156467364918.6045.9820603183181141608@skylake-alporthouse-com>
In-Reply-To: <156467364918.6045.9820603183181141608@skylake-alporthouse-com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 1 Aug 2019 08:57:42 -0700
Message-ID: <CAF6AEGvZMxnvzBgzXTzgcJpuzGOE=YTt1-H09L2qSD==pBcPXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/vgem: fix cache synchronization on arm/arm64
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     David Airlie <airlied@linux.ie>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Eric Anholt <eric@anholt.net>,
        Eric Biggers <ebiggers@google.com>,
        Imre Deak <imre.deak@intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 8:34 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Rob Clark (2019-08-01 16:18:45)
> > On Thu, Aug 1, 2019 at 5:40 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > >
> > > Quoting Sean Paul (2019-07-31 20:23:31)
> > > > On Fri, Jul 19, 2019 at 11:21:53AM +0200, Daniel Vetter wrote:
> > > > > On Wed, Jul 17, 2019 at 02:15:37PM -0700, Rob Clark wrote:
> > > > > > From: Rob Clark <robdclark@chromium.org>
> > > > > >
> > > > > > drm_cflush_pages() is no-op on arm/arm64.  But instead we can use
> > > > > > dma_sync API.
> > > > > >
> > > > > > Fixes failures w/ vgem_test.
> > > > > >
> > > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > > > ---
> > > > > > An alternative approach to the series[1] I sent yesterday
> > > > > >
> > > > > > On the plus side, it keeps the WC buffers and avoids any drm core
> > > > > > changes.  On the minus side, I don't think it will work (at least
> > > > > > on arm64) prior to v5.0[2], so the fix can't be backported very
> > > > > > far.
> > > > >
> > > > > Yeah seems a lot more reasonable.
> > > > >
> > > > > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > >
> > > > Applied to drm-misc-fixes, thanks!
> > >
> > > But it didn't actually fix the failures in CI.
> >
> > Hmm, that is unfortunate, I'd assumed that silence meant latest
> > version was working in CI..
>
> Ah, takes a intel-gfx@ for CI to pick up patches atm.
>
> > dma_sync_sg_* doesn't work on x86?  It would be kinda unfortunate to
> > have vgem only work on x86 *or* arm..  maybe bringing back
> > drm_cflush_pages() could make it work in both cases
>
> I think it stems from the expectation that vgem provides "device
> coherency" for CPU access. From the testing perspective, it's nice to
> emulate HW interactions; but maybe that is just beyond the general
> capabilities and we cannot simply use vgem as we do currently. That
> would leave a hole for mocking prime in CI that needs filling :(

yeah, being a "fake" device makes things a bit rough..  (I wonder if
there is some way to do a VM w/ both virgl and i915/gvt to get some
more "real" testing?)

OTOH, I kinda want to make drm_cache work on arm64, since dma-mapping
is already problematic, which would make this patch unnecessary.  (I'm
still not entirely sure what to do about 32b arm..)

BR,
-R
