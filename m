Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28365C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF062084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="rcFKYuVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfDZSef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:34:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39811 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDZSef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:34:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so2125672pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 11:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tDfEPJwrCBm9ci6wcZlpH2GjNvZ19A1r9EBuG6Egn6I=;
        b=rcFKYuVC6oT/eYO8J0r5N5LCOhiVxa6IJSL6fsD6++o2pokWciQezrHbpc7j/zwir6
         uOsvOlRzBtkd+62RglCNdgjYGiLcIERP4LbLmJA6kSxRhFinQSwY1HTjqFqFpqFEPJqa
         DNd24X8Lj5XF5scKwhI3mfyGv49IAawdksS9UPg+x5P4e9bsUhaYfLBm97yN7OHe8jYt
         /9u5ja6R59D5F7BEY5tliPERqw7c7CsoScqGm0rICEjgjvx8tWu0Pb+GK/nQ2fDU0Uwj
         J6Balk2gcXt4gBIIgsBkRplRtZ+sfVnX+t9zfc8YJJyOOUqdFlN5MpoCo5rpdDniBoX9
         fBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tDfEPJwrCBm9ci6wcZlpH2GjNvZ19A1r9EBuG6Egn6I=;
        b=isyHQEV0MhztDwG0Q6K3M+v+Sof1DYTydgsB1PcNMmkzl9BRn++g513rJrc2yhEsMA
         AyRJ1HdIOS6kaGyyg+gPrxZcETeH8gURiyz0unThTFV/0s5HNyS/KCijPQNCpBr41l8O
         V9B88hTaubUE+JDRuYKQty6LX9f/bT4V4MsBMXHfwYEfMxb/dnnmD9UBQED5aeQ46KC3
         oQnDFDWwn8xQsbAEbXArM6/thd6YS2zxsW7GVZwh3r6sC0jCmBeTCBo6ngRvHoPVvnC3
         TcKUMg2iDvQeotVwkm+/DTqdL7mPm8BEHhjE/TbS0gyjbjbCoNBN5SqmX/PcicIem327
         IngA==
X-Gm-Message-State: APjAAAVvdLsCB7bpPf8QA3kpQFWJZ9aelbmANKxxHWBEIyQKPx3fgg/Z
        ZsYvqq6V0FM6x+f1BR6yF2xiuA==
X-Google-Smtp-Source: APXvYqx8WqiPou8MIR2345lbQKJw5lKWL+8voZuzgRfuNjUKK9hWJMRfdVlM3kOXPWYL+mzoc+3IqQ==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr45381451pgj.396.1556303672953;
        Fri, 26 Apr 2019 11:34:32 -0700 (PDT)
Received: from ?IPv6:2601:647:5803:15b9:c55e:7075:3f8:ca93? ([2601:647:5803:15b9:c55e:7075:3f8:ca93])
        by smtp.gmail.com with ESMTPSA id x6sm3448889pfm.114.2019.04.26.11.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 11:34:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190426140102.GA4922@mit.edu>
Date:   Fri, 26 Apr 2019 11:34:29 -0700
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        Eric Biggers <ebiggers3@gmail.com>,
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
Message-Id: <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net>
References: <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com> <20190416120822.GV11158@hirez.programming.kicks-ass.net> <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com> <20190416154348.GB3004@mit.edu> <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com> <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com> <20190417151555.GG4686@mit.edu> <99e045427125403ba2b90c2707d74e02@AcuMS.aculab.com> <2236FBA76BA1254E88B949DDB74E612BA4C5E473@IRSMSX102.ger.corp.intel.com> <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com> <20190426140102.GA4922@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 26, 2019, at 7:01 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
>> On Fri, Apr 26, 2019 at 11:33:09AM +0000, Reshetova, Elena wrote:
>> Adding Eric and Herbert to continue discussion for the chacha part.=20
>> So, as a short summary I am trying to find out a fast (fast enough to be u=
sed per syscall
>> invocation) source of random bits with good enough security properties.=20=

>> I started to look into chacha kernel implementation and while it seems th=
at it is designed to=20
>> work with any number of rounds, it does not expose less than 12 rounds pr=
imitive.=20
>> I guess this is done for security sake, since 12 is probably the lowest b=
ound we want people
>> to use for the purpose of encryption/decryption, but if we are to build a=
n efficient RNG,
>> chacha8 probably is a good tradeoff between security and speed.=20
>>=20
>> What are people's opinions/perceptions on this? Has it been considered be=
fore to create a
>> kernel RNG based on chacha?
>=20
> Well, sure.  The get_random_bytes() kernel interface and the
> getrandom(2) system call uses a CRNG based on chacha20.  See
> extract_crng() and crng_reseed() in drivers/char/random.c.
>=20
> It *is* possible to use an arbitrary number of rounds if you use the
> low level interface exposed as chacha_block(), which is an
> EXPORT_SYMBOL interface so even modules can use it.  "Does not expose
> less than 12 rounds" applies only if you are using the high-level
> crypto interface.
>=20
> We have used cut down crypto algorithms for performance critical
> applications before; at one point, we were using a cut down MD4(!) for
> initial TCP sequence number generation.  But that was getting rekeyed
> every five minutes, and the goal was to make it just hard enough that
> there were other easier ways of DOS attacking a server.
>=20
> I'm not a cryptographer, so I'd really us to hear from multiple
> experts about the security level of, say, ChaCha8 so we understand
> exactly kind of security we'd offering.  And I'd want that interface
> to be named so that it's clear it's only intended for a very specific
> use case, since it will be tempting for other kernel developers to use
> it in other contexts, with undue consideration.
>=20
>                   =20

I don=E2=80=99t understand why we=E2=80=99re even considering weaker primiti=
ves. It seems to me that we should be using the =E2=80=9Cfast-erasure=E2=80=9D=
 construction for all get_random_bytes() invocations. Specifically, we shoul=
d have a per cpu buffer that stores some random bytes and a count of how man=
y random bytes there are. get_random_bytes() should take bytes from that buf=
fer and *immediately* zero those bytes in memory. When the buffer is empty, i=
t gets refilled with the full strength CRNG.

The obvious objection is =E2=80=9Coh no, a side channel could leak the buffe=
r,=E2=80=9D to which I say so what?  A side channel could just as easily lea=
k the entire CRNG state.

For Elena=E2=80=99s specific use case, we would probably want a try_get_rand=
om_bytes_notrace() that *only* tries the percpu buffer, since this code runs=
 so early in the syscall path that we can=E2=80=99t run real C code.  Or it c=
ould be moved a bit later, I suppose =E2=80=94 the really early part is not r=
eally an interesting attack surface.=
