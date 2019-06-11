Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3D7C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715D22145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391909AbfFKQLR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388744AbfFKQLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:11:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FE1A21726;
        Tue, 11 Jun 2019 16:11:14 +0000 (UTC)
Date:   Tue, 11 Jun 2019 12:11:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20190611121112.1c96aec3@gandalf.local.home>
In-Reply-To: <435093E5-6FE3-4DAA-9ABE-EB9D372F8CF8@amacapital.net>
References: <20190605130753.327195108@infradead.org>
        <20190605131945.005681046@infradead.org>
        <20190608004708.7646b287151cf613838ce05f@kernel.org>
        <20190607173427.GK3436@hirez.programming.kicks-ass.net>
        <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
        <20190611080307.GN3436@hirez.programming.kicks-ass.net>
        <435093E5-6FE3-4DAA-9ABE-EB9D372F8CF8@amacapital.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 08:54:23 -0700
Andy Lutomirski <luto@amacapital.net> wrote:


> How does that help?  If RIP == x+2 and you want to put a 5-byte jump
> at address x, no amount of 0xcc is going to change the fact that RIP
> is in the middle of the jump.
> 
> Live patching can handle this by detecting this condition on each
> CPU, but performance won’t be great.  Maybe some synchronize_sched
> trickery could help.

We have synchronize_rcu_tasks() which return after all tasks have
either entered user space or did a voluntary schedule (was not
preempted). Or have not run (still in a sleeping state).

That way we guarantee that all tasks are no longer on any trampoline
or code paths that do not call schedule. I use this to free dynamically
allocated trampolines used by ftrace. And kprobes uses this too for its
own trampolines.

-- Steve
