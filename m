Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F30FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2D12183F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfCMHf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 03:35:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:46083 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfCMHf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 03:35:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 00:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="126505757"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2019 00:35:52 -0700
Date:   Tue, 12 Mar 2019 22:30:10 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>,
        weijiang.yang@intel.com
Subject: Re: [PATCH v3 7/8] KVM:X86: Add XSS bit 11 and 12 support for CET
 xsaves/xrstors.
Message-ID: <20190312143010.GA13287@local-michael-cet-test.sh.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-8-weijiang.yang@intel.com>
 <20190228162512.GG6166@linux.intel.com>
 <20190228084404.GD12006@local-michael-cet-test.sh.intel.com>
 <f1b0c3ab-a377-d998-34d3-67c5e951f4e1@redhat.com>
 <20190310122030.GB24065@local-michael-cet-test.sh.intel.com>
 <20190310133528.GA24796@local-michael-cet-test.sh.intel.com>
 <b7ba969a-b050-d55c-4e94-0ce998a46cdf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7ba969a-b050-d55c-4e94-0ce998a46cdf@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 04:32:32PM +0100, Paolo Bonzini wrote:
> On 10/03/19 14:35, Yang Weijiang wrote:
> >>>> -		if (data != 0)
> >>>> +		if (data & ~kvm_supported_xss())
> >>>>  			return 1;
> >>> You should instead check this against CPUID[0xD, 1].EDX:ECX.  If CET is
> >>> disabled in CPUID, the guest should not be able to set it in MSR_IA32_CSS.
> >>>
> >>> Paolo
> >> Thanks, OK, will change it.
> > Hi, Paolo,
> > How about change kvm_supported_xss() as below so that CPUID[0xd,1] check
> > is implied in host_xss contents, vmx_supported_xss() now just returns host_xss
> > in vmx.c. The purpose of this change is to make XSS data check
> > common for other XSS based features.
> > 
> > +u64 kvm_supported_xss(void)
> > +{
> > +       return KVM_SUPPORTED_XSS & kvm_x86_ops->vmx_supported_xss();
> > +}
> > +
> > 
> 
> This is correct; however, you should also check against the *guest*'s
> CPUID[0xD, 1].EDX:ECX.
> 
> One possibility is to add a field kvm->guest_supported_xss and update it
> in kvm_update_cpuid, then here you do
> 
> 	if (data & ~kvm->guest_supported_xss)
> 		return 1;
> 
> Thanks,
> 
> Paolo
Thanks Paolo, I'll add the change in next version.
