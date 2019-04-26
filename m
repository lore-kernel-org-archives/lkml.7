Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F85C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA281206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gZcolju3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfDZPF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:05:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45827 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDZPF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:05:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id k92so949605edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 08:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1BKKOVXP9tjmQBqg/He9D4Zx+2GSJwf5kk/dHfK6jhI=;
        b=gZcolju3VVCUHpIEB5MH4GR9Wgq+tQBiLWDuvs16ypijweiIrEOK49Ai+TueUv7nNV
         PuCWZ3KNQ5SrL6s7eJUaHeuB9iBjiFVhgOl4xVyx7inocfOuB10i5KszohGbIZQW6m8H
         HH7Byhgvf8ei8ozCrbn7nLsF1qkuazo02V2Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1BKKOVXP9tjmQBqg/He9D4Zx+2GSJwf5kk/dHfK6jhI=;
        b=YteMgIig3fdIBfROG2tesgoLpnIGLeVtWCAaCQQfVGTQujEMVMwEYBjI7kYjiNf9M6
         cVLmM/nOiuhJMhaBn2w+6U7sd89/pdDjr21+Rn0AElkC3NaKCTPJ9Ddq+4GLBOTMdsPP
         JtARsz23pAKeLU8injeOQNqAKUWJCEq3VMyxl9MRnLJNZDBC/q6AvbCxiQth97Un0XCI
         YdzstKxwCutk637l/ca6c2Z2QwpIQfGBwt2Dc1D6bdRUmuoEADNqC7p8SJObeSxibbfI
         CJ9TQ0K5iWTL9G5IeMGkT86bNjJOIprBgVyUiQCRFZKe8TMK499fdT2rGTO5RHOqHD/b
         7zyQ==
X-Gm-Message-State: APjAAAVANM27LFWDL8QHUgmALveavpP+B8LUQ4Yy4LHt3087biw1Ml4i
        l+bZjB8k/nTXMKmyxXKNdDHWXA==
X-Google-Smtp-Source: APXvYqyvR7zzkh2I5zrhWDxcnNrcnhDdNQmAkszIdocSgWAYTRgqYX6KtYL30hrVTFNMIR6aOCdC8g==
X-Received: by 2002:a17:906:11d2:: with SMTP id o18mr22559901eja.123.1556291126445;
        Fri, 26 Apr 2019 08:05:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j55sm7238122ede.73.2019.04.26.08.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:05:25 -0700 (PDT)
Date:   Fri, 26 Apr 2019 17:05:05 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>, zhoucm1 <David1.Zhou@amd.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v2] drm: prefix header search paths with
 $(srctree)/
Message-ID: <20190426150505.GA3271@phenom.ffwll.local>
Mail-Followup-To: Dave Airlie <airlied@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>, zhoucm1 <David1.Zhou@amd.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org
References: <1553859161-2628-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAR6bT93kmyPCzJg2ZFvk239nz0nyVX5z23G+8Y0Wiba1Q@mail.gmail.com>
 <CAPM=9txpmjQqh0eLA1sMjcDatQG83vk=juLehiUDi=sBO+c9Tg@mail.gmail.com>
 <8d04d30e86a54b3e9b27b30ac0ab3822@SOC-EX01V.e01.socionext.com>
 <CAPM=9tyRHNp2R_No_0Gx0N59XR2RvD4=1G2GWgLLDxmKNk6JVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPM=9tyRHNp2R_No_0Gx0N59XR2RvD4=1G2GWgLLDxmKNk6JVg@mail.gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 12:56:48PM +1000, Dave Airlie wrote:
> Daniel, drm-misc-next-fixes?

Makes sense. Pushed.

Cheers, Daniel

> 
> Dave.
> 
> On Fri, 26 Apr 2019 at 12:25, <yamada.masahiro@socionext.com> wrote:
> >
> > Hi Dave,
> >
> > > -----Original Message-----
> > > From: Dave Airlie [mailto:airlied@gmail.com]
> > > Sent: Friday, April 26, 2019 11:19 AM
> > > To: Yamada, Masahiro/山田 真弘 <yamada.masahiro@socionext.com>
> > > Cc: David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>;
> > > dri-devel <dri-devel@lists.freedesktop.org>; nouveau
> > > <nouveau@lists.freedesktop.org>; Sam Ravnborg <sam@ravnborg.org>; David
> > > (ChunMing) Zhou <David1.Zhou@amd.com>; amd-gfx mailing list
> > > <amd-gfx@lists.freedesktop.org>; James (Qian) Wang
> > > <james.qian.wang@arm.com>; Ben Skeggs <bskeggs@redhat.com>;
> > > linux-arm-msm <linux-arm-msm@vger.kernel.org>; Intel Graphics
> > > Development <intel-gfx@lists.freedesktop.org>;
> > > intel-gvt-dev@lists.freedesktop.org; Linux Kernel Mailing List
> > > <linux-kernel@vger.kernel.org>; Christian König
> > > <christian.koenig@amd.com>; Alex Deucher <alexander.deucher@amd.com>;
> > > freedreno@lists.freedesktop.org
> > > Subject: Re: [Intel-gfx] [PATCH v2] drm: prefix header search paths with
> > > $(srctree)/
> > >
> > > On Fri, 26 Apr 2019 at 11:46, Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > > >
> > > > Hi.
> > > >
> > > >
> > > > On Fri, Mar 29, 2019 at 8:37 PM Masahiro Yamada
> > > > <yamada.masahiro@socionext.com> wrote:
> > > > >
> > > > > Currently, the Kbuild core manipulates header search paths in a crazy
> > > > > way [1].
> > > > >
> > > > > To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
> > > > > the search paths in the srctree. Some Makefiles are already written
> > > in
> > > > > that way, but not all. The goal of this work is to make the notation
> > > > > consistent, and finally get rid of the gross hacks.
> > > > >
> > > > > Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
> > > > > ("kbuild: do not drop -I without parameter").
> > > > >
> > > > > [1]: https://patchwork.kernel.org/patch/9632347/
> > > > >
> > > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > > > > ---
> > > > >
> > > > > I put all gpu/drm changes into a single patch because
> > > > > they are trivial conversion.
> > > > >
> > > > > If you are interested in the big picture of this work,
> > > > > the full patch set is available at the following URL.
> > > > >
> > > > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.g
> > > it build-test
> > > >
> > > >
> > > > Is somebody taking care of this?
> > > >
> > >
> > > Are you expecting this to be merged in the drm tree? if so please
> > > indicate that when posting.
> >
> >
> > Sorry for unclearness.
> >
> > Could you apply this to your drm tree?
> >
> > Thanks.
> >
> >
> >
> >
> > > I'd assumed this would go via kbuild tree.
> > >
> > > If the later,
> > > Acked-by: Dave Airlie <airlied@redhat.com>
> > > Dave.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
