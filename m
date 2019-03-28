Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4A9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597902184E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="RIp/KsFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfC1Q3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:29:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39715 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfC1Q3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:29:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id b65so5198366plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RxFrSWtGPO79n9lr7nT7AeJd7E6z+epkd6jFSZgZglI=;
        b=RIp/KsFM50/JZ3AZn/R53IGw4Y2rcHw9vEOUeLkVo1cwf9+gx0fUvBEY2ENtqZfauh
         OWlysxoEXmeTVGKb1ZjUpagxPLZW/wJE1skRdAWPR9xmEEINyuBrtqGBZwlbfg8jGgtr
         wVqGkeNQEhyr536f+E1FX1jtOAutXKm2AGwJxhtvS3/K0l/19Rz4UZR2nOJ/+CCD0WUN
         vmsnxtST1vJ7uVVcKzDv/Q4SFXs5EfHtVRvH3BTFtlRmQ1UuzM2qlj6wt6p4l5aqqh3d
         PHvUHCqtWQyZUjBuukuSH9hsdtOvPVHvaDTuzxliW+6JRmjw1xjmFDxqUjfVsvBsKlib
         Kfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RxFrSWtGPO79n9lr7nT7AeJd7E6z+epkd6jFSZgZglI=;
        b=EO/1+utxwWTHo1+1wGGc4twOkJX1Z5BFrjZMC6jGSnYKEPC01c4hS0XE8PkhQrTU4D
         92F2yblfmDnavmDeiyHxdpLwkCEjOtdxy3IZKkebcSTp13PkVRrxxIrwUf7XiZtUuG4n
         JgpciwywP9X2nGaewM5pDAKjl1wpgIKKMdFrKGVssJRJ2ezgJM8UmRES7rdo8K4Xndrs
         IcagDE/NUaVuT75ph198BJcYP18webrEDE8VSE1ijTBWd9rTkVix3lG8jwXht5nETkQ3
         FwLCKwHd5TXwLMiiH1601zHbaGhJXRDLU400G1cDFf8QWkkWUvtBwQ75FBhhCIXyTAw5
         0ANQ==
X-Gm-Message-State: APjAAAUDzyq2uFqvyJFJ5QkSMZN7n7fae/vlXlGRuaQAv2KDNSkV9Jf2
        E5oTtsWDuzVlgEe4ZRZUdS0IHg==
X-Google-Smtp-Source: APXvYqymbKsJqi6kvTxiJ892xPc5sAdDFA1byJ95ldiu57meZpxg6nXkmiJTRuD0HPOGO7m2zu+MUg==
X-Received: by 2002:a17:902:a5c3:: with SMTP id t3mr3508356plq.293.1553790556330;
        Thu, 28 Mar 2019 09:29:16 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:8ce3:3cc7:a36a:8c04? ([2601:646:c200:1ef2:8ce3:3cc7:a36a:8c04])
        by smtp.gmail.com with ESMTPSA id c1sm17114625pgk.44.2019.03.28.09.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:29:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon syscall
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <CAGXu5j+r-NH5+QY=siE+6RTkUKoRF0Rso6KHM4NOMsCvpcjW5g@mail.gmail.com>
Date:   Thu, 28 Mar 2019 09:29:13 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F1480E2-3D58-4A79-8609-2A9F7991804F@amacapital.net>
References: <20190318094128.1488-1-elena.reshetova@intel.com> <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com> <CAGXu5jLQaa2FYMOpQPLdRPmUPNY8jq7whM6Wa_YGjfH7oHwx4Q@mail.gmail.com> <2236FBA76BA1254E88B949DDB74E612BA4C19A55@IRSMSX102.ger.corp.intel.com> <CALCETrXnfk5zYWmpdLvYbcJ7hhFM13+LPq14MF7s99iqtS4-jg@mail.gmail.com> <CAGXu5j+r-NH5+QY=siE+6RTkUKoRF0Rso6KHM4NOMsCvpcjW5g@mail.gmail.com>
To:     Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 28, 2019, at 8:45 AM, Kees Cook <keescook@chromium.org> wrote:
>=20
>> On Tue, Mar 26, 2019 at 9:31 PM Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>> On Tue, Mar 26, 2019 at 3:35 AM Reshetova, Elena
>> <elena.reshetova@intel.com> wrote:
>>>=20
>>>>> On Mon, Mar 18, 2019 at 1:16 PM Andy Lutomirski <luto@kernel.org> wrot=
e:
>>>>> On Mon, Mar 18, 2019 at 2:41 AM Elena Reshetova
>>>>> <elena.reshetova@intel.com> wrote:
>>>>>> Performance:
>>>>>>=20
>>>>>> 1) lmbench: ./lat_syscall -N 1000000 null
>>>>>>    base:                     Simple syscall: 0.1774 microseconds
>>>>>>    random_offset (rdtsc):     Simple syscall: 0.1803 microseconds
>>>>>>    random_offset (rdrand): Simple syscall: 0.3702 microseconds
>>>>>>=20
>>>>>> 2)  Andy's tests, misc-tests: ./timing_test_64 10M sys_enosys
>>>>>>    base:                     10000000 loops in 1.62224s =3D 162.22 ns=
ec / loop
>>>>>>    random_offset (rdtsc):     10000000 loops in 1.64660s =3D 164.66 n=
sec / loop
>>>>>>    random_offset (rdrand): 10000000 loops in 3.51315s =3D 351.32 nsec=
 / loop
