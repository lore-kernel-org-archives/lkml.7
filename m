Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEAAC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8A42070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfJGPNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:13:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:57231 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbfJGPNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:13:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 08:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="196314615"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga003.jf.intel.com with ESMTP; 07 Oct 2019 08:13:23 -0700
Date:   Mon, 7 Oct 2019 08:13:23 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Changbin Du <changbin.du@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: determine whether the fault address is canonical
Message-ID: <20191007151323.GB18016@linux.intel.com>
References: <20191004134501.30651-1-changbin.du@gmail.com>
 <8b2c8164-d7ae-20b7-ff48-32eab9ec9760@intel.com>
 <20191004153115.GA19503@linux.intel.com>
 <20191007143255.GA59713@gmail.com>
 <20191007144423.GA25181@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007144423.GA25181@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:44:23PM +0200, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > > All the other reasons would require a fairly egregious kernel bug, hence
> > > the speculation that the #GP is due to a non-canonical address.  Something
> > > like the following would be more precise, though highly unlikely to ever
> > > be exercised, e.g. KVM had a fatal bug related to injecting a non-zero
> > > error code that went unnoticed for years.
> > > 
> > > 	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. %s?\n",
> > > 		  (IS_ENABLED(CONFIG_X86_64) && !error_code) ? "Non-canonical address" :
> > > 		  					       "Segmentation bug");
> > 
> > Instead of trying to guess the reason of the #GPF (which guess might be 
> > wrong), please just state it as the reason if we are sure that the cause 
> > is a non-canonical address - and provide a best-guess if it's not but 
> > clearly signal that it's a guess.
> > 
> > I.e. if I understood all the cases correctly we'd have three types of 
> > messages generated:
> > 
> >  !error_code:
> > 	"General protection fault in user access, due to non-canonical address."

A non-canonical #GP always has an error code of '0', but the reverse isn't
technically true.  And 32-bit mode obviously can't generate a non-canonical
address.

But practically speaking, since _ASM_EXTABLE_UA() should only be used for
reg<->mem instructions, the only way to get a #GP on a usercopy instruction
would be to corrupt the code itself or have a bad segment loaded in 32-bit
mode.  So qualifying the non-canonical message on '64-bit && !error_code'
is techncally more precise/correct, but likely meaningless in practice.

> >  error_code && !is_canonical_addr(fault_addr):
> > 	"General protection fault in user access. Non-canonical address?"
> > 
> >  error_code && is_canonical_addr(fault_addr):
> > 	"General protection fault in user access. Segmentation bug?"
> 
> Now that I've read the rest of the thread, since fault_addr is always 0 
> we can ignore most of this I suspect ...
