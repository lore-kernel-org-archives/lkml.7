Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127F4C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED6B222CB
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389865AbfJDPbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:31:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:61274 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389710AbfJDPbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:31:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 08:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="393593551"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga006.fm.intel.com with ESMTP; 04 Oct 2019 08:31:16 -0700
Date:   Fri, 4 Oct 2019 08:31:15 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: determine whether the fault address is canonical
Message-ID: <20191004153115.GA19503@linux.intel.com>
References: <20191004134501.30651-1-changbin.du@gmail.com>
 <8b2c8164-d7ae-20b7-ff48-32eab9ec9760@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b2c8164-d7ae-20b7-ff48-32eab9ec9760@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 07:39:08AM -0700, Dave Hansen wrote:
> On 10/4/19 6:45 AM, Changbin Du wrote:
> > +static inline bool is_canonical_addr(u64 addr)
> > +{
> > +#ifdef CONFIG_X86_64
> > +	int shift = 64 - boot_cpu_data.x86_phys_bits;
> 
> I think you mean to check the virtual bits member, not "phys_bits".
> 
> BTW, I also prefer the IS_ENABLED(CONFIG_) checks to explicit #ifdefs.
> Would one of those work in this case?
> 
> As for the error message:
> 
> >  {
> > -	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
> > +	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault at %s address in user access.",
> > +		  is_canonical_addr(fault_addr) ? "canonical" : "non-canonical");
> 
> I've always read that as "the GP might have been caused by a
> non-canonical access".  The main nit I'd have with the change is that I
> don't think all #GP's during user access functions which are given a
> non-canonical address *necessarily* caused the #GP.
> 
> There are a billion ways you can get a #GP and I bet canonical
> violations aren't the only way you can get one in a user copy function.

All the other reasons would require a fairly egregious kernel bug, hence
the speculation that the #GP is due to a non-canonical address.  Something
like the following would be more precise, though highly unlikely to ever
be exercised, e.g. KVM had a fatal bug related to injecting a non-zero
error code that went unnoticed for years.

	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. %s?\n",
		  (IS_ENABLED(CONFIG_X86_64) && !error_code) ? "Non-canonical address" :
		  					       "Segmentation bug");
