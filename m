Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A778FC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70771207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgAGXjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:39:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgAGXjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 18:39:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E69B2072A;
        Tue,  7 Jan 2020 23:39:09 +0000 (UTC)
Date:   Tue, 7 Jan 2020 18:39:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUGFIX PATCH] kprobes: Fix to cancel optimizing/unoptimizing
 kprobes correctly
Message-ID: <20200107183907.3c87500a@gandalf.local.home>
In-Reply-To: <157840814418.7181.13478003006386303481.stgit@devnote2>
References: <157840814418.7181.13478003006386303481.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jan 2020 23:42:24 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> optimize_kprobe() and unoptimize_kprobe() cancels if given kprobe
> is on the optimizing_list or unoptimizing_list. However, since
> commit f66c0447cca1 ("kprobes: Set unoptimized flag after
> unoptimizing code") modified the update timing of the
> KPROBE_FLAG_OPTIMIZED, it doesn't work as expected anymore.
> 
> The optimized_kprobe could be following states.
> 
> - [optimizing]: Before inserting jump instruction
>   op.kp->flags has KPROBE_FLAG_OPTIMIZED and
>   op->list is not empty.
> 
> - [optimized]: jump inserted
>   op.kp->flags has KPROBE_FLAG_OPTIMIZED and
>   op->list is empty.
> 
> - [unoptimizing]: Before removing jump instruction (including unused
>   optprobe)
>   op.kp->flags has KPROBE_FLAG_OPTIMIZED and
>   op->list is not empty.
> 
> - [unoptimized]: jump removed
>   op.kp->flags doesn't have KPROBE_FLAG_OPTIMIZED and
>   op->list is empty.
> 
> Current code mis-expects [unoptimizing] state doesn't have
> KPROBE_FLAG_OPTIMIZED, and that can cause wrong results.
> 
> This introduces optprobe_queued_unopt() to distinguish [optimizing]
> and [unoptimizing] states and fixes logics in optimize_kprobe() and
> unoptimize_kprobe().
> 
> Fixes: f66c0447cca1 ("kprobes: Set unoptimized flag after unoptimizing code")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Looks good.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


>  		return;
>  	}
> +
>  	/* Optimized kprobe case */
> -	if (force)
> +	if (force) {
>  		/* Forcibly update the code: this is a special case */
>  		force_unoptimize_kprobe(op);
> -	else {
> +	} else {
>  		list_add(&op->list, &unoptimizing_list);
>  		kick_kprobe_optimizer();
>  	}

I see you added some clean up to this patch.

-- Steve
