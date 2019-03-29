Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD67C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F942173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="PedOaR5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfC2JKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:10:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41895 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfC2JJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:09:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so1257363lja.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GemOod5OuJWcPDnXeTGSzwleNGc3BEqEkmSy03ihuxc=;
        b=PedOaR5fN/ZT1p0xBNoGf9vVte8bkdfd5fn97nhIN8iJ+kqqNoJDyW1fD117sjFMz2
         9pLzEXi4HT5HE62aAm9uW8hBqeau8OAFlQiEmJmfXRIcn/l18nGY7bQW3+YVfxn6jRPl
         uo2CKAsYjPOM0c8CDqT8lo7MXUmBVqKFGB4SOpk5Dl1S8TxFHbdaJWTp4VnME5EHpask
         CqvObHQ0yPhbZIqzJwIXawvLhGDhlSrT++AW5lLzZmyx4ddIDc7duIwTpmsLO9VeaNeR
         uQZK+d+u56ChdxI0RiDgW1td98aNdZQgbEP/m9e5xUmau02Zb9j5rIrCcsI7DviM2vF9
         7Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GemOod5OuJWcPDnXeTGSzwleNGc3BEqEkmSy03ihuxc=;
        b=N8leM4HWE3deqSrmcfRkr929+6nkXz6JxVS4P8IBURh3687Q45Ajlu8XA5Jzi5YCK/
         iZagKxLjab/3onFKnvLOrvchddKluHqLFC7hQuBURH71/CiMK+qQas5MoeR5vMTz3p1x
         WmMHMMtpSHEYiMhIggtvX4HlqACGF/lvKglDWOxWqoOzt+konGkFgA4QGNa3OXnha3Lw
         Dzr5vEwEa1FOC5SD5/3uDxTFWcBn1JVY1ZEwqvGsTv+x1QUg/kL3ALg0EluQ2j+TtnId
         bSa40dRbA71VOwwRKUCS7ITTo2npW2LgaLsEpiq8teG5J0kQnuLg5UG5kauClA5dP61G
         Z+Cw==
X-Gm-Message-State: APjAAAVveNt/mC5U3CBS7I13ne6ZIzsGPtqO094t61Km2AvEatOOgzKi
        tycVzrasod87nPJS9DAD30qQJDEyBcO44ZiZjKcyOg==
X-Google-Smtp-Source: APXvYqyqKF0lvsN/AX2WwaD0XBtQc0JiTXbxWUariYq5vB2wERJUsnUF7VzLdJzXjZwtj+Aq90TCwdb9/ThyNqSEXPQ=
X-Received: by 2002:a2e:240a:: with SMTP id k10mr25862421ljk.31.1553850597590;
 Fri, 29 Mar 2019 02:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190320154809.14823-1-paul.kocialkowski@bootlin.com>
 <20190320154809.14823-2-paul.kocialkowski@bootlin.com> <87zhpph4c2.fsf@anholt.net>
 <82618ee8c2a2380a62b1fb894e5c35c602e20f3d.camel@bootlin.com> <20190328185307.GZ2665@phenom.ffwll.local>
In-Reply-To: <20190328185307.GZ2665@phenom.ffwll.local>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Fri, 29 Mar 2019 09:09:46 +0000
Message-ID: <CAPj87rMmW_7Kiy==ZxvvmHXhQLWC+F=uxed442HpMMZr=MwjRA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/file: Rehabilitate the firstopen hook for
 non-legacy drivers
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Eric Anholt <eric@anholt.net>,
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

On Thu, 28 Mar 2019 at 18:53, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Mar 21, 2019 at 04:27:06PM +0100, Paul Kocialkowski wrote:
> > I don't see other options either, and using firstclose/lastopen feels
> > overall more readable in the driver code.
> >
> > I'm not sure there is such a big overhead associated with allocating
> > the binner BO (it seems that the current implementation tries to alloc
> > until the specific memory constraints for the buffer are met, so
> > perhaps that can take time). But if there is, I suppose it's best to
> > have that when starting up rather than delaying the first render
> > operation.
>
> I'm not entirely buying the "we don't need this for fbcon only" argument -
> there's plenty of dumb kms clients too (boot splash and whatever else
> there might be). If you don't want to keep this around I think allocating
> on first non-dumb bo allocation and dropping it when the last such fd
> closes sounds like a much better idea. Needs a bit more state, you need to
> track per drm_file whether you've already allocated a non-dumb bo, and a
> drm_device refcount, but that's not much. Firstopen feels like the wrong
> thing.
>
> Another option would be first_renderopen or something like that, except
> you can also render on the legacy node and I'm not sure how much there's a
> demand for this in other drivers. In the end you have open/close
> callbacks, you can do all the driver specific things you want to do in
> there.

I'd like to avoid doing it in open where possible, since that hurts
device enumeration from userspace.

Cheers,
Daniel
