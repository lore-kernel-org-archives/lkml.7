Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D52C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFB8218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556176039;
	bh=clXOPulsGsq7yugiG2SOZwcF7tC+sDSnPz9wU3akTxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dP0NguwjkduOB7Fd40Ah/pAEOLsg+jHADTP1t6qIU94oLB6K59Y+gLjjejIlbYwQX
	 OFiif1+aEaUir/aAvgl605Brd47HdV0In4SNECdYPgAcNnIxKN6VO98n6aruFF79qg
	 VFRbScW4zFuYN51Vf06uUefAMIbsHgYTqdFHz338=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388943AbfDYHHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:07:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36170 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388847AbfDYHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:07:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id b1so17379003wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 00:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zlv0/XFgcNR3wgBaFoDB30QJMdFwjhVp47g/tZDSg5M=;
        b=G3J5Y0gk5MmdRKkrmXoZK3Konx19l+YRESEhqmJXnSpz9sG2kM6PsI/WsurVsizWSF
         7MaMj8iSl4sOmoPdwB6oNVsf2fe39y8GGH6HiWiXbuEVWg7q+eK6mchKhHfCBkdOQ94i
         9veMNbVBXa+35MkR18nTL99QAOtEwgTmBxcJAuM/rfJ/ga0vHjwOKVc2u4f4L1E43pRc
         ncHsSRRWmu5PWpRvF6Jz3iuqoDOLE//D/9/chFOCymCc41NEwyxNBSc4ps9o920KJeSm
         gX4vVKO/ylY0rFYPcQS2N/i1hCVFg8KlG5R4AGFWr5Ef0PQbTPsnovAXxcZmXqKfkaqp
         lHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zlv0/XFgcNR3wgBaFoDB30QJMdFwjhVp47g/tZDSg5M=;
        b=Ouy+JN+P5ck+wKp9VhFNnHXTTHK8BE6McuT2NGUpPIe2IdE9+/YQebXx3o02bNQL2W
         PGYlZ/xgqEWTGOtfWKw8hUpS2Sj504VamYwju2DdZuwIoDgHYizPla5JjkHxspmKpWiX
         5b7U3dUiVvfcQgxUNcdIO/IjH+1QAjLKQS9kDHUApRdxAGxaP6mCJ/Kn4MaqM28z3o/w
         80+LN7KjRNIkEzY2z4SK/EMiqoK/KKTJxQyCkZtZMDlQjgh4YdMF5poFRref/DJr4G3D
         M2ac3frBB96bv2ewkk7X/xRhKZKd/hi2QYk0iHHekfZQQRk4dKfEmau8/Lu2xu5Y2qzx
         llAw==
X-Gm-Message-State: APjAAAWcIENQmxaiOD6FgDM+DIkTtHHsGy5T5pFw429d0D5NTnDO3V63
        wZdrey9k/ylw5yZ+tKVhInc=
X-Google-Smtp-Source: APXvYqy6MMNwBJt3nHW4ag3in05NjOyDtBZvQHOe83q7abZZimw/DkeBlu4Ay+7zVb+KtIVMu7wWuQ==
X-Received: by 2002:a5d:4acc:: with SMTP id y12mr3940992wrs.234.1556176035985;
        Thu, 25 Apr 2019 00:07:15 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c63sm4316836wma.29.2019.04.25.00.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 00:07:15 -0700 (PDT)
Date:   Thu, 25 Apr 2019 09:07:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        bp@alien8.de, Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v5 4/4] x86/acrn: Add hypercall for ACRN guest
Message-ID: <20190425070712.GA57256@gmail.com>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-5-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556067260-9128-5-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhao Yakui <yakui.zhao@intel.com> wrote:

> When ACRN hypervisor is detected, the hypercall is needed so that the
> ACRN guest can query/config some settings. For example: it can be used
> to query the resources in hypervisor and manage the CPU/memory/device/
> interrupt for the guest operating system.
> 
> So add the hypercall so that ACRN guest can communicate with the
> low-level ACRN hypervisor. It is implemented with the VMCALL instruction.
> 
> Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
> V1->V2: Refine the comments for the function of acrn_hypercall0/1/2
> v2->v3: Use the "vmcall" mnemonic to replace hard-code byte definition
> v4->v5: Use _ASM_X86_ACRN_HYPERCALL_H instead of _ASM_X86_ACRNHYPERCALL_H to
> align the header file of acrn_hypercall.h
>         Use the "VMCALL" mnemonic in comment/commit log.
>         Uppercase r8/rdi/rsi/rax for hypercall parameter registers in comment.
> ---
>  arch/x86/include/asm/acrn_hypercall.h | 82 +++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 arch/x86/include/asm/acrn_hypercall.h
> 
> diff --git a/arch/x86/include/asm/acrn_hypercall.h b/arch/x86/include/asm/acrn_hypercall.h
> new file mode 100644
> index 0000000..3594436
> --- /dev/null
> +++ b/arch/x86/include/asm/acrn_hypercall.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_X86_ACRN_HYPERCALL_H
> +#define _ASM_X86_ACRN_HYPERCALL_H


> +
> +#include <linux/errno.h>
> +
> +#ifdef CONFIG_ACRN_GUEST
> +
> +/*
> + * Hypercalls for ACRN guest
> + *
> + * Hypercall number is passed in R8 register.
> + * Up to 2 arguments are passed in RDI, RSI.
> + * Return value will be placed in RAX.
> + */
> +
> +static inline long acrn_hypercall0(unsigned long hcall_id)
> +{
> +	register unsigned long r8 asm("r8") = hcall_id;
> +	register long result asm("rax");
> +
> +	/* the hypercall is implemented with the VMCALL instruction.
> +	 * asm indicates that inline assembler instruction is used.
> +	 * volatile qualifier is added to avoid that it is dropped
> +	 * because of compiler optimization.
> +	 */

Non-standard comment style.

asm statements are volatile by default I believe.

I.e. the second and third sentences are partly obvious, superfluous and 
bogus.

> +	asm volatile("vmcall"
> +			: "=r"(result)
> +			: "r"(r8));
> +
> +	return result;
> +}
> +
> +static inline long acrn_hypercall1(unsigned long hcall_id,
> +				   unsigned long param1)
> +{
> +	register unsigned long r8 asm("r8") = hcall_id;
> +	register long result asm("rax");
> +
> +	asm volatile("vmcall"
> +			: "=r"(result)
> +			: "D"(param1), "r"(r8));

Why are register variables used? Doesn't GCC figure it out correctly by 
default?

> +static inline long acrn_hypercall2(unsigned long hcall_id,
> +				   unsigned long param1,
> +				   unsigned long param2)
> +{
> +	register unsigned long r8 asm("r8") = hcall_id;
> +	register long result asm("rax");
> +
> +	asm volatile("vmcall"
> +			: "=r"(result)
> +			: "D"(param1), "S"(param2), "r"(r8));

Ditto.

Thanks,

	Ingo
