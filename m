Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75889C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D9E21881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfGCHYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:24:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50623 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfGCHYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:24:03 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hiZcW-00054f-3V; Wed, 03 Jul 2019 09:24:00 +0200
Date:   Wed, 3 Jul 2019 09:24:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH] x86/fpu: Fix nofxsr regression
Message-ID: <20190703072359.du7znh63cw4fyvpc@linutronix.de>
References: <20190702213958.33291-1-andi@firstfloor.org>
 <alpine.DEB.2.21.1907030013130.1802@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907030013130.1802@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-03 00:17:17 [+0200], Thomas Gleixner wrote:
> On Tue, 2 Jul 2019, Andi Kleen wrote:
> >  
> > -	if (cmdline_find_option_bool(boot_command_line, "nofxsr")) {
> > +	if (!IS_ENABLED(CONFIG_64BIT) &&
> > +		cmdline_find_option_bool(boot_command_line, "nofxsr")) {
> > +		fpu__xstate_clear_all_cpu_caps();
> >  		setup_clear_cpu_cap(X86_FEATURE_FXSR);
> >  		setup_clear_cpu_cap(X86_FEATURE_FXSR_OPT);
> >  		setup_clear_cpu_cap(X86_FEATURE_XMM);
> 
> This is a mixture of disabling features explicitely and having the
> dependencies in cpuid-deps. Even 2 of the existing ones are pointless
> because clear(FXSR) already clears the other two.
> 
> Why not make XSAVE depend on XMM or whatever is the right dependency?

I have something half way done.

> Thanks,
> 
> 	tglx

Sebastian
