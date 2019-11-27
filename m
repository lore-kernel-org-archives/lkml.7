Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5021DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215BC2154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UkHiWpu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfK0U1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:27:49 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35632 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfK0U1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:27:48 -0500
Received: by mail-ot1-f65.google.com with SMTP id 23so18521492otf.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 12:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9xP2Kq0ECGwvZPzuAJ5O0ZAlQ2V/eOMBzNaTBOLe2M=;
        b=UkHiWpu57TLHrT7zfLK9ezWHC4Atn2Q8c+v34Ii47MuHGk4xEH0bL903ZN1ZLdrugB
         AKjwJ9K+gmwYeZj+p6Dlk5j6OHz/BE6McmcKAQEMXb9sutTq4yTSHK4ZQ+8MuHrjEQU6
         bHWRcRh9bwA8AOgnDnLa0EgMvktCFZZIb2RGJJjQbDC2e1w3AQGbrQsHtNlheS1Mempm
         sd+wTJU1aQ+nVtnbBuBDXD4uyBC/eVHDWSpHvewA+GZSMNx5cZ3h3zLPUkKqulfmGAX1
         ko8X707JwVmRR+DIsLA+vpqhD//BaQ4aHRQvZ9eM+CA2UP2FDMcUC7E59S4TMJ4Cir2G
         5mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9xP2Kq0ECGwvZPzuAJ5O0ZAlQ2V/eOMBzNaTBOLe2M=;
        b=P3Sg98R6SqTYi1/kIRljdE8PPehlERuS7plJWYwHlpgAfmotRHL9EUyagAuJcGwvHw
         Y4lSF03780h4HnoA4uiCrPxkKpospD6FE0ggLOwW6+0owPk+V+q3H1z09Pa4CDtJoVlX
         sJ7HRML6BKB17hZj2339jkTls+B9JTLGe/bqKa5QAOnf3IJlyFdkCH0EO61a82ni7mzo
         XXDDr9ONhkNpXvgo1tejDdfmX6g1PvYXjqEcsSjNRAXWc2JcxGSGomRVg5FTjcqfQDoX
         ik1RhnS3myGi8JvjoLMqagwdiY9D0M07sGmvPcxfYsMUq8f5f4fQsKVkfvXhQZC9NEto
         sOTA==
X-Gm-Message-State: APjAAAV9bqlJ+HSm3n5K44yb53rZ+3Nzqu0c9fdfolllPL1XcRyOdPsA
        62Uggi+mOZIfY05VwX6suE8kXlXcBmsyP9TsIQrJGA==
X-Google-Smtp-Source: APXvYqxyBQIW4FqJ+D1jqs4aIN1hIsrJjqe9mFFq16KOxi6M6yT7nIbsjwNSwCv3eYpB5N1h0Tosh6ej/HzfEhBG/jo=
X-Received: by 2002:a9d:328:: with SMTP id 37mr4826013otv.228.1574886467145;
 Wed, 27 Nov 2019 12:27:47 -0800 (PST)
MIME-Version: 1.0
References: <20191115191728.87338-1-jannh@google.com> <20191115191728.87338-2-jannh@google.com>
 <CALCETrVQ2NqPnED_E6Y6EsCOEJJcz8GkQhgcKHk7JVAyykq06A@mail.gmail.com>
In-Reply-To: <CALCETrVQ2NqPnED_E6Y6EsCOEJJcz8GkQhgcKHk7JVAyykq06A@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 27 Nov 2019 21:27:20 +0100
Message-ID: <CAG48ez2z8i1nosA1nGrVdXx1cXXwHBqe7CC5kMB2W=uxbsvkjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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

On Sun, Nov 24, 2019 at 12:08 AM Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Nov 15, 2019 at 11:17 AM Jann Horn <jannh@google.com> wrote:
> > A frequent cause of #GP exceptions are memory accesses to non-canonical
> > addresses. Unlike #PF, #GP doesn't come with a fault address in CR2, so
> > the kernel doesn't currently print the fault address for #GP.
> > Luckily, we already have the necessary infrastructure for decoding X86
> > instructions and computing the memory address that is being accessed;
> > hook it up to the #GP handler so that we can figure out whether the #GP
> > looks like it was caused by a non-canonical address, and if so, print
> > that address.
[...]
> > +static void print_kernel_gp_address(struct pt_regs *regs)
> > +{
> > +#ifdef CONFIG_X86_64
> > +       u8 insn_bytes[MAX_INSN_SIZE];
> > +       struct insn insn;
> > +       unsigned long addr_ref;
> > +
> > +       if (probe_kernel_read(insn_bytes, (void *)regs->ip, MAX_INSN_SIZE))
> > +               return;
> > +
> > +       kernel_insn_init(&insn, insn_bytes, MAX_INSN_SIZE);
> > +       insn_get_modrm(&insn);
> > +       insn_get_sib(&insn);
> > +       addr_ref = (unsigned long)insn_get_addr_ref(&insn, regs);
[...]
> > +}
>
> Could you refactor this a little bit so that we end up with a helper
> that does the computation?  Something like:
>
> int probe_insn_get_memory_ref(void **addr, size_t *len, void *insn_addr);
>
> returns 1 if there was a memory operand and fills in addr and len,
> returns 0 if there was no memory operand, and returns a negative error
> on error.
>
> I think we're going to want this for #AC handling, too :)

Mmmh... the instruction decoder doesn't currently give us a reliable
access size though. (I know, I'm using it here regardless, but it
doesn't really matter here if the decoded size is too big from time to
time... whereas I imagine that that'd matter quite a bit for #AC
handling.) IIRC e.g. a MOVZX that loads 1 byte into a 4-byte register
is decoded as having .opnd_bytes==4; and if you look through
arch/x86/lib/insn.c, there isn't even anything that would ever set
->opnd_bytes to 1. You'd have to add some plumbing to get reliable
access sizes. I don't want to add a helper for this before the
underlying infrastructure actually works properly.
