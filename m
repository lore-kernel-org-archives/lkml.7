Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A940C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91F021655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfKKXcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:32:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60238 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKXcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:32:36 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUJAK-0001cf-3j; Tue, 12 Nov 2019 00:32:13 +0100
Date:   Tue, 12 Nov 2019 00:32:11 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     zhong jiang <zhongjiang@huawei.com>
cc:     dave.hansen@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, luto@kernel.org, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] x86/mm: Mask out unsupported bit when it set
 noexec=off
In-Reply-To: <1573465994-33249-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <alpine.DEB.2.21.1911120012200.1833@nanos.tec.linutronix.de>
References: <1573465994-33249-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhong,

On Mon, 11 Nov 2019, zhong jiang wrote:

> Commit 510bb96fe5b3 ("x86/mm: Prevent bogus warnings with "noexec=off"")
> use  __supported_pte_mask to replace __default_kernel_pte_mask to mask
> out the unsupported bits. It works when the command line set noexec=off.
> 
> It also seems to works to use __supported_pte_mask instead in native_set_fixmap.

"Seems to work" is really not a good engineering principle and neither a
good rationale WHY this change is correct, which it is not.

> @@ -647,7 +647,7 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
>  		       phys_addr_t phys, pgprot_t flags)
>  {
>  	/* Sanitize 'prot' against any unsupported bits: */
> -	pgprot_val(flags) &= __default_kernel_pte_mask;
> +	pgprot_val(flags) &= __supported_pte_mask;
>  
>  	__native_set_fixmap(idx, pfn_pte(phys >> PAGE_SHIFT, flags));
>  }

The commit you mentioned switched __early_set_fixmap() to
__supported_pte_mask because __default_kernel_pte_mask is not yet set up at
that point which caused the following warning:

     attempted to set unsupported pgprot:    8000000000000163
                                  bits:      8000000000000000
                                  supported: 7fffffffffffffff

At this point __default_kernel_pte_mask is still compile time initialized
to ~0UL, i.e. all bits set which allows the NX bit to be set, but it's not
supported according to __supported_pte_mask.

Once __default_kernel_pte_mask is properly runtime initialized to:

     __default_kernel_pte_mask = __supported_pte_mask;

in probe_page_size_mask() there is no reason that subsequent code uses
__supported_pte_mask.

In fact that's just wrong because __default_kernel_pte_mask can have extra
bits cleared during runtime initialization, e.g.:

        /* Except when with PTI where the kernel is mostly non-Global: */
        if (cpu_feature_enabled(X86_FEATURE_PTI))
                __default_kernel_pte_mask &= ~_PAGE_GLOBAL;

So your change "works", but subtly breaks PTI protections.

Please be more careful next time and really analyse why your change is
correct and provide this analysis in the changelog.

Thanks,

	tglx