>>>>>>=20
>>>>>=20
>>>>> Egads!  RDTSC is nice and fast but probably fairly easy to defeat.
>>>>> RDRAND is awful.  I had hoped for better.
>>>>=20
>>>> RDRAND can also fail.
>>>>=20
>>>>> So perhaps we need a little percpu buffer that collects 64 bits of
>>>>> randomness at a time, shifts out the needed bits, and refills the
>>>>> buffer when we run out.
>>>>=20
>>>> I'd like to avoid saving the _exact_ details of where the next offset
>>>> will be, but if nothing else works, this should be okay. We can use 8
>>>> bits at a time and call prandom_u32() every 4th call. Something like
>>>> prandom_bytes(), but where it doesn't throw away the unused bytes.
>>>=20
>>> Actually I think this would make the end result even worse security-wise=

>>> than simply using rdtsc() on every syscall. Saving the randomness in per=
cpu
>>> buffer, which is probably easily accessible and can be probed if needed,=

>>> would supply attacker with much more knowledge about the next 3-4
>>> random offsets that what he would get if we use "weak" rdtsc. Given
>>> that for a successful exploit, an attacker would need to have stack alig=
ned
>>> once only, having a knowledge of 3-4 next offsets sounds like a present t=
o an
>>> exploit writer...  Additionally it creates complexity around the code th=
at I
>>> have issues justifying with "security" argument because of above...
>=20
> That certainly solidifies my concern against saving randomness. :)
>=20
>>> I have the patch now with alloca() and rdtsc() working, I can post it
>>> (albeit it is very simple), but I am really hesitating on adding the per=
cpu
>>> buffer randomness storage to it...
>>>=20
>>=20
>> Hmm.  I guess it depends on what types of attack you care about.  I
>> bet that, if you do a bunch of iterations of mfence;rdtsc;syscall,
>> you'll discover that the offset between the user rdtsc and the
>> syscall's rdtsc has several values that occur with high probability.
>=20
> How about rdtsc xor with the middle word of the stack canary? (to
> avoid the 0-byte) Something like:
>=20
>    rdtsc
>    xorl [%gs:...canary....], %rax
>    andq  $__MAX_STACK_RANDOM_OFFSET, %rax
>=20
> I need to look at the right way to reference the canary during that
> code. Andy might know off the top of his head. :)
>=20

Doesn=E2=80=99t this just leak some of the canary to user code through side c=
hannels?=
