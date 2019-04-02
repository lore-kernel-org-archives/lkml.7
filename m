Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838D1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF702075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lg2UWz3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfDBI7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:59:18 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43133 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbfDBI7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:59:17 -0400
Received: by mail-vs1-f67.google.com with SMTP id i207so7278626vsd.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 01:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dxJR51sd3lzu7/GkvEOOlaHvkyuImjHaHiMHEm4CQnc=;
        b=lg2UWz3tyV8smhoQC59sB3bHcmqRvNsvigTSM7ZvF6zsi6GgenAOWySUIW46i8YPa5
         OK/o9fAdMFoIMQHQ4eh2nkIgiqjgitlCrCgfF8OjK5O8hSm6xWsxdeGxFHIkySgxiNHt
         VLugPpMvLqU81ec3lqV+L3QchMKVCN239Hvfsg5vbzFz5nTMrytSoYbqDF/TNZdwWFve
         kaJxJs141S+29XSiDNS1gdC4eCKr/n3m+Z4u06kUrn6aE5zzXFvW3o9y3RcbQ/z+8DTe
         8/4jyZF8QIfq680PcpcDF0BYEvGPxz+4KASCRVvrRSevjkunUlgyK493oRaQjq1seno/
         z4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dxJR51sd3lzu7/GkvEOOlaHvkyuImjHaHiMHEm4CQnc=;
        b=aGtNu7TA8ezl2ZdC4kRZ73Jsf8E+RC/GBn6uhUosBRlph6H5Kndn+UQUXOJEgT6hjG
         2vpsfNGU8CGvhpZlrkNPbPtTZQBpssRG6WP7nCbEeKZf2sYMItd+edJV4PDbVT7mZCn/
         g6jYo6LB/GkV3TZbCCuyeuGC5CI0FiaZna7l2usPOLXbhRyyJr1wPtLXPV74L3cPsANB
         MSbwwX/pflUlr+hd52oEP16+Cc7237k29ug6K2YV12Extf+cfDRjlBf5WzKftX6EH2MF
         0+M/SqKW46ijv8K5doEE3bkgEhF4FMXAa7Jwd4iZmWPZFBxew8vsivAIu+dN1npoXRjB
         pD7g==
X-Gm-Message-State: APjAAAWjZ1pQuvMvQ7lSdTk7d9WntN0s/wNbVjIEIhy2xNzXGiYqvVEG
        OzqSEqN+tHc/pZqy0/qhRJuvOtAwFhHvRsbb0QgTvA==
X-Google-Smtp-Source: APXvYqyoarWyRKh0Ref9ihtfMU8efqa9ij9AtyBrS12UBdRIgAm6zoIhG2fKFR2SKej2km3zJcKsGjMgNPGz7iTtK/w=
X-Received: by 2002:a67:83c5:: with SMTP id f188mr40470869vsd.163.1554195556253;
 Tue, 02 Apr 2019 01:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190401162408.249668-1-glider@google.com> <20190402072659.GH12232@hirez.programming.kicks-ass.net>
In-Reply-To: <20190402072659.GH12232@hirez.programming.kicks-ass.net>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 2 Apr 2019 10:59:05 +0200
Message-ID: <CAG_fn=UJD=j1nNpq9qp9tr8J2ru4KaoPofk71XJjUW0=qcVTSA@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: use memory clobber in bitops that touch
 arbitrary memory
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paul McKenney <paulmck@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        James Y Knight <jyknight@google.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 9:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
>
> On Mon, Apr 01, 2019 at 06:24:08PM +0200, Alexander Potapenko wrote:
> > diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitop=
s.h
> > index d153d570bb04..20e4950827d9 100644
> > --- a/arch/x86/include/asm/bitops.h
> > +++ b/arch/x86/include/asm/bitops.h
> > @@ -111,7 +111,7 @@ clear_bit(long nr, volatile unsigned long *addr)
> >       } else {
> >               asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
> >                       : BITOP_ADDR(addr)
> > -                     : "Ir" (nr));
> > +                     : "Ir" (nr) : "memory");
> >       }
> >  }
>
> clear_bit() doesn't have a return value, so why are we now still using
> "+m" output ?
You're right, "m" should suffice. I'll update the patch.
By the way, now that we've added the memory barriers we can probably
remove the barrier() call from __clear_bit_unlock() and update the
comment accordingly.
For clear_bit() the memory barrier is missing on the IS_IMMEDIATE(nr)
path, so this one should be kept as is.

> AFAICT the only reason we did that was to clobber the variable, which
> you've (afaiu correctly) argued to be incorrect.
>
> So whould we not write this as:
>
>         asm volatile (LOCK_PREFIX __ASM_SIZE(btr) " %[nr], %[addr]"
>                 : : [addr] "m" (*addr), [nr] "Ir" (nr)
>                 : "memory");
>
> ?
>
> And the very same for _all_ other sites touched in this patch.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
