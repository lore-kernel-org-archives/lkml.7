Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632ABC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7E02081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfECKoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 06:44:13 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51625 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfECKoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:44:10 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x43Ai4CN052528;
        Fri, 3 May 2019 19:44:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Fri, 03 May 2019 19:44:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x43Ai4Es052522
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 3 May 2019 19:44:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/hung_task.c: Replace trigger_all_cpu_backtrace()
 with task traversal.
To:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
References: <1556538727-11876-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <39601316-2a59-bbd7-7570-0592f1791ff4@i-love.sakura.ne.jp>
Date:   Fri, 3 May 2019 19:44:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556538727-11876-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry, I know you are currently OOO.

For the record, two console outputs from two bug reports showed that syzbot is
dropping hint of the culprit thread which is causing the khungtaskd to fire.

  https://syzkaller.appspot.com/text?tag=CrashLog&x=1104bb90a00000
  https://syzkaller.appspot.com/text?tag=CrashLog&x=135ff034a00000

On 2019/04/29 20:52, Tetsuo Handa wrote:
> Since trigger_all_cpu_backtrace() uses NMI interface, printk() from other
> CPUs are called from interrupt context. Therefore, CONFIG_PRINTK_CALLER=y
> needlessly separates printk() from khungtaskd kernel thread running on
> current CPU and printk() from other threads running on other CPUs.
> 
> Also, it is completely a garbage that trigger_all_cpu_backtrace() reports
> khungtaskd kernel thread running on current CPU, for the purpose of
> calling trigger_all_cpu_backtrace() from khungtaskd is to report running
> threads which might have caused other threads being blocked for so long.
> 
> Therefore, report threads (except khungtaskd kernel thread itself) which
> are on the scheduler using task traversal approach. This allows syzbot to
> include backtrace of running threads into its report files.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  kernel/hung_task.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index f108a95..2fddd98 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -164,6 +164,23 @@ static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
>  	return can_cont;
>  }
>  
> +static void print_all_running_threads(void)
> +{
> +#ifdef CONFIG_SMP
> +	struct task_struct *g;
> +	struct task_struct *t;
> +
> +	rcu_read_lock();
> +	for_each_process_thread(g, t) {
> +		if (!t->on_cpu || t == current)
> +			continue;
> +		pr_err("INFO: Currently running\n");
> +		sched_show_task(t);
> +	}
> +	rcu_read_unlock();
> +#endif
> +}
> +
>  /*
>   * Check whether a TASK_UNINTERRUPTIBLE does not get woken up for
>   * a really long time (120 seconds). If that happens, print out
> @@ -201,7 +218,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  	if (hung_task_show_lock)
>  		debug_show_all_locks();
>  	if (hung_task_call_panic) {
> -		trigger_all_cpu_backtrace();
> +		print_all_running_threads();
>  		panic("hung_task: blocked tasks");
>  	}
>  }
> 

