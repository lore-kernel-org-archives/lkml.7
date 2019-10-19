Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA537CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FC8222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571470815;
	bh=yh6O5swUb5FATRnNpprXVim9T+S1mzekKpm1xJ81ezc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ctpk9zAQ5Qmhx78drlImlTEqFBvbnrhTi5+EXZ1I5eu+SHoFwiejDU5mT3MLeEmvn
	 /jU8/slxIvoNNXMedLsl50rNY1Q4nQPnVfClb5dMoKasO5GnbuCFoOyIWrjvgLVzXr
	 bKqpBdMUiRvNOSdAvx/BaNfRkJi26cUX0noUAHf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfJSHjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 03:39:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35033 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfJSHjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 03:39:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10so8039089wrb.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 00:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VPBsTU2gn1XnR7+v2BrLp4zUOVwR6W+IPFm+nRDxQps=;
        b=rDbWJuQjrscMy7PdZSnjvl8I5z1uPYbrRYDyHrWqEOEL7EsrupTX2U13cN8QOdq7gS
         HgMEBBBqb6+x7nw3MK4LMkfCiwV3Ihshufd69bDaospRlEzEm6yMMZY/2EulCQJvqa9v
         oaMyPuyd8FqL2dp8Aj09GjpfoX3llueH+I0ostXn43SXVsxIMOs6AWDbG4Q23ncGqR4D
         8t6Cq3uq7YFK8OoSnFgHsUj0lJtf1cvXUOYAryxIBBE3YM2f7hrEnC3s5gdC9PuEmF0X
         8aisJIigoSKXoi5AEbEJoFiKDy42Kg+j6Jkc8N2nsa77zocyZDNlamcvjVzPCQP7x3b1
         OFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VPBsTU2gn1XnR7+v2BrLp4zUOVwR6W+IPFm+nRDxQps=;
        b=no18LaNOEskxo9+4btByHSfqKgkxb0Szd3A+uNDgT6f6rbQ3tMLjNZqTfeNnmkCWdY
         jlP98QLw1GZSrugCI5Or5Fi17x3Rc6N6vwREGP1WmJ2PT0WQqDg/8DhTrwNovlnfkI+3
         oZxpcb0vUiHD+dUcdvNJBJhRXvExWI2SQJ9iUOwpz3YAYA5egcnBf914bjNOCWBJ5Mic
         8cN7+xxwLU1MYT0vEOtAES5byLfNDpkAyiG9QjnP4iiY8CdFmnWe8gl2Zo1gvsgUw6iQ
         K8nZdVOsUhDnwEIW3OAvl8GKX7k3xtHVY9ECW1+pj0GHNZHr1ieePJ5mSR76UFOJrjuc
         q8Cg==
X-Gm-Message-State: APjAAAVrh3SNdWyjrKQFnk0GLcGs6Yc7qME/aFGGxQlzhggXrLSyAQh3
        ye0pMedGqx8sTB28lPQ2es4=
X-Google-Smtp-Source: APXvYqyFqStDalEjaSdJCbMZhJyG6XC4E2N1P9rhCT1fxmpj3ed7RARMJjdS8RCdwrB89gZWBGhbeA==
X-Received: by 2002:adf:e903:: with SMTP id f3mr10433077wrm.121.1571470750673;
        Sat, 19 Oct 2019 00:39:10 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c6sm7341379wrm.71.2019.10.19.00.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 00:39:09 -0700 (PDT)
Date:   Sat, 19 Oct 2019 09:39:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: make try_to_generate_entropy() more robust
Message-ID: <20191019073907.GA101301@gmail.com>
References: <20191018203704.GC31027@cork>
 <20191018204220.GD31027@cork>
 <CAHk-=wi80VJ+4cUny2kwm0RxrmVdh24VPz5ZHjY4qCWR5iQBDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi80VJ+4cUny2kwm0RxrmVdh24VPz5ZHjY4qCWR5iQBDQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Oct 18, 2019 at 4:42 PM Jörn Engel <joern@purestorage.com> wrote:
