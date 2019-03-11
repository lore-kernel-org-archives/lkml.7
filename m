Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2958C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFBC2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfCKOa5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:30:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38744 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfCKOa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:30:57 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h3Lx4-0006hQ-47; Mon, 11 Mar 2019 15:30:50 +0100
Date:   Mon, 11 Mar 2019 15:30:50 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 14/22] x86/fpu: Eager switch PKRU state
Message-ID: <20190311143049.hclnlciq4rzqrtp6@linutronix.de>
References: <20190221115020.12385-1-bigeasy@linutronix.de>
 <20190221115020.12385-15-bigeasy@linutronix.de>
 <eedfbbbe-02d0-f977-2a64-e683b98d3904@intel.com>
 <20190308180849.hy22jejhffp4n6uh@linutronix.de>
 <b0f3ffa8-faec-73b2-f6f2-ea37ece3a3b1@intel.com>
 <20190311110605.2xxjx2ym3n63lpr2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190311110605.2xxjx2ym3n63lpr2@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-11 12:06:05 [+0100], To Dave Hansen wrote:
> On 2019-03-08 11:01:25 [-0800], Dave Hansen wrote:
> > On 3/8/19 10:08 AM, Sebastian Andrzej Siewior wrote:
> > > On 2019-02-25 10:16:24 [-0800], Dave Hansen wrote:
> > >>> +	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
> > >>> +		return;
> > >>> +
> > >>> +	if (current->mm) {
> > >>> +		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
> > >>> +		WARN_ON_ONCE(!pk);
> …
> > Nothing will break, but the warning will trigger, which isn't nice.
> 
> the warning should trigger if something goes south, I was not expecting
> it to happen.
> 
> > > My understanding is that the in-kernel XSAVE will always save everything
> > > so we should never "lose" the XFEATURE_PKRU no matter what user space
> > > does.
> > > 
> > > So as test case you want
> > > 	xsave (-1 & ~XFEATURE_PKRU)
> > > 	xrestore (-1 & ~XFEATURE_PKRU)
> > > 
> > > in userland and then a context switch to see if the warning above
> > > triggers?
> > 
> > I think you need an XRSTOR with RFBM=-1 (or at least with the PKRU bit
> > set) and the PKRU bit in the XFEATURES field in the XSAVE buffer set to 0.
> 
> let me check that, write a test case in userland and I come back with
> the results. I can remove that warning but I wasn't expecting it to
> trigger so let me verify that first.

so I made dis:
	https://breakpoint.cc/tc-xsave.c

and it doesn't trigger. 
XSAVE saves what is specified and enabled. XRSTOR restores what is
specified, available in the header and enabled. Which means even if
userland disables a bit in the header, it is still available during
context switch by kernel's XSAVE as long as it is set in XSTATE_BV.
The user can't use XSETBV (can only query via XGETBV) which means that
XFEATURE_PKRU can't be removed by the user.

But you got me thinking: During signal delivery we save tasks' FPU
content on the signal stack. If the signal handler removes
XFEATURE_PKRU bit then __fpu__restore_sig() will load the "missing
state" from init_fpstate. Which means that the protection key will be
set to zero. Not sure we want this or not but this the case. A XRSTOR in
userland without XFEATURE_PKRU would leave the PKRU state unchanged.

The test case from above does this if you want to double check.

Sebastian
