Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F81C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4472C2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sZ1zb/0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfH2NBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:01:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH2NBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pHLnDmZD0s6VAxoom9eX3yqZhJzgwbuaLN61HQul4Gw=; b=sZ1zb/0V/xNREYxYGYBd5QwEz
        3kT6f9Uyd+G2C3upWo/X/0zXpOzv31DubPkO3FHOe+6QH00K21V0x7Z9rxh1Ps7DlEPN5x1xYO5ql
        oIyHlq6KYO3McJVcJwYCRZQ6hCK+Xw69Vcy9sXzNPIgfMagVa23yC1+P8R8Xj1oo+qCrRxdGNh9Ac
        oUrZ9QGH0uJFH+VFmAUaIBeKUeyGfbnQcARNXpt0C6DlwMQYajZ8p+oMVe9JHCjims9K8w3LIKf35
        /7Qjpm/OEJSWW3+kBToei20IpPox+xPmv0hWLl9tj5vm+rHPWRKRJVzWQIDTYgEeq+1ufVktwYuaa
        yCmbHisoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3K3V-0007Sz-32; Thu, 29 Aug 2019 13:01:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 16525301167;
        Thu, 29 Aug 2019 15:01:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D21A20C9570C; Thu, 29 Aug 2019 15:01:34 +0200 (CEST)
Date:   Thu, 29 Aug 2019 15:01:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Song Liu <songliubraving@fb.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] x86/mm/cpa: Prevent large page split when ftrace flips
 RW on kernel text
Message-ID: <20190829130134.GS2369@hirez.programming.kicks-ass.net>
References: <20190828142445.454151604@linutronix.de>
 <20190828143123.971884723@linutronix.de>
 <55bb026c-5d54-6ebf-608f-3f376fbec4e5@intel.com>
 <alpine.DEB.2.21.1908281750410.1938@nanos.tec.linutronix.de>
 <309E5006-E869-4761-ADE2-ADB7A1A63FF1@fb.com>
 <alpine.DEB.2.21.1908282029550.1938@nanos.tec.linutronix.de>
 <9B34E971-20ED-4A58-B086-AB94990B5A26@fb.com>
 <alpine.DEB.2.21.1908282355340.1938@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908282355340.1938@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 12:31:34AM +0200, Thomas Gleixner wrote:
>  arch/x86/mm/pageattr.c |   26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -516,7 +516,7 @@ static inline void check_conflict(int wa
>   */
>  static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
>  					  unsigned long pfn, unsigned long npg,
> -					  int warnlvl)
> +					  unsigned long lpsize, int warnlvl)
>  {
>  	pgprotval_t forbidden, res;
>  	unsigned long end;
> @@ -535,9 +535,17 @@ static inline pgprot_t static_protection
>  	check_conflict(warnlvl, prot, res, start, end, pfn, "Text NX");
>  	forbidden = res;
>  
> -	res = protect_kernel_text_ro(start, end);
> -	check_conflict(warnlvl, prot, res, start, end, pfn, "Text RO");
> -	forbidden |= res;
> +	/*
> +	 * Special case to preserve a large page. If the change spawns the
> +	 * full large page mapping then there is no point to split it
> +	 * up. Happens with ftrace and is going to be removed once ftrace
> +	 * switched to text_poke().
> +	 */
> +	if (lpsize != (npg * PAGE_SIZE) || (start & (lpsize - 1))) {
> +		res = protect_kernel_text_ro(start, end);
> +		check_conflict(warnlvl, prot, res, start, end, pfn, "Text RO");
> +		forbidden |= res;
> +	}

Right, so this allows the RW (doesn't enforce RO) and thereby doesn't
force split, when it is a whole large page.

>  
>  	/* Check the PFN directly */
>  	res = protect_pci_bios(pfn, pfn + npg - 1);
> @@ -819,7 +827,7 @@ static int __should_split_large_page(pte
>  	 * extra conditional required here.
>  	 */
>  	chk_prot = static_protections(old_prot, lpaddr, old_pfn, numpages,
> -				      CPA_CONFLICT);
> +				      psize, CPA_CONFLICT);
>  
>  	if (WARN_ON_ONCE(pgprot_val(chk_prot) != pgprot_val(old_prot))) {
>  		/*
> @@ -855,7 +863,7 @@ static int __should_split_large_page(pte
>  	 * protection requirement in the large page.
>  	 */
>  	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
> -				      CPA_DETECT);
> +				      psize, CPA_DETECT);
>  
>  	/*
>  	 * If there is a conflict, split the large page.

And these are the callsites in __should_split_large_page(), and you
provide psize, and therefore we allow RW to preserve the large pages on
the kernel text.

> @@ -906,7 +914,8 @@ static void split_set_pte(struct cpa_dat
>  	if (!cpa->force_static_prot)
>  		goto set;
>  
> -	prot = static_protections(ref_prot, address, pfn, npg, CPA_PROTECT);
> +	/* Hand in lpsize = 0 to enforce the protection mechanism */
> +	prot = static_protections(ref_prot, address, pfn, npg, 0, CPA_PROTECT);

This is when we've already decided to split, in which case we might as
well enforce the normal rules, and .lpsize=0 does just that.

>  
>  	if (pgprot_val(prot) == pgprot_val(ref_prot))
>  		goto set;
> @@ -1503,7 +1512,8 @@ static int __change_page_attr(struct cpa
>  		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
>  
>  		cpa_inc_4k_install();
> -		new_prot = static_protections(new_prot, address, pfn, 1,
> +		/* Hand in lpsize = 0 to enforce the protection mechanism */
> +		new_prot = static_protections(new_prot, address, pfn, 1, 0,
>  					      CPA_PROTECT);

And here we check the protections of a single 4k page, in which case
large pages are irrelevant and again .lpsize=0 disables the new code.

>  
>  		new_prot = pgprot_clear_protnone_bits(new_prot);


That all seems OK I suppose.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
