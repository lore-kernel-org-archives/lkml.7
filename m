Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91797C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2AE20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbfDDOOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:14:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45173 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfDDOOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:14:15 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hC385-0003TA-Vq; Thu, 04 Apr 2019 16:14:10 +0200
Date:   Thu, 4 Apr 2019 16:14:09 +0200
From:   'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v9 00/27] x86: load FPU registers on return to userland
Message-ID: <20190404141409.upfk5z4re3pyvxzn@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <c4af28470a4347f5aa222a99471c939a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4af28470a4347f5aa222a99471c939a@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-04 14:01:43 [+0000], David Laight wrote:
> From: Sebastian Andrzej Siewior
> > Sent: 03 April 2019 17:41
> ...
> > To access the FPU registers in kernel we need:
> > - disable preemption to avoid that the scheduler switches tasks. By
> >   doing so it would set TIF_NEED_FPU_LOAD and the FPU registers would be
> >   not valid.
> > - disable BH because the softirq might use kernel_fpu_begin() and then
> >   set TIF_NEED_FPU_LOAD instead loading the FPU registers on completion.
> 
> Is there a possible optimisation here for kernel threads?
> Since there is no 'user FP state' the 'kernel FP state' can
> be saved by a task switch or softirq.

There is no such thing as "kernel FP state" that is saved.

> You'd still want the kernel thread to bracket fpu usage (or at least say
> that it is a kernel thread that always needs the fpu) to avoid having
> to save and restore the fpu registers on every context switch to/from
> a kernel thread.

I thing you misunderstood the code. A context switch between two kernel
threads never saves/restores the FPU register. This only happens if a
user task is involved and then only those FPU register (of the user
task) are saved and restored.

> 	David

Sebastian
