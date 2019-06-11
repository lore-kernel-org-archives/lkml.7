Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C4DC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDDD212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="JGwtO/95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405466AbfFKPy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:54:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41805 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405288AbfFKPy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:54:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so7194793pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7/rmAfXxEXpI5+u46SKl/lb2QdtqgSoIemXYjsm6rRY=;
        b=JGwtO/95pxnGWI13wUGtJYUXwsq99nkWvZn4XWPr+MaqxfH1xHPo/VwZvWMN644TcH
         +P5GD4btmaNaoXiIhW+LcGIMP2yMyFQY5N4lT3e1FgXZu8rIZjsY6mhGSWUNdbqw9ztd
         uMcEjYp/irLDTWtKGany7LzkGLEaxAWAgiXJxXnaUB1YGkZb8d4mUl4q1MrmQndmXEna
         9ADMcrNCBMa0lBl8T2Rpy8/atRRgd9ENS/IOVc6pMPzKbsk7y9sVZG3ZbwZFWuYv5OQf
         iYvommQbA7hy8kyvAlmoGBAMss/afzpKtaYmkDFaprYBkDgCQtDPwRCK0dLjeML3rBpv
         caRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7/rmAfXxEXpI5+u46SKl/lb2QdtqgSoIemXYjsm6rRY=;
        b=JgANwJZuoc6u5erILKpPt85sgyJu34tG/pIBlK/VkCdi4APDiBI/plBXDIrmwppQlt
         09soOfnfnrDQAWwamYVQ06W3S05INO4hKCIPT0MrmW3smcwGD4MxU3A/da5UohvTocgS
         F4XdsWe8tuCeFg2lMFY86Ti277vHfCXW5XUEQeDCu+LWLcfwzc8ZtYyt/l1pURUZ+BQ8
         8Z6bEJQIAp8oq+MqVnVPFwaSWcSqsJWH+FbdaJqwOuALIPLvAWwi0K2p38AgQu452EQt
         yHK5I5ffr27w4dRhcCge0D+/PMMO6pzn2IRQi5Si95ijk47kKu30N2CvxMqgHUdJAQbR
         n9rw==
X-Gm-Message-State: APjAAAU6rnBxgXHB35Lu9osnaZzylJv4obvLHq16fMqVjWkJ9LAKkso6
        wiS2C9pG5Txa60RxzzQ5tDjhY+6LIGU=
X-Google-Smtp-Source: APXvYqwmmEdW3dgKhypcu5q2FRXgvjN6eYK6yZrh4hwkGKY4tVK1A9+e9JQCiuTwWNW2qpqH9NzwmQ==
X-Received: by 2002:a65:63d2:: with SMTP id n18mr9739049pgv.278.1560268466060;
        Tue, 11 Jun 2019 08:54:26 -0700 (PDT)
Received: from ?IPv6:2600:1010:b062:7159:60af:2fa5:3435:5195? ([2600:1010:b062:7159:60af:2fa5:3435:5195])
        by smtp.gmail.com with ESMTPSA id g17sm17964676pfb.56.2019.06.11.08.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:54:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate instructions
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <20190611080307.GN3436@hirez.programming.kicks-ass.net>
Date:   Tue, 11 Jun 2019 08:54:23 -0700
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <435093E5-6FE3-4DAA-9ABE-EB9D372F8CF8@amacapital.net>
References: <20190605130753.327195108@infradead.org> <20190605131945.005681046@infradead.org> <20190608004708.7646b287151cf613838ce05f@kernel.org> <20190607173427.GK3436@hirez.programming.kicks-ass.net> <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net> <20190611080307.GN3436@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 11, 2019, at 1:03 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Fri, Jun 07, 2019 at 11:10:19AM -0700, Andy Lutomirski wrote:
>>=20
>>=20
>>> On Jun 7, 2019, at 10:34 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>>>=20
>>> On Sat, Jun 08, 2019 at 12:47:08AM +0900, Masami Hiramatsu wrote:
>>>=20
>>>>> This fits almost all text_poke_bp() users, except
>>>>> arch_unoptimize_kprobe() which restores random text, and for that site=

>>>>> we have to build an explicit emulate instruction.
>>>>=20
>>>> Hm, actually it doesn't restores randome text, since the first byte
>>>> must always be int3. As the function name means, it just unoptimizes
>>>> (jump based optprobe -> int3 based kprobe).
>>>> Anyway, that is not an issue. With this patch, optprobe must still work=
.
>>>=20
>>> I thought it basically restored 5 bytes of original text (with no
>>> guarantee it is a single instruction, or even a complete instruction),
>>> with the first byte replaced with INT3.
>>>=20
>>=20
>> I am surely missing some kprobe context, but is it really safe to use
>> this mechanism to replace more than one instruction?
>=20
> I'm not entirely up-to-scratch here, so Masami, please correct me if I'm
> wrong.
>=20
> So what happens is that arch_prepare_optimized_kprobe() <-
> copy_optimized_instructions() copies however much of the instruction
> stream is required such that we can overwrite the instruction at @addr
> with a 5 byte jump.
>=20
> arch_optimize_kprobe() then does the text_poke_bp() that replaces the
> instruction @addr with int3, copies the rel jump address and overwrites
> the int3 with jmp.
>=20
> And I'm thinking the problem is with something like:
>=20
> @addr: nop nop nop nop nop
>=20
> We copy out the nops into the trampoline, overwrite the first nop with
> an INT3, overwrite the remaining nops with the rel addr, but oops,
> another CPU can still be executing one of those NOPs, right?
>=20
> I'm thinking we could fix this by first writing INT3 into all relevant
> instructions, which is going to be messy, given the current code base.

How does that help?  If RIP =3D=3D x+2 and you want to put a 5-byte jump at a=
ddress x, no amount of 0xcc is going to change the fact that RIP is in the m=
iddle of the jump.

Live patching can handle this by detecting this condition on each CPU, but p=
erformance won=E2=80=99t be great.  Maybe some synchronize_sched trickery co=
uld help.=
