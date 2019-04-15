Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF8CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22BF20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pMht2VQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfDOLzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:55:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfDOLzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hCArNMDhOKaCp9h6RBPBatvpCFYjonTX6dp+QRjz/4o=; b=pMht2VQ7HgX3tUao55ROyCQOA
        59XuQY/wuL4Ra7Yuky/HWwyMS870t6Mo0j2t/Y0iPlWCfi0pvikgkxyvwQovHb9tMchZKQ7Y+Dfjh
        wko7UlLxfY2k9XCJ7pwjhJsYDjT0XGHeVren/ULYa+iC9QuJawiBXYpR/HdnMqEGqpa8cL7H9DNfH
        75yEHHg+7aM9BoEbpSiPuJivHqZYgW9p8JNadLTvZ0SESnBoGVUwuX72yObxHDsE4Qzxp96J4i0kq
        O3Fx9JfaXzG0ghHL8ZJXelq+L2ufX+//hIeY1SHWaJfOn7a1QwThN3VSf1zdQNjHYkN1O5Hm/yp14
        v55gDKwvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hG0CS-0000JY-DM; Mon, 15 Apr 2019 11:55:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4EE7729AC8449; Mon, 15 Apr 2019 13:54:58 +0200 (CEST)
Date:   Mon, 15 Apr 2019 13:54:58 +0200
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
Subject: Re: [PATCH V5 7/7] x86/jump_label: Batch jump label updates
Message-ID: <20190415115458.GM11158@hirez.programming.kicks-ass.net>
References: <cover.1554106794.git.bristot@redhat.com>
 <725010896650bc040743b0479b103f5f6d28b404.1554106794.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <725010896650bc040743b0479b103f5f6d28b404.1554106794.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:58:19AM +0200, Daniel Bristot de Oliveira wrote:
> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> index 8aa65fbbd764..ab75b222a7e2 100644
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -15,6 +15,7 @@
>  #include <asm/kprobes.h>
>  #include <asm/alternative.h>
>  #include <asm/text-patching.h>
> +#include <linux/slab.h>
>  
>  union jump_code_union {
>  	char code[JUMP_LABEL_NOP_SIZE];
> @@ -111,6 +112,93 @@ void arch_jump_label_transform(struct jump_entry *entry,
>  	mutex_unlock(&text_mutex);
>  }
>  
> +unsigned int entry_vector_max_elem __read_mostly;
> +struct text_patch_loc *entry_vector;
> +unsigned int entry_vector_nr_elem;
> +
> +void arch_jump_label_init(void)
> +{
> +	entry_vector = (void *) __get_free_page(GFP_KERNEL);
> +
> +	if (WARN_ON_ONCE(!entry_vector))
> +		return;
> +
> +	entry_vector_max_elem = PAGE_SIZE / sizeof(struct text_patch_loc);
> +	return;
> +}
> +
> +int arch_jump_label_transform_queue(struct jump_entry *entry,
> +				     enum jump_label_type type)
> +{
> +	struct text_patch_loc *tp;
> +	void *entry_code;
> +
> +	/*
> +	 * Batch mode disabled before being able to allocate memory:
> +	 * Fallback to the non-batching mode.
> +	 */
> +	if (unlikely(!entry_vector_max_elem)) {
> +		if (!slab_is_available() || early_boot_irqs_disabled)

See, the thing is, you never use slab, so that slab check is completely
wrong.

> +			goto fallback;
> +
> +		arch_jump_label_init();
> +	}
> +
> +	/*
> +	 * No more space in the vector, tell upper layer to apply
> +	 * the queue before continuing.
> +	 */
> +	if (entry_vector_nr_elem == entry_vector_max_elem)
> +		return -ENOSPC;
> +
> +	tp = &entry_vector[entry_vector_nr_elem];
> +
> +	entry_code = (void *)jump_entry_code(entry);
> +
> +	/*
> +	 * The int3 handler will do a bsearch in the queue, so we need entries
> +	 * to be sorted. We can survive an unsorted list by rejecting the entry,
> +	 * forcing the generic jump_label code to apply the queue. Warning once,
> +	 * to raise the attention to the case of an unsorted entry that is
> +	 * better not happen, because, in the worst case we will perform in the
> +	 * same way as we do without batching - with some more overhead.
> +	 */
> +	if (entry_vector_nr_elem > 0) {
> +		int prev_idx = entry_vector_nr_elem - 1;
> +		struct text_patch_loc *prev_tp = &entry_vector[prev_idx];
> +
> +		if (WARN_ON_ONCE(prev_tp->addr > entry_code))
> +			return -EINVAL;
> +	}
> +
> +	__jump_label_set_jump_code(entry, type,
> +				   (union jump_code_union *) &tp->opcode, 0);
> +
> +	tp->addr = entry_code;
> +	tp->detour = entry_code + JUMP_LABEL_NOP_SIZE;
> +	tp->len = JUMP_LABEL_NOP_SIZE;
> +
> +	entry_vector_nr_elem++;
> +
> +	return 0;
> +
> +fallback:
> +	arch_jump_label_transform(entry, type);
> +	return 0;
> +}

So how about we do something like:

+static struct bp_patching_desc {
+       int nr_entries;
+       struct text_patch_loc vec[PAGE_SIZE / sizeof(struct text_patch_loc)];
+} bp_patching;

and call it a day?

Then we have static storage, no allocation, no fail paths.

Also note that I removed that whole in_progress thing, as that is
completely redudant vs !!nr_entries.
