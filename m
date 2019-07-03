Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E681C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A767218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfGCOCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfGCOCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:02:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07A47218A3;
        Wed,  3 Jul 2019 14:02:06 +0000 (UTC)
Date:   Wed, 3 Jul 2019 10:02:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [for-next][PATCH 12/16] kprobes: Initialize kprobes at
 postcore_initcall
Message-ID: <20190703100205.0b58f3bf@gandalf.local.home>
In-Reply-To: <20190702165008.GC34718@lakrids.cambridge.arm.com>
References: <20190526191828.466305460@goodmis.org>
        <20190526191848.266163206@goodmis.org>
        <20190702165008.GC34718@lakrids.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 17:50:09 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Sun, May 26, 2019 at 03:18:40PM -0400, Steven Rostedt wrote:
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Initialize kprobes at postcore_initcall level instead of module_init
> > since kprobes is not a module, and it depends on only subsystems
> > initialized in core_initcall.
> > This will allow ftrace kprobe event to add new events when it is
> > initializing because ftrace kprobe event is initialized at
> > later initcall level.
> > 
> > Link: http://lkml.kernel.org/r/155851394736.15728.13626739508905120098.stgit@devnote2
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  kernel/kprobes.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index b1ea30a5540e..54aaaad00a47 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2289,6 +2289,7 @@ static int __init init_kprobes(void)
> >  		init_test_probes();
> >  	return err;
> >  }
> > +postcore_initcall(init_kprobes);  
> 
> As a heads-up, this is causing boot-time failures on arm64.

Thanks for the report.

> 
> On arm64 kprobes depends on the BRK handler we register in
> debug_traps_init(), which is an arch_initcall.
> 
> As of this change, init_krprobes() calls init_test_probes() before
> that's registered, so we end up hitting a BRK before we can handle it.
> 

Would something like this help?

-- Steve

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 5471efbeb937..0ca6f53c8505 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2235,6 +2235,8 @@ static struct notifier_block kprobe_module_nb = {
 extern unsigned long __start_kprobe_blacklist[];
 extern unsigned long __stop_kprobe_blacklist[];
 
+static bool run_kprobe_tests __initdata;
+
 static int __init init_kprobes(void)
 {
 	int i, err = 0;
@@ -2286,11 +2288,18 @@ static int __init init_kprobes(void)
 	kprobes_initialized = (err == 0);
 
 	if (!err)
-		init_test_probes();
+		run_kprobe_tests = true;
 	return err;
 }
 subsys_initcall(init_kprobes);
 
+static int __init run_init_test_probes(void)
+{
+	if (run_kprobe_tests)
+		init_test_probes();
+}
+module_init(run_init_test_probes);
+
 #ifdef CONFIG_DEBUG_FS
 static void report_probe(struct seq_file *pi, struct kprobe *p,
 		const char *sym, int offset, char *modname, struct kprobe *pp)

