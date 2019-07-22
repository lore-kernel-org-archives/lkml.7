Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D087C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB677218A0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfGVMmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:42:06 -0400
Received: from foss.arm.com ([217.140.110.172]:36874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfGVMmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:42:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB599344;
        Mon, 22 Jul 2019 05:42:05 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2D4C3F71A;
        Mon, 22 Jul 2019 05:42:04 -0700 (PDT)
Date:   Mon, 22 Jul 2019 13:42:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 12/16] kprobes: Initialize kprobes at
 postcore_initcall
Message-ID: <20190722124202.GF60625@arrakis.emea.arm.com>
References: <20190526191828.466305460@goodmis.org>
 <20190526191848.266163206@goodmis.org>
 <20190702165008.GC34718@lakrids.cambridge.arm.com>
 <20190703100205.0b58f3bf@gandalf.local.home>
 <20190703140832.GD48312@arrakis.emea.arm.com>
 <20190709111520.5f098b22@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709111520.5f098b22@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, Jul 09, 2019 at 11:15:20AM -0400, Steven Rostedt wrote:
> On Wed, 3 Jul 2019 15:08:32 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > index 5471efbeb937..0ca6f53c8505 100644
> > > --- a/kernel/kprobes.c
> > > +++ b/kernel/kprobes.c
> > > @@ -2235,6 +2235,8 @@ static struct notifier_block kprobe_module_nb = {
> > >  extern unsigned long __start_kprobe_blacklist[];
> > >  extern unsigned long __stop_kprobe_blacklist[];
> > >  
> > > +static bool run_kprobe_tests __initdata;
> > > +
> > >  static int __init init_kprobes(void)
> > >  {
> > >  	int i, err = 0;
> > > @@ -2286,11 +2288,18 @@ static int __init init_kprobes(void)
> > >  	kprobes_initialized = (err == 0);
> > >  
> > >  	if (!err)
> > > -		init_test_probes();
> > > +		run_kprobe_tests = true;
> > >  	return err;
> > >  }
> > >  subsys_initcall(init_kprobes);
> > >  
> > > +static int __init run_init_test_probes(void)
> > > +{
> > > +	if (run_kprobe_tests)
> > > +		init_test_probes();  
> > 
> > A return 0 here.
> > 
> > > +}
> > > +module_init(run_init_test_probes);  
> > 
> > This does the trick. I prefer your fix as it leaves the arch code
> > unchanged. In case you need it:
> 
> And I actually think yours is better for the opposite reason ;-)
> 
> I agree with Masami, that the selftest actually caught a bug here. I
> think the arch code may need to change as the purpose of Masami's
> changes was to enable kprobes earlier in boot. The selftest failing
> means that an early kprobe will fail too.

I just got back from holiday and catching up with emails. Do I still
need to merge the arm64 fix making the debug initialisation a
core_initcall()?

Can we actually get kprobes invoked before init_kprobes() has been
called?

Thanks.

-- 
Catalin
