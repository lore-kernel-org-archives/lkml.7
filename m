Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F0DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283AC20645
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vhpBp/wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfDOLfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:35:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60506 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfDOLfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KCPWHTN30sFpitzu9muU3nKBytIKi1M+ll7D6eJnfsU=; b=vhpBp/wpfzAm4CFvW5oq9nvG4
        c6lT/mu6eGvIR7Ubu98NbJ0LbVpjKw0w4llAchvh3ez3Pb5j2xAtQxjqHLbHIleXUdVIXm3wvBPz5
        W1k6CBU4TmIBSmIAxSqY+hUMJ/c1M+eQMwqjcsQWAtm2z2FQuX/P57Qz9GA1WySZQrA39OH4aXMyv
        hyZITqGCpROnWq0ZtBfiXfn5kvrB8sX2flz3aTNK90u2M487L/Wq9/gOXePPURJeW62tP7PVVFFtI
        JBYyLPhU9QfRNDyExeJSP5aD8Tbzs6bwCwgjdyac7EgEV4dPHQgiFU83RbU0GrHsUMgPfelCHs5wf
        nyk2AKfdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFztg-0000JV-P3; Mon, 15 Apr 2019 11:35:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1558A2038C257; Mon, 15 Apr 2019 13:35:35 +0200 (CEST)
Date:   Mon, 15 Apr 2019 13:35:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V5 5/7] x86/alternative: Batch of patch operations
Message-ID: <20190415113535.GK11158@hirez.programming.kicks-ass.net>
References: <cover.1554106794.git.bristot@redhat.com>
 <a4e6c503c552f7c02273c5f000c2c601a1b87c32.1554106794.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e6c503c552f7c02273c5f000c2c601a1b87c32.1554106794.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:58:17AM +0200, Daniel Bristot de Oliveira wrote:
> +	ip = (void *) regs->ip - sizeof(unsigned char);

That one confused me mightily. Does that want to be:

	ip = (void *)regs->ip - LEN_INT3;

or something? Even just a naked 1 would've been less confusing.

>  
> +	/*
> +	 * Skip the binary search if there is a single member in the vector.
> +	 */
> +	if (unlikely(bp_patching.nr_entries == 1))
> +		goto single_poke;
> +
> +	tp = bsearch(ip, bp_patching.vec, bp_patching.nr_entries,
> +		     sizeof(struct text_patch_loc),
> +		     patch_cmp);
> +	if (!tp)
> +		return 0;
> +
> +	/* set up the specified breakpoint detour */
> +	regs->ip = (unsigned long) tp->detour;
>  	return 1;
> +single_poke:
> +	if (ip == bp_patching.vec->addr) {
> +		regs->ip = (unsigned long) bp_patching.vec->detour;
> +		return 1;
> +	}
> +
> +	return 0;

	if (bp_patching.nr_entries > 1) {
		tp = bsearch(ip, bp_patching.vec, bp_patching.nr_entries,
			     sizeof(struct text_patch_loc), patch_cmp);
		if (!tp)
			return 0;
	} else {
		tp = bp_patching.vec;
		if (tp->addr != ip)
			return 0;
	}

	regs->ip = (unsigned long)tp->detour;
	return 1;
>  }
>  NOKPROBE_SYMBOL(poke_int3_handler);

> +void text_poke_bp_batch(struct text_patch_loc *tp, unsigned int nr_entries)
>  {
> +	int patched_all_but_first = 0;
>  	unsigned char int3 = 0xcc;
> +	unsigned int i;
>  
>  	lockdep_assert_held(&text_mutex);
>  
> +	bp_patching.vec = tp;
> +	bp_patching.nr_entries = nr_entries;
> +	bp_patching.in_progress = true;
>  	/*
>  	 * Corresponding read barrier in int3 notifier for making sure the
>  	 * in_progress and handler are correctly ordered wrt. patching.
>  	 */
>  	smp_wmb();
>  
> +	/*
> +	 * First step: add a int3 trap to the address that will be patched.
> +	 */
> +	for (i = 0; i < nr_entries; i++)
> +		text_poke(tp[i].addr, &int3, sizeof(int3));
>  
>  	on_each_cpu(do_sync_core, NULL, 1);
>  
> +	/*
> +	 * Second step: update all but the first byte of the patched range.
> +	 */
> +	for (i = 0; i < nr_entries; i++) {
> +		if (tp[i].len - sizeof(int3) > 0) {
> +			text_poke((char *)tp[i].addr + sizeof(int3),
> +				  (const char *)tp[i].opcode + sizeof(int3),
> +				  tp[i].len - sizeof(int3));
> +			patched_all_but_first++;
> +		}
> +	}
> +
> +	if (patched_all_but_first) {
>  		/*
>  		 * According to Intel, this core syncing is very likely
>  		 * not necessary and we'd be safe even without it. But
> @@ -821,15 +874,52 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
>  		on_each_cpu(do_sync_core, NULL, 1);
>  	}
>  
> +	/*
> +	 * Third step: replace the first byte (int3) by the first byte of
> +	 * replacing opcode.
> +	 */
> +	for (i = 0; i < nr_entries; i++)
> +		text_poke(tp[i].addr, tp[i].opcode, sizeof(int3));
>  
>  	on_each_cpu(do_sync_core, NULL, 1);
>  	/*
>  	 * sync_core() implies an smp_mb() and orders this store against
>  	 * the writing of the new instruction.
>  	 */
> +	bp_patching.vec = NULL;
> +	bp_patching.nr_entries = 0;
> +	bp_patching.in_progress = false;
> +}

