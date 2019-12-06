Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DD3C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D97021823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Z+tCKCo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfLFKSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:18:47 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43911 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfLFKSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:18:47 -0500
Received: by mail-oi1-f194.google.com with SMTP id x14so2134465oic.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 02:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQbD0TaQnCCyjdF8tYf2x8M1VesCn+pzXeR/60dguDg=;
        b=Z+tCKCo5OHTC3bBUN022In54CQxWvkmO+8Z2DhcuZjNic0NPoTnvHMsDdKVOa69cFj
         64V8mXaD0aJoVnaMUZqPi9bUdgwowDOcB6GuyzWXSAOsefH/2O6h845owjqLpIcq32Up
         +3mXqrfoWHcEy9zKltpqdfnc/r5vDrE3pMuyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQbD0TaQnCCyjdF8tYf2x8M1VesCn+pzXeR/60dguDg=;
        b=dOn1AowkNXjN6+aUGf7q3PFp29s8SDzShZ+KUyQdSVNENEmAU9e+OZgZTo3sOyUyas
         n+CxhGP7siM7lTP8dyksB/c29RnbHQ5wiBpGmbm85r3sYRk94ECFtuUKE2rFxIZL/LRV
         iGd5aEvuO/Qq45MmDDHvd2UUsylKvHTbjss5Ra/nEQrfCAX67dyVT4/sjxkWC0G+CB/U
         H8+PQPeEiRKByUn/kigU9/CC+S1Rk4lKfA5IJfh5f9wWywOfc2lUH/vjT6Olh8asTHCu
         w2N9pK/iqMLEJxHceNYF1eVaSV7MxqCT/6qhtJjP0PZBJRUOh6In4fqB6byhcGnfQaXI
         0THg==
X-Gm-Message-State: APjAAAVaPpRThMxeUEBYl+q1OyhXWeJD3KAJ3NMH1gYW/dhKj3gbSO50
        Y7QVIA2RsAgyBF1HbIM4Lf4Ya8ueGBtXmyVz3h4HCg==
X-Google-Smtp-Source: APXvYqySrkijux/w9xw8znz+Eu74QnKoOVApoFziVtlnvs01v7V4F/uKzjr8d+Viy7fuwMggVjIh+o9nwzMAQf5zPmQ=
X-Received: by 2002:a54:440d:: with SMTP id k13mr11773948oiw.128.1575627525771;
 Fri, 06 Dec 2019 02:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20191127092523.5620-1-kraxel@redhat.com> <20191127092523.5620-2-kraxel@redhat.com>
 <20191128113930.yhckvneecpvfhlls@sirius.home.kraxel.org> <20191205221523.GN624164@phenom.ffwll.local>
 <20191206100724.ukzdyaym3ltcyfaa@sirius.home.kraxel.org>
In-Reply-To: <20191206100724.ukzdyaym3ltcyfaa@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 6 Dec 2019 11:18:34 +0100
Message-ID: <CAKMK7uH==kE_ViKioJgpDRqFq-ROhws7atwwxcmu=Bwt9ZF52Q@mail.gmail.com>
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

On Fri, Dec 6, 2019 at 11:07 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Dec 05, 2019 at 11:15:23PM +0100, Daniel Vetter wrote:
> > On Thu, Nov 28, 2019 at 12:39:30PM +0100, Gerd Hoffmann wrote:
> > > On Wed, Nov 27, 2019 at 10:25:22AM +0100, Gerd Hoffmann wrote:
> > > > The fake offset is going to stay, so change the calling convention for
> > > > drm_gem_object_funcs.mmap to include the fake offset.  Update all users
> > > > accordingly.
> > > >
> > > > Note that this reverts 83b8a6f242ea ("drm/gem: Fix mmap fake offset
> > > > handling for drm_gem_object_funcs.mmap") and on top then adds the fake
> > > > offset to  drm_gem_prime_mmap to make sure all paths leading to
> > > > obj->funcs->mmap are consistent.
> > > >
> > > > v3: move fake-offset tweak in drm_gem_prime_mmap() so we have this code
> > > >     only once in the function (Rob Herring).
> > >
> > > Now this series fails in Intel CI.  Can't see why though.  The
> > > difference between v2 and v3 is just the place where vma->vm_pgoff gets
> > > updated, and no code between the v2 and v3 location touches vma ...
> >
> > Looks like unrelated flukes, this happens occasionally. If you're paranoid
> > hit the retest button on patchwork to double-check.
> > -Daniel
>
> Guess you kicked CI?  Just got CI mails, now reporting success, without
> doing anything.  So I'll go push v3 to misc-next.

Yeah I kicked it, since iirc you need your patchwork account to be
treated with the re-run powers first. Might want to get those with a
quick ping on irc, it's useful.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
