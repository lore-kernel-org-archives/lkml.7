Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547FDC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DC2212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391476AbfFKPwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388958AbfFKPwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:52:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89DDF2080A;
        Tue, 11 Jun 2019 15:52:11 +0000 (UTC)
Date:   Tue, 11 Jun 2019 11:52:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20190611115210.490c345a@gandalf.local.home>
In-Reply-To: <20190611112254.576226fe@gandalf.local.home>
References: <20190605130753.327195108@infradead.org>
        <20190605131945.005681046@infradead.org>
        <20190608004708.7646b287151cf613838ce05f@kernel.org>
        <20190607173427.GK3436@hirez.programming.kicks-ass.net>
        <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
        <20190611080307.GN3436@hirez.programming.kicks-ass.net>
        <20190611112254.576226fe@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 11:22:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> What would work would be to:
> 
> 	add breakpoint to first opcode.
> 
> 	call synchronize_tasks();

BTW, that should be "synchronize_rcu_tasks()"

-- Steve

> 
> 	/* All tasks now hitting breakpoint and jumping over affected
> 	code */
> 
> 	update the rest of the instructions.
> 
> 	replace breakpoint with jmp.
