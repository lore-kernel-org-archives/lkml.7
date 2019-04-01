Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BB72084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbfDAIYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:24:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58301 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731774AbfDAIYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:24:30 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hAsEy-0006Cj-L4; Mon, 01 Apr 2019 10:24:24 +0200
Date:   Mon, 1 Apr 2019 10:24:24 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 18/24] x86/fpu: Prepare copy_fpstate_to_sigframe() for
 TIF_NEED_FPU_LOAD
Message-ID: <20190401082424.uljjh5cejj33gb3r@linutronix.de>
References: <20190321202632.16810-1-bigeasy@linutronix.de>
 <20190321202632.16810-19-bigeasy@linutronix.de>
 <alpine.DEB.2.21.1903312013390.2476@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903312013390.2476@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-31 20:20:25 [+0200], Thomas Gleixner wrote:
> 
> I think this should do the following:
> 
> 	fpregs_lock();
> 	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
> 		pagefault_disable();
> 		ret = copy_fpu_to_user(...);
> 		pagefault_enable();
> 		if (!res)
> 			return 0;
> 		copy_fpregs_to_fpstate(fpu); 
> 	}
> 	fpregs_unlock();
> 
> The point is that in most cases the direct store from the FPU registers to
> user space will succeed simply because the stack is accessible and you only
> do the store in kernel memory and copy when that fails.

let me try that.

> Thanks,
> 
> 	tglx
> 

Sebastian
