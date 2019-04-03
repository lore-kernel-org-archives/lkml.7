Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4E8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A012146E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ZZ0PzCyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDCAgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:36:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46175 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfDCAgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 20:36:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so7362928pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 17:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=P5RCofpKTbZe811SjxGOceeye0qtXlbAtAKSO6vqGsk=;
        b=ZZ0PzCyAYDEnyq9DlIJK4fTMnYALSzTI2Yah1SubjLG/g5tJT/iqKYKQwdK/lTklYb
         smmU6AcmCjnI5xWbzk6Kj0enubmg0Qr2VJTw+EK2AEGhrsynqLZCYTw0E5iWjwedPmAa
         5pmpWxtkff2Qq7C03wEeXdhkwxI/7G9i3k5CduoNU+OzDyh5pZ/h+ZOsvWqcXDAe9Sim
         2xthjHind1t94mPrFO1Zcp6zVnRqzscdtkGCEdw5ApucWt6Z54yW05u3rbxg64V6sieh
         VYXXmIIV14Cun+t+1J2nB2vEGNU6YWl5W6mC8Y2Yif7HmJgdDli9qul9C0YKmcGl25c8
         Ve+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=P5RCofpKTbZe811SjxGOceeye0qtXlbAtAKSO6vqGsk=;
        b=iDn9+Id7Y0CvqA2ceDtZIkUkRzD3KrHjwjbMXXGvce0ZbMrNztlh2EM37qa1TtG9Zv
         i33QKt6Sja33dOpd+YMcg5SH9R28EIF/q8zUb6JLhLoTJJ/Qay+T9d96NklFmIpY3++R
         ql9/MAdWOugX+EmAS03cL3uqvP2sED7e52ZwvK1Pc32oU5hk1qC+x53agm4bmlYsNdQg
         GEtiDnGFfc2ZzfDXN5kS0wFV2IfrEDo2V7XOcNFRWm6c8RDjTITdn1iI38TqQR8tu6bx
         ThbfN+VoFs1QXVk+kFjUExknDZy1Tsth7IU8pTQK1sDqGzKo14XQQ79Kb75zVA8p4jWR
         lSfQ==
X-Gm-Message-State: APjAAAXoBKHwS/56Fj5n+FcjniZyjctcn9dMcQBjZUMfsyfVx5fn7SUs
        WzSUnGsj3wFtIXU0iBZOUIg/+g==
X-Google-Smtp-Source: APXvYqzhHz2nvMb/c3yaux0Bgy5oCYFsW5t2RYO8uyVzYP+IGy4enftpVeW4wv7sr0SIOlhPX33IfQ==
X-Received: by 2002:a65:524a:: with SMTP id q10mr57254374pgp.224.1554251764012;
        Tue, 02 Apr 2019 17:36:04 -0700 (PDT)
Received: from [10.250.82.145] (226.sub-97-41-161.myvzw.com. [97.41.161.226])
        by smtp.gmail.com with ESMTPSA id v188sm25859333pgb.7.2019.04.02.17.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 17:36:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 15/14] x86/dumpstack/64: Speedup in_exception_stack()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <alpine.DEB.2.21.1904022127210.1812@nanos.tec.linutronix.de>
Date:   Tue, 2 Apr 2019 18:36:00 -0600
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6205D576-694A-4C7D-B1B7-A9FF2E1F9E77@amacapital.net>
References: <20190331214020.836098943@linutronix.de> <20190331215136.039902969@linutronix.de> <alpine.DEB.2.21.1904021214340.1676@nanos.tec.linutronix.de> <20190402154329.scp7i7uqevubgwrz@treble> <alpine.DEB.2.21.1904021746080.1676@nanos.tec.linutronix.de> <7789E14E-C623-4DB7-B076-76B931957C9C@amacapital.net> <alpine.DEB.2.21.1904022027170.1812@nanos.tec.linutronix.de> <alpine.DEB.2.21.1904022127210.1812@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 2, 2019, at 1:29 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Tue, 2 Apr 2019, Thomas Gleixner wrote:
>> On Tue, 2 Apr 2019, Andy Lutomirski wrote:
>>>> On Apr 2, 2019, at 9:48 AM, Thomas Gleixner <tglx@linutronix.de> wrote:=

>>>>=20
>>>>>> On Tue, 2 Apr 2019, Josh Poimboeuf wrote:
>>>>>> On Tue, Apr 02, 2019 at 12:19:46PM +0200, Thomas Gleixner wrote:
>>>>>> +/*
>>>>>> + * Array of exception stack page descriptors. If the stack is larger=
 than
>>>>>> + * PAGE_SIZE, all pages covering a particular stack will have the sa=
me
>>>>>> + * info.
>>>>>> + */
>>>>>> +static const struct estack_pages estack_pages[ESTACK_PAGES] ____cach=
eline_aligned =3D {
>>>>>> +    [CONDRANGE(DF)]        =3D ESTACK_PAGE(DOUBLEFAULT_IST, DF),
>>>>>> +    [CONDRANGE(NMI)]    =3D ESTACK_PAGE(NMI_IST, NMI),
>>>>>> +    [PAGERANGE(DB)]        =3D ESTACK_PAGE(DEBUG_IST, DB),
>>>>>> +    [CONDRANGE(MCE)]    =3D ESTACK_PAGE(MCE_IST, MCE),
>>>>>=20
>>>>> It would be nice if the *_IST macro naming aligned with the struct
>>>>> cea_exception_stacks field naming.  Then you could just do, e.g.
>>>>> ESTACKPAGE(DF).
>>>>=20
>>>> Yes, lemme fix that up.
>>>>=20
>>>>> Also it's a bit unfortunate that some of the stack size knowledge is
>>>>> hard-coded here, i.e #DB always being > 1 page and non-#DB being
>>>>> sometimes 1 page.
>>>>=20
>>>> The problem is that there is no way to make this macro maze conditional=
 on
>>>> sizeof(). But my macro foo is rusty.
>>>=20
>>> How about a much better fix: make the DB stack be the same size as all
>>> the others and just have 4 of them (DB0, DB1, DB2, and DB3.  After all,
>>> overflowing from one debug stack into another is just as much of a bug a=
s
>>> overflowing into a different IST stack.
>>=20
>> That makes sense.
>=20
> Except that we just have two not four.
>=20
> It needs some tweaking of the ist_shift stuff in entry_64.S but that's not=

> rocket science. Famous last words....
>=20

The ist_shift mess should probably be in C, but that=E2=80=99s a big can of w=
orms. That being said, why do we have it at all?  Once upon a time, we=E2=80=
=99d do ICEBP from user mode (or a legit breakpoint), then send a signal and=
 hit a data breakpoint, and we=E2=80=99d recurse.  But we don=E2=80=99t run u=
ser debug handlers on the IST stack at all anymore.

Maybe we can convince ourselves it=E2=80=99s safe?

What we should do is check, on IST return, that we=E2=80=99re not about to r=
eturn to our own stack.  Then we can at least properly panic.=
