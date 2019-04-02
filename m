Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5AEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2F020856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QT6jpJCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfDBLcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:32:10 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44065 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbfDBLcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:32:09 -0400
Received: by mail-vs1-f68.google.com with SMTP id j184so7533105vsd.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 04:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zUjXHBpjHSxq+1LD4/mMegqIsw7rgr06JRKbCdsX+lk=;
        b=QT6jpJCaH1Ddd0JkqGvNiSjfSvzz4HbCdiXPoYN2+Yim5Df9TndLnrB05wmajX4kRt
         U3t9NmrREsnEYS+iGSLNaXuIbaLaDBcmSttg6Kw+PdjySyyp8mr0wut274zQbPQmEoaq
         vVsOzqvPY4tDrnz9eU8ufYL1fCKK2vAJnicIz6sxt73qeCZyEIWLXd+YQXF5AHwAN+Qd
         luj6rLNwpj6hcYHIbwu0wqXBhjmVGL+/bP1E4NHXRpSvlR195TF65hT2B909PcLK32lS
         LlbpYNZ9hHqpzPKO98DVXxXRsEN14uBYdk51BT/0AExWzKyRlIJNt8N7N4/Ks6owXKLG
         xnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zUjXHBpjHSxq+1LD4/mMegqIsw7rgr06JRKbCdsX+lk=;
        b=gLu7EnCUkSW4oYOCU1vqPT5yWv45FqQiXZYkiLpE2db9lRYH+AQz4leljBC7DUJv/T
         jwFkT+Bz1nRNiJd4Dhl/QbUeCDTJRCLTBihRuvV0KrJB3t/crBDG25TksiqW2ppeurLu
         R2Qvempd5E2OuuwGLfb7x7vJpkJs1muhVDupXLuAa2T0+3RzMf6+rx5AYhiPNTCjZAfr
         ff/+YEWfIbbBgdPZw/Ek/JVFgO20DVCGpplU8rytc0xxgQzrnGAOh8TgHLE0eLz7upqI
         +j1vn3LRd5ePrHPoAOu7d+728qqvNb6/oo2A/MwdctR056QI0pvYUsM+xHxAy++ZT5O/
         snEA==
X-Gm-Message-State: APjAAAXfP9js1h+DHoehfM/HEWf/RHSO5AwCFR46aUOY2T/Kk6atKW0L
        TOm6Yf5Nry7+n0Jt8SzAXcFhpZjMIx45WQyqwRhY2w==
X-Google-Smtp-Source: APXvYqyLqMCn8QY+l4A0NQFRjN1y1rxK1zcQsEJ6CArG53UDHRIKvG5bjjXTrLjNTY4msx0L8RhYGAQV8BxI0fjEk+I=
X-Received: by 2002:a67:ba03:: with SMTP id l3mr32723043vsn.96.1554204728590;
 Tue, 02 Apr 2019 04:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190401162408.249668-1-glider@google.com> <20190402072659.GH12232@hirez.programming.kicks-ass.net>
 <CAG_fn=UJD=j1nNpq9qp9tr8J2ru4KaoPofk71XJjUW0=qcVTSA@mail.gmail.com>
In-Reply-To: <CAG_fn=UJD=j1nNpq9qp9tr8J2ru4KaoPofk71XJjUW0=qcVTSA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 2 Apr 2019 13:31:57 +0200
Message-ID: <CAG_fn=VAjx4iM8zdQnLY-nbbb09PEcwfzk3zbEWoCYxtjrnE-g@mail.gmail.com>
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

On Tue, Apr 2, 2019 at 10:59 AM Alexander Potapenko <glider@google.com> wro=
te:
>
> On Tue, Apr 2, 2019 at 9:27 AM Peter Zijlstra <peterz@infradead.org> wrot=
e:
> >
> >
> >
> > On Mon, Apr 01, 2019 at 06:24:08PM +0200, Alexander Potapenko wrote:
> > > diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bit=
ops.h
> > > index d153d570bb04..20e4950827d9 100644
> > > --- a/arch/x86/include/asm/bitops.h
> > > +++ b/arch/x86/include/asm/bitops.h
> > > @@ -111,7 +111,7 @@ clear_bit(long nr, volatile unsigned long *addr)
> > >       } else {
> > >               asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
> > >                       : BITOP_ADDR(addr)
> > > -                     : "Ir" (nr));
> > > +                     : "Ir" (nr) : "memory");
> > >       }
> > >  }
> >
> > clear_bit() doesn't have a return value, so why are we now still using
> > "+m" output ?
> You're right, "m" should suffice. I'll update the patch.
> By the way, now that we've added the memory barriers we can probably
> remove the barrier() call from __clear_bit_unlock() and update the
> comment accordingly.
> For clear_bit() the memory barrier is missing on the IS_IMMEDIATE(nr)
> path, so this one should be kept as is.
>
> > AFAICT the only reason we did that was to clobber the variable, which
> > you've (afaiu correctly) argued to be incorrect.
> >
> > So whould we not write this as:
> >
> >         asm volatile (LOCK_PREFIX __ASM_SIZE(btr) " %[nr], %[addr]"
> >                 : : [addr] "m" (*addr), [nr] "Ir" (nr)
> >                 : "memory");
Updated the patch.
I took the liberty of not adding the symbolic names to reduce the diff.
If you think that's necessary I can do that in a separate patch.
> > ?
> >
> > And the very same for _all_ other sites touched in this patch.
>
>
>
> --
> Alexander Potapenko
> Software Engineer
>
> Google Germany GmbH
> Erika-Mann-Stra=C3=9Fe, 33
> 80636 M=C3=BCnchen
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
