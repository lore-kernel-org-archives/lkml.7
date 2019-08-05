Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110F9C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90842054F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfHET6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:58:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38115 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfHET6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:58:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so82189627qtl.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 12:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkzvEI6Tns5RQIrPdwX9/BySbUwnle9P3y+uxdJJN8w=;
        b=mEYRAqdzzTj6FDX5sZxCqmBGAFsXJ9kJNerHMVvxzyawbQY6n1reG8JVNPYt/FXL/O
         1PELOpB2xFArZQpz2R0w1K2CafFb22+bE/lIvTC5L3GslhM4PIoMABh1RWSkJLbqetVT
         pMAfrxLOO1p/MatEF4ADTuM9ww15261m9H2COKiEK1F9ndNI5FhQziUA1GmEMGCVOcQU
         ZL/gyAeuMxubNqFXHafFj75FeQ4+tWdehEJjmL9QrqhOHN92e0kldOqMjY/B6+O5sKmY
         1n703yC4Er7Q/pkwMvbCsRCqNjLzlvGNUJgL3LtgsAzrCNsPCeEIUFB4vxlJXlbHsk85
         fXKA==
X-Gm-Message-State: APjAAAUvaUmizVWny6gAoUrDnFrahDx9bwb0kpHb2r758ogRdhA4RzmF
        GZPWDaB6qIsCiWJmUAtUUWe3lH+p3t/O1Jsx4I8=
X-Google-Smtp-Source: APXvYqypwGXNI05c4k/o7XNqtx5QnpGh0SQ4OArCQGs2TY25vaZmexgH14mrqY99HwUGyJ+XfKIdwmLh8H0x/ZZWpNs=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr108599076qtf.204.1565035095532;
 Mon, 05 Aug 2019 12:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190805165128.GA23762@roeck-us.net> <CAK8P3a1MLMu0qh-j9fZXmG10-q2SZrtFm9JGT_xOuuZHQm31qw@mail.gmail.com>
 <20190805185204.GA28257@roeck-us.net>
In-Reply-To: <20190805185204.GA28257@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Aug 2019 21:57:59 +0200
Message-ID: <CAK8P3a1AsD8SJge-W10xNsyYrYyLqce1W2+9nMGTPdHcP5haOg@mail.gmail.com>
Subject: Re: [PATCH] page flags: prioritize kasan bits over last-cpuid
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 8:52 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Aug 05, 2019 at 08:35:40PM +0200, Arnd Bergmann wrote:
> > On Mon, Aug 5, 2019 at 6:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > On Fri, Aug 02, 2019 at 09:49:02PM -0700, Arnd Bergmann wrote:
> > > > ARM64 randdconfig builds regularly run into a build error, especially
> > > > when NUMA_BALANCING and SPARSEMEM are enabled but not SPARSEMEM_VMEMMAP:
> > > >
> > > >   #error "KASAN: not enough bits in page flags for tag"
> > > >
> > > > The last-cpuid bits are already contitional on the available space, so
> > > > the result of the calculation is a bit random on whether they were
> > > > already left out or not.
> > > >
> > > > Adding the kasan tag bits before last-cpuid makes it much more likely to
> > > > end up with a successful build here, and should be reliable for
> > > > randconfig at least, as long as that does not randomize NR_CPUS or
> > > > NODES_SHIFT but uses the defaults.
> > > >
> > > > In order for the modified check to not trigger in the x86 vdso32 code
> > > > where all constants are wrong (building with -m32), enclose all the
> > > > definitions with an #ifdef.
> > > >
> > >
> > > This results in
> > >
> > > ./include/linux/page-flags-layout.h:95:2: error: #error "Not enough bits in page flags"
> > >  #error "Not enough bits in page flags"
> > >
> > > when trying to build mipsel64:fuloong2e_defconfig.
> >
> > Do you have my follow-up fix applied?
> >
> > https://ozlabs.org/~akpm/mmots/broken-out/page-flags-prioritize-kasan-bits-over-last-cpuid-fix.patch
> >
>
> No. I see the failure in next-20190729..next-20190805.
>
> I didn't try to apply that patch, but I don't see
> arch/mips/vdso/vdso.h in the tree. I only see
>
> arch/mips/include/asm/vdso.h
> arch/mips/include/asm/vdso/vdso.h
>
> Are you sure that your patch can be applied as-is ?

Ah, right, we now have support for the generic vdso on mips,
so the file got moved from arch/mips/vdso/vdso.h to
arch/mips/include/asm/vdso/vdso.h

Try applying it to the new location then. I think it should still apply,
but have not tried it.

         Arnd
