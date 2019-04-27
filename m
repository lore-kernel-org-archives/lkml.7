Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE186C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5F82087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="u9yTIjKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfD0N7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:59:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42406 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0N7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:59:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id w25so3083119pfi.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PI6q5rNMQB3L3EbNYvJfYnJlLDtk6q+SVS2IDRk0Rp8=;
        b=u9yTIjKTT3SKeKWRO6iD3c6cD2C1LEI4Jkds0FliUgZbI0fQg69UAzwQF6W0ngyP4E
         fQ+QzhFFQUJ/HCXEspgIwVeNd3wvVBbn6Hof8ui8IuzFMnPn85k62lKi+s8+Qmd55YMI
         eFVKSs/3AdKtV1HpWGfBDUB6da2dvBlZia7nbXgbGVA+oMjf87SCKgIkwTHQTukSReCM
         BsTZ8AUdyDTRY9cMcGRljcXH1RRaeuklljR0JioD4Iyeot7bIq7LwJH5G2n2MqHjaMkh
         yOjissV8Ge8mDPj9GUPtc3FvqmqHp/9yXAxLqSO4353jJkkYPyoA6NEieGtZ8MoPtxO/
         lUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PI6q5rNMQB3L3EbNYvJfYnJlLDtk6q+SVS2IDRk0Rp8=;
        b=kcF9aR8ECAqRxgEK6QvaBQc5vggrXkfpq5zzH9BLLx61Intv5IaVx8kXYHYjkGlpBF
         6ay5P7BpMoA890o9giQVh/P/qMrzU9w2ITjOEnnZbDx3c2eIXfdOw+t2JH7IDlRcdcNl
         pt5oRuIodmCorHz1kBjyk96hh6oDT8tVvex3KjCFzQJY2kD8o20J6LZou0HRydIoB+NM
         UewfnFO/pOvBp5wFs9MUOQXB1QnzwUYjvbho6iI4Z2yzdcLP0uEfJVSb+0FCw8IZb2p4
         Z8Sg6GzsmaEbcClNIkK8nVGVZtMpKvT2wSREBGGTyiV52GPCbC9wNLNuMmKFriKmOo1E
         x/wA==
X-Gm-Message-State: APjAAAU1lh0d/oSUm6TZJvHI7bkzFGYIMiS+G6bLvQ4Cw7UdboROD5+q
        +8fKNjX+dtDpahGDqEIpOa3Epw==
X-Google-Smtp-Source: APXvYqyuDIoj/chuwVRIRvlZjuFvmtYd//KFgWHU4jKdUnphydGG6nGZjhT7DUgrzjKjXnZgFs3TcQ==
X-Received: by 2002:a63:5c56:: with SMTP id n22mr50298258pgm.108.1556373578626;
        Sat, 27 Apr 2019 06:59:38 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:a08d:668a:535c:86e9? ([2601:646:c200:1ef2:a08d:668a:535c:86e9])
        by smtp.gmail.com with ESMTPSA id g63sm43128219pfc.127.2019.04.27.06.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 06:59:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190426180235.GC9835@mit.edu>
Date:   Sat, 27 Apr 2019 06:59:36 -0700
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
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
Message-Id: <1EB25EC8-28A4-46C6-84E9-14858B68C815@amacapital.net>
References: <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com> <20190416154348.GB3004@mit.edu> <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com> <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com> <20190417151555.GG4686@mit.edu> <99e045427125403ba2b90c2707d74e02@AcuMS.aculab.com> <2236FBA76BA1254E88B949DDB74E612BA4C5E473@IRSMSX102.ger.corp.intel.com> <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com> <20190426140102.GA4922@mit.edu> <20190426174419.GB691@sol.localdomain> <20190426180235.GC9835@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 26, 2019, at 11:02 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
>> On Fri, Apr 26, 2019 at 10:44:20AM -0700, Eric Biggers wrote:
>> Would it be possibly to call ChaCha20 through the actual crypto API so th=
at SIMD
>> instructions (e.g. AVX-2) could be used?  That would make it *much* faste=
r.
>> Also consider AES-CTR with AES-NI instructions.
>=20
> It's not obvious SIMD instructions will be faster in practice, since
> it requires saving and restoring the vector/FPU registers.  If you're
> going to be doing a *lot* of vector processing (for example when doing
> block-level RAID-5 / RAID-6 computations), it might be worth it.  But
> if you're only going to be turning the crank for 12 or 20 rounds, the
> overhead of calling kernel_fpu_begin() and kernel_fpu_end() is
> probably going to make this worth it.
>=20

So generate a whole page or more of random bytes at a time and save them up f=
or when they=E2=80=99re needed.=
