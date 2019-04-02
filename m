Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE71C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EBF2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfDBT5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:57:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:30463 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfDBT5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:57:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 12:57:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,301,1549958400"; 
   d="scan'208";a="219937579"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga001.jf.intel.com with ESMTP; 02 Apr 2019 12:57:12 -0700
Date:   Tue, 2 Apr 2019 12:57:12 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
        rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, yu-cheng.yu@intel.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [RFC PATCH v4 1/8] KVM:VMX: Define CET VMCS fields and bits
Message-ID: <20190402195712.GE31303@linux.intel.com>
References: <20190318150351.15550-1-weijiang.yang@intel.com>
 <20190318150351.15550-2-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318150351.15550-2-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:03:44PM +0800, Yang Weijiang wrote:
> CET - Control-flow Enforcement Technology, it's used to
> protect against return/jump oriented programming (ROP)
> attacks. It provides the following capabilities to defend
> against ROP/JOP style control-flow subversion attacks:
> - Shadow Stack (SHSTK):
>                  A second stack for the program that is
>                  used exclusively for control transfer
>                  operations.
> - Indirect Branch Tracking (IBT):
>                  Free branch protection to defend against
>                  Jump/Call Oriented Programming.
> 
> On processors that support CET, VMX saves/restores
> the states of IA32_S_CET, SSP and IA32_INTR_SSP_TABL_ADDR MSR
                                                  ^^^^
Please spell out "table" in full, here and below.

> to the VMCS area for Guest/Host unconditionally.
> 
> If VM_EXIT_LOAD_HOST_CET_STATE = 1, the host CET MSRs are
> restored from VMCS host-state area at VM exit as follows:

This contradicts the above statement that "VMX saves/restores ...
IA32_S_CET, SSP and IA32_INTR_SSP_TABL_ADDR MSR" unconditionally.

> 
> - HOST_S_CET: Host supervisor mode IA32_S_CET MSR is loaded
>                    from this field.

Maybe provide a brief introduction on the MSRs instead of mixing that
in with the VMCS field definition?  "Host supervisor mode IA32_S_CET"
makes it sound as if the MSR only exists at cpl=0 or something.

> 
> - HOST_SSP : Host SSP is loaded from this field.
> 
> - HOST_INTR_SSP_TABLE : Host IA32_INTR_SSP_TABL_ADDR
                                             ^^^^
>                              MSR is loaded from this field.
> 
> If VM_ENTRY_LOAD_GUEST_CET_STATE = 1, the guest CET MSRs are loaded
> from VMCS guest-state area at VM entry as follows:
> 
> - GUEST_S_CET : Guest supervisor mode IA32_S_CET MSR is loaded
>                      from this field.
> 
> - GUEST_SSP :        Guest SSP is loaded from this field.
> 
> - GUEST_INTR_SSP_TABLE : Guest IA32_INTR_SSP_TABL_ADDR
                                               ^^^^
>                              MSR is loaded from this field.

You can probably drop the per-field descriptions, the intro regarding
VM_EXIT_LOAD_{HOST,GUEST}_CET_STATE should make it obvious to readers
that these fields contain host/guest values, and the names line up with
the MSRs (assuming you add a brief intro on the MSRs).  E.g.:

If VM_EXIT_LOAD_HOST_CET_STATE = 1, the host's CET MSRs are restored
from the following VMCS fields at VM-Exit:

 - HOST_S_CET
 - HOST_SSP
 - HOST_INTR_SSP_TABLE

> 
> Additionally, to context switch guest and host CET states, the VMM
> uses xsaves/xrstors instructions to save/restore the guest CET states
> at VM exit/entry. The CET xsave area is within thread_struct.fpu area.
> If OS execution flow changes during task switch/interrupt/exception etc.,
> the OS also relies on xsaves/xrstors to switch CET states accordingly.
> 
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>

Assuming you both worked on these patches, a Co-developed-by: tag is
needed for Zhang Yi.  The current docs on Co-developed-by: are a bit
sparse, linux-next has a patch with more information on its usage[1].

https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/24a2bb90741bf86ddcf6558be419e182ff44fc95

> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/vmx.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index ade0f153947d..fd70c4577c5a 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -98,6 +98,7 @@
>  #define VM_EXIT_LOAD_IA32_EFER                  0x00200000
>  #define VM_EXIT_SAVE_VMX_PREEMPTION_TIMER       0x00400000
>  #define VM_EXIT_CLEAR_BNDCFGS                   0x00800000
> +#define VM_EXIT_LOAD_HOST_CET_STATE             0x10000000
>  
>  #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
>  
> @@ -109,6 +110,7 @@
>  #define VM_ENTRY_LOAD_IA32_PAT			0x00004000
>  #define VM_ENTRY_LOAD_IA32_EFER                 0x00008000
>  #define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
> +#define VM_ENTRY_LOAD_GUEST_CET_STATE           0x00100000
>  
>  #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR	0x000011ff
>  
> @@ -325,6 +327,9 @@ enum vmcs_field {
>  	GUEST_PENDING_DBG_EXCEPTIONS    = 0x00006822,
>  	GUEST_SYSENTER_ESP              = 0x00006824,
>  	GUEST_SYSENTER_EIP              = 0x00006826,
> +	GUEST_S_CET                     = 0x00006828,
> +	GUEST_SSP                       = 0x0000682a,
> +	GUEST_INTR_SSP_TABLE            = 0x0000682c,
>  	HOST_CR0                        = 0x00006c00,
>  	HOST_CR3                        = 0x00006c02,
>  	HOST_CR4                        = 0x00006c04,
> @@ -337,6 +342,9 @@ enum vmcs_field {
>  	HOST_IA32_SYSENTER_EIP          = 0x00006c12,
>  	HOST_RSP                        = 0x00006c14,
>  	HOST_RIP                        = 0x00006c16,
> +	HOST_S_CET                      = 0x00006c18,
> +	HOST_SSP                        = 0x00006c1a,
> +	HOST_INTR_SSP_TABLE             = 0x00006c1c
>  };
>  
>  /*
> -- 
> 2.17.1
> 
