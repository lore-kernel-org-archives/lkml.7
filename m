Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3235C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D2C20835
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfKYRct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:32:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfKYRct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:32:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F85620740;
        Mon, 25 Nov 2019 17:32:46 +0000 (UTC)
Date:   Mon, 25 Nov 2019 12:32:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 00/17] Rewrite x86/ftrace to use text_poke (and
 more)
Message-ID: <20191125123245.5ae9cb60@gandalf.local.home>
In-Reply-To: <20191125125534.2aaaccf00c38a9a25dee623a@kernel.org>
References: <20191111131252.921588318@infradead.org>
        <20191125125534.2aaaccf00c38a9a25dee623a@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019 12:55:34 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
> ...
>         on_each_cpu(do_sync_core, NULL, 1);
>         /*
>          * sync_core() implies an smp_mb() and orders this store against
>          * the writing of the new instruction.
>          */
>         bp_patching.vec = NULL;
>         bp_patching.nr_entries = 0;
> }
> -----
> 
> I think the "on_each_cpu(do_sync_core, NULL, 1);" can sync the pipeline
> but doesn't ensure all ongoing int3 handling is done. Thus, we may need a

How does it not ensure all ongoing int3 handling is done? int3 is done
with interrupts disabled, and the on_each_cpu() requires all CPUs to
have had their interrupts enabled, thus int3 handling should be
completed. Perhaps we need another sync core?

	on_each_cpu(do_sync_core, NULL, 1);
	bp_patching.nr_entries = 0;
	on_each_cpu(do_sync_core, NULL, 1);
	bp_patching.vec = NULL;

?

-- Steve


> bigger wait in between bp_patching.nr_entries = 0 and bp_patching.vec = NULL;
