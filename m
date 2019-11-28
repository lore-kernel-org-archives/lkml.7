Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98BDC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 03:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9AC2071F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 03:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="MnoCuKgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfK1Ds7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 22:48:59 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39498 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfK1Ds7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 22:48:59 -0500
Received: by mail-pj1-f65.google.com with SMTP id v93so7965813pjb.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 19:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=yv4lzaz/lJ+UAu0LhgGWX8+y+KBGfeSxnjpBF0v9wfw=;
        b=MnoCuKgb7WTxxIhTf4H+faWz2M7maNA11WFAus47nFLD/Yv8Kr9B2HnVfFBtIX1taR
         skamCl7z2aynaCRlOK7sH1c0JnVR0oNI6PmKASzXX3OQvh7fUteyV1lzUmdDJPFrmlgb
         m37nvyOO+3lJyOfhAEdbRDTwcPdORbFegfMLWSpUopZdXbbaYJ154EowUZnRRdApk4I5
         hJHj7CG/slexlYJCqxSyfWefzyRSGIjhxFSTfEL1aacmOyvCFmFz41ZX2wKoP3zh5qwP
         K8J3llpNq6Wew03q8hr0PRa1oQwIeu90MrI09g6iwvJRyurbVzjdXKbejGUkWYcqOfAj
         KoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=yv4lzaz/lJ+UAu0LhgGWX8+y+KBGfeSxnjpBF0v9wfw=;
        b=URdxIoebawI8Dl6LiCaverLoSzLBzGfqd0LyqsAe5/sJwaF3zENoFtNpD43wEqWH9m
         0Bxf8sFeRk3pJNT0y3E4PgDsnMb9dqtdmehA/AUyWQAQbnbryH9sJlcjwJeSmykf7S6X
         reRnExeZrBsAGH7v/3K1egVl9aV2IsoLO7XMdiA1arHojbGx2PhIGSRIj6BeZ5sCj8zz
         XDVWdESkZ0oD41cHIm0G4JCLLnhb7NDVRQ+e0872ZMhd0Y/Ii9kPzYIjTX/yjM3VO9s1
         aIzowXbtd4x1f5VIv5NrLdeK4VOn74oHec/1ND606bR675GnTF8fcDxf3uuzuloe6+Au
         XExA==
X-Gm-Message-State: APjAAAX11APqLBfWPI1gGDKAiEEm3i20jd4x5msOiCf7wsVeLsQqV/hJ
        BSiyTp2yeJy5eWN5kRVQDwHr/w==
X-Google-Smtp-Source: APXvYqyyBdGALJ9xeEsJ3KrCmaVDycwJs6ljGTasssYWlYkE3BMlOLomFjp5o7IPZAgNNjfxjsR6Kg==
X-Received: by 2002:a17:902:b101:: with SMTP id q1mr7895615plr.154.1574912938343;
        Wed, 27 Nov 2019 19:48:58 -0800 (PST)
Received: from ?IPv6:2600:1010:b040:9410:acb0:9c64:b6aa:d8e3? ([2600:1010:b040:9410:acb0:9c64:b6aa:d8e3])
        by smtp.gmail.com with ESMTPSA id c17sm18049268pfo.42.2019.11.27.19.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 19:48:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] lkdtm/bugs: Avoid ifdefs for DOUBLE_FAULT
