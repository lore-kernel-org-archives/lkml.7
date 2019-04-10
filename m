Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C640C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E0120693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbfDJO53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:57:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:62034 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732883AbfDJO51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:57:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 07:57:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="290361665"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga004.jf.intel.com with ESMTP; 10 Apr 2019 07:57:26 -0700
Date:   Wed, 10 Apr 2019 07:57:25 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Paolo Bonzini' <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: optimize check for valid PAT value
Message-ID: <20190410145725.GB10760@linux.intel.com>
References: <1554890126-347-1-git-send-email-pbonzini@redhat.com>
 <c2aaa028ef564c6d8bd50dbd86489115@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2aaa028ef564c6d8bd50dbd86489115@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:55:53PM +0000, David Laight wrote:
> From: Paolo Bonzini
> > Sent: 10 April 2019 10:55
> > 
> > This check will soon be done on every nested vmentry and vmexit,
> > "parallelize" it using bitwise operations.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> ...
> > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > index 28406aa1136d..7bc7ac9d2a44 100644
> > --- a/arch/x86/kvm/x86.h
> > +++ b/arch/x86/kvm/x86.h
> > @@ -347,4 +347,12 @@ static inline void kvm_after_interrupt(struct kvm_vcpu *vcpu)
> >  	__this_cpu_write(current_vcpu, NULL);
> >  }
> > 
> > +static inline bool kvm_pat_valid(u64 data)
> > +{
> > +	if (data & 0xF8F8F8F8F8F8F8F8)
> > +		return false;
> > +	/* 0, 1, 4, 5, 6, 7 are valid values.  */
> > +	return (data | ((data & 0x0202020202020202) << 1)) == data;
> > +}
> > +
> 
> How about:
> 	/*
> 	 * Each byte must be 0, 1, 4, 5, 6 or 7.
> 	 * Convert 001x to 011x then 100x so 2 and 3 fail the test.
> 	 */
> 	data |= (data ^ 0x0404040404040404ULL)) + 0x0202020202020202ULL;
> 	if (data & 0xF8F8F8F8F8F8F8F8ULL)
> 		return false;

Woah.  My vote is for Paolo's version as the separate checks allow the
reader to walk through step-by-step.  The generated assembly isn't much
different from a performance perspective since the TEST+JNE will be not
taken in the fast path.

Fancy:
   0x000000000004844f <+255>:   movabs $0xf8f8f8f8f8f8f8f8,%rcx
   0x0000000000048459 <+265>:   xor    %eax,%eax
   0x000000000004845b <+267>:   test   %rcx,%rdx
   0x000000000004845e <+270>:   jne    0x4848b <kvm_mtrr_valid+315>
   0x0000000000048460 <+272>:   movabs $0x202020202020202,%rax
   0x000000000004846a <+282>:   and    %rdx,%rax
   0x000000000004846d <+285>:   add    %rax,%rax
   0x0000000000048470 <+288>:   or     %rdx,%rax
   0x0000000000048473 <+291>:   cmp    %rdx,%rax
   0x0000000000048476 <+294>:   sete   %al
   0x0000000000048479 <+297>:   retq

Really fancy:
   0x0000000000048447 <+247>:   movabs $0x404040404040404,%rcx
   0x0000000000048451 <+257>:   movabs $0x202020202020202,%rax
   0x000000000004845b <+267>:   xor    %rdx,%rcx
   0x000000000004845e <+270>:   add    %rax,%rcx
   0x0000000000048461 <+273>:   movabs $0xf8f8f8f8f8f8f8f8,%rax
   0x000000000004846b <+283>:   or     %rcx,%rdx
   0x000000000004846e <+286>:   test   %rax,%rdx
   0x0000000000048471 <+289>:   sete   %al
   0x0000000000048474 <+292>:   retq
