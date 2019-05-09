Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37920C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073BB21744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="wALPIkKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfEILaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:30:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43066 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEILaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:30:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id r3so1975067qtp.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fefsIyQlS+PE1KzrJIi4KuRCpKpBYyPVtYH4pxbYOj8=;
        b=wALPIkKCc39G4Zkl7NKUawBtHAYQtGjWHx1k3+tbvjSXA+91dfV+Kb0+1XFKKIZQg8
         2mAwkEAwNFB9ULY2ivgN16hqSC7KnZGaKNzKqacIJUnIhoORA/DDdAXTfbhVunnqRn5M
         kE1uoGOtMfFzDL567wwUzzZwReiOXGgAiZEisDP/J2TL5h4gTTGAf+EBM9nnYD40zeQB
         RXtkmbg71Wmzw/qR1biIpmb+dqiCeyc67hV+npuKSANz1Js0YRkJu9WMy7/zXKbmNoeD
         nDqX2IL/d+R4aGjbeioBqzoNjvCJxptaEQgjh3+Vviz0B8/ibfncRts1g5+RCABe3r9j
         d9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fefsIyQlS+PE1KzrJIi4KuRCpKpBYyPVtYH4pxbYOj8=;
        b=UJbwCDsXQuSrZaIi6zt+YUk6GoXedVufb8lvnek9rIcbVp1Hh/FVIznLKpL9NDwncA
         67H/RtgpQPLNDddAh7URZB/Wc3epvkp4Er3lM6sE1SyNlDZ0wHdzbnKH4cp2Xl4vE6nm
         o4Au3rVKiivJ8wLXfG3XPvMl53Zg1FLR1fZ8yd7w0N1vSm+a3K1VsOh2ZWr0Q4zCwrx8
         hFk7VD3ZZLtr8+xA5wCK2OGWmicxbWQCXMbrWA6+xpdHcZS5rfvRfs0unRM83dM78eft
         WNrekpcKxqDadgN0/740s3vBetaL39idwLymtkbbU1L87sSAugyylnXzLuQ9u/vBCB0f
         VyFg==
X-Gm-Message-State: APjAAAXIne3qx7xNTI/pFgRd3wmUqGzoqZ1MPV140FbrMIL4bDh0NI03
        V+iNheXOKft05FVYyvHeP6crRsjiwheTcu0qz1gWVQ==
X-Google-Smtp-Source: APXvYqxhavDoDtncVVFpIMi2Xg5cRbGsIlttaMiV4M0Hm30viC0bzcfLCkHLvFoeZx0WTa6gNj44afmdX5+0JioEY9c=
X-Received: by 2002:a0c:b99c:: with SMTP id v28mr3054612qvf.10.1557401399660;
 Thu, 09 May 2019 04:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190423092810.28359-1-jian-hong@endlessm.com>
 <155613593248.25205.769591454199358982@skylake-alporthouse-com> <15be67b19d898ab74c9ae6d9d9080ef339772e00.camel@intel.com>
In-Reply-To: <15be67b19d898ab74c9ae6d9d9080ef339772e00.camel@intel.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 9 May 2019 19:29:48 +0800
Message-ID: <CAD8Lp462rLGnnTLCSOoMWwU37bxCk1cznsw8==Z8AgumeqHXkQ@mail.gmail.com>
Subject: Re: [PATCH] i915: disable framebuffer compression on GeminiLake
To:     Paulo Zanoni <paulo.r.zanoni@intel.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Thu, Apr 25, 2019 at 4:27 AM Paulo Zanoni <paulo.r.zanoni@intel.com> wro=
te:
>
> Em qua, 2019-04-24 =C3=A0s 20:58 +0100, Chris Wilson escreveu:
> > Quoting Jian-Hong Pan (2019-04-23 10:28:10)
> > > From: Daniel Drake <drake@endlessm.com>
> > >
> > > On many (all?) the Gemini Lake systems we work with, there is frequen=
t
> > > momentary graphical corruption at the top of the screen, and it seems
> > > that disabling framebuffer compression can avoid this.
> > >
> > > The ticket was reported 6 months ago and has already affected a
> > > multitude of users, without any real progress being made. So, lets
> > > disable framebuffer compression on GeminiLake until a solution is fou=
nd.
> > >
> > > Buglink: https://bugs.freedesktop.org/show_bug.cgi?id=3D108085
> > > Signed-off-by: Daniel Drake <drake@endlessm.com>
> > > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> >
> > Fixes: fd7d6c5c8f3e ("drm/i915: enable FBC on gen9+ too") ?
> > Cc: Paulo Zanoni <paulo.r.zanoni@intel.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: <stable@vger.kernel.org> # v4.11+
> >
> > glk landed 1 month before, so that seems the earliest broken point.
> >
>
> The bug is well reported, the bug author is helpful and it even has a
> description of "steps to reproduce" that looks very easy (although I
> didn't try it). Everything suggests this is a bug the display team
> could actually solve with not-so-many hours of debugging.
>
> In the meantime, unbreak the systems:
> Reviewed-by: Paulo Zanoni <paulo.r.zanoni@intel.com>

Quick ping here. Any further comments on this patch? Can it be applied?

Thanks
Daniel
