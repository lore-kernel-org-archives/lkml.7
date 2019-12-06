Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABABC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 11:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0138A21835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 11:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Gl+qSlNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLFLK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 06:10:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46412 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfLFLK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 06:10:27 -0500
Received: by mail-oi1-f194.google.com with SMTP id a124so5759870oii.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 03:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLu8PQob6R7INQhNcyi5eV/VwuZ3ViZfX5Cr/XgalEQ=;
        b=Gl+qSlNmaiBh0lNDEeK3wAVf56e6C5UDX83HhGX2mAZ0NU7ZMDBd5ZqrCdExodjS0m
         Wu9uL2ysiXsTj5+0JMTAvsUZCoXiKc1DPnp3tGKgifxfZZKBSRR21SCkXTuzVdC4l7ET
         PuOGIaoh+vqX5AjF6mwGN1EmWc/JfZ6nL4RIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLu8PQob6R7INQhNcyi5eV/VwuZ3ViZfX5Cr/XgalEQ=;
        b=lbspyZ8EbY71YtAx2alNO1Jxt1VZpKVl2+brZikHf1uKzYG7AB/elqlTlVq09K/n82
         6r7WGoZfzgWHTohIO62Q3YAa3w4s4SpC3U9qi35NQEc3xVO9yRsUxEt+f2Lkz9tdVgxs
         /4smvdSixePKdowEFTL05rLLD9h51Mq5fqflGHvvUgC2bdRJStEgjO+mAHAnIiLy9q3i
         IviyOAETQzw67GJqEfwZhcna/fwku9LGEnuaThlzo11NrG1qW4rgTgOutGRovXS9cM6s
         7QmVpchjchz4PNpmIM2bBOw9f+ugDVYxzf3AKILKiM5T03Y/7DNbmz41ukFfhbHIDjq0
         FhnQ==
X-Gm-Message-State: APjAAAXvvGkc73XcRzCP45SkLfKCNHcAc9LBLciumKl4kRrRqPQ/rE7V
        ID77TlJx/NV8NTFWNwm+OQkJPtxCapIWLXv+IYWtrg==
X-Google-Smtp-Source: APXvYqwOneJdtD1ZXuC72wTUlo4WXxW+SIIYiQGT6fyPkbbuOUD9Np8+lzYh2iG8qelEE2FENTDJM+w77++vv8XFiOI=
X-Received: by 2002:aca:d985:: with SMTP id q127mr11318982oig.132.1575630626520;
 Fri, 06 Dec 2019 03:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20191127092523.5620-1-kraxel@redhat.com> <20191127092523.5620-2-kraxel@redhat.com>
 <20191128113930.yhckvneecpvfhlls@sirius.home.kraxel.org> <20191205221523.GN624164@phenom.ffwll.local>
 <20191206100724.ukzdyaym3ltcyfaa@sirius.home.kraxel.org> <20191206102200.6osisct57n424ujn@sirius.home.kraxel.org>
In-Reply-To: <20191206102200.6osisct57n424ujn@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 6 Dec 2019 12:10:15 +0100
Message-ID: <CAKMK7uF=wZ8snurJwftyjVD2ExutfzNUGGhy8=UVFYf3=sz7qQ@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v3 1/2] drm: call drm_gem_object_funcs.mmap
 with fake offset
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 11:22 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Dec 06, 2019 at 11:07:24AM +0100, Gerd Hoffmann wrote:
> > On Thu, Dec 05, 2019 at 11:15:23PM +0100, Daniel Vetter wrote:
> > > Looks like unrelated flukes, this happens occasionally. If you're paranoid
> > > hit the retest button on patchwork to double-check.
> > > -Daniel
> >
> > Guess you kicked CI?  Just got CI mails, now reporting success, without
> > doing anything.  So I'll go push v3 to misc-next.
>
> Oops, spoke too soon.  Next mail arrived.  Fi.CI.BAT works, but
> Fi.CI.IGT still fails.
>
> Where is the "test again" button?  Can I re-run the tests on v2?  Right
> now I tend to commit v2 to have a fix committed, then go figure why v3
> fails ...

Top of the mail you get from CI is the link to the patchwork series.
That contains all the same info like in the mail, plus the coveted
button. If failures look similar then yes I guess v3 is somehow
broken. But I've looked, looks like just 2x unrelated noise and you
being unlucky, so imo totally fine to push v3. I'll give CI folks a
heads-up (best done over irc usually).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
