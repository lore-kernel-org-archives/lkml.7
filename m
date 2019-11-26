Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E0CC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 00:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E84F207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 00:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574727072;
	bh=jJS9jbYP1/zWBCwOWNXMbLgoYZJ2eLtU8Jol3wQrP1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=u+2d6zSa5BuOdgNxLOxWgEgaU3n+USr28fmmiO/vB8LzQFT74a0C8N+zGsooUUa6A
	 y+jcVlAlCRk5EwJrhjN3AroCBBTxpvjbdhCDmi+g5U6ofwsMkqr+bejvfkfS4SQEJZ
	 54FnI5/TOtL5JJmacMqNUpJZ8RgFjc1NxBN97bqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKZALL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 19:11:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfKZALL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 19:11:11 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BEDC20409;
        Tue, 26 Nov 2019 00:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574727070;
        bh=jJS9jbYP1/zWBCwOWNXMbLgoYZJ2eLtU8Jol3wQrP1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nVKsvE1l1vfX+76KBqPj2yOSXGXkTmQdrNszwn4bLAwOky1yITvTvAsLxwW+6LVJf
         w0HGxOfjTOvY/T8udn1+qPjTnKSogwZKfGF9Fdexo2flkwwccm29v4W2MCd1gQKabz
         S0GAfuox34KRptyzbdCh/V7696v7+FE+Y0oXwjxg=
Date:   Tue, 26 Nov 2019 09:11:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 00/17] Rewrite x86/ftrace to use text_poke (and
 more)
Message-Id: <20191126091104.5e0cdc61e3b143fae4ed4cfd@kernel.org>
In-Reply-To: <20191125123245.5ae9cb60@gandalf.local.home>
References: <20191111131252.921588318@infradead.org>
        <20191125125534.2aaaccf00c38a9a25dee623a@kernel.org>
        <20191125123245.5ae9cb60@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019 12:32:45 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 25 Nov 2019 12:55:34 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
> > ...
> >         on_each_cpu(do_sync_core, NULL, 1);
> >         /*
> >          * sync_core() implies an smp_mb() and orders this store against
> >          * the writing of the new instruction.
> >          */
> >         bp_patching.vec = NULL;
> >         bp_patching.nr_entries = 0;
> > }
> > -----
> > 
> > I think the "on_each_cpu(do_sync_core, NULL, 1);" can sync the pipeline
> > but doesn't ensure all ongoing int3 handling is done. Thus, we may need a
> 
> How does it not ensure all ongoing int3 handling is done? int3 is done
> with interrupts disabled, and the on_each_cpu() requires all CPUs to
> have had their interrupts enabled, thus int3 handling should be
> completed. Perhaps we need another sync core?
> 
> 	on_each_cpu(do_sync_core, NULL, 1);
> 	bp_patching.nr_entries = 0;
> 	on_each_cpu(do_sync_core, NULL, 1);
> 	bp_patching.vec = NULL;

OK, let me check.

The 1st sync_core will ensure the poking "int3" is removed. Thus any
int3-hit address (ip) should NOT match the bp_patching.vec[*].addr after
that. At this point, "if (likely(!bp_patching.nr_entries))" check does not
work.

And the 2nd sync_core will ensure all poke_int3_handler() will see the
bp_patching.nr_entries = 0.
After this point, "if (likely(!bp_patching.nr_entries))" works and
poke_int3_handler() will exit soon. (before touching bp_patching.vec)

So this looks good to me.

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
