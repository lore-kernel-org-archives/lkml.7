Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729DDC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB6120880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfDHQzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:55:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:54764 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfDHQzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:55:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 09:55:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="162465007"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2019 09:55:52 -0700
Date:   Mon, 8 Apr 2019 09:55:51 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: fix warning Using plain integer as NULL pointer
Message-ID: <20190408165551.GD25880@linux.intel.com>
References: <20190406093658.GA7438@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190406093658.GA7438@hari-Inspiron-1545>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nit: For future reference, wrapping the warning text with quotes in the
     shortlog would be helpful.  I initially read it as "fix a warning by
     using a plain integer as a NULL pointer".  E.g.:

     KVM: x86: fix warning "Using plain integer as NULL pointer"

On Sat, Apr 06, 2019 at 03:06:58PM +0530, Hariprasad Kelam wrote:
> Changed passing argument as "0 to NULL" which resolves below sparse warning

Nit: Use imperative mood to state what the patch does, as opposed to
     talking about the change in the past tense.  That allows using past
     tense to describe things that actually did happen in the past.  E.g.:

     Pass "NULL" instead of "0" for a pointer argument when querying
     KVM_CAP_NESTED_STATE to resolve the below sparse warning:

> 
> arch/x86/kvm/x86.c:3096:61: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Thanks for the fix!

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 099b851..39034ec 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3093,7 +3093,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  		break;
>  	case KVM_CAP_NESTED_STATE:
>  		r = kvm_x86_ops->get_nested_state ?
> -			kvm_x86_ops->get_nested_state(NULL, 0, 0) : 0;
> +			kvm_x86_ops->get_nested_state(NULL, NULL, 0) : 0;
>  		break;
>  	default:
>  		break;
> -- 
> 2.7.4
> 
