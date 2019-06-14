Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1614BC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E252321537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfFNO6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:58:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38411 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfFNO6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:58:21 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbnei-0000Nt-C5; Fri, 14 Jun 2019 16:58:16 +0200
Date:   Fri, 14 Jun 2019 16:58:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kees Cook <keescook@chromium.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/asm: Pin sensitive CR0 bits
In-Reply-To: <20190604234422.29391-3-keescook@chromium.org>
Message-ID: <alpine.DEB.2.21.1906141657470.1722@nanos.tec.linutronix.de>
References: <20190604234422.29391-1-keescook@chromium.org> <20190604234422.29391-3-keescook@chromium.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019, Kees Cook wrote:

> With sensitive CR4 bits pinned now, it's possible that the WP bit for
> CR0 might become a target as well. Following the same reasoning for
> the CR4 pinning, this pins CR0's WP bit (but this can be done with a
> static value).
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/include/asm/special_insns.h | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 284a77d52fea..9c9fd3760079 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -31,7 +31,22 @@ static inline unsigned long native_read_cr0(void)
>  
>  static inline void native_write_cr0(unsigned long val)
>  {
> -	asm volatile("mov %0,%%cr0": : "r" (val), "m" (__force_order));
> +	unsigned long bits_missing = 0;
> +
> +set_register:
> +	if (static_branch_likely(&cr_pinning))
> +		val |= X86_CR0_WP;
> +
> +	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
> +
> +	if (static_branch_likely(&cr_pinning)) {
> +		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
> +			bits_missing = X86_CR0_WP;
> +			goto set_register;

Same comment as for the cr4 variant.

Thanks,

	tglx
