Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07345C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E332070B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfHTLQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:16:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51640 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbfHTLQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:16:51 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0282-00032z-Rg; Tue, 20 Aug 2019 13:16:42 +0200
Date:   Tue, 20 Aug 2019 13:16:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com, stable@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/mm/pti: in pti_clone_pgtable() don't increase addr
 by PUD_SIZE
In-Reply-To: <20190820100055.GI2332@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1908201315450.2223@nanos.tec.linutronix.de>
References: <20190820075128.2912224-1-songliubraving@fb.com> <20190820100055.GI2332@hirez.programming.kicks-ass.net>
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

On Tue, 20 Aug 2019, Peter Zijlstra wrote:
> What that code wants to do is skip to the end of the pud, a pmd_size
> increase will not do that. And right below this, there's a second
> instance of this exact pattern.
> 
> Did I get the below right?
> 
> ---
> diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> index b196524759ec..32b20b3cb227 100644
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -330,12 +330,14 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
>  
>  		pud = pud_offset(p4d, addr);
>  		if (pud_none(*pud)) {
> +			addr &= PUD_MASK;
>  			addr += PUD_SIZE;

			round_up(addr, PUD_SIZE);

perhaps?

>  			continue;
>  		}
>  
>  		pmd = pmd_offset(pud, addr);
>  		if (pmd_none(*pmd)) {
> +			addr &= PMD_MASK;
>  			addr += PMD_SIZE;
>  			continue;
>  		}
> 
