Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CABC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713B52075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="cGF3AP4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfECQkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:40:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45072 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfECQkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:40:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id o5so2934587pls.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 09:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wO+jnW70s0cmOTXg4iOs5E+w567bkWpBLIgvBYRMCxM=;
        b=cGF3AP4tRiCgQyFVUzz9dmLwmzg/EKlZu0Io9Quu+YlZukBQo4VPWnSafapLdH6wiK
         tCKauzUcit5AeZX5tmEU/REVUQrsqsXh8BvYW/wEwsVb8n3WDXijDdWXep5L2fcnZjuo
         F7JK69WTo6QgfZmAkd+sZfytfC9nkIkEWSxzSgXcKHSA1VIkWXszvQ53/xHR+kl+a4Nq
         SmGPeFa6/bG80pkUtxBu0awmqA0d2UiZxBAV6iy8LR3GX5i2iB3zibWajEvpGMOM1hSH
         aukbBHcmBS8qeJCofwboAtg32svSvvnMMCUTBgnD+y4T5It9L/u2qJq0SbuMVwe9A8mK
         NYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wO+jnW70s0cmOTXg4iOs5E+w567bkWpBLIgvBYRMCxM=;
        b=hDsqSt04KHXEHNdNQBcT+1qyw2JLr2TQJmtdPbjPhwmOHi7nlC+5VqcKrxrLHXXteq
         Gomj7OmlqSQ+2alCLtx7Zm31dVJ3mP4hcpFTXvyJoz0gl9aEqgrg05368kRazZk0UThb
         KfDkALfht86siirz0mY6qT9qpJV80gj+pTimEH/PDbsKNKOsTEi0k+QJbwnFDaX7W5WE
         YVUnyP5RX4dSOEykl/M6p8ZtX/9+7PzyFHTnyEo3Ii+A76UlwvVKdkKfm+5Iy5MVoTnr
         whV5WAAWgyFQfwfM2BBi0f1Ul0xb/g0b9I4AupNhAzN359O+Dn2f5LvTZd/kEGTFy1Ll
         hP5w==
X-Gm-Message-State: APjAAAUn51qGmeEYBWMeb8t3WzrucFSpt60vOl/GhwIGBLkdMSK3YKj1
        7zhdmPOQOkgnUYB6NAs+nL1oeA==
X-Google-Smtp-Source: APXvYqwLgW3kxzwj1kIVAKhisJj8j7z5+A4dUMmuS0r5cZCs+9ceMPHDywayEvVH0NPACj034iXdWg==
X-Received: by 2002:a17:902:6ac6:: with SMTP id i6mr11650609plt.313.1556901642168;
        Fri, 03 May 2019 09:40:42 -0700 (PDT)
Received: from [10.145.97.154] ([12.53.65.170])
        by smtp.gmail.com with ESMTPSA id a6sm3539309pfn.181.2019.05.03.09.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 09:40:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190502164325.GA115950@gmail.com>
Date:   Fri, 3 May 2019 09:40:40 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DD37CAB-2197-42EC-9D27-5DF924EED22B@amacapital.net>
References: <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net> <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com> <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net> <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com> <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com> <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com> <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com> <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com> <20190502150853.GA16779@gmail.com> <CALCETrVBXZNAKGRXm0_txKGjqKnjx30Eb05hesye8M50D4A8Mw@mail.gmail.com> <20190502164325.GA115950@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 2, 2019, at 9:43 AM, Ingo Molnar <mingo@kernel.org> wrote:
>=20
>=20
> * Andy Lutomirski <luto@kernel.org> wrote:
>=20
>>> 8 gigabits/sec sounds good throughput in principle, if there's no
>>> scalability pathologies with that.
>>=20
>> The latency is horrible.
>=20
> Latency would be amortized via batching anyway, so 8 gigabits/sec=20
> suggests something on the order of magnitude of 4 bits per cycle, right?=20=

> With 64 bits extraction at a time that would be 16 cycles per 64-bit=20
> word, which isn't too bad, is it?

I haven=E2=80=99t really dug in, but some Googling suggests that the 8Gbps f=
igure is what you get with all cores doing RDRAND.  It sounds like the actua=
l RDRAND instruction doesn=E2=80=99t pipeline.

> Making it "optional" is not really a technical argument in any way=20
> though, either distros enable it in which case it's a de-facto default=20
> setting, or they don't, in which case it de-facto almost doesn't exist.
>=20
>=20

True.=
