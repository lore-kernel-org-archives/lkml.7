Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102B3C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC8F2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfDLPYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:24:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37627 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDLPYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:24:43 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hEy2f-0006Tp-Ns; Fri, 12 Apr 2019 17:24:37 +0200
Date:   Fri, 12 Apr 2019 17:24:37 +0200
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
Message-ID: <20190412152437.d2bswajqtx7hrpkb@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-24-bigeasy@linutronix.de>
 <20190412143615.GE19808@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190412143615.GE19808@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-12 16:36:15 [+0200], Borislav Petkov wrote:
> On Wed, Apr 03, 2019 at 06:41:52PM +0200, Sebastian Andrzej Siewior wrote:
> > @@ -226,10 +236,9 @@ static void fpu__initialize(struct fpu *fpu)
> >  {
> >  	WARN_ON_FPU(fpu != &current->thread.fpu);
> >  
> > +	set_thread_flag(TIF_NEED_FPU_LOAD);
> >  	fpstate_init(&fpu->state);
> >  	trace_x86_fpu_init_state(fpu);
> > -
> > -	trace_x86_fpu_activate_state(fpu);
> 
> That is called nowhere after this patch.

Isn't it called from fpu__clear()?

> Shouldn't it be called below, before fpregs_activate() because
> fpregs_activate() does trace_x86_fpu_regs_activated()?

Why? fpu__initialize() wipes the FPU state and starts from zero.
fpregs_mark_activate() on the other hand marks this FPU context is
currently active.

Sebastian
