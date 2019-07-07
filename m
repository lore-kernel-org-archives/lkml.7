Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1754CC5B578
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 00:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FE820836
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 00:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="K/kNLwak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfGGAhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 20:37:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39217 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfGGAhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 20:37:01 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so11451530ioh.6
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 17:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LDlUAGaiOj2lV+d8lR6yfpV8uRP0NGntOh0DqKXbHyA=;
        b=K/kNLwakHCXe0w/uwTZ4ZweXZ4YNhSTMXJOWPibn1cM4yTSuZH6rDFPcWIFXlTfwdo
         eIpj2pyzZYoMu2Yqy8Gcgs+T5dO4lZG+qKx9WpJQsicCvpXyJpzio2VgLwyQtsMmQcU/
         OOMAm3pQTRH1aSP11JQNkVODrOuiIVx1/Ei6R0/1ynHmsmDqXJr7CLEH8QpEC1m2GeO6
         A9qOKFlg9bvCjwFaEahHJJ/wEawDrcTjwnkd1mKrNqNrgbBg/kGPLtNh31XMaPNKNcey
         qEFmxioJgRvPJnI+I9KgWGc9J2Gv9QQU8EXCyUXuZfZ+60BtIwPzANfY1rHF39Xt1i4P
         7ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LDlUAGaiOj2lV+d8lR6yfpV8uRP0NGntOh0DqKXbHyA=;
        b=cQCK0RqYDPiQkm4S55vinZevxQd7E9ulZnv/iQh8bAIK/ufZ2d/5PvbhgEHfr3n6cp
         E+v801LGKSgTG+5e9kHIlrm5hv3ooHJ5xBYqS4CANMOKCKY3gvHo/pODxaZgWiesjJiN
         w6/N55Gy5EAsei3AmNrz9QNq96pRTIr6+p7ikVms1VCti+laofLBGINfioYGHsiJe5Rz
         xnonaeKbom8GC00u0qtwzV70+KcxykKqe1nPvX9AqzpTzvUupZVIXGxNCGOlkOaSa4IU
         kDc2G7Q8apgxYxyJg4Rzb24QFyfCAeLhSl0wPP9uM9GKQAV9IxtjmASwaW7LwwjOK4JJ
         YcrA==
X-Gm-Message-State: APjAAAUcXWOmTP3Q8aJ1UcPar94AItncdvMhXy89Qf4iwkU+bFmG8cL2
        9IOUnnkiZeTB1EotTNOc0BCsRA==
X-Google-Smtp-Source: APXvYqw1cd9NRitLKvHvEFCPgXc3GPDX4mCyleBFtLUFSFU95WE+w4QTTBmX9rntwiEyxJfw2ki7iA==
X-Received: by 2002:a6b:7311:: with SMTP id e17mr11599270ioh.112.1562459821048;
        Sat, 06 Jul 2019 17:37:01 -0700 (PDT)
Received: from ?IPv6:2601:281:200:3b79:cd59:12b2:b8b5:6291? ([2601:281:200:3b79:cd59:12b2:b8b5:6291])
        by smtp.gmail.com with ESMTPSA id y5sm13147626ioc.86.2019.07.06.17.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 17:37:00 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <CAHk-=wjOFXr83=A03ORuT5qq5yiQPwN9vMOrYvTMcqdC-wNn8w@mail.gmail.com>
Date:   Sat, 6 Jul 2019 18:36:59 -0600
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBA737F7-43F3-448B-B251-EF6F0060DD12@amacapital.net>
References: <20190704195555.580363209@infradead.org> <20190704200050.534802824@infradead.org> <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com> <20190705134916.GU3402@hirez.programming.kicks-ass.net> <CAHk-=whsgA+8XtqJY91gqHhh9xLYQLM3kLLFTby=uf2eoZyK7Q@mail.gmail.com> <20190706182728.435a89ed@gandalf.local.home> <CAHk-=wj=vCn1c7O4rpjwnS1fZbEppkeUhAq=ob3+wox0FKNZwQ@mail.gmail.com> <CAHk-=wjOFXr83=A03ORuT5qq5yiQPwN9vMOrYvTMcqdC-wNn8w@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 6, 2019, at 6:08 PM, Linus Torvalds <torvalds@linux-foundation.org>=
 wrote:
>=20
> On Sat, Jul 6, 2019 at 3:41 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>=20
>>> On Sat, Jul 6, 2019 at 3:27 PM Steven Rostedt <rostedt@goodmis.org> wrot=
e:
>>>=20
>>> We also have to deal with reading vmalloc'd data as that can fault too.
>>=20
>> Ahh, that may be a better reason for PeterZ's patches and reading cr2
>> very early from asm code than the stack trace case.
>=20
> Hmm. Another alternative might be to simply just make our vmalloc page
> fault handling more robust.
>=20
> Right now, if we take a vmalloc page fault in an inconvenient spot, it
> is fatal because it corrupts the cr2 in the outer context.
>=20
> However, it doesn't *need* to be fatal. Who cares if the outer context
> cr2 gets corrupted? We probably *shouldn't* care - it's an odd and
> unusual case, and the outer context could just handle the wrong
> vmalloc-address cr2 fine (it's going to be a no-op, since the inner
> page fault will have handled it already), return, and then re-fault.
>=20
> The only reason it's fatal right now is that we care much too deeply about=

>=20
> (a) the error code
> (b) the pt_regs state
>=20
> when we handle vmalloc faults.
>=20
> So one option is that we simply handle the vmalloc faults _without_
> caring about the error code and the pt_regs state, because even if the
> error code or the pt_regs implies that the fault comes from user
> space, the cr2 value might be due to a vmalloc fault from the inner
> kernel page fault that corrupted cr2.
>=20
> Right now vmalloc faults are already special and need to be handled
> without holding any locks etc. We'd just make them even more special,
> and say that we might have a vmalloc area fault from any context.
>=20
> IOW, somethinig like the attached patch would make nesting vmalloc
> faults harmless. Sure, we'll do the "vmalloc fault" twice, and return
> and re-do the original page fault, but this is a very unusual case, so
> from a performance angle we don't really care.

Eww. I would like to be able to rely on fault into being correct.  Also, you=
r patch won=E2=80=99t do so well if the fault is from user mode, I think.


>=20
> But I guess the "read cr2 early" is fine too..
>=20
>               Linus
> <patch.diff>
