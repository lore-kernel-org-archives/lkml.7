Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C74EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A82320679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565643758;
	bh=HdtES/JZD1pzNL+NsSsjAHI5TprD4NtHrngjAEp3k+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JLGLfHtKZhtsndJTQZn69//Bx9302vew788IBlX+ShXD4pzZvH1RTdGHguaRG6Zdl
	 t2XByRVEWRTcZXqcimg3hFa3q3atdjU85fEcG4ZA4bPocvp366d+AEXXZzvMyJNnpS
	 qzfAePwXDwG8V8RP+kwhXkHILHP+Hp06ZyiWKM7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfHLVCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfHLVCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:02:36 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA0B32085A;
        Mon, 12 Aug 2019 21:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565643756;
        bh=HdtES/JZD1pzNL+NsSsjAHI5TprD4NtHrngjAEp3k+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNKF9aJHlZemAWlWGbShw4TAXTCEfxdZNNALki5iJ5Sz9Wfy/YHKc6Xg3rRxjM4fY
         10NGl/e8Lo6wKNpuDaKkLZj0kMSuv5wdxZw9a2AzzyPK34JhJ2kp8XJ3I0xi4M5/K/
         NEQRJ4vf48M6gfmSQLM/hmcAogTFQitQai5IBKRE=
Date:   Mon, 12 Aug 2019 23:02:33 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Message-ID: <20190812210232.GA3648@lenoir>
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-14-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802151501.13069-14-paulmck@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:15:01AM -0700, Paul E. McKenney wrote:
> The multi_cpu_stop() function relies on the scheduler to gain control from
> whatever is running on the various online CPUs, including any nohz_full
> CPUs running long loops in kernel-mode code.  Lack of the scheduler-clock
> interrupt on such CPUs can delay multi_cpu_stop() for several minutes
> and can also result in RCU CPU stall warnings.  This commit therefore
> causes multi_cpu_stop() to enable the scheduler-clock interrupt on all
> online CPUs.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> ---
>  kernel/stop_machine.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index b4f83f7bdf86..a2659f61ed92 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -20,6 +20,7 @@
>  #include <linux/smpboot.h>
>  #include <linux/atomic.h>
>  #include <linux/nmi.h>
> +#include <linux/tick.h>
>  #include <linux/sched/wake_q.h>
>  
>  /*
> @@ -187,15 +188,19 @@ static int multi_cpu_stop(void *data)
>  {
>  	struct multi_stop_data *msdata = data;
>  	enum multi_stop_state curstate = MULTI_STOP_NONE;
> -	int cpu = smp_processor_id(), err = 0;
> +	int cpu, err = 0;
>  	const struct cpumask *cpumask;
>  	unsigned long flags;
>  	bool is_active;
>  
> +	for_each_online_cpu(cpu)
> +		tick_nohz_dep_set_cpu(cpu, TICK_DEP_MASK_RCU);

Looks like it's not the right fix but, should you ever need to set an
all-CPUs (system wide) tick dependency in the future, you can use tick_set_dep().

Thanks.
