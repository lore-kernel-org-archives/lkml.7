Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAD5C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 03:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2181821019
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 03:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="HwGl7KFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfKIDc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 22:32:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35807 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfKIDc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 22:32:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id d13so6442638pfq.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 19:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=XQW1IHBNj4tNG/wRhiKP3qyZodk8NXBhaLvOY9h4KzU=;
        b=HwGl7KFafVhJTLrWRA9dXDsdxM6Vtjbvti/IatAjqLKtFtYOAIwejf6Wev5TrdLfV8
         ikhHzMzlYWG1zxAR/nKZ/HuuGWLhBCpOTKKeQlSbE7IgkWS7U4oQWsNfB6QaufLEJojp
         mwzk4zQ8eH3JL9WBEKtQzm2jFwzfZ27oru9A4mydWdtSSaHp86nNHbUSsXOjTy2G4wxb
         Ha2PN3fIxdw3XPsIS1HCPtTkuaKEvvOoVLcfqLr5c62bHpOSmWYlvUpGFK5R6gxmqBFV
         K1NKW4K79ibsOJa1f1I+TD2kTovXYEL5aYboEza9Q58EPyZfkj5kb5Mf73CVEFyYZBFn
         GT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=XQW1IHBNj4tNG/wRhiKP3qyZodk8NXBhaLvOY9h4KzU=;
        b=Xn00es099EiagBggckdEaEGNagSpA1HB3C9ZUYdU02R0oXysjkksOz9xN5BjwxtuZp
         IE8L8d4KoAGLe0n9s0e4sOoyaRWWxxj0Lvz4ZU4xudr0OwbsHznVA/iiBMTvY9Qawbt5
         LpWqc23eahrcCfYY0WBNtYd4k0ZhpBeKi8Slo4cK7NB3bkS+ZZsn5rBCUPTdYpxh0+Me
         ZjuZuVUGcw8dV5TrGFSakRAHfou5X7kWjkHSfZV98hGE6/xKrFxEMo95966hhi1q+ATe
         9aQFHcHcP+AgLlngqCM/zuLolKFYSNq6rfM3rgpF4UwAhNnDjL8Di/OLwQuYhDJX5sQ3
         wlRA==
X-Gm-Message-State: APjAAAXUHRC1hSLWRQS8sZ7rJ467Y+Bl2KaDaFZ9E/enHc8s45bJFGdu
        77msnwwfWknEkiqI827bZUUaBw==
X-Google-Smtp-Source: APXvYqwQuTnZpRjQGcJgdQwhk/CuZeo1BLt79gVZdXqduXYr62hvdFShMJfsPLcdINLtUfFBIQeGRg==
X-Received: by 2002:a63:de08:: with SMTP id f8mr15859696pgg.107.1573270377692;
        Fri, 08 Nov 2019 19:32:57 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:34eb:b0f2:33fb:284c? ([2601:646:c200:1ef2:34eb:b0f2:33fb:284c])
        by smtp.gmail.com with ESMTPSA id j23sm6983176pfe.95.2019.11.08.19.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 19:32:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 4/9] x86/io: Speedup schedule out of I/O bitmap user
Date:   Fri, 8 Nov 2019 19:32:55 -0800
Message-Id: <53B49BD3-6F9C-4A78-B203-1BD53034014D@amacapital.net>
References: <alpine.DEB.2.21.1911090043430.2605@nanos.tec.linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <JGross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <alpine.DEB.2.21.1911090043430.2605@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 8, 2019, at 3:45 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFOn Fri, 8 Nov 2019, Andy Lutomirski wrote:
>>> On 11/7/19 6:08 AM, Thomas Gleixner wrote:
>>> On Thu, 7 Nov 2019, Thomas Gleixner wrote:
>>>> Just that I can't add the storage to tss_struct due to the VMX insanity=
 of
>>>> setting TSS limit hard to 0x67 on vmexit instead of restoring the host
>>>> value.
>>>=20
>>> Well, I can. The build bugon in vmx.c is just bogus.
>>=20
>> SDM vol 3 27.5.2 says the BUILD_BUG_ON is right.  Or am I
>> misunderstanding you?
>>=20
>> I'm reasonably confident that the TSS limit is indeed 0x67 after VM
>> exit, and I wrote the existing code that tries to optimize this to avoid
>> LTR when not needed.
>=20
> The BUILD_BUG_ON(IO_BITMAP_OFFSET - 1 =3D=3D 0x67) in the VMX code is bogu=
s in
> two aspects:
>=20
> 1) This wants to be in generic x86 code

I think disagree. The only thing special about 0x67 is that VMX hard codes i=
t. It=E2=80=99s specifically a VMX-ism. So I think the VMX code should indee=
d assert that 0x67 is a safe value.

>=20
> 2) The IO_BITMAP_OFFSET is not the right thing to check because it makes
>   asssumptions about the layout of tss_struct. Nothing requires that the
>   I/O bitmap is placed right after x86_tss, which is the hardware mandated=

>   tss structure. It pointlessly makes restrictions on the struct
>   tss_struct layout.

I agree with this.

>=20
> The proper thing to check is:
>=20
>    - Offset of x86_tss in tss_struct is 0
>    - Size of x86_tss =3D=3D 0x68
>=20
> We already have the page alignment sanity check off TSS in
> cpu_entry_area.c. That's where this should have gone into in the first
> place.

>=20
> Thanks,
>=20
>    tglx
