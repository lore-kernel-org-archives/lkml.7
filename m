Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90A0C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB395216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+A/wOiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfHEUTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:19:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36338 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHEUTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:19:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so40197981pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 13:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=74S3qTl60NBsMNkNpY0zRnYYXHfUZnU0Q7nPy46duFk=;
        b=E+A/wOiPt5GugVatMsiXDKMVB9ioFsq0HJ9h6jgzH7fMXhJ3Bi1CK/LVvuNti5VbJ1
         Oy3n1ctQ9QNjL18oGnH39C2xbKIMybWWg9PO04YM1hGpIZAcBA1jZl8FcFpm/lWpQpbc
         jTXj66s1eik3w0j55un6gt0zZ5VWy5NHgtO4dUIkjSqXKvlNP7+0GI1gNxaWEq4XKxNt
         cGs27+X1DTX1Yeagd7naPWN/wbdZYo7LCoa/I+dF/zEBVAeZRdYm7YU9xjW0JGX98T7h
         9owOmNCM2pw3pTiHwJfW5d1olnNPcbpF4WkGG34ZWpluCas62KgrPqUOnVtC6dgWTkjB
         PJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=74S3qTl60NBsMNkNpY0zRnYYXHfUZnU0Q7nPy46duFk=;
        b=A9klZTyQy8qPMVPiijeY1dDkOTpY0x+GCctmHAj5oBehPVQGNSfQM6Jqj1A90IuENi
         qiGpnqC4M8BErRZsQfaPHH7EQQzM3/09QhDrHsbE0Fo9G1t+VxGOR1oDKm6q9bKiBAcJ
         M+Uv7TmCt5H16ypbn0XN7ctiAezR5oGMeeU1oDTQFU/iVD2KlBvDHFaQEpVhIjXvi6hH
         uO0PPYCf32WGxXnA0DUKymTOd+AcVtdwFOk/3d5qWjUhDPzIfrooFrZPdYymiy6d1KBB
         0Ib6kKlwxFFlqJ06JaF2Hkw/P9zgtn3Jzouv1Vr1mtZq7qWYeG9zlL0czsR0c4muf67X
         CUVQ==
X-Gm-Message-State: APjAAAVuIk4hWaWDqKafwi7wlIL5nzI8clZI1HbiGwf7YZRAuCgnz56Z
        qxMw1E+gyw9G2GuNfnoPALSumYxQ
X-Google-Smtp-Source: APXvYqzgKEQuIQNn4qU0/bXbsMCanpVARX0B5qZYewgP3u+eXwzdOFAxXh+bUpmMliIVI4yY5kRhgA==
X-Received: by 2002:a63:607:: with SMTP id 7mr28586476pgg.240.1565036339546;
        Mon, 05 Aug 2019 13:18:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m20sm97121200pff.79.2019.08.05.13.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 13:18:58 -0700 (PDT)
Date:   Mon, 5 Aug 2019 13:18:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] page flags: prioritize kasan bits over last-cpuid
Message-ID: <20190805201857.GA28470@roeck-us.net>
References: <20190805165128.GA23762@roeck-us.net>
 <CAK8P3a1MLMu0qh-j9fZXmG10-q2SZrtFm9JGT_xOuuZHQm31qw@mail.gmail.com>
 <20190805185204.GA28257@roeck-us.net>
 <CAK8P3a1AsD8SJge-W10xNsyYrYyLqce1W2+9nMGTPdHcP5haOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1AsD8SJge-W10xNsyYrYyLqce1W2+9nMGTPdHcP5haOg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 09:57:59PM +0200, Arnd Bergmann wrote:
> On Mon, Aug 5, 2019 at 8:52 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > On Mon, Aug 05, 2019 at 08:35:40PM +0200, Arnd Bergmann wrote:
> > > On Mon, Aug 5, 2019 at 6:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > On Fri, Aug 02, 2019 at 09:49:02PM -0700, Arnd Bergmann wrote:
> > > > > ARM64 randdconfig builds regularly run into a build error, especially
> > > > > when NUMA_BALANCING and SPARSEMEM are enabled but not SPARSEMEM_VMEMMAP:
> > > > >
> > > > >   #error "KASAN: not enough bits in page flags for tag"
> > > > >
> > > > > The last-cpuid bits are already contitional on the available space, so
> > > > > the result of the calculation is a bit random on whether they were
> > > > > already left out or not.
> > > > >
> > > > > Adding the kasan tag bits before last-cpuid makes it much more likely to
> > > > > end up with a successful build here, and should be reliable for
> > > > > randconfig at least, as long as that does not randomize NR_CPUS or
> > > > > NODES_SHIFT but uses the defaults.
> > > > >
> > > > > In order for the modified check to not trigger in the x86 vdso32 code
> > > > > where all constants are wrong (building with -m32), enclose all the
> > > > > definitions with an #ifdef.
> > > > >
> > > >
> > > > This results in
> > > >
> > > > ./include/linux/page-flags-layout.h:95:2: error: #error "Not enough bits in page flags"
> > > >  #error "Not enough bits in page flags"
> > > >
> > > > when trying to build mipsel64:fuloong2e_defconfig.
> > >
> > > Do you have my follow-up fix applied?
> > >
> > > https://ozlabs.org/~akpm/mmots/broken-out/page-flags-prioritize-kasan-bits-over-last-cpuid-fix.patch
> > >
> >
> > No. I see the failure in next-20190729..next-20190805.
> >
> > I didn't try to apply that patch, but I don't see
> > arch/mips/vdso/vdso.h in the tree. I only see
> >
> > arch/mips/include/asm/vdso.h
> > arch/mips/include/asm/vdso/vdso.h
> >
> > Are you sure that your patch can be applied as-is ?
> 
> Ah, right, we now have support for the generic vdso on mips,
> so the file got moved from arch/mips/vdso/vdso.h to
> arch/mips/include/asm/vdso/vdso.h
> 
> Try applying it to the new location then. I think it should still apply,
> but have not tried it.
> 

Turns out it is applied there (it looks like it was merged into
the original patch). But it doesn't help; the build failure is
still there. Reverting "page flags: prioritize kasan bits over
last-cpuid" on top of next-20190805 fixes the problem for me.

Guenter
