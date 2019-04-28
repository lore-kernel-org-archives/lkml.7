Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E934C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84962067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="UZWXkJs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfD1SIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:08:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37993 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1SIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 14:08:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so4000408plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FYD656bv9iAQBWULjvE+VvlBMmnQrd2nUgj+MzkTcdI=;
        b=UZWXkJs88BO0LKLomMd82kO6ETPL7CwePZN7DGDD2kgmaUnG8kA29ccqjcUqDugbU6
         6SF3vWvMZtdaYfBWEvlRAw+RJ3ORwiu19tv/cWhjDGx8OVarl5Qq5+PpeqBUvY/JYfIX
         yFd+Qjpcl43xjMKiuhnB5AfM6X+ojHLv2sMRmY4Df4jg/IlwrUVlescOfiCZKlEnG7z0
         15iItOHIQJz1IAQUoh254FVMqyGPoeGSAcXu/3AqjEAyWJBKTOhamyf4weuq1o9Yw34E
         8RAbcVrUS+VtHDxsbYOvsrWMwyfj3AAIwJyo2kP4kSkkjvWkF4A//ydnQB7ATrtWAARP
         CtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FYD656bv9iAQBWULjvE+VvlBMmnQrd2nUgj+MzkTcdI=;
        b=ExHlkBixpsu6vSf8s7HravuanXgcIK4IygoV77JdG5lHLp3SwDoFskzQyRRgTEsnzf
         H8MXadx4CFtKRZEyR2GRQz0J964pGyfXekH+kijI/eRZD0kb2ZrkQG4kaokgP0O494Pn
         jm6i7pTCO5xbCQikmEayuDwS4OFDYYpPmv1FTs4eJI6MQXGcwyaU50eFxFnrEPTogTb3
         mp+uz5eXMQF4w8L/9tnBJ9/sXl844ecYTQVdjKi58H0XflwB/OUT6kMWvmFiKmiEaOg2
         UZqVjQDJvJHQYYDzfpS7CoW0Vz31cGH4lH0/wqT9MpoCz3UjSQkYdmT/csQjKFgzgnz9
         y82Q==
X-Gm-Message-State: APjAAAWmWoTmgzm35GP7UpShgIbboWZTwIRUnuumB3hnyWNRp9onm1kI
        xLp8CzAlPo7XtNKQ7Wjjafg06Q==
X-Google-Smtp-Source: APXvYqwYQeIaIg6KNVUwn54cCp8B2EERyUt9EyQPUbmZhiX4UvVbrDNcytCMtd1zL/vmJ7rp3A7dhA==
X-Received: by 2002:a17:902:b181:: with SMTP id s1mr35385995plr.9.1556474916540;
        Sun, 28 Apr 2019 11:08:36 -0700 (PDT)
Received: from ?IPv6:2600:1010:b144:c2ea:2812:6533:d7:28e? ([2600:1010:b144:c2ea:2812:6533:d7:28e])
        by smtp.gmail.com with ESMTPSA id b13sm42408198pfd.12.2019.04.28.11.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 11:08:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/4] x86/thread_info: introduce ->ftrace_int3_stack member
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190428135143.09d35bb6@oasis.local.home>
Date:   Sun, 28 Apr 2019 11:08:34 -0700
Cc:     Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D5735AF7-D603-4B20-A3EE-B519044D1E5D@amacapital.net>
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-2-nstange@suse.de> <F6268634-96D3-4267-B739-6D375FAB26A8@amacapital.net> <20190428135143.09d35bb6@oasis.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 28, 2019, at 10:51 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Sun, 28 Apr 2019 10:41:10 -0700
> Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>=20
>>> Note that at any given point
>>> in time, there can be at most four such call insn emulations pending:
>>> namely at most one per "process", "irq", "softirq" and "nmi" context.
>>>=20
>>=20
>> That=E2=80=99s quite an assumption. I think your list should also contain=

>> exception, exceptions nested inside that exception, and machine
>> check, at the very least.  I=E2=80=99m also wondering why irq and softirq=
 are
>> treated separately.
>=20
> 4 has usually been the context count we choose. But I guess in theory,
> if we get exceptions then I could potentially be more.
>=20
> As for irq vs softirq, an interrupt can preempt a softirq. Interrupts
> are enabled while softirqs are running. When sofirqs run, softirqs are
> disabled to prevent nested softirqs. But interrupts are enabled again,
> and another interrupt may come in while a softirq is executing.
>=20
>>=20
>> All this makes me think that one of the other solutions we came up
>> with last time we discussed this might be better.
>=20
> +100
>=20
> Perhaps adding another slot into pt_regs that gets used by int3 to
> store a slot to emulate a call on return?
>=20
>=20

That=E2=80=99s not totally nuts, although finding pt_regs isn=E2=80=99t enti=
rely trivial.

I still think I prefer an approach where we just emulate the call directly.=
