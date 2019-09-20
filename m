Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3102EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29BD20644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfITN0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 09:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfITN0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:26:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5EA7205F4;
        Fri, 20 Sep 2019 13:26:01 +0000 (UTC)
Date:   Fri, 20 Sep 2019 09:26:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 25/32] trace: Use pr_warn instead of pr_warning
Message-ID: <20190920092600.29a26322@gandalf.local.home>
In-Reply-To: <20190920062544.180997-26-wangkefeng.wang@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
        <20190920062544.180997-26-wangkefeng.wang@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 14:25:37 +0800
Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
> pr_warning"), removing pr_warning so all logging messages use a
> consistent <prefix>_warn style. Let's do it.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  kernel/trace/trace_benchmark.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
> index 80e0b2aca703..2e9a4746ea85 100644
> --- a/kernel/trace/trace_benchmark.c
> +++ b/kernel/trace/trace_benchmark.c
> @@ -178,14 +178,14 @@ static int benchmark_event_kthread(void *arg)
>  int trace_benchmark_reg(void)
>  {
>  	if (!ok_to_run) {
> -		pr_warning("trace benchmark cannot be started via kernel command line\n");
> +		pr_warn("trace benchmark cannot be started via kernel command line\n");
>  		return -EBUSY;
>  	}
>  
>  	bm_event_thread = kthread_run(benchmark_event_kthread,
>  				      NULL, "event_benchmark");
>  	if (IS_ERR(bm_event_thread)) {
> -		pr_warning("trace benchmark failed to create kernel thread\n");
> +		pr_warn("trace benchmark failed to create kernel thread\n");
>  		return PTR_ERR(bm_event_thread);
>  	}
>  

