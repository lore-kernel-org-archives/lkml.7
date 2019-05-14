Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6577CC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F34920578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="nTtwzpON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfENRP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:15:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37526 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfENRP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:15:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id g3so9474007pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6+3exks6fdLq67Hyw13z/f6pVq1U2l7pQ2O271G9vzY=;
        b=nTtwzpONuJZF5R4VbarCf6fwPLkAGQZT5G84BzUCr7yO1AamMP7qvVbUCXQBLNf7lN
         +OOEC4Vn1PICfpX7D/yrPeD34lTMW6+woOHKzQozMW1EkAQi1fo8K0yrJPKFtAmEsIvz
         WT4jnJ1ZVdzvIKRX0GK+Qvs5qIP0TeNFJ6HCmlw3LiweRiRozYwv5nnZISyI0dx+6NNk
         6BlbsZkHsqVK/9ZCWGp86O80jKTFWZhJ8rzjANvvUb6sshQZLbD7UBBuk4quygQkPmZL
         Z+1k4urAKXvJkeMvzbq2gV/FZqPgH/3C8CquqXOmahnZOz8ZSA0FdcPJMyvpWygRB+Iq
         45NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6+3exks6fdLq67Hyw13z/f6pVq1U2l7pQ2O271G9vzY=;
        b=IoL+ogumJiSGP+sFzwaBtVzsJmCogRGDd6TMtHows4/zjGMF1h8H+ByYtzAobf1tYo
         gqw5G8bWwAesQaZ7DfLIzot5ZQlesTpu24J7Uj2JICn9cii0YX7cQFmkmi8ryftcWOxp
         U3C9qEB+8FBqtceKah9l363EfUv1UC+O0tyjFUk3rE8l+0jSpmy7lhGaojUDdAHQNl1G
         tTYpHrJaPluphZ4NPZUGrBxV8DSW4y/qfzxEq4F5F4GX942NJ31Ga5pgBG1ElbUp7PF4
         l+IhnWP+h4L7vybC5GlHiOdalpIORJDwenU7zDFe1l+NAVfOefxGNp/0sDRHMZRZnebG
         AstQ==
X-Gm-Message-State: APjAAAV6uxxNIruMwHK/37T9wbKGOelpFEkBbUY9WCLoTdRkSzT1P0xf
        495hKQ9IwStGZRL0d94OcnCzWg==
X-Google-Smtp-Source: APXvYqwUhltskd/aBmpkCuJ2MmMvOaKISuKKkPHJ5N4EoQH32puZlI/2JxO6sqqBSrW//VP+7Su70Q==
X-Received: by 2002:aa7:93ba:: with SMTP id x26mr41836706pff.238.1557854125653;
        Tue, 14 May 2019 10:15:25 -0700 (PDT)
Received: from ?IPv6:2600:1010:b003:d41f:c45f:19c:b406:c9bd? ([2600:1010:b003:d41f:c45f:19c:b406:c9bd])
        by smtp.gmail.com with ESMTPSA id h123sm1692723pfe.80.2019.05.14.10.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 10:15:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC] x86: Speculative execution warnings
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <EB9EEC92-A513-44B4-9377-56691916BF5D@vmware.com>
Date:   Tue, 14 May 2019 10:15:21 -0700
Cc:     Paul Turner <pjt@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirsky <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3944C0B1-D0C4-4D2F-B055-69313CFD73F2@amacapital.net>
References: <20190510192514.19301-1-namit@vmware.com> <CAPM31RJ_vQsLp3nK5nhq0U8J+x_9w=aV+TtPGj7vdtiOKPpw8g@mail.gmail.com> <EB9EEC92-A513-44B4-9377-56691916BF5D@vmware.com>
To:     Nadav Amit <namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 14, 2019, at 10:00 AM, Nadav Amit <namit@vmware.com> wrote:

>> On May 14, 2019, at 1:00 AM, Paul Turner <pjt@google.com> wrote:
>>=20
>> From: Nadav Amit <namit@vmware.com>
>> Date: Fri, May 10, 2019 at 7:45 PM
>> To: <x86@kernel.org>
>> Cc: Borislav Petkov, <linux-kernel@vger.kernel.org>, Nadav Amit, Andy
>> Lutomirsky, Ingo Molnar, Peter Zijlstra, Thomas Gleixner, Jann Horn
>>=20
>>> It may be useful to check in runtime whether certain assertions are
>>> violated even during speculative execution. This can allow to avoid
>>> adding unnecessary memory fences and at the same time check that no data=

>>> leak channels exist.
>>>=20
>>> For example, adding such checks can show that allocating zeroed pages
>>> can return speculatively non-zeroed pages (the first qword is not
>>> zero).  [This might be a problem when the page-fault handler performs
>>> software page-walk, for example.]
>>>=20
>>> Introduce SPEC_WARN_ON(), which checks in runtime whether a certain
>>> condition is violated during speculative execution. The condition should=

>>> be computed without branches, e.g., using bitwise operators. The check
>>> will wait for the condition to be realized (i.e., not speculated), and
>>> if the assertion is violated, a warning will be thrown.
>>>=20
>>> Warnings can be provided in one of two modes: precise and imprecise.
>>> Both mode are not perfect. The precise mode does not always make it easy=

>>> to understand which assertion was broken, but instead points to a point
>>> in the execution somewhere around the point in which the assertion was
>>> violated.  In addition, it prints a warning for each violation (unlike
>>> WARN_ONCE() like behavior).
>>>=20
>>> The imprecise mode, on the other hand, can sometimes throw the wrong
>>> indication, specifically if the control flow has changed between the
>>> speculative execution and the actual one. Note that it is not a
>>> false-positive, it just means that the output would mislead the user to
>>> think the wrong assertion was broken.
>>>=20
>>> There are some more limitations. Since the mechanism requires an
>>> indirect branch, it should not be used in production systems that are
>>> susceptible for Spectre v2. The mechanism requires TSX and performance
>>> counters that are only available in skylake+. There is a hidden
>>> assumption that TSX is not used in the kernel for anything else, other
>>> than this mechanism.
>>=20
>> Nice trick!
>=20
> =E2=80=9CIllusion." [ ignore if you don=E2=80=99t know the reference ]
>=20
>>=20
>> Can you eliminate the indirect call by forcing an access fault to
>> abort the transaction instead, e.g. "cmove 0, $1=E2=80=9D?
>>=20
>> (If this works, it may also allow support on older architectures as
>> the RTM_RETIRED.ABORT* events go back further I believe?)
>=20
> I don=E2=80=99t think it would work. The whole problem is that we need a c=
ounter
> that is updated during execution and not retirement. I tried several
> counters and could not find other appropriate ones.
>=20
> The idea behind the implementation is to affect the control flow through
> data dependency. I may be able to do something similar without an indirect=

> branch. I=E2=80=99ll take a page, put the XABORT on the page and make the p=
age NX.
> Then, a direct jump would go to this page. The conditional-mov would chang=
e
> the PTE to X if the assertion is violated. There should be a page-walk eve=
n
> if the CPU finds the entry in the TLB, since this entry is NX.
>=20

I think you only get a page walk if the TLB entry is not-present.  I=E2=80=99=
d be a bit surprised if the CPU is willing to execute, even speculatively, f=
rom speculatively written data. Good luck!=
