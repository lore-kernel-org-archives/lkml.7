Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C91C47410
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645AE22CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfKMPtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:49:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfKMPtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:49:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B8222B4B;
        Wed, 13 Nov 2019 15:49:47 +0000 (UTC)
Date:   Wed, 13 Nov 2019 10:49:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greentime Hu <green.hu@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Burton <paulburton@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <deanbo422@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 01/50] kallsyms/printk: Add loglvl to print_ip_sym()
Message-ID: <20191113104945.604e34d2@gandalf.local.home>
In-Reply-To: <20191106030542.868541-2-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
        <20191106030542.868541-2-dima@arista.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Nov 2019 03:04:52 +0000
Dmitry Safonov <dima@arista.com> wrote:

> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2002,12 +2002,12 @@ void ftrace_bug(int failed, struct dyn_ftrace *rec)
>  	case -EFAULT:
>  		FTRACE_WARN_ON_ONCE(1);
>  		pr_info("ftrace faulted on modifying ");

Hmm, I wonder if I should change that from info to something more
important, as this is important information for debugging. But this has
nothing to do with this patch set.

> -		print_ip_sym(ip);
> +		print_ip_sym(KERN_INFO, ip);

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  		break;
>  	case -EINVAL:
>  		FTRACE_WARN_ON_ONCE(1);
>  		pr_info("ftrace failed to modify ");
> -		print_ip_sym(ip);
> +		print_ip_sym(KERN_INFO, ip);
>  		print_ip_ins(" actual:   ", (unsigned char *)ip);
>  		pr_cont("\n");
>  		if (ftrace_expected) {
> @@ -2018,12 +2018,12 @@ void ftrace_bug(int failed, struct dyn_ftrace *rec)
>  	case -EPERM:
>  		FTRACE_WARN_ON_ONCE(1);
>  		pr_info("ftrace faulted on writing ");
> -		print_ip_sym(ip);
> +		print_ip_sym(KERN_INFO, ip);
>  		break;
>  	default:
>  		FTRACE_WARN_ON_ONCE(1);
>  		pr_info("ftrace faulted on unknown error ");
> -		print_ip_sym(ip);
> +		print_ip_sym(KERN_INFO, ip);
>  	}
>  	print_bug_type();
>  	if (rec) {

