Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A31C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 05:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57152154A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 05:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574918643;
	bh=VBbhkDJDkbjqoegiy3jUe6U+f7TMrtXr7r+3AKCvRhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u5fMGIynD8a+S2AXXkQeEdiiWXQ/YM+LXayR7UsCYg2MIMsHJXmLL3+2egsyYdiE1
	 F/hsbQtS96xeyalQJr6Wrorl+tkIAKzpl5U0Jym6Gx8cMbE3HiQUKA181wgEof10Bd
	 ITw/q5htD/WkNoyu3fG6ZOqjzD9RpUi5YyxXMopI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfK1FX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 00:23:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfK1FX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 00:23:59 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74EA621781
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574918638;
        bh=VBbhkDJDkbjqoegiy3jUe6U+f7TMrtXr7r+3AKCvRhE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XFSzWRJHCks5raSsyf2h45mbCkTAf/dnYcCDtm+C5Upm1SvhaW02lIbvnNjcPETLS
         CBqDm56PLSRLJX5wGbK6pvwysYk+9WGUiaqYvaebu+K9MQdJ1iTR6UH5IPhboZR8YH
         OVcGscC7dAJDPfHMrhG80AWHqevKP4gyt9UtA2WY=
Received: by mail-wr1-f44.google.com with SMTP id s5so29446619wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 21:23:58 -0800 (PST)
X-Gm-Message-State: APjAAAV1Gk+pFDu+JbOp/r4mVBF6fVwd5npO4qMFvjnxXNSGM0zUSXfr
        80Vaqi/QmJYH0oATB5/BL8HA2XFTnKO+QtHQfBBYYA==
X-Google-Smtp-Source: APXvYqyR7ToFOKMB3H45yiG009eHrHB26hEhJubbVHuPxZ+9pxVJPUi3dXnZeWmiKmzURvTdaqF0QWrYWaEe9J3nQ5E=
X-Received: by 2002:adf:f491:: with SMTP id l17mr4133365wro.149.1574918636807;
 Wed, 27 Nov 2019 21:23:56 -0800 (PST)
MIME-Version: 1.0
References: <20191115191728.87338-1-jannh@google.com> <20191115191728.87338-2-jannh@google.com>
 <CALCETrVQ2NqPnED_E6Y6EsCOEJJcz8GkQhgcKHk7JVAyykq06A@mail.gmail.com> <CAG48ez2z8i1nosA1nGrVdXx1cXXwHBqe7CC5kMB2W=uxbsvkjg@mail.gmail.com>
In-Reply-To: <CAG48ez2z8i1nosA1nGrVdXx1cXXwHBqe7CC5kMB2W=uxbsvkjg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 27 Nov 2019 21:23:44 -0800
X-Gmail-Original-Message-ID: <CALCETrXU-hetnH7CTz-Z2xPDAkawx6GdxGtYo0=Jqq1YnoXrWg@mail.gmail.com>
Message-ID: <CALCETrXU-hetnH7CTz-Z2xPDAkawx6GdxGtYo0=Jqq1YnoXrWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:27 PM Jann Horn <jannh@google.com> wrote:
>
> On Sun, Nov 24, 2019 at 12:08 AM Andy Lutomirski <luto@kernel.org> wrote:
> > On Fri, Nov 15, 2019 at 11:17 AM Jann Horn <jannh@google.com> wrote:
> > > A frequent cause of #GP exceptions are memory accesses to non-canonical
> > > addresses. Unlike #PF, #GP doesn't come with a fault address in CR2, so
> > > the kernel doesn't currently print the fault address for #GP.
> > > Luckily, we already have the necessary infrastructure for decoding X86
> > > instructions and computing the memory address that is being accessed;
> > > hook it up to the #GP handler so that we can figure out whether the #GP
> > > looks like it was caused by a non-canonical address, and if so, print
> > > that address.
> [...]
> > > +static void print_kernel_gp_address(struct pt_regs *regs)
> > > +{
> > > +#ifdef CONFIG_X86_64
> > > +       u8 insn_bytes[MAX_INSN_SIZE];
> > > +       struct insn insn;
> > > +       unsigned long addr_ref;
> > > +
> > > +       if (probe_kernel_read(insn_bytes, (void *)regs->ip, MAX_INSN_SIZE))
> > > +               return;
> > > +
> > > +       kernel_insn_init(&insn, insn_bytes, MAX_INSN_SIZE);
> > > +       insn_get_modrm(&insn);
> > > +       insn_get_sib(&insn);
> > > +       addr_ref = (unsigned long)insn_get_addr_ref(&insn, regs);
> [...]
> > > +}
> >
> > Could you refactor this a little bit so that we end up with a helper
> > that does the computation?  Something like:
> >
> > int probe_insn_get_memory_ref(void **addr, size_t *len, void *insn_addr);
> >
> > returns 1 if there was a memory operand and fills in addr and len,
> > returns 0 if there was no memory operand, and returns a negative error
> > on error.
> >
> > I think we're going to want this for #AC handling, too :)
>
> Mmmh... the instruction decoder doesn't currently give us a reliable
> access size though. (I know, I'm using it here regardless, but it
> doesn't really matter here if the decoded size is too big from time to
> time... whereas I imagine that that'd matter quite a bit for #AC
> handling.) IIRC e.g. a MOVZX that loads 1 byte into a 4-byte register
> is decoded as having .opnd_bytes==4; and if you look through
> arch/x86/lib/insn.c, there isn't even anything that would ever set
> ->opnd_bytes to 1. You'd have to add some plumbing to get reliable
> access sizes. I don't want to add a helper for this before the
> underlying infrastructure actually works properly.

Fair enough.  Although, with #AC, we know a priori that the address is
unaligned, so we could at least print "Unaligned access at 0x%lx\n".
But we can certainly leave these details to someone else.

(For context, there are patches floating around to enable a formerly
secret CPU feature to generate #AC on a LOCK instruction that spans a
cache line.)

--Andy
