Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC21C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFD72189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfH1Lhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:37:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfH1Lhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:37:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D55AE2A09B9;
        Wed, 28 Aug 2019 11:37:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 447A75D712;
        Wed, 28 Aug 2019 11:37:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 28 Aug 2019 13:37:46 +0200 (CEST)
Date:   Wed, 28 Aug 2019 13:37:43 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Sebastian Mayr <me@sam.st>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: get_unmapped_area && in_ia32_syscall (Was: [PATCH] uprobes/x86:
 fix detection of 32-bit user mode)
Message-ID: <20190828113743.GA3721@redhat.com>
References: <20190728152617.7308-1-me@sam.st>
 <alpine.DEB.2.21.1908232343470.1939@nanos.tec.linutronix.de>
 <20190827140055.GA6291@redhat.com>
 <15c5d9f6-6429-4775-05af-8a956d44a9ef@gmail.com>
 <459fdf33-1290-2651-6344-0ff9e466ddfc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459fdf33-1290-2651-6344-0ff9e466ddfc@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 28 Aug 2019 11:37:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28, Dmitry Safonov wrote:
>
> > On 8/27/19 3:00 PM, Oleg Nesterov wrote:
> > [..]
> >> But to remind, there is another problem with in_ia32_syscall() && uprobes.
> >>
> >> get_unmapped_area() paths use in_ia32_syscall() and this is wrong in case
> >> when the caller is xol_add_vma(), in this case TS_COMPAT won't be set.>
> >> Usually the addr = TASK_SIZE - PAGE_SIZE passed to get_unmapped_area() should
> >> work, mm->get_unmapped_area() won't be even called. But if this addr is already
> >> occupied get_area() can return addr > TASK_SIZE.
> >
> > Technically, it's not bigger than TASK_SIZE that's supplied
> > get_unmapped_area() as an argument..

Hmm. What do you mean?

Just in case, TASK_SIZE checks TIF_ADDR32, not TS_COMPAT.

> >>  	if (!area->vaddr) {
> >> +		if(!is_64bit_mm(mm))
> >> +			current_thread_info()->status |= TS_COMPAT;
> >>  		/* Try to map as high as possible, this is only a hint. */
> >>  		area->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
> >>  						PAGE_SIZE, 0, 0);
> >> +		if(!is_64bit_mm(mm))
> >> +			current_thread_info()->status &= ~TS_COMPAT;;
> >>  		if (area->vaddr & ~PAGE_MASK) {
> >>  			ret = area->vaddr;
> >>  			goto fail;
> >
> > It could have been TASK_SIZE_OF(),

tsk is always current, why do we need TASK_SIZE_OF() ?

> > I see that arch_uprobe_analyze_insn() uses is_64bit_mm() which
> > is correct the majority of time, but not for processes those jump
> > switching CS..

Heh. it's actually even worse. Just suppose a 32-bit application simply
mmaps a 64-bit executable which has a probe. But this is off-topic.

> > Do I read the code properly and xol is always one page?

Yes,

> > Could that page be reserved on the top of mmap_base/mmap_compat_base at
> > the binfmt loading time?

How? I don't understand...

> (I would need than to add .mremap() for
> > restoring sake).

for what? I don't think you can restore a probed process anyway... OK,
right now this is off-topic too.

Oleg.

