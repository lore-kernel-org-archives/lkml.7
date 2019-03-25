Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCEFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0095A20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfCZNvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:51:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:9037 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZNvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:51:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 06:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="332158383"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by fmsmga005.fm.intel.com with ESMTP; 26 Mar 2019 06:51:39 -0700
Date:   Tue, 26 Mar 2019 04:45:34 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
        rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, yu-cheng.yu@intel.com
Subject: Re: [RFC PATCH v4 0/8] This patch-set is to enable Guest CET support
Message-ID: <20190325204533.GA12253@local-michael-cet-test.sh.intel.com>
References: <20190318150351.15550-1-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318150351.15550-1-weijiang.yang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:03:43PM +0800, Yang Weijiang wrote:
> Control-flow Enforcement Technology (CET) provides protection against
> return/jump-oriented programming (ROP) attacks. To make kvm Guest OS own
> the capability, this patch-set is required. It enables CET related CPUID
> report, xsaves/xrstors, vmx entry configuration etc. for Guest OS.
> 
> PATCH 1    : Define CET VMCS fields and bits.
> PATCH 2/3  : Report CET feature support in CPUID.
> PATCH 4    : Fix xsaves size calculation issue.
> PATCH 5    : Pass through CET MSRs to Guest.
> PATCH 6    : Set Guest CET state auto loading bit.
> PATCH 7    : Load Guest fpu state when accessing CET XSAVES managed MSRs.
> PATCH 8    : Add CET MSR user space access interface.
> 
> Changelog:
> 
>  v4:
>  - Add Sean's patch for loading Guest fpu state before access XSAVES
>    managed CET MSRs.
>  - Melt down CET bits setting into CPUID configuration patch.
>  - Add VMX interface to query Host XSS.
>  - Check Host and Guest XSS support bits before set Guest XSS.
>  - Make Guest SHSTK and IBT feature enabling independent.
>  - Do not report CET support to Guest when Host CET feature is
>    Disabled.
> 
>  v3:
>  - Modified patches to make Guest CET independent to Host enabling.
>  - Added patch 8 to add user space access for Guest CET MSR access.
>  - Modified code comments and patch description to reflect changes.
> 
>  v2:
>  - Re-ordered patch sequence, combined one patch.
>  - Added more description for CET related VMCS fields.
>  - Added Host CET capability check while enabling Guest CET loading bit.
>  - Added Host CET capability check while reporting Guest CPUID(EAX=7,
>    EXC=0).
>  - Modified code in reporting Guest CPUID(EAX=D,ECX>=1), make it clearer.
>  - Added Host and Guest XSS mask check while setting bits for Guest XSS.
> 
> 
> Sean Christopherson (1):
>   KVM:x86: load guest fpu state when accessing MSRs managed by XSAVES
> 
> Yang Weijiang (7):
>   KVM:VMX: Define CET VMCS fields and bits
>   KVM:CPUID: Add CET CPUID support for Guest
>   KVM:CPUID: Fix xsaves area size calculation for CPUID.(EAX=0xD,ECX=1).
>   KVM:VMX: Pass through host CET related MSRs to Guest.
>   KVM:VMX: Load Guest CET via VMCS when CET is enabled in Guest
>   KVM:x86: Allow Guest to set supported bits in XSS
>   KVM:x86: Add user-space read/write interface for CET MSRs
> 
>  arch/x86/include/asm/kvm_host.h  |  5 +-
>  arch/x86/include/asm/msr-index.h |  2 +
>  arch/x86/include/asm/vmx.h       |  8 +++
>  arch/x86/kvm/cpuid.c             | 53 ++++++++++++++------
>  arch/x86/kvm/vmx.c               | 86 ++++++++++++++++++++++++++++++--
>  arch/x86/kvm/x86.c               | 32 +++++++++++-
>  arch/x86/kvm/x86.h               |  4 ++
>  7 files changed, 167 insertions(+), 23 deletions(-)
> 
> -- 
> 2.17.1
Hi, Paolo and Sean,
Do you have any comments on v4 patches?
