Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B87FC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B16C206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWrSj4PA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbfG2UtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:49:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33229 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387573AbfG2UtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:49:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so27892578plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BeAeQDMMo4FgxNSctdMcxvraGIHZjszW+IJTyoPT1RE=;
        b=CWrSj4PAwWTQSPVCPG3TLcwCJ3DM5xP4Shb9KQgpIvuSr2j12/FxOg1T7ynQznn8Vb
         NnoJJBOIUi8DMiCBZt6Os3TcHq3Kf96+Yf3FrmAt0XsXHJu8PM6ndSQPgA15IqRW6AXb
         y+TEYLWLvvxQ0eYANsZPVCB9hrqAH8P3aiago5gjqmovM7BypAWxlutXnhdCSRqSKMQp
         r0BCWme6WOS5CYNzdpmDzpJbWu8p3qeYykKCqc3sfgShr2xyiOhDXrQO/pjob6eqzvxb
         C8H5a8Lbs+XUJAZodZkhWNV+bG3Vk3DoGec7ycFlXxKf2TAhk/9RbbueZr1vRO+I8l99
         d4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BeAeQDMMo4FgxNSctdMcxvraGIHZjszW+IJTyoPT1RE=;
        b=o7w1KjdZ6y+KWoL5kO8qsoqWzGOjLPtgUHi65yYz7c9zc+0YAwOO1bBXYGuF9kmDTW
         tAKUjVm/ut/0x0CQABwgOZTpnElRsPYdfHEAJYzihJsxnTioP2x1NU7srmyL5WqEsgc8
         53znoM/8BjlobAsM/vcN8JWCO5KDiupbOaqLNxuYsVsL2s3DmMKhq8vSWpGFGu2D4aVm
         BUqbaQU2cFHo1dl48UVHx6yxJyDtWXEmSrTL/ULBZQVad/rdlGDzFtBSiJsnj8y+2HBN
         UrvdcN3PLZ5GLJMF13IvH3WGpzC9PT1pGJOCtf51gT2bj212kHdxG/cF4oLut3qoBm2I
         m5Bw==
X-Gm-Message-State: APjAAAUBNOrVmcskM6MoUk2rYDh0OgE6KPL2s6aXQnfDoIZUnWHSJDk/
        4gKLe3cYDBof0Wtb9wNXSURGRzg7gu+1jkcx/20MZw==
X-Google-Smtp-Source: APXvYqx/TPPendSyXntwM8oOX2jFzT6bLZe6kftdnHHz7ao2NIGtPPiO9c1dYx2w5iDHFoySsocxwIciXxnEX1de5rw=
X-Received: by 2002:a17:902:e703:: with SMTP id co3mr14760295plb.119.1564433362401;
 Mon, 29 Jul 2019 13:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190729202542.205309-1-ndesaulniers@google.com>
 <20190729203246.GA117371@archlinux-threadripper> <CAKwvOdm7GRBWYhPy4Ni2jbsXJp8gDF-AqaAxeLbZ03+LvHxADQ@mail.gmail.com>
 <20190729204755.GA118622@archlinux-threadripper>
In-Reply-To: <20190729204755.GA118622@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jul 2019 13:49:11 -0700
Message-ID: <CAKwvOdk13rU=Fyb0BUFCL4ZYATxTNS3YG52ziPcqixfg4r7=gQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: workaround clang codegen bug in dcbz
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 1:47 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Jul 29, 2019 at 01:45:35PM -0700, Nick Desaulniers wrote:
> > On Mon, Jul 29, 2019 at 1:32 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Mon, Jul 29, 2019 at 01:25:41PM -0700, Nick Desaulniers wrote:
> > > > But I'm not sure how the inlined code generated would be affected.
> > >
> > > For the record:
> > >
> > > https://godbolt.org/z/z57VU7
> > >
> > > This seems consistent with what Michael found so I don't think a revert
> > > is entirely unreasonable.
> >
> > Thanks for debugging/reporting/testing and the Godbolt link which
> > clearly shows that the codegen for out of line versions is no
> > different.  The case I can't comment on is what happens when those
> > `static inline` functions get inlined (maybe the original patch
> > improves those cases?).
> > --
> > Thanks,
> > ~Nick Desaulniers
>
> I'll try to build with various versions of GCC and compare the
> disassembly of the one problematic location that I found and see
> what it looks like.

Also, guess I should have included the tag:
Fixes: 6c5875843b87 ("powerpc: slightly improve cache helpers")
-- 
Thanks,
~Nick Desaulniers
