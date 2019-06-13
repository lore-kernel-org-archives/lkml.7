Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D90C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8D120665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442592;
	bh=6cDE1IQBqECLX/GE3cz5RFhViPVqUCHI2jp+eXTJxAQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=D3asCY4S7VD6qw3tebVtsGuY6gj2rlMMvmMKBZnW1wWBbf/9aTN1obJxrvLVfgET/
	 Ic25PtfjGwe7j8aDTP2/Fr7X2KJv62RIJoiCzGQGZLVSvrcGH1obh2y7Rt2xOcIAYp
	 Gc3i7V9XP6SRLLMMS0Ned1l4WdAu/1vREapKPnnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391972AbfFMQQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731151AbfFMQQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:16:27 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A501A217D6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 16:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560442585;
        bh=6cDE1IQBqECLX/GE3cz5RFhViPVqUCHI2jp+eXTJxAQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S+m9ecci+s1CfUEwQ+LU0pgPcQX0O3+GlhwHwETe4L4Vg3BsI02F7irSlLLhw3vS7
         756B+c6c/qOr8fuOkfLvDzliqYxc6edRAA7PG9C/WDjGnTy0LFrgkSurMHDC3HpOfy
         IGmtaoI/YNTpYJfvjPvjM+6c3Cnz+nGSxxXe5xs4=
Received: by mail-wr1-f43.google.com with SMTP id r16so2289454wrl.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 09:16:25 -0700 (PDT)
X-Gm-Message-State: APjAAAW6yybJqewfVi5dSkfawMJ+i7J+5dUva1zNYBCA44rV4qNDeJdY
        SfoLneH/Z8Swh8NMbKZ4r1bHS1TXAsAvwQHpYyFJmw==
X-Google-Smtp-Source: APXvYqxPBRxDWhvUkJ0orRQfDXYAMpb8FV7UATEbNv15yOAEwBF2eD9eUhD8hB9TODzqHxXRpLYam0XxFB3N/2AKD4M=
X-Received: by 2002:a5d:6207:: with SMTP id y7mr40127026wru.265.1560442584209;
 Thu, 13 Jun 2019 09:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190612170834.14855-1-mhillenb@amazon.de> <eecc856f-7f3f-ed11-3457-ea832351e963@intel.com>
 <A542C98B-486C-4849-9DAC-2355F0F89A20@amacapital.net> <CALCETrXHbS9VXfZ80kOjiTrreM2EbapYeGp68mvJPbosUtorYA@mail.gmail.com>
 <F05B97DB-34BD-44CF-AC6A-945D7AD39C38@vmware.com>
In-Reply-To: <F05B97DB-34BD-44CF-AC6A-945D7AD39C38@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 13 Jun 2019 09:16:12 -0700
X-Gmail-Original-Message-ID: <CALCETrUH4xDeyJh9N19Pf4k5ibRG7phCJy8PEfiJbvr6WZL0MA@mail.gmail.com>
Message-ID: <CALCETrUH4xDeyJh9N19Pf4k5ibRG7phCJy8PEfiJbvr6WZL0MA@mail.gmail.com>
Subject: Re: [RFC 00/10] Process-local memory allocations for hiding KVM secrets
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Marius Hillenbrand <mhillenb@amazon.de>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Alexander Graf <graf@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 6:50 PM Nadav Amit <namit@vmware.com> wrote:
>
> > On Jun 12, 2019, at 6:30 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Wed, Jun 12, 2019 at 1:27 PM Andy Lutomirski <luto@amacapital.net> w=
rote:
> >>> On Jun 12, 2019, at 12:55 PM, Dave Hansen <dave.hansen@intel.com> wro=
te:
> >>>
> >>>> On 6/12/19 10:08 AM, Marius Hillenbrand wrote:
> >>>> This patch series proposes to introduce a region for what we call
> >>>> process-local memory into the kernel's virtual address space.
> >>>
> >>> It might be fun to cc some x86 folks on this series.  They might have
> >>> some relevant opinions. ;)
> >>>
> >>> A few high-level questions:
> >>>
> >>> Why go to all this trouble to hide guest state like registers if all =
the
> >>> guest data itself is still mapped?
> >>>
> >>> Where's the context-switching code?  Did I just miss it?
> >>>
> >>> We've discussed having per-cpu page tables where a given PGD is only =
in
> >>> use from one CPU at a time.  I *think* this scheme still works in suc=
h a
> >>> case, it just adds one more PGD entry that would have to context-swit=
ched.
> >>
> >> Fair warning: Linus is on record as absolutely hating this idea. He mi=
ght change his mind, but it=E2=80=99s an uphill battle.
> >
> > I looked at the patch, and it (sensibly) has nothing to do with
> > per-cpu PGDs.  So it's in great shape!
> >
> > Seriously, though, here are some very high-level review comments:
> >
> > Please don't call it "process local", since "process" is meaningless.
> > Call it "mm local" or something like that.
> >
> > We already have a per-mm kernel mapping: the LDT.  So please nix all
> > the code that adds a new VA region, etc, except to the extent that
> > some of it consists of valid cleanups in and of itself.  Instead,
> > please refactor the LDT code (arch/x86/kernel/ldt.c, mainly) to make
> > it use a more general "mm local" address range, and then reuse the
> > same infrastructure for other fancy things.  The code that makes it
> > KASLR-able should be in its very own patch that applies *after* the
> > code that makes it all work so that, when the KASLR part causes a
> > crash, we can bisect it.
> >
> > + /*
> > + * Faults in process-local memory may be caused by process-local
> > + * addresses leaking into other contexts.
> > + * tbd: warn and handle gracefully.
> > + */
> > + if (unlikely(fault_in_process_local(address))) {
> > + pr_err("page fault in PROCLOCAL at %lx", address);
> > + force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)address, current=
);
> > + }
> > +
> >
> > Huh?  Either it's an OOPS or you shouldn't print any special
> > debugging.  As it is, you're just blatantly leaking the address of the
> > mm-local range to malicious user programs.
> >
> > Also, you should IMO consider using this mechanism for kmap_atomic().
> > Hi, Nadav!
>
> Well, some context for the =E2=80=9Chi=E2=80=9D would have been helpful. =
(Do I have a bug
> and I still don=E2=80=99t understand it?)

Fair enough :)

>
> Perhaps you regard some use-case for a similar mechanism that I mentioned
> before. I did implement something similar (but not the way that you wante=
d)
> to improve the performance of seccomp and system-calls when retpolines ar=
e
> used. I set per-mm code area that held code that used direct calls to inv=
oke
> seccomp filters and frequently used system-calls.
>
> My mechanism, I think, is more not suitable for this use-case. I needed m=
y
> code-page to be at the same 2GB range as the kernel text/modules, which d=
oes
> complicate things. Due to the same reason, it is also limited in the size=
 of
> the data/code that it can hold.
>

I actually meant the opposite.  If we had a general-purpose per-mm
kernel address range, could it be used to optimize kmap_atomic() by
limiting the scope of any shootdowns?  As a rough sketch, we'd have
some kmap_atomic slots for each cpu *in the mm-local region*.  I'm not
entirely sure this is a win.

--Andy
