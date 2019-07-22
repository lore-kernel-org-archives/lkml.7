Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD3CC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23C7217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfGVMel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:34:41 -0400
Received: from foss.arm.com ([217.140.110.172]:36810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbfGVMel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:34:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A33AF344;
        Mon, 22 Jul 2019 05:34:40 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBAAC3F71A;
        Mon, 22 Jul 2019 05:34:39 -0700 (PDT)
Date:   Mon, 22 Jul 2019 13:34:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 12/16] kprobes: Initialize kprobes at
 postcore_initcall
Message-ID: <20190722123437.GE60625@arrakis.emea.arm.com>
References: <20190526191828.466305460@goodmis.org>
 <20190526191848.266163206@goodmis.org>
 <20190702165008.GC34718@lakrids.cambridge.arm.com>
 <20190703100205.0b58f3bf@gandalf.local.home>
 <20190709213049.f84b4df6562250ac6ef0b51d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709213049.f84b4df6562250ac6ef0b51d@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 09:30:49PM +0900, Masami Hiramatsu wrote:
> On Wed, 3 Jul 2019 10:02:05 -0400 Steven Rostedt <rostedt@goodmis.org>
> wrote:
> > On Tue, 2 Jul 2019 17:50:09 +0100 Mark Rutland
> > <mark.rutland@arm.com> wrote:
> > > On Sun, May 26, 2019 at 03:18:40PM -0400, Steven Rostedt wrote:
> > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > > ---
> > > >  kernel/kprobes.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > > index b1ea30a5540e..54aaaad00a47 100644
> > > > --- a/kernel/kprobes.c
> > > > +++ b/kernel/kprobes.c
> > > > @@ -2289,6 +2289,7 @@ static int __init init_kprobes(void)
> > > >  		init_test_probes();
> > > >  	return err;
> > > >  }
> > > > +postcore_initcall(init_kprobes);  
[...]
> > > On arm64 kprobes depends on the BRK handler we register in
> > > debug_traps_init(), which is an arch_initcall.
> > > 
> > > As of this change, init_krprobes() calls init_test_probes() before
> > > that's registered, so we end up hitting a BRK before we can handle it.
[...]
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 5471efbeb937..0ca6f53c8505 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2235,6 +2235,8 @@ static struct notifier_block kprobe_module_nb = {
> >  extern unsigned long __start_kprobe_blacklist[];
> >  extern unsigned long __stop_kprobe_blacklist[];
> >  
> > +static bool run_kprobe_tests __initdata;
> > +
> >  static int __init init_kprobes(void)
> >  {
> >  	int i, err = 0;
> > @@ -2286,11 +2288,18 @@ static int __init init_kprobes(void)
> >  	kprobes_initialized = (err == 0);
> >  
> >  	if (!err)
> > -		init_test_probes();
> > +		run_kprobe_tests = true;
> >  	return err;
> >  }
> >  subsys_initcall(init_kprobes);
> 
> Just out of curious, if arm64's handler code initialized in arch_initcall,
> why this subsys_initcall() function causes a problem?

It doesn't but patch 12/16 in this series changes it to
postcore_initcall().

-- 
Catalin
