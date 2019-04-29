Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C15C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDF420673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="mJoF2k0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfD2QIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:08:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38659 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfD2QIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:08:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so5546315pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DgqEiFoJ0lREmPgEjE6zA2ZDdNhn1GFrfwTI165MKEs=;
        b=mJoF2k0cQ6CXpyu+xjlYytIZm428iS7bDzAWm7CJ26qbT8k3sYpmlWfG3tSDd+BifW
         tYYNTyh2SPjzWsdH0cpqkrTJy7yYbT2a24aB5KWOBrrtOdb/A9w92HMlIDW+T9OL7z7L
         LKaZeTZ3Q361qQA5zVBimZjp1RW/F/8HIqNt+3TY/yveobjdZJagBcc2UZMIG81FIV9u
         PM3PCwEjrkcEGjHbClQrFQojF2l2rHMy+6XjnSQQEyt35tXUhefzaMl8asTaybROf/fD
         8lK8zx+Z88fb9+nqITH5FTTHfLrmZP8i0LO1nieluXt8j4Inv0F7kLOkCghsckquRqTj
         lcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DgqEiFoJ0lREmPgEjE6zA2ZDdNhn1GFrfwTI165MKEs=;
        b=eN3QoOnq0iLKsefA6UhjCNlJe8GUQUUHIRVw0SgH56/oOigewTCk6/bioUNNkDGPUH
         MeiO4+veDskhZGJ/cuBd2t9qbB4gdZbUD5m63GQSFKlMZxkOky7PGp3TaDC0SfUnqFDN
         62baDuQLHFnsGMxbDXUEPLyUuRx1rSwl6NLZuKZs+aB+IsINP6rjsmUo1KO0gqp1v/bL
         oeHIZn9o2nrg9la/4Utshaz+X9L5srw8c6Z8KFXmnFs3QH2HeHsK/JwiUQhkAxfK1PTW
         y5Jvo8iwNgQjvDe24RxGcwcmXjd+x1N2D0JjdF2uI0ykg/Ls5ubh/1Rhl2ytX/PRROAd
         CwLg==
X-Gm-Message-State: APjAAAXKHonMKo+F2zt0t1b2U5no+Xc38ZA3meWFH38nHs0Kqiq6KT8R
        wiZSDS7M9zLNXNr7Kc5EuP1qnA==
X-Google-Smtp-Source: APXvYqzjBAl0JBYAWNMknyt6gMWXG4KtZqCJrdWupd/8F9tf0yNkLgXN7GOLbGVffksCkt/xKKfvRQ==
X-Received: by 2002:aa7:8589:: with SMTP id w9mr63888990pfn.97.1556554092724;
        Mon, 29 Apr 2019 09:08:12 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:9576:fc98:a516:2c9b? ([2601:646:c200:1ef2:9576:fc98:a516:2c9b])
        by smtp.gmail.com with ESMTPSA id j32sm22964507pgi.73.2019.04.29.09.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 09:08:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
Date:   Mon, 29 Apr 2019 09:08:10 -0700
Cc:     Theodore Ts'o <tytso@mit.edu>, Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net>
References: <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com> <20190416120822.GV11158@hirez.programming.kicks-ass.net> <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com> <20190416154348.GB3004@mit.edu> <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com> <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com> <20190417151555.GG4686@mit.edu> <99e045427125403ba2b90c2707d74e02@AcuMS.aculab.com> <2236FBA76BA1254E88B949DDB74E612BA4C5E473@IRSMSX102.ger.corp.intel.com> <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com> <20190426140102.GA4922@mit.edu> <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net> <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 29, 2019, at 12:46 AM, Reshetova, Elena <elena.reshetova@intel.com>=
 wrote:
>=20
>=20
>>>> On Apr 26, 2019, at 7:01 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>>>=20
>=20
>> It seems to me
>> that we should be using the =E2=80=9Cfast-erasure=E2=80=9D construction f=
or all get_random_bytes()
>> invocations. Specifically, we should have a per cpu buffer that stores so=
me random
>> bytes and a count of how many random bytes there are. get_random_bytes() s=
hould
>> take bytes from that buffer and *immediately* zero those bytes in memory.=
 When
>> the buffer is empty, it gets refilled with the full strength CRNG.
>=20
> Ideally it would be great to call smth fast and secure on each syscall wit=
hout a per-cpu
> buffer,

Why?  You only need a few bits, and any sensible crypto primitive is going t=
o be much better at producing lots of bits than producing just a few bits.  E=
ven ignoring that, avoiding the I-cache hit on every syscall has value.  And=
 I still don=E2=80=99t see what=E2=80=99s wrong with a percpu buffer.

> so that's why I was asking on chacha8. As Eric pointed it should not be us=
ed for
> cryptographic purpose, but I think it is reasonably secure for our purpose=
, especially if
> the generator is sometimes reseeded with fresh entropy.=20
> However, it very well might be that is too slow anyway.=20
>=20
> So, I think then we can do the per-cpu approach as you suggesting.=20
> Have a per-cpu buffer big enough as you suggested (couple of pages) from w=
here
> we regularly read 8 bits at the time and zero them as we go.=20
>=20
> I am just not sure on the right refill strategy in this case?
> Should we try to maintain this per-cpu buffer always with some random byte=
s by
> having a work queued that would refill it (or part of it, i.e. a page from=
 a set of 4 pages)=20
> regularly from CRNG source?=20
> I guess how often we need to refill will depend so much on the syscall rat=
e
> on that cpu, so it might be hard to find a reasonable period.
> In any case we need to prepare to do a refill straight from a syscall,
> if despite our best efforts to keep the buffer refilled we run out of bits=
.
> Is it ok to get a visible performance hit at this point? In worse case we w=
ill need to
> generate n pages worth of random numbers, which is going to take a
> while.=20

I think a small hit every few syscalls is okay. The real time people will tu=
rn this off regardless.

>=20
> I will try doing this PoC and measure implications (without the worker
> refill to start with). Let's see how bad (performance wise it looks).
>=20
> Best Regards,
> Elena.
>=20
>=20
>=20
>=20
>=20
>> The obvious objection is =E2=80=9Coh no, a side channel could leak the bu=
ffer,=E2=80=9D to which I say
>> so what?  A side channel could just as easily leak the entire CRNG state.=

>>=20
>> For Elena=E2=80=99s specific use case, we would probably want a
>> try_get_random_bytes_notrace() that *only* tries the percpu buffer, since=
 this code
>> runs so early in the syscall path that we can=E2=80=99t run real C code. =
 Or it could be moved a
>> bit later, I suppose =E2=80=94 the really early part is not really an int=
eresting attack surface.
