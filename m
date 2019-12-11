Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146A7C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E087E20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="PbO4pb1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbfLKRWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:22:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42648 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbfLKRWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:22:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so4352529pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 09:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=spw+W66PwysKgYjLUTMzmWWpPtpOjK/KGVzC9TUKzdw=;
        b=PbO4pb1guyauqOSSQFQWZ3G12I2ugsUQjrHJOjpkw+PWbC0W7o9eoK0OzI4kIn1ycF
         dVTtKgqJ9CCSEKlC3Bwn/EriDTtXP75qP6H5kC+8n6Bl7GYGeHgM9dXg4BTsHGwamkD3
         Tcw8KvbxM8vXCrGpxPRpHXDXc/tXK7U7kg6eHZi5onuQPxHztHAd6y+1VWF3hDgosxxp
         9gicct8DNIqiNU912wmZ6OKkukyg14AgshMRuPt6uaXGGJeKq3SNgz/xN20vkeK3ptYk
         HOoAWOc29MRzEyBe+t6K3BABQy6b3PBVCXiHm8lNpjFsU3CwhGwZzKDJP1/M98qn8ADL
         Gfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=spw+W66PwysKgYjLUTMzmWWpPtpOjK/KGVzC9TUKzdw=;
        b=J8CbmtABIcUffur9WUqxz+FPPB+NBTZiGoVej9qLmA+wCNkco2YUvAoWOrP6ce0HXg
         vGX9TlY05rw5sOSAmKcH+5xsadVj/K5gVVqh1esmAi9b1aa80jeKTo3ZhdBgwTrOldvT
         9V5ANpQre/oKL7pqiiqRYszUP/3yHkge1K+zoQFqkeBMNIxEnV7adI6XdcAd78SNcCiO
         0oZHGkunFoyFVNbnnvSVPjuITob1aEcbedT4T3fNFbSfvwbwKdUgnUn+JZDN2KEJnH42
         bmluErEauA4TyYwIgTqpyH+KvSG8fHFxXeFBsHLZZnavvNa94XYVvNLGMgsLsSc+YUKr
         d2Vw==
X-Gm-Message-State: APjAAAX5mAFyVSiC7qq7VJncrd99rGK3dBt8BltwaJKdYGWE2O9fjgW7
        lJhvOHde81avgV5YUEqSHL6JMg==
X-Google-Smtp-Source: APXvYqzLKkz3flFJAsLfXqLq1D/8jKbb+4Ox1/+wU2wtbh9y3mHgBV2cTIFxazZBDm0nWiQyivAj4w==
X-Received: by 2002:a05:6a00:9c:: with SMTP id c28mr4977641pfj.234.1576084952380;
        Wed, 11 Dec 2019 09:22:32 -0800 (PST)
Received: from ?IPv6:2600:1010:b005:489c:fc8f:334b:9230:8615? ([2600:1010:b005:489c:fc8f:334b:9230:8615])
        by smtp.gmail.com with ESMTPSA id y29sm3742573pfo.155.2019.12.11.09.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 09:22:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 2/4] x86/traps: Print address on #GP
Date:   Wed, 11 Dec 2019 09:22:30 -0800
Message-Id: <BC48F4AD-8330-4ED6-8BE8-254C835506A5@amacapital.net>
References: <20191211170632.GD14821@zn.tnic>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
In-Reply-To: <20191211170632.GD14821@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 11, 2019, at 9:06 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> =EF=BB=BFOn Mon, Dec 09, 2019 at 03:31:18PM +0100, Jann Horn wrote:
>>    I have already sent a patch to syzkaller that relaxes their parsing of=
 GPF
>>    messages (https://github.com/google/syzkaller/commit/432c7650) such th=
at
>>    changes like the one in this patch don't break it.
>>    That patch has already made its way into syzbot's syzkaller instances
>>    according to <https://syzkaller.appspot.com/upstream>.
>=20
> Ok, cool.
>=20
> I still think we should do the oops number marking, though, as it has
> more benefits than just syzkaller scanning for it. The first oops has alwa=
ys
> been of crucial importance so having the number in there:
>=20
> [    2.542218] [1] general protection fault while derefing a non-canonical=
 address 0xdfff000000000001: 0000 [#1] PREEMPT SMP
>        ^
>=20
> would make eyeballing oopses even easier. Basically the same reason why
> you're doing this enhancement. :)
>=20

Could we spare a few extra bytes to make this more readable?  I can never ke=
ep track of which number is the oops count, which is the cpu, and which is t=
he error code.  How about:

OOPS 1: general protection blah blah blah (CPU 0)

and put in the next couple lines =E2=80=9C#GP(0)=E2=80=9D.

> So let me know if you don't have time to do it or you don't care about
> it etc, and I'll have a look. Independent of those patches, of course -
> those look good so far.
>=20
> Thx.
>=20
> --=20
> Regards/Gruss,
>    Boris.
>=20
> https://people.kernel.org/tglx/notes-about-netiquette
