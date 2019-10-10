Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48601C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6792067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfJJQXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 12:23:19 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45173 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJQXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 12:23:18 -0400
Received: by mail-vk1-f194.google.com with SMTP id q25so1471292vkn.12;
        Thu, 10 Oct 2019 09:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBjP/c0OKbAYMhFk+/MWcTlhvk8Dj6HOEt+fBr53HAk=;
        b=XOmUJOUlkWZe5ls4RwRWWg+kYqPnfYl1n0QN2bSuAuQ7fKRg9mrzL7z8p7OiXZH2zQ
         5ABBVXDJZVTyAGciqNWbQZPWoF0mm4tGkBiVrA/iwgqzn3H27I/dAQrKutyyuM5ZcrvC
         5bGgbCdVBbob7VuJGnXC+xvCR/TD+LnLsj6Jw06SmJpfDvnhCatRjaiEqIhl32KB6yO9
         W/z0o9eCcZYzZe/enOkk59WHbD0E9Qh7qidyYkv846uQSuOHQNNUpuPuW9nmEai27/k1
         b3oq6esB1oRmDuiR/mnCmxIzfDKoPNhIPw5osSWI+DL7uLIoir8PHyesPIfPCmBS3K6l
         0FQw==
X-Gm-Message-State: APjAAAVViYlH2xP18Sw1YVa7K3X0875G8xb0y2e41iTK9cvSqMfd0wcd
        3mgW+jg6/5HaicasbadlBFNKSf7YxPjAKCUtyTU=
X-Google-Smtp-Source: APXvYqxR5nObCEPHTyxfZVEjMwGluSVjyDTAju7pr0IKOuLXRkT9sFsva0PDisUmx53NIWYO7d0j9h/xhWamFO8Of1Y=
X-Received: by 2002:a1f:3811:: with SMTP id f17mr5853576vka.56.1570724597472;
 Thu, 10 Oct 2019 09:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191008230038.24037-1-ezequiel@collabora.com>
 <20191008230038.24037-3-ezequiel@collabora.com> <20191009180136.GE85762@art_vandelay>
 <CAAEAJfDP0PsGAoRfGyDyWj7DxgP6nwwwA1_gwLQuVy-fRDa-UA@mail.gmail.com> <20191010160059.GJ85762@art_vandelay>
In-Reply-To: <20191010160059.GJ85762@art_vandelay>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Thu, 10 Oct 2019 12:23:05 -0400
Message-ID: <CAKb7UvhWWYcpmyMZgerdJiG=sZjQUBVkeEwev+PdYzBW6+xsbQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] drm/rockchip: Add optional support for CRTC gamma LUT
To:     Sean Paul <sean@poorly.run>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 12:01 PM Sean Paul <sean@poorly.run> wrote:
> > > > +static int vop_crtc_atomic_check(struct drm_crtc *crtc,
> > > > +                              struct drm_crtc_state *crtc_state)
> > > > +{
> > > > +     struct vop *vop = to_vop(crtc);
> > > > +
> > > > +     if (vop->lut_regs && crtc_state->color_mgmt_changed &&
> > > > +         crtc_state->gamma_lut) {
> > > > +             unsigned int len;
> > > > +
> > > > +             len = drm_color_lut_size(crtc_state->gamma_lut);
> > > > +             if (len != crtc->gamma_size) {
> > > > +                     DRM_DEBUG_KMS("Invalid LUT size; got %d, expected %d\n",
> > > > +                                   len, crtc->gamma_size);
> > > > +                     return -EINVAL;
> > > > +             }
> > >
> > > Overflow is avoided in drm_mode_gamma_set_ioctl(), so I don't think you need
> > > this function.
> > >
> >
> > But that only applies to the legacy path. Isn't this needed to ensure
> > a gamma blob
> > has the right size?
>
> Yeah, good point, we check the element size in the atomic path, but not the max
> size. I haven't looked at enough color lut stuff to have an opinion whether this
> check would be useful in a helper function or not, something to consider, I
> suppose.

Some implementations support multiple sizes (e.g. 256 and 1024) but
not anything in between. It would be difficult to expose this
generically, I would imagine. The 256 size is kind of special, since
basically all legacy usage assumes that 256 is the one true quantity
of LUT entries...

  -ilia
