Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB48DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCF72133F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="o9tVnigb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfHXAN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 20:13:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40109 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHXAN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 20:13:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id h3so6470840pls.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 17:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VWU0ylJDr+29uUzAcujtRyKx7Kjb8w7X0k3narASjMo=;
        b=o9tVnigbLk97XJLHLQcayUDShA0hBJ1b1BjdETiro3WRqrfhLDmAdbAiVJI/8dm1z8
         JcmZdMNcekRPghSCDOh53hvRmubAUsRLnFREuLxy3fI00GkivqPZOfZkeZOdT0wNZ7Mq
         DnKBgA4u8+RQPcR2ykru6JQT2iD8cTLUZQ1nX0dp7oEatjC9q3jO6SW8it5oZLNmiPFj
         jn2QtzvellHHIC0vCtVvjN/gfd5y1N2CQBwwqNNhNrehI5nc/jP5THEBYoZGws9a9Bl9
         YsDQvthBeYpWUQHWq1R1CY0U1UJwV5Op0xQui+wUl+CpT5Tl7sI0zIgwa2p7ffPCA9T0
         AxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VWU0ylJDr+29uUzAcujtRyKx7Kjb8w7X0k3narASjMo=;
        b=DBMlv4o3YNa/f/bjo2ET/mlpKN3VTgS+oI9Rr7dUcGR9GJS+ywkDLDBVubIQasK9NV
         mu3OZoIscf90s3P/QSsepb2ZzM8vf7kmaG8XYtv6zz9HiwabtusltHEobjHWHVaci5uo
         I9HDJGTNM4M/zXTHgmGO/pGRuPtM+MbjsWxqtBBCb/RjSToCm/xPCBs5u7RMFrPAIwfw
         rOOIyiCuWUtZJuxKZYzoxOAGYiY7jUW0ef9Vk0cuszyfC1QK1I5lnwq9tU753mnCawvf
         EXylcIh6U7vMx5fVWNa7xdrOV/mkws3nsN/wSw8HAov5YQawHdeyjyP9/CG9NukW2nZt
         zX8g==
X-Gm-Message-State: APjAAAVpQbcpjoW817/6t9gU34uvCU5tX9fQ5MJRlEh+8loZpq7I5wuh
        LOFWWllRvZkAAAOXKYC5p0Pucg==
X-Google-Smtp-Source: APXvYqylt1JmVu2zwoEbBmrL04QluCRrjPD/N5apaiZ0sqUPzNyZWsOivzlBZpGXGJdL1AjSaetnZQ==
X-Received: by 2002:a17:902:9b90:: with SMTP id y16mr7523314plp.17.1566605607633;
        Fri, 23 Aug 2019 17:13:27 -0700 (PDT)
Received: from ?IPv6:2600:1012:b064:e620:ac21:e025:1693:952e? ([2600:1012:b064:e620:ac21:e025:1693:952e])
        by smtp.gmail.com with ESMTPSA id a10sm4952222pfl.159.2019.08.23.17.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 17:13:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] uprobes/x86: fix detection of 32-bit user mode
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G77)
In-Reply-To: <alpine.DEB.2.21.1908240202220.1939@nanos.tec.linutronix.de>
Date:   Fri, 23 Aug 2019 17:13:25 -0700
Cc:     Sebastian Mayr <me@sam.st>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE4AECCC-AFBE-4DA7-A229-B6B870E06B1D@amacapital.net>
References: <20190728152617.7308-1-me@sam.st> <alpine.DEB.2.21.1908232343470.1939@nanos.tec.linutronix.de> <alpine.DEB.2.21.1908240142000.1939@nanos.tec.linutronix.de> <32D5D6B1-B29E-426E-90B6-48565A3B8F3B@amacapital.net> <alpine.DEB.2.21.1908240200070.1939@nanos.tec.linutronix.de> <alpine.DEB.2.21.1908240202220.1939@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 23, 2019, at 5:03 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Sat, 24 Aug 2019, Thomas Gleixner wrote:
>> On Fri, 23 Aug 2019, Andy Lutomirski wrote:
>>>> On Aug 23, 2019, at 4:44 PM, Thomas Gleixner <tglx@linutronix.de> wrote=
:
>>>>=20
>>>>>> On Sat, 24 Aug 2019, Thomas Gleixner wrote:
>>>>>> On Sun, 28 Jul 2019, Sebastian Mayr wrote:
>>>>>>=20
>>>>>> -static inline int sizeof_long(void)
>>>>>> +static inline int sizeof_long(struct pt_regs *regs)
>>>>>> {
>>>>>> -    return in_ia32_syscall() ? 4 : 8;
>>>>>=20
>>>>> This wants a comment.
>>>>>=20
>>>>>> +    return user_64bit_mode(regs) ? 8 : 4;
>>>>=20
>>>> The more simpler one liner is to check
>>>>=20
>>>>   test_thread_flag(TIF_IA32)
>>>=20
>>> I still want to finish killing TIF_IA32 some day.  Let=E2=80=99s please n=
ot add new users.
>>=20
>> Well, yes and no. This needs to be backported ....
>=20
> And TBH the magic in user_64bit_mode() is not pretty either.
>=20
>=20

It=E2=80=99s only magic on Xen. I should probably stick a cpu_feature_enable=
d(X86_FEATURE_XENPV) in there instead.=