Date:   Wed, 27 Nov 2019 19:48:27 -0800
Message-Id: <2BD95E04-8DA9-40CA-B9B0-1548325B044D@amacapital.net>
References: <201911271852.4AA977DFD@keescook>
Cc:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        x86 <x86@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <201911271852.4AA977DFD@keescook>
To:     Kees Cook <keescook@chromium.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 27, 2019, at 6:54 PM, Kees Cook <keescook@chromium.org> wrote:
>=20
> =EF=BB=BFOn Wed, Nov 27, 2019 at 06:15:17PM -0800, Andy Lutomirski wrote:
>>=20
>>>> On Nov 27, 2019, at 5:50 PM, Kees Cook <keescook@chromium.org> wrote:
>>>=20
>>> =EF=BB=BFOn Wed, Nov 27, 2019 at 01:01:40PM -0800, Andy Lutomirski wrote=
:
>>>>=20
>>>>=20
>>>>>> On Nov 27, 2019, at 11:19 AM, Kees Cook <keescook@chromium.org> wrote=
:
>>>>>=20
>>>>> =EF=BB=BFLKDTM test visibility shouldn't change, so remove the ifdefs o=
n
>>>>> DOUBLE_FAULT and make sure test failure doesn't crash the system.
>>>>>=20
>>>>> Link: https://lore.kernel.org/lkml/20191127184837.GA35982@gmail.com
>>>>> Fixes: b09511c253e5 ("lkdtm: Add a DOUBLE_FAULT crash type on x86")
>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>> ---
>>>>> applies on top of tip/x86/urgent
>>>>> ---
>>>>> drivers/misc/lkdtm/bugs.c  | 8 +++++---
>>>>> drivers/misc/lkdtm/core.c  | 4 +---
>>>>> drivers/misc/lkdtm/lkdtm.h | 2 --
>>>>> 3 files changed, 6 insertions(+), 8 deletions(-)
>>>>>=20
>>>>> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
>>>>> index a4fdad04809a..22f5293414cc 100644
>>>>> --- a/drivers/misc/lkdtm/bugs.c
>>>>> +++ b/drivers/misc/lkdtm/bugs.c
>>>>> @@ -342,9 +342,9 @@ void lkdtm_UNSET_SMEP(void)
>>>>> #endif
>>>>> }
>>>>>=20
>>>>> -#ifdef CONFIG_X86_32
>>>>> void lkdtm_DOUBLE_FAULT(void)
>>>>> {
>>>>> +#ifdef CONFIG_X86_32
>>>>>  /*
>>>>>   * Trigger #DF by setting the stack limit to zero.  This clobbers
>>>>>   * a GDT TLS slot, which is okay because the current task will die
>>>>> @@ -373,6 +373,8 @@ void lkdtm_DOUBLE_FAULT(void)
>>>>>  asm volatile ("movw %0, %%ss; addl $0, (%%esp)" ::
>>>>>            "r" ((unsigned short)(GDT_ENTRY_TLS_MIN << 3)));
>>>>>=20
>>>>> -    panic("tried to double fault but didn't die\n");
>>>>> -}
>>>>> +    pr_err("FAIL: tried to double fault but didn't die!\n");
>>>>> +#else
>>>>> +    pr_err("FAIL: this test is only available on 32-bit x86.\n");
>>>>> #endif
>>>>> +}
>>>>=20
>>>> I=E2=80=99m not familiar with the userspace tooling, but this seems unf=
ortunate. The first FAIL is =E2=80=9Cthe test case screwed up, and it=E2=80=99=
s a bug.=E2=80=9D  The second FAIL is =E2=80=9Cnot applicable to this system=
.=E2=80=9D
>>>>=20
>>>>=20
>>>> ISTM simply not exposing the test on systems that don=E2=80=99t support=
 makes sense. Can you clarify?
>>>=20
>>> I don't like the tests liked in the DIRECT file to change from build to
>>> build (it should be stable per kernel version). Userspace needs to know
>>> how to evaluate the results of running each test, so in both cases, I
>>> consider it a failure: double fault didn't work or you tried to test
>>> double fault on an unsupported architecture. (The SMEP test works
>>> similarly.)
>>>=20
>>=20
>>=20
>> So how is the test harness supposed
>> to distinguish success from failure?  If it printed UNSUPPORTED instead o=
f FAIL, it would make more sense to me, but I=E2=80=99m not sure why that=E2=
=80=99s better than just not exposing it at all.
>=20
> If kernelci or similar ever mentions this as a problem for them, I'm
> happy to change it. I think it's an error to request this test in the
> wrong environment (because that implies userspace doesn't know how to
> evaluate the results). As I like it _available_ because having it
> missing makes the code ugly (lots of ifdefs) and provides to signal to
> userspace about it (EINVAL on the write to DIRECT) doesn't tell me if I
> have the wrong kernel version or the wrong architecture, etc. Since the
> tester needs to be parsing dmesg and system state (did it panic, etc), I
> much prefer keeping the signals there.
>=20
>=20

Could we perhaps standardized on some particular error code to say =E2=80=9C=
I know about this test, but it=E2=80=99s not implemented on this kernel?=E2=80=
=9D=