> >
> > We can generate entropy on almost any CPU, even if it doesn't provide a
> > high-resolution timer for random_get_entropy().  As long as the CPU is
> > not idle, it changed the register file every few cycles.  As long as the
> > ALU isn't fully synchronized with the timer, the drift between the
> > register file and the timer is enough to generate entropy from.
> 
> >  static void entropy_timer(struct timer_list *t)
> >  {
> > +     struct pt_regs *regs = get_irq_regs();
> > +
> > +     /*
> > +      * Even if we don't have a high-resolution timer in our system,
> > +      * the register file itself is a high-resolution timer.  It
> > +      * isn't monotonic or particularly useful to read the current
> > +      * time.  But it changes with every retired instruction, which
> > +      * is enough to generate entropy from.
> > +      */
> > +     mix_pool_bytes(&input_pool, regs, sizeof(*regs));
> 
> Ok, so I still like this conceptually, but I'm not entirely sure that
> get_irq_regs() works reliably in a timer. It's done from softirq
> TIMER_SOFTIRQ context, so not necessarily _in_ an interrupt.
> 
> Now, admittedly this code doesn't really need "reliably". The odd
> occasional hickup would arguably just add more noise. And I think the
> code works fine. get_irq_regs() will return a pointer to the last
> interrupt or exception frame on the current CPU, and I guess it's all
> fine. But let's bring in Thomas, who was not only active in the
> randomness discussion, but might also have stronger opinions on this
> get_irq_regs() usage.
> 
> Thomas, opinions? Using the register state (while we're doing the
> whole entropy load with scheduling etc) looks like a good source of
> high-entropy data outside of just the TSC, so it does seem like a very
> valid model. But I want to run it past more people first, and Thomas
> is the obvious victim^Wchoice.

Not Thomas, but one potential problem I can see is that our 
set_irq_regs() use (on x86) is fundamentally nested, we restore whatever 
context we interrupt:

  dagon:~/tip> git grep set_irq_regs arch/x86
  arch/x86/include/asm/irq_regs.h:static inline struct pt_regs *set_irq_regs(struct pt_regs *new_regs)
  arch/x86/kernel/apic/apic.c:    struct pt_regs *old_regs = set_irq_regs(regs);
  arch/x86/kernel/apic/apic.c:    set_irq_regs(old_regs);
  arch/x86/kernel/cpu/acrn.c:     struct pt_regs *old_regs = set_irq_regs(regs);
  arch/x86/kernel/cpu/acrn.c:     set_irq_regs(old_regs);
  arch/x86/kernel/cpu/mshyperv.c: struct pt_regs *old_regs = set_irq_regs(regs);
  arch/x86/kernel/cpu/mshyperv.c: set_irq_regs(old_regs);
  arch/x86/kernel/cpu/mshyperv.c: struct pt_regs *old_regs = set_irq_regs(regs);
  arch/x86/kernel/cpu/mshyperv.c: set_irq_regs(old_regs);
  arch/x86/kernel/irq.c:  struct pt_regs *old_regs = set_irq_regs(regs);
  arch/x86/kernel/irq.c:  set_irq_regs(old_regs);
  arch/x86/kernel/irq.c:  struct pt_regs *old_regs = set_irq_regs(regs);
  arch/x86/kernel/irq.c:  set_irq_regs(old_regs);
  arch/x86/kernel/irq.c:  struct pt_regs *old_regs = set_irq_regs(regs);
  arch/x86/kernel/irq.c:  set_irq_regs(old_regs);
  arch/x86/kernel/irq.c:  struct pt_regs *old_regs = set_irq_regs(regs);
  arch/x86/kernel/irq.c:  set_irq_regs(old_regs);
  arch/x86/kernel/irq.c:  struct pt_regs *old_regs = set_irq_regs(regs);
  arch/x86/kernel/irq.c:  set_irq_regs(old_regs);

But from a softirq or threaded irq context that 'interrupted' regs 
context might potentially be NULL.

NULL isn't a good thing to pass to mix_pool_bytes(), because the first 
use of 'in' (='bytes') in _mix_pool_bytes() is a dereference without a 
NULL check AFAICS:

                w = rol32(*bytes++, input_rotate);

So at minimum I'd only mix this entropy into the pool if 'regs' is 
non-zero. This would automatically do the right thing and not crash the 
kernel on weird irq execution models such as threaded-only or -rt.

If irq-regs _is_ set, then I think we can generally rely on it to either 
be a valid regs pointer or NULL, inside an IRQ handler execution 
instance.

( Furthermore, if we are mixing in regs, then we might as well mix in a 
  few bytes of the interrupted stack as well if it's a kernel stack, 
  which would normally carry quite a bit of variation as well (such as 
  return addresses). Often it has more entropy than just register 
  contents, and it's also cache-hot, so a cheap source of entropy. But 
  that would require a second mix_pool_bytes() call and further 
  examination. Such an approach too would obviously require a non-NULL 
  'regs' pointer. :-) ]

Thanks,

	Ingo
