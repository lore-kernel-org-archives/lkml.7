Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DCCC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A423D218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfGVJlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:41:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36121 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbfGVJlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:41:40 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpUp0-0003F7-7p; Mon, 22 Jul 2019 11:41:30 +0200
Date:   Mon, 22 Jul 2019 11:41:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pingfan Liu <kernelfans@gmail.com>
cc:     x86@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smp: force all cpu to boot once under maxcpus option
In-Reply-To: <1562747823-16972-1-git-send-email-kernelfans@gmail.com>
Message-ID: <alpine.DEB.2.21.1907221137090.1782@nanos.tec.linutronix.de>
References: <1562747823-16972-1-git-send-email-kernelfans@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2019, Pingfan Liu wrote:
>  
> +static inline bool maxcpus_allowed(unsigned int cpu)
> +{
> +	/* maxcpus only takes effect during system bootup */
> +	if (smp_boot_done)
> +		return true;
> +	if (num_online_cpus() < setup_max_cpus)
> +		return true;
> +	/*
> +	 * maxcpus should allow cpu to set CR4.MCE asap, otherwise the set may
> +	 * be deferred indefinitely.
> +	 */
> +	if (!per_cpu(cpuhp_state, cpu).booted_once)
> +		return true;

As this is a x86 only issue, you cannot inflict this magic on every
architecture.

Aside of that this does not solve the problem at all because smp_init()
still does:

        for_each_present_cpu(cpu) {
                if (num_online_cpus() >= setup_max_cpus)
                        break;
                if (!cpu_online(cpu))
                        cpu_up(cpu);
        }

So the remaining CPUs are not onlined at all.

Thanks,

	tglx
