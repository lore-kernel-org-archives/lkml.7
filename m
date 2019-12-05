Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47320C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2EF206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="L8FdU8vN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfLERvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:51:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35072 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbfLERvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:51:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so1552724plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:date:message-id:subject
         :in-reply-to:references:to:cc;
        bh=FCGatpZYf0VVWoHuLUemNc1kt+XkdMeNvkxB+YQmnHg=;
        b=L8FdU8vN96r71rbYw51rj6vIpOVc5DnN5IJ+3yDersXBL5KUtdAf67xbqAXYTc1wEE
         a+LyMAptkx8DTA+a7jRRFfBw1pvh4EqXTYk7QrU3tn245PSOSp0En+s8nvkaf5LBE3Ib
         07H0oe1khXVeeKzMvYvRDTqhtgjUlMg3FTEfWH/Fx4S9mUstlBxieEwXR2nlbIityeNA
         pXGx1CVFZjfMAvUKotuB5D7ecBIpfcPYUcpSLTIirPd8t8Lwe7B2yIZ/4TWnAcSV/oMQ
         nvksWMSBR0OcIxCpDgGmdPsmQCGcCU04CLq3uYvj435atSQu1d1dnQ4GptQ67wGZLCZ3
         331w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :message-id:subject:in-reply-to:references:to:cc;
        bh=FCGatpZYf0VVWoHuLUemNc1kt+XkdMeNvkxB+YQmnHg=;
        b=hveM/TagsCoL3AHwef3haGPpmmuuNSZ1xMQyeq0TZfKnMvaV+H60YJk8Z9F8A1vITh
         d6PdO0BdyFabMYcHR91zTC7erJIRpQVBrT5i8nrKLcbuhaeDdBbQf6fK6gbShORxNFMa
         Ov0Icu8UDqAus56dHBIxE6uIKeEUquUV/m9NitOdMkFohXM6upm1SVsMXu8iJsvJ+VzH
         sNfptxSSxH2kVpE0yAJNPs+wyyPgTbufup8Aycr67PAU7SQR/EolvX5I8H/1sY7Uu7Ni
         pr/I9j5eXn6YFVa+B+crE5OUJ8JEMqmLpVIdA5NsRnwDAUbT2JFy7Y+109MVqcQWWP31
         LMrw==
X-Gm-Message-State: APjAAAUs6HIHjC152+pyDAl9eTugjJBj3kCuQW6DY9IdlFOOxpXhzDTn
        0DbUmQ0QOHJ7pH69yIMafH/ucA==
X-Google-Smtp-Source: APXvYqxWenbC7aMhdSO+T2gMNHix0r07nRxxeNt2nB0h10Cs6TnocognLiP1iRqYHK8qtvnX2OImlg==
X-Received: by 2002:a17:90a:ab0c:: with SMTP id m12mr10225051pjq.69.1575568301922;
        Thu, 05 Dec 2019 09:51:41 -0800 (PST)
Received: from [172.18.68.114] ([207.62.246.80])
        by smtp.gmail.com with ESMTPSA id a13sm2264616pfc.40.2019.12.05.09.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:51:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Date:   Thu, 5 Dec 2019 09:51:39 -0800
Message-Id: <66B551EF-8CC6-4145-9618-8DC4F4498138@amacapital.net>
Subject: Re: Running an Ivy Bridge cpu at fixed frequency
In-Reply-To: <df5b67c5f51b48c391480358d6af53ca@AcuMS.aculab.com>
References: <df5b67c5f51b48c391480358d6af53ca@AcuMS.aculab.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 5, 2019, at 7:54 AM, David Laight <David.Laight@aculab.com> wrote:
>=20
> =EF=BB=BFFrom: Peter Zijlstra
>> Sent: 05 December 2019 09:46
>> As Andy already wrote, perf is really good for this.
>> Find attached, it probably is less shiny than what Andy handed you, but
>> contains all the bits required to frob something.
>=20
> You are in a maze of incomplete documentation all disjoint.

I don=E2=80=99t see any documentation.  Maybe you shouldn=E2=80=99t have tur=
ned your flashlight on.

>=20
> The x86 instruction set doc (eg 325462.pdf) defines the rdpmc instruction,=
 tells you
> how many counters each cpu type has, but doesn't even contain a reference
> to how they are incremented.
> I guess there are some processor-specific MSR for that.
>=20
> perf_event_open(2) tells you a few things, but doesn't actually what anyth=
ing is.
> It contains all but the last 'if' clause of this function, without really s=
aying
> what any of it does - or why you might do it this way.
>=20
> static inline u64 mmap_read_self(void *addr)
> {
>       struct perf_event_mmap_page *pc =3D addr;
>       u32 seq, idx, time_mult =3D 0, time_shift =3D 0, width =3D 0;
>       u64 count, cyc =3D 0, time_offset =3D 0, enabled, running, delta;
>       s64 pmc =3D 0;
>=20
>       do {
>               seq =3D pc->lock;
>               barrier();
>=20
>               enabled =3D pc->time_enabled;
>               running =3D pc->time_running;
>=20
>               if (pc->cap_user_time && enabled !=3D running) {
>                       cyc =3D rdtsc();
>                       time_mult =3D pc->time_mult;
>                       time_shift =3D pc->time_shift;
>                       time_offset =3D pc->time_offset;
>               }
>=20
>               idx =3D pc->index;
>               count =3D pc->offset;
>               if (pc->cap_user_rdpmc && idx) {
>                       width =3D pc->pmc_width;
>                       pmc =3D rdpmc(idx - 1);
>               }
>=20
>               barrier();
>       } while (pc->lock !=3D seq);
>=20
>       if (idx) {
>               pmc <<=3D 64 - width;
>               pmc >>=3D 64 - width; /* shift right signed */
>               count +=3D pmc;
>       }
>=20
>       if (enabled !=3D running) {
>               u64 quot, rem;
>=20
>               quot =3D (cyc >> time_shift);
>               rem =3D cyc & ((1 << time_shift) - 1);
>               delta =3D time_offset + quot * time_mult +
>                       ((rem * time_mult) >> time_shift);
>=20
>               enabled +=3D delta;
>               if (idx)
>                       running +=3D delta;
>=20
>               quot =3D count / running;
>               rem =3D count % running;
>               count =3D quot * enabled + (rem * enabled) / running;
>       }
>=20
>       return count;
> }
>=20
> AFAICT:
> 1) The last clause is scaling the count up to allow for time when the hard=
ware counter
>  couldn't be allocated.
>  I'm not convinced that is useful, better to ignore the entire measurement=
.
>  Half this got deleted from the man page, leaving strange 'set but unused'=
 variables.
>=20
> 2) The hardware counters are disabled while the process is asleep.
>  On wake a different pmc counter might be used (maybe on a different cpu).=

>  The new cpu might not even have a counter available.
>=20
> 3) If you don't want to scale up for missing periods it is probably enough=
 to do:
>   do {
>       seq =3D pc->offset;
>       barrier();
>       idx =3D pc->index;
>       if (!index)
>           return -1;
>       count =3D pc->offset + rdpmc(idx - 1);
>   } while (seq !=3D pc->seq);
>   return (unsigned int)count;
>=20
> Not tried it yet :-)

Use my version :).  I just throw out the sample if we were preempted or if i=
t was otherwise suspicious.

=E2=80=94Andy

>=20
>   David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
> Registration No: 1397386 (Wales)
