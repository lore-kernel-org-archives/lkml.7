Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1763C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79566217D6
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNrTD/eg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbfHAPS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:18:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40182 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730835AbfHAPS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:18:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so69503310eds.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gIfSabpVp9eE7lJHzBppB62vKhN84Wb7zIuuCObxbsE=;
        b=ZNrTD/egNWyggNQI4aKhw3rt484V0kvyB4GuTDajjJPMP/vSaPJ0VuKljCqlbb+P5A
         hiRrdAK2QJlU7pZ92i3/6LTZgDwgXzRHGJeelw/vI2reaGscjHx1CxZiBhfL960X6Ml+
         TfZdbaazxJGcfI2xZ1kF0Z1/sVrMw6Sq9ea+zlCmGiovy2qkcz0EUWurWeapH8GvMTni
         12OJLt1vEQYnJKMakup4T/6eArPfE72r6UQ4h9n3BY/xPpxWimbCg7s6E108ASiiW1qI
         eVS9DIQBAFDZmVUk4nZDVsgHA/Z3b12+wE+0CJbESVN03dDSpW8pM3e7reqOp1fVXXnj
         Obbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIfSabpVp9eE7lJHzBppB62vKhN84Wb7zIuuCObxbsE=;
        b=hh0Z19e1R34z1MLK/Bk1fN3YF2XLxpNja0052H3tXMbeX9wZcmJV803VeVWEQvir6N
         fqO3dbfPNwh7cToSBEMMXgh34fnveuLzIVIPVJjZDMpaXVvdlWMqoUTqX4coPecSOhp6
         Zl40vI/9XUqZEfPWXsfmen3f3RfFH/AbDtcLc9ctORuOpInSketAj2Px84ylBUs9nTO4
         y34qcwm9ldvCJ9PSZQkJYSR8VXJjMsuhBC3JSrVeXvKu/LuSb2aeIhAvtXlTT2wtKCzj
         00IOCjZdVzmJrmg3p36LJTlMS/7yFACo0DXbOfcmZKe3RMtqOhGH7mcPvq10PSJ2bzVp
         ZUZA==
X-Gm-Message-State: APjAAAWq7+28w7kEFFpKSZFTzrSXDAS3VKrfsJ586bIvrqMyA1PmMMXv
        7ZeV3hBlheS1uDLLASkbieMh3fnAKTsuoflOleg=
X-Google-Smtp-Source: APXvYqxi0dJxQtEdKZtFvGG3TF56BLjVuzQQjIsbAkPejhzpILAjKGsAIJYs66UGezOdwa7K1pdcB1cSy+80rGdyxho=
X-Received: by 2002:a17:906:3612:: with SMTP id q18mr102805422ejb.278.1564672736964;
 Thu, 01 Aug 2019 08:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190717211542.30482-1-robdclark@gmail.com> <20190719092153.GJ15868@phenom.ffwll.local>
 <20190731192331.GT104440@art_vandelay> <156466322613.6045.7313079853087889718@skylake-alporthouse-com>
In-Reply-To: <156466322613.6045.7313079853087889718@skylake-alporthouse-com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 1 Aug 2019 08:18:45 -0700
Message-ID: <CAF6AEGu8K+PwRyY738aFyv+fdZ_UZDhY3XcFY-w4uLMW+w6X9Q@mail.gmail.com>
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

On Thu, Aug 1, 2019 at 5:40 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Sean Paul (2019-07-31 20:23:31)
> > On Fri, Jul 19, 2019 at 11:21:53AM +0200, Daniel Vetter wrote:
> > > On Wed, Jul 17, 2019 at 02:15:37PM -0700, Rob Clark wrote:
> > > > From: Rob Clark <robdclark@chromium.org>
> > > >
> > > > drm_cflush_pages() is no-op on arm/arm64.  But instead we can use
> > > > dma_sync API.
> > > >
> > > > Fixes failures w/ vgem_test.
> > > >
> > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > ---
> > > > An alternative approach to the series[1] I sent yesterday
> > > >
> > > > On the plus side, it keeps the WC buffers and avoids any drm core
> > > > changes.  On the minus side, I don't think it will work (at least
> > > > on arm64) prior to v5.0[2], so the fix can't be backported very
> > > > far.
> > >
> > > Yeah seems a lot more reasonable.
> > >
> > > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > Applied to drm-misc-fixes, thanks!
>
> But it didn't actually fix the failures in CI.

Hmm, that is unfortunate, I'd assumed that silence meant latest
version was working in CI..

dma_sync_sg_* doesn't work on x86?  It would be kinda unfortunate to
have vgem only work on x86 *or* arm..  maybe bringing back
drm_cflush_pages() could make it work in both cases

BR,
-R
