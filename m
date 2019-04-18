Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EEFC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BFB2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389727AbfDRQ4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:56:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:49364 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388375AbfDRQ4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:56:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 09:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,366,1549958400"; 
   d="scan'208";a="165888456"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga001.fm.intel.com with ESMTP; 18 Apr 2019 09:56:11 -0700
Date:   Thu, 18 Apr 2019 09:56:11 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: kvm: hyper-v: deal with buggy TLB flush requests
 from WS2012
Message-ID: <20190418165611.GD17218@linux.intel.com>
References: <20190320174320.9459-1-vkuznets@redhat.com>
 <20190418141752.GB17218@linux.intel.com>
 <f858f28f-6d22-b53b-9572-5220b9ecf81c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f858f28f-6d22-b53b-9572-5220b9ecf81c@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 06:47:56PM +0200, Paolo Bonzini wrote:
> On 18/04/19 16:17, Sean Christopherson wrote:
> > On Wed, Mar 20, 2019 at 06:43:20PM +0100, Vitaly Kuznetsov wrote:
> >> It was reported that with some special Multi Processor Group configuration,
> >> e.g:
> >>  bcdedit.exe /set groupsize 1
> >>  bcdedit.exe /set maxgroup on
> >>  bcdedit.exe /set groupaware on
> >> for a 16-vCPU guest WS2012 shows BSOD on boot when PV TLB flush mechanism
> >> is in use.
> >>
> >> Tracing kvm_hv_flush_tlb immediately reveals the issue:
> >>
> >>  kvm_hv_flush_tlb: processor_mask 0x0 address_space 0x0 flags 0x2
> >>
> >> The only flag set in this request is HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES,
> >> however, processor_mask is 0x0 and no HV_FLUSH_ALL_PROCESSORS is specified.
> >> We don't flush anything and apparently it's not what Windows expects.
> >>
> >> TLFS doesn't say anything about such requests and newer Windows versions
> >> seem to be unaffected. This all feels like a WS2012 bug, which is, however,
> >> easy to workaround in KVM: let's flush everything when we see an empty
> >> flush request, over-flushing doesn't hurt.
> >>
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> ---
> >>  arch/x86/kvm/hyperv.c | 12 +++++++++++-
> >>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> >> index 421899f6ad7b..5887f7d22ac6 100644
> >> --- a/arch/x86/kvm/hyperv.c
> >> +++ b/arch/x86/kvm/hyperv.c
> >> @@ -1371,7 +1371,17 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
> >>  
> >>  		valid_bank_mask = BIT_ULL(0);
> >>  		sparse_banks[0] = flush.processor_mask;
> >> -		all_cpus = flush.flags & HV_FLUSH_ALL_PROCESSORS;
> >> +
> >> +		/*
> >> +		 * WS2012 seems to be buggy, under certain conditions it is
> >> +		 * possible to observe requests with processor_mask = 0x0 and
> >> +		 * no HV_FLUSH_ALL_PROCESSORS flag set. It also seems that
> > 
> > "and no HV_FLUSH_ALL_PROCESSORS flag set" is awkward, and probably
> > extraneous.  The whole comment is a probably a bit more verbose than it
> > needs to be, e.g. most readers won't care how we came to the conclusion
> > that 'processor_mask == 0', and those that care about the background will
> > read the changelog anyways.
> > 
> > Maybe something like this:
> > 
> > 		/*
> > 		 * Some Windows versions, e.g. WS2012, use processor_mask = 0
> > 		 * in lieu of the dedicated flag to flush all processors.
> > 		 */
> 
> Hmm, not really.  "In lieu" seems intentional.  "without" is more accurate.

True, probably isn't exactly by design.

> My take:
> 
>                  * Work around possible WS2012 bug: it sends hypercalls
>                  * with processor_mask = 0x0 and HV_FLUSH_ALL_PROCESSORS clear,
>                  * while also expecting us to flush something and crashing if
>                  * we don't. Let's treat processor_mask == 0 same as
>                  * HV_FLUSH_ALL_PROCESSORS.

Nice.  What about this for the last sentence?  Either way, LGTM.

  For simplicity, flush all CPUs if the guest neglected to set processor_mask.

>                  */
> 
> Paolo
> 
> 
> > 
> > 
> >> +		 * Windows actually expects us to flush something and crashes
> >> +		 * otherwise. Let's treat processor_mask == 0 same as
> >> +		 * HV_FLUSH_ALL_PROCESSORS.
> >> +		 */
> >> +		all_cpus = (flush.flags & HV_FLUSH_ALL_PROCESSORS) ||
> >> +			(flush.processor_mask == 0);
> > 
> > Nits:
> > 
> > Personal preference, but I like '!flush.processor_mask' in this case as it
> > immediately conveys that we're handling the scenario where the guest didn't
> > set a mask.  Then there wouldn't be a visual need for the second set of
> > parentheses.
> > 
> > Aligning its indentation with the first first chunk of the statement would
> > also be nice, but again, personal preference.  :-)
> > 
> >>  	} else {
> >>  		if (unlikely(kvm_read_guest(kvm, ingpa, &flush_ex,
> >>  					    sizeof(flush_ex))))
> >> -- 
> >> 2.20.1
> >>
> 
