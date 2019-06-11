Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73935C0650E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6472173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BLs92YLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405721AbfFKTlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:41:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37621 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387563AbfFKTlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:41:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id r10so13094996otd.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GulUsqBf8T027861ToGt8N8Fkx90aYJ3H5Xyw39pJCk=;
        b=BLs92YLhBG37uFU+cv1zbVt054d9bpwDQzV1xZdsuQvcZDtafmxwl3DJq0QAi99ly3
         fTguFr0mXqAua8mxzGmXTgGYpHcfHxqRKkJpiGKRnDImCIFJ1PVOtToClVzTp0NXuMhg
         TzGHhfcrfHwSFtwxEU3vqrb6CJ3kaZAF1OmBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GulUsqBf8T027861ToGt8N8Fkx90aYJ3H5Xyw39pJCk=;
        b=V2N4GG0K76bTVSG+cNUMfIhuRHbBDPSiLlToankXQPEBeEVhVm6xH47dqdhUgUhyKh
         kgeRwVou0Ql6dNKGa+H73AS4ojO56cRZToGb1YMgLSaS136QUOyVPhCqommA9B024hAP
         CzxkZXPHolPsjGUjWsU6AcPGgnlUKYQpAiIRsGn4nySLgmPypYxUjb23SaB+APgC6UZl
         dDx8Ixz4UsYTtXU1n/snRd7+66kQiZs9FHj1niAHLQx8Pl65Mfyt7YnmW7or0dTuknPd
         KmmV2iNJiSaMVUShMkSbtNTndsr0SyDsHXUBqUb74hnEcz3XvykoGPX6lbi9pl1/EGCg
         98hQ==
X-Gm-Message-State: APjAAAUjgdtnbEkbs1iHCtqltaEuak42b1CxjH5Kihh8WpGmV7ECuvGl
        vHnKaU/axtk72Zdt6xXg6jRfHmd1OGzbiA1I9DA4oA==
X-Google-Smtp-Source: APXvYqylT3xp9u/Ufj7vpvMygQsyUsKKPYr6kWcupwMqFgM4VF/sbqAy0s68jrFuWrsPCzr+0e0GPUHeTTSPqdpHLwk=
X-Received: by 2002:a9d:7451:: with SMTP id p17mr4483924otk.204.1560282111688;
 Tue, 11 Jun 2019 12:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <87k1dsjkdo.fsf@turtle.gmx.de> <20190611153656.GA5084@kroah.com>
 <CAKMK7uH_3P3pYkJ9Ua4hOFno5UiQ4p-rdWu9tPO75MxGCbyXSA@mail.gmail.com> <87ef40j6mx.fsf@turtle.gmx.de>
In-Reply-To: <87ef40j6mx.fsf@turtle.gmx.de>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 11 Jun 2019 21:41:40 +0200
Message-ID: <CAKMK7uGTmb8SiTW+6mjovJwmrZYqhJY84ZyD5ozM_ynTBoOjGg@mail.gmail.com>
Subject: Re: Linux 5.1.9 build failure with CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT=n
To:     Sven Joachim <svenjoac@gmx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 8:53 PM Sven Joachim <svenjoac@gmx.de> wrote:
>
> On 2019-06-11 19:33 +0200, Daniel Vetter wrote:
>
> > On Tue, Jun 11, 2019 at 5:37 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >> On Tue, Jun 11, 2019 at 03:56:35PM +0200, Sven Joachim wrote:
> >> > Commit 1e07d63749 ("drm/nouveau: add kconfig option to turn off nouveau
> >> > legacy contexts. (v3)") has caused a build failure for me when I
> >> > actually tried that option (CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT=n):
> >> >
> >> > ,----
> >> > | Kernel: arch/x86/boot/bzImage is ready  (#1)
> >> > |   Building modules, stage 2.
> >> > |   MODPOST 290 modules
> >> > | ERROR: "drm_legacy_mmap" [drivers/gpu/drm/nouveau/nouveau.ko] undefined!
> >> > | scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> >> > `----
> >
> > Calling drm_legacy_mmap is definitely not a great idea.
>
> Certainly not, but it was done by Dave in commit 2036eaa7403 ("nouveau:
> bring back legacy mmap handler") for compatibility with old
> xf86-video-nouveau versions (older than 1.0.4) that call DRIOpenDRMMaster.
>
> If that is really necessary, it probably has been broken in Linus' tree
> by commit bed2dd8421 where the test has been moved to ttm_bo_mmap() and
> returns -EINVAL on failure.

Looking at the commit it's actually 1.0.1, which was release in 2012.
I'd say lets keep current upstream as-is, and hope no one cares
anymore ...
-Daniel

> > I think either
> > we need a custom patch to remove that out on older kernels, or maybe
> > even #ifdef if you want to be super paranoid about breaking stuff ...
> >
> >> > Upstream does not have that problem, as commit bed2dd8421 ("drm/ttm:
> >> > Quick-test mmap offset in ttm_bo_mmap()") has removed the use of
> >> > drm_legacy_mmap from nouveau_ttm.c.  Unfortunately that commit does not
> >> > apply in 5.1.9.
> >> >
> >> > Most likely 4.19.50 and 4.14.125 are also affected, I haven't tested
> >> > them yet.
> >>
> >> They probably are.
> >>
> >> Should I just revert this patch in the stable tree, or add some other
> >> patch (like the one pointed out here, which seems an odd patch for
> >> stable...)
> >
> > ... or backport the above patch, that should be save to do too. Not
> > sure what stable folks prefer?
> > -Daniel
>
> Cheers,
>        Sven



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
