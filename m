Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00C5C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E01920881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfENWaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:30:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbfENWaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:30:13 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EMQtDY011941
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 18:30:12 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sg3nc6nem-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 18:30:12 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 14 May 2019 23:30:11 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 May 2019 23:30:08 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4EMSrMR19857518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 22:28:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA96CB2065;
        Tue, 14 May 2019 22:28:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD1BFB205F;
        Tue, 14 May 2019 22:28:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 14 May 2019 22:28:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9573016C1285; Tue, 14 May 2019 15:28:52 -0700 (PDT)
Date:   Tue, 14 May 2019 15:28:52 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Liu Chuansheng <chuansheng.liu@intel.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] kernel/hung_task.c: Monitor killed tasks.
Reply-To: paulmck@linux.ibm.com
References: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19051422-0064-0000-0000-000003DE67A4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011099; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01203385; UDB=6.00631653; IPR=6.00984306;
 MB=3.00026893; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-14 22:30:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051422-0065-0000-0000-00003D78A060
Message-Id: <20190514222852.GE4184@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 08:02:11PM +0900, Tetsuo Handa wrote:
> syzbot's second top report is "no output from test machine" where the
> userspace process failed to spawn a new test process for 300 seconds
> for some reason. One of reasons which can result in this report is that
> an already spawned test process was unable to terminate (e.g. trapped at
> an unkillable retry loop due to some bug) after SIGKILL was sent to that
> process. Therefore, reporting when a thread is failing to terminate
> despite a fatal signal is pending would give us more useful information.
> 
> This version shares existing sysctl settings (e.g. check interval,
> timeout, whether to panic) used for detecting TASK_UNINTERRUPTIBLE
> threads, for I don't know whether people want to use a new kernel
> config option and different sysctl settings for monitoring killed
> threads.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>

Looks good to me.

Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>

A few inconsequential comments below.

> ---
>  include/linux/sched.h |  1 +
>  kernel/hung_task.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index a2cd1585..d42bdd7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -850,6 +850,7 @@ struct task_struct {
>  #ifdef CONFIG_DETECT_HUNG_TASK
>  	unsigned long			last_switch_count;
>  	unsigned long			last_switch_time;
> +	unsigned long			killed_time;
>  #endif
>  	/* Filesystem information: */
>  	struct fs_struct		*fs;
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index f108a95..34e7b84 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -141,6 +141,47 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  	touch_nmi_watchdog();
>  }
>  
> +static void check_killed_task(struct task_struct *t, unsigned long timeout)
> +{
> +	unsigned long stamp = t->killed_time;
> +
> +	/*
> +	 * Ensure the task is not frozen.
> +	 * Also, skip vfork and any other user process that freezer should skip.
> +	 */
> +	if (unlikely(t->flags & (PF_FROZEN | PF_FREEZER_SKIP)))
> +		return;
> +	/*
> +	 * Skip threads which are already inside do_exit(), for exit_mm() etc.
> +	 * might take many seconds.
> +	 */
> +	if (t->flags & PF_EXITING)
> +		return;
> +	if (!stamp) {
> +		stamp = jiffies;
> +		if (!stamp)
> +			stamp++;

Cute trick to avoid issues with jiffy overflow on 32-bit systems.  ;-)

> +		t->killed_time = stamp;
> +		return;
> +	}
> +	if (time_is_after_jiffies(stamp + timeout * HZ))

And if I understand correctly, timeout of zero disables everything, so
we don't get the backwards false-positive comparison above.

> +		return;
> +	trace_sched_process_hang(t);
> +	if (sysctl_hung_task_panic) {
> +		console_verbose();
> +		hung_task_call_panic = true;
> +	}
> +	/*
> +	 * This thread failed to terminate for more than
> +	 * sysctl_hung_task_timeout_secs seconds, complain:
> +	 */
> +	pr_err("INFO: task %s:%d can't die for more than %ld seconds.\n",
> +	       t->comm, t->pid, (jiffies - stamp) / HZ);
> +	sched_show_task(t);
> +	hung_task_show_lock = true;
> +	touch_nmi_watchdog();
> +}
> +
>  /*
>   * To avoid extending the RCU grace period for an unbounded amount of time,
>   * periodically exit the critical section and enter a new one.
> @@ -192,6 +233,9 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  				goto unlock;
>  			last_break = jiffies;
>  		}
> +		/* Check threads which are about to terminate. */
> +		if (unlikely(fatal_signal_pending(t)))
> +			check_killed_task(t, timeout);
>  		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
>  		if (t->state == TASK_UNINTERRUPTIBLE)
>  			check_hung_task(t, timeout);
> -- 
> 1.8.3.1
> 

