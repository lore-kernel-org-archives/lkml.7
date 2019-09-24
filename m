Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2762C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 00:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E2E2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 00:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503697AbfIXAq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 20:46:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:37123 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390773AbfIXAq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 20:46:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 17:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,542,1559545200"; 
   d="scan'208";a="195532991"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Sep 2019 17:46:25 -0700
Date:   Mon, 23 Sep 2019 17:46:25 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/17] KVM: retpolines: x86: eliminate retpoline from
 vmx.c exit handlers
Message-ID: <20190924004625.GB13147@linux.intel.com>
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-16-aarcange@redhat.com>
 <87o8zb8ik1.fsf@vitty.brq.redhat.com>
 <7329012d-0b3b-ce86-f58d-3d2d5dc5a790@redhat.com>
 <20190923190514.GB19996@redhat.com>
 <20190923202349.GL18195@linux.intel.com>
 <ccfa85b7-b484-7052-f991-78ad05ce7fe7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccfa85b7-b484-7052-f991-78ad05ce7fe7@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 02:15:39AM +0200, Paolo Bonzini wrote:
> On 23/09/19 22:23, Sean Christopherson wrote:
> >  
> > +int nested_vmx_handle_vmx_instruction(struct kvm_vcpu *vcpu)
> > +{
> > +	switch (to_vmx(vcpu)->exit_reason) {
> > +	case EXIT_REASON_VMCLEAR:
> > +		return handle_vmclear(vcpu);
> > +	case EXIT_REASON_VMLAUNCH:
> > +		return handle_vmlaunch(vcpu);
> > +	case EXIT_REASON_VMPTRLD:
> > +		return handle_vmptrld(vcpu);
> > +	case EXIT_REASON_VMPTRST:
> > +		return handle_vmptrst(vcpu);
> > +	case EXIT_REASON_VMREAD:
> > +		return handle_vmread(vcpu);
> > +	case EXIT_REASON_VMRESUME:
> > +		return handle_vmresume(vcpu);
> > +	case EXIT_REASON_VMWRITE:
> > +		return handle_vmwrite(vcpu);
> > +	case EXIT_REASON_VMOFF:
> > +		return handle_vmoff(vcpu);
> > +	case EXIT_REASON_VMON:
> > +		return handle_vmon(vcpu);
> > +	case EXIT_REASON_INVEPT:
> > +		return handle_invept(vcpu);
> > +	case EXIT_REASON_INVVPID:
> > +		return handle_invvpid(vcpu);
> > +	case EXIT_REASON_VMFUNC:
> > +		return handle_vmfunc(vcpu);
> > +	}
> > +
> 
> Do you really need that?  Why couldn't the handle_* functions simply be
> exported from nested.c to vmx.c?

Nope, just personal preference to keep the nested code as isolated as
possible.  We use a similar approach for vmx_{g,s}et_vmx_msr().

Though if we do want to go this route, it'd be better to simply move
handle_vmx_instruction() to nested.c instead of bouncing through that
and nested_vmx_handle_vmx_instruction().
