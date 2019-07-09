Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1874FC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F6B21670
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfGIPPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfGIPPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:15:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D73702166E;
        Tue,  9 Jul 2019 15:15:21 +0000 (UTC)
Date:   Tue, 9 Jul 2019 11:15:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 12/16] kprobes: Initialize kprobes at
 postcore_initcall
Message-ID: <20190709111520.5f098b22@gandalf.local.home>
In-Reply-To: <20190703140832.GD48312@arrakis.emea.arm.com>
References: <20190526191828.466305460@goodmis.org>
        <20190526191848.266163206@goodmis.org>
        <20190702165008.GC34718@lakrids.cambridge.arm.com>
        <20190703100205.0b58f3bf@gandalf.local.home>
        <20190703140832.GD48312@arrakis.emea.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 15:08:32 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

 
> > -- Steve
> > 
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
> >  
> > +static int __init run_init_test_probes(void)
> > +{
> > +	if (run_kprobe_tests)
> > +		init_test_probes();  
> 
> A return 0 here.
> 
> > +}
> > +module_init(run_init_test_probes);  
> 
> This does the trick. I prefer your fix as it leaves the arch code
> unchanged. In case you need it:

And I actually think yours is better for the opposite reason ;-)

I agree with Masami, that the selftest actually caught a bug here. I
think the arch code may need to change as the purpose of Masami's
changes was to enable kprobes earlier in boot. The selftest failing
means that an early kprobe will fail too.

-- Steve


> 
> Tested-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Thanks.
> 

