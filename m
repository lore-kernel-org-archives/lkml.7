Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1126C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39BC21851
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfGBQuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:50:13 -0400
Received: from foss.arm.com ([217.140.110.172]:53372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBQuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:50:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F59828;
        Tue,  2 Jul 2019 09:50:12 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56DA13F246;
        Tue,  2 Jul 2019 09:50:11 -0700 (PDT)
Date:   Tue, 2 Jul 2019 17:50:09 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [for-next][PATCH 12/16] kprobes: Initialize kprobes at
 postcore_initcall
Message-ID: <20190702165008.GC34718@lakrids.cambridge.arm.com>
References: <20190526191828.466305460@goodmis.org>
 <20190526191848.266163206@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526191848.266163206@goodmis.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2019 at 03:18:40PM -0400, Steven Rostedt wrote:
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Initialize kprobes at postcore_initcall level instead of module_init
> since kprobes is not a module, and it depends on only subsystems
> initialized in core_initcall.
> This will allow ftrace kprobe event to add new events when it is
> initializing because ftrace kprobe event is initialized at
> later initcall level.
> 
> Link: http://lkml.kernel.org/r/155851394736.15728.13626739508905120098.stgit@devnote2
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/kprobes.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index b1ea30a5540e..54aaaad00a47 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2289,6 +2289,7 @@ static int __init init_kprobes(void)
>  		init_test_probes();
>  	return err;
>  }
> +postcore_initcall(init_kprobes);

As a heads-up, this is causing boot-time failures on arm64.

On arm64 kprobes depends on the BRK handler we register in
debug_traps_init(), which is an arch_initcall.

As of this change, init_krprobes() calls init_test_probes() before
that's registered, so we end up hitting a BRK before we can handle it.

Thanks,
Mark.

>  
>  #ifdef CONFIG_DEBUG_FS
>  static void report_probe(struct seq_file *pi, struct kprobe *p,
> @@ -2614,5 +2615,3 @@ static int __init debugfs_kprobe_init(void)
>  
>  late_initcall(debugfs_kprobe_init);
>  #endif /* CONFIG_DEBUG_FS */
> -
> -module_init(init_kprobes);
> -- 
> 2.20.1
> 
> 
