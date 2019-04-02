Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E269DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFB12084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfDBUKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:10:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:54075 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfDBUKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:10:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 13:10:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,301,1549958400"; 
   d="scan'208";a="158136472"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2019 13:10:18 -0700
Date:   Tue, 2 Apr 2019 13:10:18 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
        rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, yu-cheng.yu@intel.com
Subject: Re: [RFC PATCH v4 0/8] This patch-set is to enable Guest CET support
Message-ID: <20190402201017.GF31303@linux.intel.com>
References: <20190318150351.15550-1-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318150351.15550-1-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:03:43PM +0800, Yang Weijiang wrote:
> Control-flow Enforcement Technology (CET) provides protection against
> return/jump-oriented programming (ROP) attacks. To make kvm Guest OS own
> the capability, this patch-set is required. It enables CET related CPUID
> report, xsaves/xrstors, vmx entry configuration etc. for Guest OS.

...

> Yang Weijiang (7):
>   KVM:VMX: Define CET VMCS fields and bits
>   KVM:CPUID: Add CET CPUID support for Guest
>   KVM:CPUID: Fix xsaves area size calculation for CPUID.(EAX=0xD,ECX=1).

I like the earnestness of scoping to CPUID, but "KVM: x86:" is sufficient
and more correct, e.g. ARM has CPUID as well and most architectures have
an equivalent.

>   KVM:VMX: Pass through host CET related MSRs to Guest.
>   KVM:VMX: Load Guest CET via VMCS when CET is enabled in Guest
>   KVM:x86: Allow Guest to set supported bits in XSS
>   KVM:x86: Add user-space read/write interface for CET MSRs

Please add spaces between KVM: and the more specific scope.

> 
>  arch/x86/include/asm/kvm_host.h  |  5 +-
>  arch/x86/include/asm/msr-index.h |  2 +
>  arch/x86/include/asm/vmx.h       |  8 +++
>  arch/x86/kvm/cpuid.c             | 53 ++++++++++++++------
>  arch/x86/kvm/vmx.c               | 86 ++++++++++++++++++++++++++++++--

Please rebase to the latest KVM for the next version, this is getting
fairly stale.  Thanks!

>  arch/x86/kvm/x86.c               | 32 +++++++++++-
>  arch/x86/kvm/x86.h               |  4 ++
>  7 files changed, 167 insertions(+), 23 deletions(-)
> 
> -- 
> 2.17.1
> 
