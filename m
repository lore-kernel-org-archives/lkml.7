Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE924C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC6420883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwAUSHDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfDBMho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:37:44 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36236 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDBMhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:37:43 -0400
Received: by mail-ua1-f67.google.com with SMTP id e15so4291902uam.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 05:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5d2HkYnQ9HlSZJOwpry0TKtdG4vndyCo899X4by8jSM=;
        b=EwAUSHDAk/+svQS8T1z+ibKHkHgMOyxL8oxOSdQ+7ZlveHeVlhItFGY5xpqt8kMGgM
         MzA6mvBgNOsfEV2Mm5X0zs44VuWEyVrQ0HcnSVttv989e/KuqmLnY7uVhEauBV9H8dWd
         Jq35CcAd/8E2ND0jFm1o7OFEzxQSsJr9HynY+XirLNN53p7hvpIz4SJkv/Y2KqW8MeDd
         Xx6zSpP7ZlYbFCpbLRRh5GJUDSm4vzfPDnDg6jECwuW4SMcioJPECA8Z3ougtmtqrd8f
         E0kGa+777vTAOkyMMSdOL4jy+mYW8g+Fn9TjbM8/od8LmIOgWZOgdDfSjUUSd55tOHZt
         lsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5d2HkYnQ9HlSZJOwpry0TKtdG4vndyCo899X4by8jSM=;
        b=EGdTLg84xaKKxIEiRjCc90ePpYBe2EytwqUYU/+hntA6OOjWZxhfOsq7QIJYw25NUK
         fF9QnZUeBJ73wIMcILXXkE3FqL3FCzC9qWEISDMGSyfNln7iMUjIPbczbfBI7wnAomgd
         l95ft3TEdVIvyy891aGD85ep/mgcIUoaImq2IT/nEQt4jMyy6wJO1ld3xmglMkKlu7Z4
         58KW8uSd50OcpC5bZuhKuTXaidaPefHeLi8DjkpW6aakcwJ7SlpNE7Tz+9p89eXQ2LTJ
         yd2Gz7q0bmghhRD6yyHyLm1zn1lr1T52h2GB2dkGnGQ9bxCa8codFK3utOmUPmwSZh+t
         dD/g==
X-Gm-Message-State: APjAAAXjb9oJeg3pzoOESBHG9IH1ji6KzZHq4WtGdSVwLzC6ix0/yVML
        cf7AX7WaO61YvlXRDpErA6ifTgLa2f53N/CjEXG8sg==
X-Google-Smtp-Source: APXvYqw+1jJsTGGHuM8ZOKpVCA7j8TNEbir8JwSmF/rPkj8v12XI4En6wg+zqeM3iMi5u+Rf+GKUjCELZhSw/6FQ42M=
X-Received: by 2002:ab0:1d82:: with SMTP id l2mr4258995uak.120.1554208661967;
 Tue, 02 Apr 2019 05:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190402112813.193378-1-glider@google.com> <4c6a1e592fd345618ef7b7d5bee592da@AcuMS.aculab.com>
 <CAG_fn=XA3e+2+DdAN4_Yvw_yBeokVcnW5Cb5-Q0Hs5DbhVxzHw@mail.gmail.com>
In-Reply-To: <CAG_fn=XA3e+2+DdAN4_Yvw_yBeokVcnW5Cb5-Q0Hs5DbhVxzHw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 2 Apr 2019 14:37:30 +0200
Message-ID: <CAG_fn=UiWCEHUaA71nozUbY7G8g7ZH0ni8Lut=hKVr_rNNC3pw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/asm: fix assembly constraints in bitops
To:     David Laight <David.Laight@aculab.com>
Cc:     "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "jyknight@google.com" <jyknight@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 2:35 PM Alexander Potapenko <glider@google.com> wrot=
e:
>
> On Tue, Apr 2, 2019 at 1:44 PM David Laight <David.Laight@aculab.com> wro=
te:
> >
> > From: Alexander Potapenko
> > > Sent: 02 April 2019 12:28
> > >
> > > 1. Use memory clobber in bitops that touch arbitrary memory
> > >
> > > Certain bit operations that read/write bits take a base pointer and a=
n
> > > arbitrarily large offset to address the bit relative to that base.
> >
> > Although x86_64 can use a signed 64bit bit number, looking at arm and a=
rm64
> > they use 'int nr' throughout as do the generic functions.
> > Maybe x86 ought to be consistent here.
> > I doubt negative bit numbers are expected to work?
> I don't have a strong opinion on this, but the corresponding Intel
> instructions do accept 64-bit operands.
>
> > Did you try telling gcc that a big buffer (250MB is the limit for 32bit=
)
> > from the pointer might be changed?
> Yes, I did, see
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1966993.html
> This still isn't a silver bullet, e.g. I saw an example where touching
> a function parameter cast to a big buffer in the assembly resulted in
> clobbering a global.
> Moreover, one can imagine a situation where such a trick may be harmful, =
e.g.:
>
> void foo(int size) {
>   struct arr {
>     long val[1U<<28];
>   };
>   long *bitmap =3D malloc(size);
>   asm("#do something" : "+m"(*(struct arr*)bitmap);
>   if (size < 1024)
>     process(bitmap[size]);
(let it be bitmap[size-2] so that we don't overflow the buffer)
> }
>
> If a (smart enough) compiler knows that malloc(size) returns a pointer
> to |size| bytes in memory, it may assume that |size| is at least
> 1U<<28 (because otherwise it's incorrect to treat |bitmap| as a
> pointer to a big array) and delete the size check.
> This is of course a synthetic example, but not a completely impossible on=
e.
>
> > That ought to be softer than a full 'memory' clobber as it should
> > only affect memory that could be accessed through the pointer.
> >
> > ....
> > > -#define BITOP_ADDR(x) "+m" (*(volatile long *) (x))
> > > +#define RLONG_ADDR(x) "m" (*(volatile long *) (x))
> > > +#define WBYTE_ADDR(x) "+m" (*(volatile char *) (x))
> > >
> > > -#define ADDR                         BITOP_ADDR(addr)
> > > +#define ADDR                         RLONG_ADDR(addr)
> >
> > Is it worth just killing ADDR ?
> > (as a different patch)
> Agreed.
> >         David
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, M=
K1 1PT, UK
> > Registration No: 1397386 (Wales)
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
