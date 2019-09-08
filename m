Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145AEC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F8D21744
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbfIHB67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 21:58:59 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40461 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfIHB67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 21:58:59 -0400
Received: by mail-vs1-f67.google.com with SMTP id v10so3320272vsc.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 18:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wvcp3nV7La4YoI+ieadHx02sDBCIHvis3wKPKJAabs=;
        b=b6HiGLnU9c7DdRS2rxcupMjmCs9fFhUZamLF97Axg54X2UqhBrg58HEi5PNBQ6fxzn
         my02Hvw7Z33rRD8svkRf6HT4pmCSZ8VP7yJupuH5styJ6mobAAy7Ih2e4g+R9tAMpLLf
         BRKsStguEpfQGKkBR+xQqblSxWX5v5OHF1QPV5md7tfVUCllgY+sSlkU3Cw2wGjunibS
         57yASjQpOf5K4H8sYUUflZrA4elX1cI152czf2vkiLFxPDtw+sC7vgR6jlhQwIu9rmv8
         ah9nLTVC+OTTxYr+xgc4slKo6Qy7T5GbcYx2jWozpnR0caX2ErYTMKW1WFXceLB7cKV0
         JYlg==
X-Gm-Message-State: APjAAAV1zc/99h5FXlUcLsEJFmdwcakURZnwyAMpjBtKWc800weY9TD6
        FCgVraMo1I/rWaRK9Tu0+DxB3UfDpEWhgqJZvl4=
X-Google-Smtp-Source: APXvYqylZV390V/V1oizqnab5+4dm12EOj8yZUV8cYoKWUvOfP7UehtT5iz9+JYf89ReeVrKsPeKsLwhqt0H+c6F8EM=
X-Received: by 2002:a67:db12:: with SMTP id z18mr7697263vsj.18.1567907937861;
 Sat, 07 Sep 2019 18:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190805140119.7337-1-kraxel@redhat.com> <20190805140119.7337-9-kraxel@redhat.com>
 <20190813151115.GA29955@ulmo> <20190814055827.6hrxj6daovxxnnvw@sirius.home.kraxel.org>
 <20190814093524.GA31345@ulmo> <20190814101411.lj3p6zjzbjvnnjf4@sirius.home.kraxel.org>
 <CACAvsv5Rar9F=Wf-9HBpndY4QaQZcGCx05j0esvV9pitM=JoGg@mail.gmail.com> <20190821115523.GA21839@ulmo>
In-Reply-To: <20190821115523.GA21839@ulmo>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Sat, 7 Sep 2019 21:58:46 -0400
Message-ID: <CAKb7UvjXq0ptiPYu5EGH6sJAbbRjN3X4f_knrxyOHD1Zi7P1BA@mail.gmail.com>
Subject: Re: [Nouveau] [Intel-gfx] [PATCH v6 08/17] drm/ttm: use gem vma_node
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ben Skeggs <skeggsb@gmail.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        linux-graphics-maintainer@vmware.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        spice-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 7:55 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Aug 21, 2019 at 04:33:58PM +1000, Ben Skeggs wrote:
> > On Wed, 14 Aug 2019 at 20:14, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > >   Hi,
> > >
> > > > > Changing the order doesn't look hard.  Patch attached (untested, have no
> > > > > test hardware).  But maybe I missed some detail ...
> > > >
> > > > I came up with something very similar by splitting up nouveau_bo_new()
> > > > into allocation and initialization steps, so that when necessary the GEM
> > > > object can be initialized in between. I think that's slightly more
> > > > flexible and easier to understand than a boolean flag.
> > >
> > > Yes, that should work too.
> > >
> > > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> > Acked-by: Ben Skeggs <bskeggs@redhat.com>
>
> Thanks guys, applied to drm-misc-next.

Hi Thierry,

Initial investigations suggest that this commit currently in drm-next

commit 019cbd4a4feb3aa3a917d78e7110e3011bbff6d5
Author: Thierry Reding <treding@nvidia.com>
Date:   Wed Aug 14 11:00:48 2019 +0200

    drm/nouveau: Initialize GEM object before TTM object

breaks nouveau userspace which tries to allocate GEM objects with a
non-page-aligned size. Previously nouveau_gem_new would just call
nouveau_bo_init which would call nouveau_bo_fixup_align before
initializing the GEM object. With this change, it is done after. What
do you think -- OK to just move that bit of logic into the new
nouveau_bo_alloc() (and make size/align be pointers so that they can
be fixed up?)

Cheers,

  -ilia
