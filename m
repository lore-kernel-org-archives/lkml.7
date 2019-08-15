Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DD2C32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 02:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880E2208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 02:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfHOCAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 22:00:18 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:43688 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727273AbfHOCAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 22:00:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=kerneljasonxing@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TZVw0gI_1565834379;
Received: from ali-6c96cfdd2b5d.local(mailfrom:kerneljasonxing@linux.alibaba.com fp:SMTPD_---0TZVw0gI_1565834379)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Aug 2019 09:59:54 +0800
Subject: Re: [PATCH v2] psi: get poll_work to run when calling poll syscall
 next time
To:     hannes@cmpxchg.org, surenb@google.com
Cc:     dennis@kernel.org, mingo@redhat.com, axboe@kernel.dk,
        lizefan@huawei.com, peterz@infradead.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, caspar@linux.alibaba.com,
        joseph.qi@linux.alibaba.com
References: <1563864339-2621-1-git-send-email-kerneljasonxing@linux.alibaba.com>
 <1564463819-120014-1-git-send-email-kerneljasonxing@linux.alibaba.com>
From:   Jason Xing <kerneljasonxing@linux.alibaba.com>
Message-ID: <3208597b-05d1-2461-729b-c35bd6811188@linux.alibaba.com>
Date:   Thu, 15 Aug 2019 09:59:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564463819-120014-1-git-send-email-kerneljasonxing@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It's been delayed for no reason a couple of days. Any comments and 
suggestions on this patch V2 would be appreciated.

Thanks,
Jason

On 2019/7/30 下午1:16, Jason Xing wrote:
> Only when calling the poll syscall the first time can user
> receive POLLPRI correctly. After that, user always fails to
> acquire the event signal.
> 
> Reproduce case:
> 1. Get the monitor code in Documentation/accounting/psi.txt
> 2. Run it, and wait for the event triggered.
> 3. Kill and restart the process.
> 
> If the user doesn't kill the monitor process, it seems the
> poll_work works fine. After killing and restarting the monitor,
> the poll_work in kernel will never run again due to the wrong
> value of poll_scheduled. Therefore, we should reset the value
> as group_init() does after the last trigger is destroyed.
> 
> [PATCH V2]
> In the patch v2, I put the atomic_set(&group->poll_scheduled, 0);
> into the right place.
> Here I quoted from Johannes as the best explaination:
> "The question is why we can end up with poll_scheduled = 1 but the work
> not running (which would reset it to 0). And the answer is because the
> scheduling side sees group->poll_kworker under RCU protection and then
> schedules it, but here we cancel the work and destroy the worker. The
> cancel needs to pair with resetting the poll_scheduled flag."
> 
> Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
> Reviewed-by: Caspar Zhang <caspar@linux.alibaba.com>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>   kernel/sched/psi.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7acc632..acdada0 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1131,7 +1131,14 @@ static void psi_trigger_destroy(struct kref *ref)
>   	 * deadlock while waiting for psi_poll_work to acquire trigger_lock
>   	 */
>   	if (kworker_to_destroy) {
> +		/*
> +		 * After the RCU grace period has expired, the worker
> +		 * can no longer be found through group->poll_kworker.
> +		 * But it might have been already scheduled before
> +		 * that - deschedule it cleanly before destroying it.
> +		 */
>   		kthread_cancel_delayed_work_sync(&group->poll_work);
> +		atomic_set(&group->poll_scheduled, 0);
>   		kthread_destroy_worker(kworker_to_destroy);
>   	}
>   	kfree(t);
> 
