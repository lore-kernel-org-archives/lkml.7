Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD577C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83488206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfCEDQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:16:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:12474 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfCEDQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:16:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 19:16:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,442,1544515200"; 
   d="scan'208";a="159763741"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by orsmga001.jf.intel.com with ESMTP; 04 Mar 2019 19:16:56 -0800
Date:   Mon, 4 Mar 2019 18:11:26 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>,
        weijiang.yang@intel.com
Subject: Re: [PATCH v3 3/8] KVM:CPUID: Add CPUID support for Guest CET
Message-ID: <20190304101126.GA3700@local-michael-cet-test.sh.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-4-weijiang.yang@intel.com>
 <20190304184753.GD17120@linux.intel.com>
 <20190304185429.GF17120@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304185429.GF17120@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 10:54:29AM -0800, Sean Christopherson wrote:
> On Mon, Mar 04, 2019 at 10:47:53AM -0800, Sean Christopherson wrote:
> > On Mon, Feb 25, 2019 at 09:27:11PM +0800, Yang Weijiang wrote:
> > > Guest CET SHSTK and IBT capability are reported via
> > > CPUID.(EAX=7, ECX=0):ECX[bit 7] and EDX[bit 20] respectively.
> > > Guest user mode and supervisor mode xsaves component size
> > > is reported via CPUID.(EAX=0xD, ECX=1):ECX[bit 11] and ECX[bit 12]
> > > respectively.
> > > 
> > > Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > ---
> > >  arch/x86/kvm/cpuid.c | 60 +++++++++++++++++++++++++++++++++-----------
> > >  arch/x86/kvm/x86.h   |  4 +++
> > >  2 files changed, 50 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > > index cb1aece25b17..5e05756cc6db 100644
> > > --- a/arch/x86/kvm/cpuid.c
> > > +++ b/arch/x86/kvm/cpuid.c
> > > @@ -65,6 +65,16 @@ u64 kvm_supported_xcr0(void)
> > >  	return xcr0;
> > >  }
> > >  
> > > +u64 kvm_supported_xss(void)
> > > +{
> > > +	u64 xss;
> > > +
> > > +	rdmsrl(MSR_IA32_XSS, xss);
> > 
> > Honest question as I haven't thought through the flows: do we actually
> > need to restrict XSS based on what's enabled in the host?  This
> > conflicts with your other statements that CET features can be enabled
> > independent of host support.
> 
> Never mind, just saw Paolo's comment in a previous version about XSAVE
> being dependent on host XSS.  The below comment about caching still
> applies though.
>
In my WIP work, I use existing host_xss in vmx.c instead of reading MSR here to
incoperate host status.

> > And if we do incorporate the host status, the value should be read once
> > and cached unless we're expecting the host value to change dynamically,
> > e.g. see host_efer.
> > 
> > > +	xss &= KVM_SUPPORTED_XSS;
> > > +	return xss;
> > > +}
> > > +EXPORT_SYMBOL(kvm_supported_xss);
> > > +
> > >  #define F(x) bit(X86_FEATURE_##x)
> > >  
> > >  /* For scattered features from cpufeatures.h; we currently expose none */
