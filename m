Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF72C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76E62173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfFNO5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:57:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38402 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfFNO5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:57:46 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbne4-0000Lp-M4; Fri, 14 Jun 2019 16:57:36 +0200
Date:   Fri, 14 Jun 2019 16:57:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kees Cook <keescook@chromium.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/asm: Pin sensitive CR4 bits
In-Reply-To: <20190604234422.29391-2-keescook@chromium.org>
Message-ID: <alpine.DEB.2.21.1906141646320.1722@nanos.tec.linutronix.de>
References: <20190604234422.29391-1-keescook@chromium.org> <20190604234422.29391-2-keescook@chromium.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019, Kees Cook wrote:
> ---
> v2:
> - move setup until after CPU feature detection and selection.
> - refactor to use static branches to have atomic enabling.
> - only perform the "or" after a failed check.

Maybe I'm missing something, but

>  static inline unsigned long native_read_cr0(void)
>  {
>  	unsigned long val;
> @@ -74,7 +80,23 @@ static inline unsigned long native_read_cr4(void)
>  
>  static inline void native_write_cr4(unsigned long val)
>  {
> -	asm volatile("mov %0,%%cr4": : "r" (val), "m" (__force_order));
> +	unsigned long bits_missing = 0;
> +
> +set_register:
> +	if (static_branch_likely(&cr_pinning))
> +		val |= cr4_pinned_bits;

The or happens before the first write and therefore

> +	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
> +
> +	if (static_branch_likely(&cr_pinning)) {
> +		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {

this path can never be entered when the function is called proper. Sure,
for the attack scenario the jump directly to the mov cr4 instruction is
caught.

Wouldn't it make sense to catch situations where a regular caller provides
@val with pinned bits unset? I.e. move the OR into this code path after
storing bits_missing.

> +			bits_missing = ~val & cr4_pinned_bits;
> +			goto set_register;
> +		}
> +		/* Warn after we've set the missing bits. */
> +		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
> +			  bits_missing);
> +	}
>  }

Something like this:

	unsigned long bits_missing = 0;

again:
	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));

	if (static_branch_likely(&cr_pinning)) {
		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
			bits_missing = ~val & cr4_pinned_bits;
			val |= cr4_pinned_bits;
			goto again;
		}
		/* Warn after we've set the missing bits. */
		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
			  bits_missing);
	}

Thanks,

	tglx
