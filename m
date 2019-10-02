Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FCAC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642EE217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4cObNtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfJBVGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:06:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45232 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbfJBVGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:06:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id u12so391483pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 14:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nnuWp9o1RpgvITnmL7LTsPFljnPiknKKHQUHm98mrZ4=;
        b=T4cObNtQ9BzuXk1AzgmY3Sc75aW7mav2CcAKcsDLC6tJGSGN1Im2tyak5dQuBl6ooh
         rmucnO+yufqGKap3U20y1tKRMZk55Z4Fw+0X7NcpiKq7r8oElQt41NMSlgm5hQaoUOcn
         TI20pIZB5NLrwuZZ8s/oQQtaxMUSX1mbmXzZyoQITNYCDeyWL1T1RVrU5/01TcSOjB0k
         H87wCZj3EvU/uec0eHPlVmc+Y2Bv/0rzHKLpqB2/GgJUCZkyNx1xoOR4GVomTqOIMqis
         +Bd9tSeFBAsy36uaeeclC1Vd4eI3i7I4YHt44jyjQDrfw6rPA4VI0rPWsb02ik9U9ISP
         0hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nnuWp9o1RpgvITnmL7LTsPFljnPiknKKHQUHm98mrZ4=;
        b=HxdSCs/phBv8S/qJ7CYBuq+PqKg/pT3TwwoT3IP6Ap5zMdfUH6Jnj1oTvP4UcOAQvW
         YOcSStiMQYHN7+LenB8aNjtQtzy7Ea8SydG904OytuNW9ygtXqcw+SBxQApx9X3OADMF
         0O3b90ja+Sv9pLxgBTxWwlRG49RxdLTogqtslN22Ni9YsSMZ2D9L1zs8cCErKjeCSVHt
         BoU6E4DakEs9Zi5nADtRAzULYokeJRPntx50norKEbVgVJyG9QJaiIKSt98oXBQcD9CL
         OQjzQWcm1bVkpxXhle55JWZCGH4Bbiw0g0EyzehR/u8v8ff1uYC5o7c2sSl/QfU/ge19
         EGRg==
X-Gm-Message-State: APjAAAXFvoXn61VEkT0neMkkS3MVRQf3who3TcA7jvVbycggAUFiGOlX
        sEcEJwFC/GHntmI/oyJ01GLuWkoeqOA7vBLRmWO1KA==
X-Google-Smtp-Source: APXvYqyU8Fl0l+rqi6339fDMhqJwPCU1m7omZfuV2qQaEQI4L5k50rkX+z9V7oon9o4K/aE/KPg7wYE2ofuxHA943P4=
X-Received: by 2002:a17:902:820e:: with SMTP id x14mr5819917pln.223.1570050404239;
 Wed, 02 Oct 2019 14:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191002120136.1777161-7-arnd@arndb.de> <20191002165137.15726-1-ndesaulniers@google.com>
 <20191002170733.GB1076951@archlinux-threadripper>
In-Reply-To: <20191002170733.GB1076951@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Oct 2019 14:06:33 -0700
Message-ID: <CAKwvOdmfD-vYNw=YZKBhZhaK04BSMD9xjPJ4seqDe+keHb42_w@mail.gmail.com>
Subject: Re: [PATCH 6/6] [RESEND] drm/amdgpu: work around llvm bug #42576
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Hawking.Zhang@amd.com, David Airlie <airlied@linux.ie>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org,
        "Koenig, Christian" <christian.koenig@amd.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>, le.ma@amd.com,
        LKML <linux-kernel@vger.kernel.org>, ray.huang@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 10:07 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Oct 02, 2019 at 09:51:37AM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > > Apparently this bug is still present in both the released clang-9
> > > and the current development version of clang-10.
> > > I was hoping we would not need a workaround in clang-9+, but
> > > it seems that we do.

Here's a fix: https://reviews.llvm.org/D68356
Can't possibly land until clang-10 though.

> >
> > I think I'd rather:
> > 1. mark AMDGPU BROKEN if CC_IS_CLANG. There are numerous other issues building
> >    a working driver here.
>
> The only reason I am not thrilled about this is we will lose out on
> warning coverage while the compiler bug gets fixed. I think the AMDGPU
> drivers have been the single biggest source of clang warnings.
>
> I think something like:
>
> depends on CC_IS_GCC || (CC_IS_CLANG && COMPILE_TEST)
>
> would end up avoiding the runtime issues and give us warning coverage.
> The only issue is that we would still need this patch...
>
> Cheers,
> Nathan



-- 
Thanks,
~Nick Desaulniers
