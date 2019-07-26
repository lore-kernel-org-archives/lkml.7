Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79448C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DFF217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="YnIQx4Bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbfGZVbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:31:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44228 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387515AbfGZVbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:31:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so6581813otl.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 14:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=Jfd4mpE87lptWZqiCfBhaLZUZjR4MuZc1S8+FaCFHwg=;
        b=YnIQx4BnH07uyAmyxAoCIvR48D36Um9TBtzlvXVfr300qctKk1hGfBIOG+Wa6+mAk4
         sDmR4ApgQcjUsDHzqWukknQbr5+VRHr8immO1DlZizwmpELIiY7x80YL4CtIdDOjhIX/
         4lJGEgLcnz8Flz8iKpCcs315MQpw6dU8YlgbeDkbf/wXw/OH9cHzMSzp7xEqdJjpnKM2
         EG9mc5T1/nLQSt9d1jpbdbiHieg4x7Kt5oVZ4Ux6DSHOKJHUzX+aagY8AI7Mk8XMZos7
         ZuSCFeN+hoAUEc6I0LonwQ2+S/aFaz6AwUFcSKlHCRoPh/kx0CY0IwdkFABBH4m1YAnu
         F6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Jfd4mpE87lptWZqiCfBhaLZUZjR4MuZc1S8+FaCFHwg=;
        b=RaxG/IF253Rmjcp7ZQDM0U223d/TYrRRKpTnhOLsFw/NM/eAG7i7EGuH/2nvFqEs3c
         plXntPLkTLUYdBxBmJ6Os3m7f0uKh4KAKMlL1RtMCVv3OP9+xFGyENhiZ7/nZij6QtN6
         Nr0HRr5uBrdAvaI9g3F+2hoHpEVwJR3zkt77n1SyklslovxBPrjRsMCqAW+vNo77GDEF
         PmKcjoeRDABDYne1/jaz4oAqkzDPA53Py7qgUmLswo2H4ksLoxuvCdf7n4XJ/G2PHbc2
         pQudBo01lzDFiyMTKWwqvHg24QX0f/CBEcsE94H8/6Se/Qep9ge/Sc2z1YyZZhdWavI/
         sv4A==
X-Gm-Message-State: APjAAAXOQlbDK9/yFkayUerDZGAsLioCFnxmope8MAPqGKaX1OwCageU
        GMTHYUW58sF6YfuL7riuhwo=
X-Google-Smtp-Source: APXvYqwMnRPP3U+3zAp80Qn84RIfFfCdghblszx8MmNF3wxHudRez2+JOjXqsjAZQl8lsWgmSe0+Eg==
X-Received: by 2002:a9d:48f:: with SMTP id 15mr39510012otm.160.1564176662636;
        Fri, 26 Jul 2019 14:31:02 -0700 (PDT)
Received: from [26.83.97.235] ([172.56.7.186])
        by smtp.gmail.com with ESMTPSA id x193sm17872767oix.15.2019.07.26.14.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 14:31:01 -0700 (PDT)
Date:   Fri, 26 Jul 2019 23:30:52 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wibXtQ9pjB9ctpy5jWJK93DL19Lj09Et6cYEQE+h7tPpg@mail.gmail.com>
References: <20190726093934.13557-1-christian@brauner.io> <20190726093934.13557-2-christian@brauner.io> <CAHk-=wibXtQ9pjB9ctpy5jWJK93DL19Lj09Et6cYEQE+h7tPpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/2] pidfd: add P_PIDFD to waitid()
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <8A437322-D16E-4D5F-ACFA-3B1DEAAC100A@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 26, 2019 11:26:45 PM GMT+02:00, Linus Torvalds <torvalds@linux-foun=
dation=2Eorg> wrote:
>On Fri, Jul 26, 2019 at 2:41 AM Christian Brauner
><christian@brauner=2Eio> wrote:
>>
>> -       if (type < PIDTYPE_MAX)
>> +       if (type < PIDTYPE_MAX && !pid)
>>                 pid =3D find_get_pid(upid);
>
>So now we have four cases in the switch statement, and two of them do
>*not* want that "find_get_pid()" call=2E
>
>Honestly, let's just move that whole thing into the switch statement
>for the two cases that do want it=2E Particulartly since I think the
>"upid =3D=3D 0" case for P_PGID will prefer it that way anyway=2E
>
>Let's not check 'type' in two different places in two completely
>different ways=2E
>
>Ok?
>
>             Linus

Ok, will resend with that changed=2E

Christian
