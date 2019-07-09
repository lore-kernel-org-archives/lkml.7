Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDD8C73C42
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19FB216E3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562675455;
	bh=BCctahsZCXIi3y2EElHt4wtbP9jSttNX4X4IVfwp7AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CLpd41x/E6NKzB78BLJWYkD2zYeuwrcd7XIqZ4VDC2+s2g+y5Q2cK5YnF4Im3lPSi
	 Zk8CimStbw++7mmHSv/usrPuRqsU/gAUEriwJ9R8m2arjFFgbExPoXDqif+EagtZ9T
	 XGJO5QS0wGidLNjR7YN4liAw936Z0DFYbFbOeQBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfGIMay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfGIMay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:30:54 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0073D214AF;
        Tue,  9 Jul 2019 12:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562675453;
        bh=BCctahsZCXIi3y2EElHt4wtbP9jSttNX4X4IVfwp7AI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ElWcx5thcaH0OKL05/0EQXZFk++2rdKvYBeTSr72PVp0JIxTRStMffQ9pqzLFiCxc
         UVVOiyKMsXEibzIOiG0HdNySMPIzJUf9J/DgbtcrvM33CllOebVJSU0SQuUTj9D1Wt
         BmSF2kIv67+6kLj+2q+mCp6zKE9orOgakyFeQHto=
Date:   Tue, 9 Jul 2019 21:30:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [for-next][PATCH 12/16] kprobes: Initialize kprobes at
 postcore_initcall
Message-Id: <20190709213049.f84b4df6562250ac6ef0b51d@kernel.org>
In-Reply-To: <20190703100205.0b58f3bf@gandalf.local.home>
References: <20190526191828.466305460@goodmis.org>
        <20190526191848.266163206@goodmis.org>
        <20190702165008.GC34718@lakrids.cambridge.arm.com>
        <20190703100205.0b58f3bf@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 3 Jul 2019 10:02:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 2 Jul 2019 17:50:09 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Sun, May 26, 2019 at 03:18:40PM -0400, Steven Rostedt wrote:
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > > Initialize kprobes at postcore_initcall level instead of module_init
> > > since kprobes is not a module, and it depends on only subsystems
> > > initialized in core_initcall.
> > > This will allow ftrace kprobe event to add new events when it is
> > > initializing because ftrace kprobe event is initialized at
> > > later initcall level.
> > > 
> > > Link: http://lkml.kernel.org/r/155851394736.15728.13626739508905120098.stgit@devnote2
> > > 
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > ---
> > >  kernel/kprobes.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > index b1ea30a5540e..54aaaad00a47 100644
> > > --- a/kernel/kprobes.c
> > > +++ b/kernel/kprobes.c
> > > @@ -2289,6 +2289,7 @@ static int __init init_kprobes(void)
> > >  		init_test_probes();
> > >  	return err;
> > >  }
> > > +postcore_initcall(init_kprobes);  
> > 
> > As a heads-up, this is causing boot-time failures on arm64.
> 
> Thanks for the report.
> 
> > 
> > On arm64 kprobes depends on the BRK handler we register in
> > debug_traps_init(), which is an arch_initcall.
> > 
> > As of this change, init_krprobes() calls init_test_probes() before
> > that's registered, so we end up hitting a BRK before we can handle it.
> > 
> 
> Would something like this help?
> 
> -- Steve
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 5471efbeb937..0ca6f53c8505 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2235,6 +2235,8 @@ static struct notifier_block kprobe_module_nb = {
>  extern unsigned long __start_kprobe_blacklist[];
>  extern unsigned long __stop_kprobe_blacklist[];
>  
> +static bool run_kprobe_tests __initdata;
> +
>  static int __init init_kprobes(void)
>  {
>  	int i, err = 0;
> @@ -2286,11 +2288,18 @@ static int __init init_kprobes(void)
>  	kprobes_initialized = (err == 0);
>  
>  	if (!err)
> -		init_test_probes();
> +		run_kprobe_tests = true;
>  	return err;
>  }
>  subsys_initcall(init_kprobes);


Just out of curious, if arm64's handler code initialized in arch_initcall,
why this subsys_initcall() function causes a problem?

This is actually related to my boot-time tracing series, so I would like
fix this issue without this patch.

Thank you,

>  
> +static int __init run_init_test_probes(void)
> +{
> +	if (run_kprobe_tests)
> +		init_test_probes();
> +}
> +module_init(run_init_test_probes);
> +
>  #ifdef CONFIG_DEBUG_FS
>  static void report_probe(struct seq_file *pi, struct kprobe *p,
>  		const char *sym, int offset, char *modname, struct kprobe *pp)
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
