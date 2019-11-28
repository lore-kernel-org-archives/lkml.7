Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E367AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 02:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABA2215F2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 02:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="LojbQ22s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfK1CPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 21:15:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38663 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbfK1CPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 21:15:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id o8so6535354pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 18:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=XKJnukPRIpRZM8ESM42CDezgPUH+DNpYUDF+AgeMnxA=;
        b=LojbQ22sjkATQWlWLgldJDisEccdNnFSAr/WbVbHBsNFqUEJQd4EfE+e+k2L7buwJX
         72qUUsnI9S87uUkAp2a3K4sw17UOrP8a8hEnQYdVv2PFz/fvRyjnJqxX57LdSk17hAm7
         fQCMeZXtebD75ZrZ00EeGdAKSAD3TiPv8BHzCDTMNKvrCXPZBoG4/LYmR9VtmQRpOO5Y
         LE+/ceeilOK2yMrLC54h5Zko8plN3PCbNl/x67egNAy/KMg+PeNcAcWkzqzvr9eAY2eq
         rE0WxH0UZlxAXVB3qns3e1sYH1EKDJVmldgOgGuILNa+XKFi6BpbhYP3jVtubo0l9/EG
         tKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=XKJnukPRIpRZM8ESM42CDezgPUH+DNpYUDF+AgeMnxA=;
        b=ZWWNN90MTHS9qdJSx7/jZcC3y0VxFo5judruv8p17Vpe3RbcM7jOdLPuEBHv6ZhO+Q
         XaL5xwfXpdxgH/KF+VADcE5xe2HSAm2kcB44Au72hTvAUkM9XY4P+TK0irr1joYmDyON
         n2EPASJLx4ArdChRP4eZj7ZhE85OBty5XcjFOthlgaG80/NFrG/1sq2WRz5NwRIqFK/S
         L36aRj/NtGgoQiJasUwC2EhgdNF5ZwEh9/5iENKPVWSAskfEIDUNZ4zMCu+f2tBwCghi
         06AsfzKFF7vt/suunIdSCm2obDiNFOCImGb5s/2CQ93I+m7aGjd6QB8fLKhsBX1fcEIg
         EbhA==
X-Gm-Message-State: APjAAAVb3PCU4oJqQ4BvjJbPS5SgRluzey9DXHW6kzhP0BoNbEpUou1q
        Nz8bN/P2UJCswxcm6s/T+rfNDg==
X-Google-Smtp-Source: APXvYqwTRN+B7usIpZ2EjxKm7sld1bFhj6BbhPH3fXWS8xVewpkEMaeYUAea0ocTRBZgtWFWNJef/w==
X-Received: by 2002:a17:902:8ec4:: with SMTP id x4mr7060349plo.114.1574907320118;
        Wed, 27 Nov 2019 18:15:20 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:d875:fac7:54dc:40be? ([2601:646:c200:1ef2:d875:fac7:54dc:40be])
        by smtp.gmail.com with ESMTPSA id p5sm17953369pgj.63.2019.11.27.18.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 18:15:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] lkdtm/bugs: Avoid ifdefs for DOUBLE_FAULT
Date:   Wed, 27 Nov 2019 18:15:17 -0800
Message-Id: <C0659748-A5B3-45D3-B752-88A643C66E46@amacapital.net>
References: <201911271748.A7C361E28@keescook>
Cc:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        x86 <x86@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <201911271748.A7C361E28@keescook>
To:     Kees Cook <keescook@chromium.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 27, 2019, at 5:50 PM, Kees Cook <keescook@chromium.org> wrote:
>=20
> =EF=BB=BFOn Wed, Nov 27, 2019 at 01:01:40PM -0800, Andy Lutomirski wrote:
>>=20
>>=20
>>>> On Nov 27, 2019, at 11:19 AM, Kees Cook <keescook@chromium.org> wrote:
>>>=20
>>> =EF=BB=BFLKDTM test visibility shouldn't change, so remove the ifdefs on=

>>> DOUBLE_FAULT and make sure test failure doesn't crash the system.
>>>=20
>>> Link: https://lore.kernel.org/lkml/20191127184837.GA35982@gmail.com
>>> Fixes: b09511c253e5 ("lkdtm: Add a DOUBLE_FAULT crash type on x86")
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>> applies on top of tip/x86/urgent
>>> ---
>>> drivers/misc/lkdtm/bugs.c  | 8 +++++---
>>> drivers/misc/lkdtm/core.c  | 4 +---
>>> drivers/misc/lkdtm/lkdtm.h | 2 --
>>> 3 files changed, 6 insertions(+), 8 deletions(-)
>>>=20
>>> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
>>> index a4fdad04809a..22f5293414cc 100644
>>> --- a/drivers/misc/lkdtm/bugs.c
>>> +++ b/drivers/misc/lkdtm/bugs.c
>>> @@ -342,9 +342,9 @@ void lkdtm_UNSET_SMEP(void)
>>> #endif
>>> }
>>>=20
>>> -#ifdef CONFIG_X86_32
>>> void lkdtm_DOUBLE_FAULT(void)
>>> {
>>> +#ifdef CONFIG_X86_32
>>>   /*
>>>    * Trigger #DF by setting the stack limit to zero.  This clobbers
>>>    * a GDT TLS slot, which is okay because the current task will die
>>> @@ -373,6 +373,8 @@ void lkdtm_DOUBLE_FAULT(void)
>>>   asm volatile ("movw %0, %%ss; addl $0, (%%esp)" ::
>>>             "r" ((unsigned short)(GDT_ENTRY_TLS_MIN << 3)));
>>>=20
>>> -    panic("tried to double fault but didn't die\n");
>>> -}
>>> +    pr_err("FAIL: tried to double fault but didn't die!\n");
>>> +#else
>>> +    pr_err("FAIL: this test is only available on 32-bit x86.\n");
>>> #endif
>>> +}
>>=20
>> I=E2=80=99m not familiar with the userspace tooling, but this seems unfor=
tunate. The first FAIL is =E2=80=9Cthe test case screwed up, and it=E2=80=99=
s a bug.=E2=80=9D  The second FAIL is =E2=80=9Cnot applicable to this system=
.=E2=80=9D
>>=20
>>=20
>> ISTM simply not exposing the test on systems that don=E2=80=99t support m=
akes sense. Can you clarify?
>=20
> I don't like the tests liked in the DIRECT file to change from build to
> build (it should be stable per kernel version). Userspace needs to know
> how to evaluate the results of running each test, so in both cases, I
> consider it a failure: double fault didn't work or you tried to test
> double fault on an unsupported architecture. (The SMEP test works
> similarly.)
>=20


So how is the test harness supposed
to distinguish success from failure?  If it printed UNSUPPORTED instead of FA=
IL, it would make more sense to me, but I=E2=80=99m not sure why that=E2=80=99=
s better than just not exposing it at all.=
