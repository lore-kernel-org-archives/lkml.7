Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FA2C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE8621881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfGCOIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:08:36 -0400
Received: from foss.arm.com ([217.140.110.172]:48900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfGCOIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:08:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B1142B;
        Wed,  3 Jul 2019 07:08:35 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62BAB3F718;
        Wed,  3 Jul 2019 07:08:34 -0700 (PDT)
Date:   Wed, 3 Jul 2019 15:08:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 12/16] kprobes: Initialize kprobes at
 postcore_initcall
Message-ID: <20190703140832.GD48312@arrakis.emea.arm.com>
References: <20190526191828.466305460@goodmis.org>
 <20190526191848.266163206@goodmis.org>
 <20190702165008.GC34718@lakrids.cambridge.arm.com>
 <20190703100205.0b58f3bf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703100205.0b58f3bf@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 10:02:05AM -0400, Steven Rostedt wrote:
> > On arm64 kprobes depends on the BRK handler we register in
> > debug_traps_init(), which is an arch_initcall.
> > 
> > As of this change, init_krprobes() calls init_test_probes() before
> > that's registered, so we end up hitting a BRK before we can handle it.
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
>  
> +static int __init run_init_test_probes(void)
> +{
> +	if (run_kprobe_tests)
> +		init_test_probes();

A return 0 here.

> +}
> +module_init(run_init_test_probes);

This does the trick. I prefer your fix as it leaves the arch code
unchanged. In case you need it:

Tested-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

-- 
Catalin
