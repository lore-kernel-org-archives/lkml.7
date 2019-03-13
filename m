Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AF1C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9951B217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfCMNrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:47:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45441 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfCMNrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:47:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id v20so1877308qtv.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 06:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9hhGiqFkQOyj2HsXpZqb68aTtiFInjQWkWhoHrfSTE=;
        b=bbTQ6JXLQtT9PcI3czchnUkfgPVySDJgQ2tHB01q8rQ75mY6s9m0m39qNhvMojsBjK
         QQl0vPfF59ZbY2JuTIYAuqPxdP56nQVwrEGHyHW3Oz/FGZZAdapz9rsrnjSce81Z1AJG
         mSToGQM0g4USamrTjkbxPHAfWNXBpJvuwqQrHhO4EKBzj+gAO87CGiJuXj8Z6hw0vkqp
         KJvNBNi1VqMODH0qBnfZOQHg0LYmocd+2dWhcNxstoQG5mTai0vXckAgVbK2Yqll89mI
         q7KeT8SN9ky2p7LRT71gOE5HMQx9RBswKSWMlyaxwGov3aLGN2xu6+SIIhKeTulhoC6t
         0AQw==
X-Gm-Message-State: APjAAAVZ7yTCRzoChUiSDb1Z8GFVvEAFR1dLJq1VCYZNOJ4wwUlESNIH
        ttCro5CjY+noikL9ozX+Cn6YBVR7HNTmY/9+5bM=
X-Google-Smtp-Source: APXvYqzDz9nXPvhIIABdz4si/3eHnXmxwwi1bNgLVFzVGNvjIBFKeOcRRRFharl5kiWI4O48Lgd+6ldPwSqyMGehKL4=
X-Received: by 2002:a0c:b05a:: with SMTP id l26mr34139845qvc.40.1552484833092;
 Wed, 13 Mar 2019 06:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190310183051.87303-1-cai@lca.pw> <20190311035815.kq7ftc6vphy6vwen@linux-r8p5>
 <20190311122100.GF22862@mellanox.com> <1552312822.7087.11.camel@lca.pw>
 <CAK8P3a0QB7+oPz4sfbW_g2EGZZmC=LMEnkMNLCW_FD=fEZoQPA@mail.gmail.com> <20190313091844.GA24390@hirez.programming.kicks-ass.net>
In-Reply-To: <20190313091844.GA24390@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Mar 2019 14:46:55 +0100
Message-ID: <CAK8P3a3_2O7KBKTSD-QC5tcpohy8bkVVHsdAJnanTU1B+H12-w@mail.gmail.com>
Subject: Re: [PATCH] mm/debug: add a cast to u64 for atomic64_read()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, Jason Gunthorpe <jgg@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 10:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Mar 11, 2019 at 03:20:04PM +0100, Arnd Bergmann wrote:
> > On Mon, Mar 11, 2019 at 3:00 PM Qian Cai <cai@lca.pw> wrote:
> >
> > At least the atomic_long part we discussed there has been resolved now
> > as part of commit b5d47ef9ea5c ("locking/atomics: Switch to generated
> > atomic-long").
> >
> > Adding Mark Rutland to Cc, maybe he has some ideas of how to use
> > the infrastructure he added to use consistent types for atomic64()
> > on the remaining 64-bit architectures.
>
> A quick count shows there's only 5 definitions of atomic64_t in the
> tree, it would be trivial to align them on type.
>
> $ git grep "} atomic64_t"
> arch/arc/include/asm/atomic.h:} atomic64_t;
> arch/arm/include/asm/atomic.h:} atomic64_t;
> arch/x86/include/asm/atomic64_32.h:} atomic64_t;
> include/asm-generic/atomic64.h:} atomic64_t;
> include/linux/types.h:} atomic64_t;

Right, that would make sense as well.

> Note that the one used in _most_ cases, is the one from linux/types.h,
> and that is using 'long'. The others, all typically on ILP32 platforms,
> obviously must use long long.
>
> I have no objection to changing the types.h one to long long or all of
> them to s64. It really shouldn't matter at all.

I thiunk it needs an '__attribute__((aligned(8)))' annotation at least on
x86-32, but it should be harmless to do that everywhere. The
32-bit architectures of course already use a 'long long' base type
(unsigned long long on x86 and arc), but we'd still need to
change all the 64-bit architectures to consistently use s64
in their implementation. This would be the majority of the work, e.g.

arch/powerpc/include/asm/atomic.h:
static __inline__ void atomic64_##op(long a, atomic64_t *v)             \

arch/riscv/include/asm/atomic.h
static __always_inline                                                  \
c_type atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)     \

arch/sparc/include/asm/atomic_64.h:
long atomic64_##op##_return(long, atomic64_t *);

arch/s390/include/asm/atomic.h:
static inline void atomic64_##op(long i, atomic64_t *v)                 \

arch/mips/include/asm/atomic.h:
static __inline__ void atomic64_##op(long i, atomic64_t * v)                  \

arch/ia64/include/asm/atomic.h:
static __inline__ long                                                  \
ia64_atomic64_##op (__s64 i, atomic64_t *v)                             \

arch/alpha/include/asm/atomic.h:
static __inline__ void atomic64_##op(long i, atomic64_t * v)            \

arch/parisc/include/asm/atomic.h:
static __inline__ s64 atomic64_##op##_return(s64 i, atomic64_t *v)      \

The problem is not that any of those would be hard to change,
it's more that there are so many functions across 10 architectures,
and everything has some subtle differences somewhere.

It would be tempting to use scripts/atomic/* to generate more of
the code in a consistent way, but that is likely to be even more
work and more error-prone at the start.

      Arnd
