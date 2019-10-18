Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2CDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F173E222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439901AbfJRQd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:33:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:14218 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405782AbfJRQd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:33:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 09:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,312,1566889200"; 
   d="scan'208";a="199757212"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga003.jf.intel.com with ESMTP; 18 Oct 2019 09:33:11 -0700
Date:   Fri, 18 Oct 2019 09:33:10 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux@googlegroups.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/2] x86/cpu/vmware: Use the full form of INL in
 VMWARE_HYPERCALL
Message-ID: <20191018163310.GB26319@linux.intel.com>
References: <20191018134052.3023-1-thomas_os@shipmail.org>
 <20191018134052.3023-2-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018134052.3023-2-thomas_os@shipmail.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 03:40:51PM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> LLVM's assembler doesn't accept the short form INL instruction:
> 
>   inl (%%dx)
> 
> but instead insists on the output register to be explicitly specified.
> 
> This was previously fixed for the VMWARE_PORT macro. Fix it also for
> the VMWARE_HYPERCALL macro.
> 
> Fixes: b4dd4f6e3648 ("Add a header file for hypercall definitions")
> Suggested-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Cc: clang-built-linux@googlegroups.com
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86-ml <x86@kernel.org>
> Cc: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/vmware.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
> index e00c9e875933..f5fbe3778aef 100644
> --- a/arch/x86/include/asm/vmware.h
> +++ b/arch/x86/include/asm/vmware.h
> @@ -29,7 +29,8 @@
>  
>  /* The low bandwidth call. The low word of edx is presumed clear. */
>  #define VMWARE_HYPERCALL						\
> -	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT ", %%dx; inl (%%dx)", \
> +	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT			\
> +		      ", %%dx; inl (%%dx), %%eax",			\

Why wrap in the middle of movw?  Wrapping between instructions or letting
the line poke out is more readable IMO, e.g.

	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT ", %%dx; "	\
		      "inl (%%dx), %%eax",				\

or

	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT ", %%dx; inl (%%dx), %%eax", \

>  		      "vmcall", X86_FEATURE_VMCALL,			\
>  		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
>  
> -- 
> 2.21.0
> 
