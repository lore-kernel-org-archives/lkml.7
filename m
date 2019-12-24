Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF95C2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CB52071E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="zDWD8XCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfLXMPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:15:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38239 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfLXMPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:15:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so10690372pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 04:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=cUl5gZioHf+9+6AN9dmbhGHLhNt8/shlwV1E7YstAts=;
        b=zDWD8XCA/EeC40f+rqUuDAnCbmAAgAgN8grpTLGD/hu+c6oJ0ekyx9F6083vGsPNpB
         IGrhdkZdQkxUJLQB7IC7MUBKdiAhvr42yCtnEmbLuDVhaVlWU50A+XXkfqUzCfKxLwYd
         NcWZApcamRuoTETR8c7gHOWeAVehTsmseTXj6LnGvlE98ZW3YWEywJh2onhr62RKIN/O
         QbWUv3VfPQ9hUaNXtaLLQYhY2txQ0sPDCgcRwZIrZh36FXuwhdnUh56nRBpE8VWMrHr3
         eko3/wFRsyPKl+dK9FEf1/R7qWEszOxJvMCuzKzRvNgASrlCBXtD9TcieHqLYVVfd8P7
         LnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=cUl5gZioHf+9+6AN9dmbhGHLhNt8/shlwV1E7YstAts=;
        b=CtsR2NPcrPNJe+OsdvuVZ0xJDILc8Mr4n05LqtGESX9a4FXbFcUv07Mw6bSuw+1agp
         eF7guD4edd9kxLRxtzyXNHT9NJkHQn6MxyeblVnZWnyz9lQT9KXPXcYL3GLwBhD6z06q
         0/rT4bO0gFebWR7VXRk4DdIb46ih0AlzL0bDHuhT1uaDiFeTr14/HyWwMdAGxmJbBzfj
         2YXeIqvNQSgCysupQmG8suBWwECFuK2udbH7ZWv28rnvu9V/1Ab3o8wpfBcgbHBV+whN
         5vnwogRsOeCfwC9+gOrCUcqkD25W0RURqOMpB34W+WIHt3RkoPAKRZFqYTi7aQHPYeei
         LDuQ==
X-Gm-Message-State: APjAAAWSG3FvOhy1WUBvf1Zuxj9u6dpUAxP6U823E+D3giHEkzFBBwxc
        JTNXPnHjaLZxXKFOfhN4E7tmvw==
X-Google-Smtp-Source: APXvYqxQw1UT4Rk2hWrXeLnplHcgXPOvZ2uVcW7HJIiySYb8+fVviH72PQISJdC4tjd4Z7zmNcXU4Q==
X-Received: by 2002:a62:868f:: with SMTP id x137mr34816521pfd.228.1577189713974;
        Tue, 24 Dec 2019 04:15:13 -0800 (PST)
Received: from [192.168.0.9] (111-255-104-19.dynamic-ip.hinet.net. [111.255.104.19])
        by smtp.gmail.com with ESMTPSA id j5sm11842535pfn.180.2019.12.24.04.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2019 04:15:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 04/10] lib: vdso: get pointer to vdso data from the arch
Date:   Tue, 24 Dec 2019 20:15:11 +0800
Message-Id: <D2614EC4-5B80-4846-994D-22730ACD44A1@amacapital.net>
References: <de5273aa-69dc-8e37-c917-44708257d2ba@c-s.fr>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        X86 ML <x86@kernel.org>
In-Reply-To: <de5273aa-69dc-8e37-c917-44708257d2ba@c-s.fr>
To:     christophe leroy <christophe.leroy@c-s.fr>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 24, 2019, at 7:53 PM, christophe leroy <christophe.leroy@c-s.fr> wr=
ote:
>=20
> =EF=BB=BF
>=20
>> Le 24/12/2019 =C3=A0 03:27, Andy Lutomirski a =C3=A9crit :
>>> On Mon, Dec 23, 2019 at 6:31 AM Christophe Leroy
>>> <christophe.leroy@c-s.fr> wrote:
>>>=20
>>> On powerpc, __arch_get_vdso_data() clobbers the link register,
>>> requiring the caller to set a stack frame in order to save it.
>>>=20
>>> As the parent function already has to set a stack frame and save
>>> the link register to call the C vdso function, retriving the
>>> vdso data pointer there is lighter.
>> I'm confused.  Can't you inline __arch_get_vdso_data()?  Or is the
>> issue that you can't retrieve the program counter on power without
>> clobbering the link register?
>=20
> Yes it can be inlined (I did it in V1 https://patchwork.ozlabs.org/patch/1=
180571/), but you can't do it without clobbering the link register, because t=
he only way to get the program counter is to do to as if you were calling an=
other function but you call to the address which just follows where you are,=
 so that it sets LR which the simulated return address which corresponds to t=
he address following the branch.
>=20
> static __always_inline
> const struct vdso_data *__arch_get_vdso_data(void)
> {
>    void *ptr;
>=20
>    asm volatile(
>        "    bcl    20, 31, .+4;\n"
>        "    mflr    %0;\n"
>        "    addi    %0, %0, __kernel_datapage_offset - (.-4);\n"
>        : "=3Db"(ptr) : : "lr");
>=20
>    return ptr + *(unsigned long *)ptr;
> }
>=20
>> I would imagine that this patch generates worse code on any
>> architecture with PC-relative addressing modes (which includes at
>> least x86_64, and I would guess includes most modern architectures).
>=20
> Why ? Powerpc is also using PC-relative addressing for all calls but indir=
ect calls.

I mean PC-relative access for data.  The data page is at a constant, known o=
ffset from the vDSO text.

I haven=E2=80=99t checked how much x86_64 benefits from this, but at least t=
he non-array fields ought to be accessible with a PC-relative access.

It should be possible to refactor a little bit so that the compiler can stil=
l see what=E2=80=99s going on.  Maybe your patch actually does this. I=E2=80=
=99d want to look at the assembly.  This also might not matter much on x86_6=
4 in particular, since x86_64 can convert a PC-relative address to an absolu=
te address with a single instruction with no clobbers.

Does power have PC-relative data access?  If so, I wonder if the code can be=
 arranged so that even the array accesses don=E2=80=99t require computing an=
 absolute address at any point.
