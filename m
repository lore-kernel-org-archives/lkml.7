Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D3FC33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B1820720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgAHOWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:22:54 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:37923 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbgAHOWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:22:53 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MCayD-1iyEm02WJP-009g9A for <linux-kernel@vger.kernel.org>; Wed, 08 Jan
 2020 15:22:51 +0100
Received: by mail-qk1-f170.google.com with SMTP id z76so2773937qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:22:51 -0800 (PST)
X-Gm-Message-State: APjAAAV8q+zDK93TxOaNQU/1L4TYoN3Mq1eJxTvd4cjyqqkMcPOKTcGG
        n1yYyvwSgP3JNuxe+9le+Oz6ArqZQQHqwi0SzBg=
X-Google-Smtp-Source: APXvYqyfqgQD2H5+TORrgk7UjrEH2d32T6FSbyTEIj1G/XZzi/vedpcHrmeg7cndEJWWjXDeHezpKOfItgKTCtvZnNc=
X-Received: by 2002:a37:2f02:: with SMTP id v2mr4384139qkh.3.1578493370496;
 Wed, 08 Jan 2020 06:22:50 -0800 (PST)
MIME-Version: 1.0
References: <20191111131252.921588318@infradead.org> <20191111132458.220458362@infradead.org>
 <20191111164703.GA11521@willie-the-truck> <20191111171955.GO4114@hirez.programming.kicks-ass.net>
 <20191111172541.GT5671@hirez.programming.kicks-ass.net> <20191112112950.GB17835@willie-the-truck>
 <20191113092636.GG4131@hirez.programming.kicks-ass.net> <CAK8P3a0MJGpg6AkmwRL6o7TCPOQXSMDShutigvBjeOMDn0BHaA@mail.gmail.com>
 <20200108091628.7e548401@gandalf.local.home>
In-Reply-To: <20200108091628.7e548401@gandalf.local.home>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jan 2020 15:22:33 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0ejxNueA7dDBV103yY2j7QiLfzG96pc163miD3hKE6qA@mail.gmail.com>
Message-ID: <CAK8P3a0ejxNueA7dDBV103yY2j7QiLfzG96pc163miD3hKE6qA@mail.gmail.com>
Subject: Re: [PATCH -v5mkII 13/17] arm/ftrace: Use __patch_text()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bristot@redhat.com,
        Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, namit@vmware.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rabin Vincent <rabin@rab.in>, Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:biUHxl8UTZgOhX3GvGWcEFqJUAGaWoL4SLHx+vh+W2p7oNoE8/G
 DRBhhBRTZmKE/4dto4Z9z4Rq8Sdx8ph7rcS1uDMxHvcWunErXdw8tUVGPLSGzcvy5h4UXgu
 ZOi8TyDrjWd0NZTcnluaEBIhB5vxGb4VW6LbHpOcj/X6dRmo8fioovxMYQPDGd770P1EQmV
 jb1aDj7/ux57dRLLDs3Sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c8kA/IJVZHU=:nmtrTJ/8FJa2Z1/RTYZvEd
 V84dU2txZ82FDTtoWj+MGR/XhATia3/uvWClAaIctEnb4vpKvvgvbvEIfD0xtxMYYV6xR/u4T
 qh/q705lCv5rk6RbnTVfQIIH0YAVcbmbQjJZMnmL6enH4fjVxSz6K2eFn3EpCpLOj1HEBDj6e
 1vFiJe0uAoMECGYH+MOXE2w/FBJ2KIyTqqX0ZY76Tjx8vyComS/O3UilqJ6a9Woax7CFhmjal
 TSC0HKmgMaeelsfh+52f9uB1HafNnsS/NUL0VLRmy+xH1SNdnc6IrHQnOe8WkMaP4n4t1mv9M
 zDh07IXXgFIsSEHA3NayPnuSW/P2k8jrJByno1Jm3t8uTWrhIXuCPHee37IatGvcqk3Mqh8il
 fuZoMq8lNBHTpewSuC0+JcKQjeeUJkP2kSJ0Xl1A124/uQ+bsLc6rogk8/dsGQ4vRHdVLvjX/
 o49U1rPh7N1Hcw1HdxOaUwn8Q+Eyni8gNEYxmruEP0LzVob6X1z85Mi8fOrzEPJn1sVVIA7uN
 /ZFYe1PvaNvFtH2wNovvJ/eSXfvWJybDUn9kd3OGGJBw0mCsG1u/bm7clLbW5+46hGscUuXLZ
 caBlMQcBywnR1JMK0aXWhWQ9NaEni02rXb09BWlZumkAh1jIxjEPxL7K4urx++or9HKg6X2Be
 bq9V3ASbjunmHj+sfJBp3SdYZkhUWR6UBQRX7vje94PPQJCu3MrPDgCB9mC91vJVGAOlpCdpT
 16PLTfFaw36WWd5B/IbtVCCbw+jWCzQxKBKflxEuXmiUwYFWjq3Nm4T4beCGArPtHF0CAn/ww
 D70+qkzBBG7ayWWODItI4CsEl0popjurMt1/uVOeNwghHHzo8mgb8C9tyj2oZnRq2ZeU4wV8s
 J9OL6ekrsewjDc9AOj+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 3:16 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 8 Jan 2020 13:22:52 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > The problem is that we don't have a BE32 definition of
> > __opcode_to_mem_thumb32, mostly because no hardware
> > supports that.
> >
> > One possible workaround is a big ugly:
> >
> > diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
> > index d0a05a3bdb96..1067fd122897 100644
> > --- a/arch/arm/kernel/patch.c
> > +++ b/arch/arm/kernel/patch.c
> > @@ -90,9 +90,11 @@ void __kprobes __patch_text_real(void *addr,
> > unsigned int insn, bool remap)
> >
> >                 size = sizeof(u32);
> >         } else {
> > +#ifdef CONFIG_THUMB2_KERNEL
> >                 if (thumb2)
>
> If we change the above to:
>
>                 if (IS_ENABLED(CONFIG_THUMB2_KERNEL) && thumb2)
>
> Would the compiler optmize out __opcode_to_mem_thumb32(). We would need
> to add a declaration for it, but wont need to define it. At least we
> wont have nasty #ifdef logic in the code.

If we add a declaration for it, I think no change to patch.c is needed,
as 'thumb2' already has compile-time constant value equal to
IS_ENABLED(CONFIG_THUMB2_KERNEL).

I'll try it out.

       Arnd
