Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDA5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84A52175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfDEP6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:58:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfDEP6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:58:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0B77C049E24;
        Fri,  5 Apr 2019 15:58:37 +0000 (UTC)
Received: from treble (ovpn-123-87.rdu2.redhat.com [10.10.123.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 17AA55D71B;
        Fri,  5 Apr 2019 15:58:35 +0000 (UTC)
Date:   Fri, 5 Apr 2019 10:58:33 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] x86/entry: re-enable interrupts before exiting
Message-ID: <20190405155833.bnp5lfa5u33zhznk@treble>
References: <20190405153525.29587-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405153525.29587-1-tycho@tycho.ws>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 05 Apr 2019 15:58:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 09:35:24AM -0600, Tycho Andersen wrote:
> If the kernel oopses in an interrupt, nothing re-enables interrupts:
> 
> Aug 23 19:30:27 xpfo kernel: [   38.302714] BUG: sleeping function called from invalid context at
> ./include/linux/percpu-rwsem.h:33
> Aug 23 19:30:27 xpfo kernel: [   38.303837] in_atomic(): 0, irqs_disabled(): 1, pid: 1970, name:
> lkdtm_xpfo_test
> Aug 23 19:30:27 xpfo kernel: [   38.304758] CPU: 3 PID: 1970 Comm: lkdtm_xpfo_test Tainted: G      D
> 4.13.0-rc5+ #228
> Aug 23 19:30:27 xpfo kernel: [   38.305813] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.10.1-1ubuntu1 04/01/2014
> Aug 23 19:30:27 xpfo kernel: [   38.306926] Call Trace:
> Aug 23 19:30:27 xpfo kernel: [   38.307243]  dump_stack+0x63/0x8b
> Aug 23 19:30:27 xpfo kernel: [   38.307665]  ___might_sleep+0xec/0x110
> Aug 23 19:30:27 xpfo kernel: [   38.308139]  __might_sleep+0x45/0x80
> Aug 23 19:30:27 xpfo kernel: [   38.308593]  exit_signals+0x21/0x1c0
> Aug 23 19:30:27 xpfo kernel: [   38.309046]  ? blocking_notifier_call_chain+0x11/0x20
> Aug 23 19:30:27 xpfo kernel: [   38.309677]  do_exit+0x98/0xbf0
> Aug 23 19:30:27 xpfo kernel: [   38.310078]  ? smp_reader+0x27/0x40 [lkdtm]
> Aug 23 19:30:27 xpfo kernel: [   38.310604]  ? kthread+0x10f/0x150
> Aug 23 19:30:27 xpfo kernel: [   38.311045]  ? read_user_with_flags+0x60/0x60 [lkdtm]
> Aug 23 19:30:27 xpfo kernel: [   38.311680]  rewind_stack_do_exit+0x17/0x20
> 
> do_exit() expects to be called in a well-defined environment, so let's
> re-enable interrupts after unwinding the stack, in case they were disabled.
> 
> Note that if any spinlocks are held, etc. we'll also get the above warning,
> so this isn't a silver bullet. So, let's add a C helper in case someone
> wants to add fancier lock busting or if we've forgotten to unwind something
> else.
> 
> I've had to add back in the hack that Josh removed in 8c1f75587a18
> ("x86/entry/64: Add unwind hint annotations") with the loop after the call,
> because for whatever reason without that I get a warning:
> 
>   AS      arch/x86/entry/entry_64.o
> arch/x86/entry/entry_64.o: warning: objtool: .entry.text: unexpected end of section
> 
> It seems to actually work fine for me though, since the new helper is also
> __noreturn. Perhaps there's a better way to do this?

Unfortunately, objtool doesn't have a way to detect noreturn functions
in other objects, so they're hard-coded in a list.  You can add
__finish_rewind_stack_do_exit to the global_noreturns array in
tools/objtool/check.c.

-- 
Josh
