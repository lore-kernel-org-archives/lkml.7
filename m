Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75461C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458BC2158A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="LTNVu137"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfK2SUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 13:20:03 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39756 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfK2SUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 13:20:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so4309981oty.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 10:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=urZfuzsCbzoczupKQe+p+P3/97PDZQ+qT28ZuADLov8=;
        b=LTNVu1373ngJ+alF4Bv5H5tJCyLBv1vtDp5N8j58OukvwSImXQypoNFj4NxCRjgP2A
         m2jy9yqyEYh89uldLvLptppmClOQ0n6Uz0TEG1Wq2gEMmqdhcR4Ob146N7Q30m2BdFa9
         wqDpWAcBJkX/g9Ad1hhw2nYOyEUYXfyMagSikKjIbmdfoMo2zQ+P2n2Zb7FRAe2qfFJb
         EDU/XXZflZcb5XEOeXbVicR4wq/qoI+eMeL93b73wiBdlVqUGo4mn/XQ92oS6u3CRfoy
         ymh46fk8Gkk/XuTcyT/ersdbKgP34RoJHAfIl1IwoxtFGGjj+gfILywqPMtQ0QXYAbPL
         RMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=urZfuzsCbzoczupKQe+p+P3/97PDZQ+qT28ZuADLov8=;
        b=DmS8Newb4YVAvZzcy9iD7AkH066xQWjNV2huBfznajPunZfykbjuKyrvqn++oUgo2h
         iAiWsaOU9HjOJgyJItUYUZ8LI/vTPpweOF9kspB9uRgB/C1fgdIySImqg1ogY9pzlgH7
         lJsIRhrh4zIOHS6zBPtYIB/5j71fNLUgsqt1kvGWBU8i2KLs6lXzPtwcGM+xYoGO3KQ1
         aerGl8vOHxQPuY4tyJTA6qyGzB4lFlRIp+ZAEhvktkv+vXBjZP6c8W3zDFvMIngwpJA+
         T8Rl2eQKtGKpagoOHUtYJ6Lo2ZSKeqgxXnLjxR6axNW5MhKrAFqCmtYmO5101h2u3c3s
         p2RA==
X-Gm-Message-State: APjAAAVRA3y4fLiTSyRI+4mIF3KgITlXXWqp+UIp9HF04fSi27SCWyYm
        w1tSrOKGTQzwjUZxIQK5EMzdVg==
X-Google-Smtp-Source: APXvYqwOjKk2bD4Oy/MikCZ0/keVW04owHgDCN4GtvjWMzR5gf7oK1DVmrF8aQ8xVeRzJqbunkGhLg==
X-Received: by 2002:a05:6830:1e7c:: with SMTP id m28mr3274846otr.131.1575051601917;
        Fri, 29 Nov 2019 10:20:01 -0800 (PST)
Received: from ?IPv6:2600:1702:1be0:ec0:d960:3a5:a5de:158a? ([2600:1702:1be0:ec0:d960:3a5:a5de:158a])
        by smtp.gmail.com with ESMTPSA id l73sm3963160oib.0.2019.11.29.10.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 10:20:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] ptrace/x86: introduce TS_COMPAT_RESTART to fix get_nr_restart_syscall()
Date:   Fri, 29 Nov 2019 10:19:59 -0800
Message-Id: <CBC57AB1-D92D-44B1-9428-B84B17429C8F@amacapital.net>
References: <20191129173213.GB3992@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
In-Reply-To: <20191129173213.GB3992@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 29, 2019, at 9:32 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> =EF=BB=BFOn 11/28, Andy Lutomirski wrote:
>>=20
>> I think this doesn=E2=80=99t work for x32.
>=20
> Why? get_nr_restart_syscall() can still rely on the "orig_ax & __X32_SYSCA=
LL_BIT"
> check, debugger should restore regs->orig_ax correctly.

Right. Although relying on this is IMO a ridiculous bit of ABI.

>=20
>> Let=E2=80=99s either save the result of syscall_get_arch()
>=20
> We can save the result of syscall_get_arch(), but it doesn't distinguish
> x32/x86_64 tasks, so it doesn't really differ from TS_COMPAT.

Duh. Never mind.

>=20
>> or just actually calculate and save the restart_syscall nr here.
>=20
> sure, we we can do this.

I like this the best unless we can renumber the syscalls.

>=20
>> Before we commit to this, Kees, do you think we can manage to just renumb=
er
>> restart_syscall()?  That=E2=80=99s a much better solution if we can pull i=
t off.
>=20
> Agreed.
>=20
> Oleg.
>=20
