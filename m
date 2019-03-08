Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0130C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31D620851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCHRYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:24:45 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33049 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfCHRYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:24:45 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h2JEY-0000Xy-Tx; Fri, 08 Mar 2019 18:24:35 +0100
Date:   Fri, 8 Mar 2019 18:24:34 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 12/22] x86/fpu: Only write PKRU if it is different from
 current
Message-ID: <20190308172434.6mshxok52syxwsrz@linutronix.de>
References: <20190221115020.12385-1-bigeasy@linutronix.de>
 <20190221115020.12385-13-bigeasy@linutronix.de>
 <198b2412-e81d-6c55-c74f-c2cab60fc5f2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <198b2412-e81d-6c55-c74f-c2cab60fc5f2@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-25 10:08:10 [-0800], Dave Hansen wrote:
> On 2/21/19 3:50 AM, Sebastian Andrzej Siewior wrote:
> > @@ -111,6 +111,12 @@ static inline void __write_pkru(u32 pkru)
> >  {
> >  	u32 ecx = 0, edx = 0;
> >  
> > +	/*
> > +	 * WRPKRU is relatively expensive compared to RDPKRU.
> > +	 * Avoid WRPKRU when it would not change the value.
> > +	 */
> > +	if (pkru == __read_pkru())
> > +		return;
> >  	/*
> >  	 * "wrpkru" instruction.  Loads contents in EAX to PKRU,
> >  	 * requires that ecx = edx = 0.
> 
> Could we do this in write_pkru() instead?  I tried to keep the __
> versions of read and write as simple and symmetric as possible.

write_pkru() has:
| static inline void write_pkru(u32 pkru)
| {
|         struct pkru_state *pk;
| 
|         if (!boot_cpu_has(X86_FEATURE_OSPKE))
|                 return;
|         
|         pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
|         /*
|          * The PKRU value in xstate needs to be in sync with the value that is
|          * written to the CPU. The FPU restore on return to userland would
|          * otherwise load the previous value again.
|          */
|         fpregs_lock();
|         if (pk)
|                 pk->pkru = pkru;
|         __write_pkru(pkru);
|         fpregs_unlock();
| }

and is other callers besides write_pkru():
|arch/x86/include/asm/fpu/internal.h:    __write_pkru(pkru_val);
|arch/x86/kvm/vmx/vmx.c:         __write_pkru(vcpu->arch.pkru);
|arch/x86/kvm/vmx/vmx.c:                 __write_pkru(vmx->host_pkru)

Do want __write_pkru_isn() and __read_pkru_isn() so those are symmetric
and then we would have __write_pkru() which does the read check and
invokes __write_pkru_isn()?

Sebastian
