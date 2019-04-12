Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA15C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749DA2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfDLRUB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:20:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38121 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfDLRUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:20:00 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hEzqG-0000zL-1E; Fri, 12 Apr 2019 19:19:56 +0200
Date:   Fri, 12 Apr 2019 19:19:55 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 23/27] x86/fpu: Defer FPU state load until return to
 userspace
Message-ID: <20190412171955.npe2pbomc6np326v@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-24-bigeasy@linutronix.de>
 <20190412143615.GE19808@zn.tnic>
 <20190412152437.d2bswajqtx7hrpkb@linutronix.de>
 <20190412162213.GF19808@zn.tnic>
 <20190412163741.wq2iq44bnvcbne3a@linutronix.de>
 <20190412164827.GG19808@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190412164827.GG19808@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-12 18:48:28 [+0200], Borislav Petkov wrote:
> On Fri, Apr 12, 2019 at 06:37:41PM +0200, Sebastian Andrzej Siewior wrote:
> > (as you mentioned) so we would always record both trace points.
> > Therefore I would suggest to remove it.
> 
> Remove which one?

remove x86_fpu_activate_state.

> Recording both TPs seems to make sense unless it doesn't make a whole
> lotta sense to have:
> 
> fpregs_mark_activate
> |-> trace_x86_fpu_activate_state		<-- TP1
> |-> fpregs_activate
>     |-> trace_x86_fpu_regs_activated		<-- TP2

> Yeah, looks like the two are too much and too close for no good
> reason. There's nothing particularly spectacular in-between in
> fpregs_activate().

correct.

> > Maybe we could add a new one to __fpregs_load_activate() one in case we
> > avoid loading registers because of fpregs_state_valid(). This might make
> > sense.
> 
> But that's only the switch_fpu_return() path. Is fpregs_mark_activate()
> is going to use only the trace_x86_fpu_regs_activated() one? Note the
> "d" at the end.

You could have a trace-point in case we return to userland and we don't
load FPU registers because it looks like they are valid.
It was just an idea.

We could also rip all trcepoints out, rethink the situation and add new
ones based on current code.
- on schedule out, we may need to save registers (depending on
  TIF_NEED_FPU_LOAD) which is new. Before the series we always did.

- on schedule in do nothing but set that TIF bit. This is probably
  boring.

- on return to userland we should load the registers but can avoid it if
  we assume that they are valid for the current task
  (fpregs_state_valid())

- in kernel_fpu_begin() we may trash the task's FPU state (by saving its
  registers or by resetting fpu_fpregs_owner_ctx).

Those might be interesting.

Currently we have:
  "x86/fpu: %p load: %d xfeatures: %llx xcomp_bv: %llx"

and we have to find out what happens based on where that TP was
recorded. Also I'm not sure if the recorded xfeatures change over time.
I think they do not…

>   [ Btw, those two names need adjusting too: who came up with such close,
>      confusing names?!
>      ]

you mean trace_x86_fpu_activate_state and trace_x86_fpu_regs_activated?
They were added in d1898b733619b ("x86/fpu: Add tracepoints to dump FPU
state at key points") and we wouldn't have any otherwise.

Sebastian
