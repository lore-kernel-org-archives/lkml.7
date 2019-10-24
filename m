Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B61FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6942A20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408656AbfJXHkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:40:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:59750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727635AbfJXHkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:40:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44E04AF6A;
        Thu, 24 Oct 2019 07:40:00 +0000 (UTC)
Subject: Ping: [PATCH] x86/stackframe/32: repair 32-bit Xen PV
From:   Jan Beulich <jbeulich@suse.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <ef1c9381-dfc7-7150-feca-581f4d798513@suse.com>
Message-ID: <279e6368-7446-9419-fef9-c4069b6aee5a@suse.com>
Date:   Thu, 24 Oct 2019 09:40:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ef1c9381-dfc7-7150-feca-581f4d798513@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.10.2019 12:41, Jan Beulich wrote:
> Once again RPL checks have been introduced which don't account for a
> 32-bit kernel living in ring 1 when running in a PV Xen domain. The
> case in FIXUP_FRAME has been preventing boot; adjust BUG_IF_WRONG_CR3
> as well just in case.
> 
> Fixes: 3c88c692c287 ("x86/stackframe/32: Provide consistent pt_regs")
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Ping?

I'd like to further note that there appears to a likely related
2nd problem - I'm seeing seemingly random attempts to enter VM86
mode when running PV under Xen. I suspect a never written eflags
value to get inspected. While the issue here kills the kernel
reliably during boot, that other issue sometimes allows the
system to at least come up in a partly functional way (depending
on which user processes get killed because of there not being
any VM86 mode available when running PV under [64-bit] Xen).

Jan

> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -48,6 +48,17 @@
>  
>  #include "calling.h"
>  
> +#ifndef CONFIG_XEN_PV
> +# define USER_SEGMENT_RPL_MASK SEGMENT_RPL_MASK
> +#else
> +/*
> + * When running paravirtualized on Xen the kernel runs in ring 1, and hence
> + * simple mask based tests (i.e. ones not comparing against USER_RPL) have to
> + * ignore bit 0. See also the C-level get_kernel_rpl().
> + */
> +# define USER_SEGMENT_RPL_MASK (SEGMENT_RPL_MASK & ~1)
> +#endif
> +
>  	.section .entry.text, "ax"
>  
>  /*
> @@ -172,7 +183,7 @@
>  	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
>  	.if \no_user_check == 0
>  	/* coming from usermode? */
> -	testl	$SEGMENT_RPL_MASK, PT_CS(%esp)
> +	testl	$USER_SEGMENT_RPL_MASK, PT_CS(%esp)
>  	jz	.Lend_\@
>  	.endif
>  	/* On user-cr3? */
> @@ -217,7 +228,7 @@
>  	testl	$X86_EFLAGS_VM, 4*4(%esp)
>  	jnz	.Lfrom_usermode_no_fixup_\@
>  #endif
> -	testl	$SEGMENT_RPL_MASK, 3*4(%esp)
> +	testl	$USER_SEGMENT_RPL_MASK, 3*4(%esp)
>  	jnz	.Lfrom_usermode_no_fixup_\@
>  
>  	orl	$CS_FROM_KERNEL, 3*4(%esp)
> 

