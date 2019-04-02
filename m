Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0927C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5D521473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxvdPITN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfDBMgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:36:11 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:46433 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfDBMgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:36:10 -0400
Received: by mail-vk1-f193.google.com with SMTP id x2so2909932vkx.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 05:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Li87jjEn1YGHqSMMXXpm7CCTnECkrAGhG11G6BnjCRo=;
        b=FxvdPITNv4YEh4AucG0BeHubpS0xXj1kDuw+ZhX3oi0Zgtq97lo/6zc5RfciCETLVQ
         eEPKsv/vMcfM71RpjJNkwk8tduYl/PDeq9EgoXNQ+mmAfSE/4thcFxrg9QHMrbm272de
         lnzHP8wNzDfQeznHEYUVbleTIHqJI4K9oKmsr/0Bw6VPNi839RWEBL2t8iZY2s2eIXKf
         4VOgWbsKDvvDWkQugn9fA1x2ojV7hiMrx3ECLyZuhK4VhsjDxW33QfJdrAThKMRQi8ZT
         vVYLTEfRxKsIWeitsAnXIUiP2zWq6oXDWaUOS/fBB3AHO20zGbV7PgD+H2GSd89L+mNK
         19sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Li87jjEn1YGHqSMMXXpm7CCTnECkrAGhG11G6BnjCRo=;
        b=Es24k6Zr2hktT/rpejpvACIxehgZvmd7d/Vz/uBoZw3BCh6aYVyVw50CsOn0AcBQZU
         +88Excrm1anirffX+jJE1ZarKK4wBqmYXkuToOB0Q7IXj7/vVxdKt51d6pKlU5fGAIEp
         LUeKkCrfAQc04T/SLc4iH0GET+vjAsn/Rn5yy8kTMQabxthBRgAX88kUVgWQCT5gUa4U
         /l46DqGP9I112wgGyQv1HYEuWB8yMsF11vBwts8/Qni4/qB01XZT+h3F4VMF9Wto3OQy
         3MAFxCMTgfM5I70RLEAaCubtWGSrwT38TwnDz55xR+D2UJw5PYFLMAT34qsIMzLoPzt5
         L7OA==
X-Gm-Message-State: APjAAAXohazZd4THmPWyj9BUisb10sFsNmSgIYYuGI1vNGZsMhGZDJtO
        eT2JtMv9pBRfHq+sfNlEaRTqlJDWNn8t8/lo4cvyEg==
X-Google-Smtp-Source: APXvYqyBycFbw73GGLH0sXio5OxZQv2hbolKrUuehxUBJE3bvRKts6U/Gl/AEtG+wIpC2x5CGSdiZUULBe2SlJOKwrk=
X-Received: by 2002:ac5:c24b:: with SMTP id n11mr29796243vkk.81.1554208569611;
 Tue, 02 Apr 2019 05:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190402112813.193378-1-glider@google.com> <4c6a1e592fd345618ef7b7d5bee592da@AcuMS.aculab.com>
In-Reply-To: <4c6a1e592fd345618ef7b7d5bee592da@AcuMS.aculab.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 2 Apr 2019 14:35:58 +0200
Message-ID: <CAG_fn=XA3e+2+DdAN4_Yvw_yBeokVcnW5Cb5-Q0Hs5DbhVxzHw@mail.gmail.com>
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

On Tue, Apr 2, 2019 at 1:44 PM David Laight <David.Laight@aculab.com> wrote=
:
>
> From: Alexander Potapenko
> > Sent: 02 April 2019 12:28
> >
> > 1. Use memory clobber in bitops that touch arbitrary memory
> >
> > Certain bit operations that read/write bits take a base pointer and an
> > arbitrarily large offset to address the bit relative to that base.
>
> Although x86_64 can use a signed 64bit bit number, looking at arm and arm=
64
> they use 'int nr' throughout as do the generic functions.
> Maybe x86 ought to be consistent here.
> I doubt negative bit numbers are expected to work?
I don't have a strong opinion on this, but the corresponding Intel
instructions do accept 64-bit operands.

> Did you try telling gcc that a big buffer (250MB is the limit for 32bit)
> from the pointer might be changed?
Yes, I did, see
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1966993.html
This still isn't a silver bullet, e.g. I saw an example where touching
a function parameter cast to a big buffer in the assembly resulted in
clobbering a global.
Moreover, one can imagine a situation where such a trick may be harmful, e.=
g.:

void foo(int size) {
  struct arr {
    long val[1U<<28];
  };
  long *bitmap =3D malloc(size);
  asm("#do something" : "+m"(*(struct arr*)bitmap);
  if (size < 1024)
    process(bitmap[size]);
}

If a (smart enough) compiler knows that malloc(size) returns a pointer
to |size| bytes in memory, it may assume that |size| is at least
1U<<28 (because otherwise it's incorrect to treat |bitmap| as a
pointer to a big array) and delete the size check.
This is of course a synthetic example, but not a completely impossible one.

> That ought to be softer than a full 'memory' clobber as it should
> only affect memory that could be accessed through the pointer.
>
> ....
> > -#define BITOP_ADDR(x) "+m" (*(volatile long *) (x))
> > +#define RLONG_ADDR(x) "m" (*(volatile long *) (x))
> > +#define WBYTE_ADDR(x) "+m" (*(volatile char *) (x))
> >
> > -#define ADDR                         BITOP_ADDR(addr)
> > +#define ADDR                         RLONG_ADDR(addr)
>
> Is it worth just killing ADDR ?
> (as a different patch)
Agreed.
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
