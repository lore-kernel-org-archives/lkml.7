Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DF3C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CA020835
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556040246;
	bh=iYPrKA+CLfE+81yGX8HKug1p2zjXsokfBC4B5o7cWfc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sBdpNY2SP35G3bC6h6ODDtJsnhgnWYbnfJX8aPZyY3i+tRiSRKWqeMOJG1TrReA8q
	 SgXddCUoPX7jkomcYUHGJnBGpY8Jd7d7GD3tAVlJPm9kmyhvsLRqPtpb9VA71hdwor
	 ph9gaR6jWVQn0WW2Lds84sS6zQrB0f2zstmjEJG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfDWRYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728447AbfDWRYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:24:02 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E30C521850
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556040241;
        bh=iYPrKA+CLfE+81yGX8HKug1p2zjXsokfBC4B5o7cWfc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XXy3hiAAkeIWF29U1MFFQT+Kf4podYbKv3dMvIzY5Tn4Rc0LkcSl3npDijWPdNkrA
         x0splrtWA44skJGul3zEoJT7Nu/OBFWC6o8q2h2iKEfHpvnEu3BNedVoNqyQySFE+2
         RfGOFajxsstuT3bSmQJ6g2DtIjvgu9ek+2hoKj9Q=
Received: by mail-wm1-f42.google.com with SMTP id o25so1059095wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 10:24:00 -0700 (PDT)
X-Gm-Message-State: APjAAAU1oIGcUgx9S4pbYlod7TvQmMvkgg0xkyPZGGUe8QcnfYVDjz3s
        lrgyqSfvv1nkokh4LyH/UOT79nz9uY6lnqhzXaKNVA==
X-Google-Smtp-Source: APXvYqwGdQ9MUfdYBNY6hjUK/BccVGSK5ThFMU5wsMOaU6iBhCW5Mb4JaXwnZIEfhA6w9kGN5hNCCNKBSEyjvu3D2Sc=
X-Received: by 2002:a1c:e188:: with SMTP id y130mr3031759wmg.83.1556040239484;
 Tue, 23 Apr 2019 10:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190423065706.15430-1-namit@vmware.com> <CALCETrUohp2rMr9EcoAYm2M=Ktu4Bg2sPfUWMy5JqM-GXsDOBQ@mail.gmail.com>
 <44A66873-0834-4794-81A5-3B2131314AA4@vmware.com>
In-Reply-To: <44A66873-0834-4794-81A5-3B2131314AA4@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 23 Apr 2019 10:23:47 -0700
X-Gmail-Original-Message-ID: <CALCETrXLjL4vMwQP1tweWvk_+dBvZFdE85ckt8TZSVw2XyW_yQ@mail.gmail.com>
Message-ID: <CALCETrXLjL4vMwQP1tweWvk_+dBvZFdE85ckt8TZSVw2XyW_yQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/tlb: Remove flush_tlb_info from the stack
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 9:56 AM Nadav Amit <namit@vmware.com> wrote:
>
> > On Apr 23, 2019, at 9:50 AM, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Tue, Apr 23, 2019 at 12:12 AM Nadav Amit <namit@vmware.com> wrote:
>https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=3Dx8=
6/fixes >> Remove flush_tlb_info variables from the stack. This allows to a=
lign
> >> flush_tlb_info to cache-line and avoid potentially unnecessary cache
> >> line movements. It also allows to have a fixed virtual-to-physical
> >> translation of the variables, which reduces TLB misses.
> >>
> >> Use per-CPU struct for flush_tlb_mm_range() and
> >> flush_tlb_kernel_range(). Add debug assertions to ensure there are
> >> no nested TLB flushes that might overwrite the per-CPU data. For
> >> arch_tlbbatch_flush(), use a const struct.
> >>
> >> Results when running a microbenchmarks that performs 10^6 MADV_DONTEED
> >> operations and touching a page, in which 3 additional threads run a
> >> busy-wait loop (5 runs):
> >
> > Can you add a memset(,,,. 0, sizeof(struct flush_tlb_info)) everywhere
> > you grab it?  Or, even better, perhaps do something like:
> >
> > static inline struct flush_tlb_info *get_flush_tlb_info(void)
> > {
> >  /* check reentrancy, make sure that we use smp_processor_id() or
> > otherwise assert that we're bound to a single CPU. */
> >  struct flush_tlb_info *ptr =3D this_cpu_ptr(...);
> >  memset(ptr, 0, sizeof(*ptr));
> >  return ptr;
> > }
> >
> > static inline void put_flush_tlb_info(void)
> > {
> > /* finish checking reentrancy. */
> > }
>
> I=E2=80=99ll check if the compiler is smart enough to avoid redundant ass=
ignments,
> and if it is not, I=E2=80=99ll just give all the struct arguments to
> get_flush_tlb_info() instead of memset() if you don=E2=80=99t mind.

Sounds good.

>
> I also want to give a try for parallelizing the remote and local
> invocations, which really annoys me every time I look at the code.

Yes please!
