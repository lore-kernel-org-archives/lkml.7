Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A7FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45912077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfDLQhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:37:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37931 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLQhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:37:47 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hEzBN-0008Ci-SG; Fri, 12 Apr 2019 18:37:41 +0200
Date:   Fri, 12 Apr 2019 18:37:41 +0200
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
Message-ID: <20190412163741.wq2iq44bnvcbne3a@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-24-bigeasy@linutronix.de>
 <20190412143615.GE19808@zn.tnic>
 <20190412152437.d2bswajqtx7hrpkb@linutronix.de>
 <20190412162213.GF19808@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190412162213.GF19808@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-12 18:22:13 [+0200], Borislav Petkov wrote:
> On Fri, Apr 12, 2019 at 05:24:37PM +0200, Sebastian Andrzej Siewior wrote:
> > Isn't it called from fpu__clear()?
> 
> $ git grep trace_x86_fpu_activate_state
> $
> 
> all 23 patches applied. Grepping the later patches doesn't give
> trace_x86_fpu_activate_state() either.
> 
> > > Shouldn't it be called below, before fpregs_activate() because
> > > fpregs_activate() does trace_x86_fpu_regs_activated()?
> > 
> > Why? fpu__initialize() wipes the FPU state and starts from zero.
> > fpregs_mark_activate() on the other hand marks this FPU context is
> > currently active.
> 
> Well, then the naming still needs adjusting.
> 
> "trace_x86_fpu_activate_state" reads to me like the state is being
> activated here, at the call site. And fpregs_mark_activate() marks which
> *fpu is the active one.

bah. You are referring to trace_x86_fpu_activate_state. I parsed this as
fpu__initialize(). Sorry for that.

trace_x86_fpu_activate_state is unused and we should do something about
it.  Adding it to fpregs_mark_activate() seems to make sense.
We we also have this:
 fpregs_mark_activate()
   fpregs_activate()
      trace_x86_fpu_regs_activated()

(as you mentioned) so we would always record both trace points.
Therefore I would suggest to remove it.
Maybe we could add a new one to __fpregs_load_activate() one in case we
avoid loading registers because of fpregs_state_valid(). This might make
sense.

Sebastian
