Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D779C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AB620850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LEYe+K66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfDKAP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:15:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45926 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfDKAP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 20:15:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3B00DAg174755;
        Thu, 11 Apr 2019 00:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ZE0Izvf5nzZxCJ/OcSAToK5lGjnoIFnhYkDGbZEZ6ZE=;
 b=LEYe+K66LGKaugCFdAnSWj2H5td93cEHq144Ekjj7jVVAnh3rzH4oL+uqgXaXIdgKKBC
 +/rP7K98uDNRpFyPn4+oW5jhx+mm0+MIlf6/puyjzZpR8ohPo1bMw3NnhmB8y5k6OHI6
 odNAg50CrgwSHP/QuvstkKNjXkpgHkRgNe2XgakQbj6Hl8bbRxdwAcO2D7f55hpGr4h6
 l+ShaB/5N49HH9v04JptHWkF+GUmy5PCHHZEfzGcIL0bt6YoHh7bacWHwMDYDp/1lxQO
 PqKOyXj3MpsKMw8iSOo6Y5A6XtDB5LvzhsjM7aNHkYMyMJGZijXdqhnNXLH2vpbSIacj Hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2rphmep4eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 00:15:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3B0Dv0f003434;
        Thu, 11 Apr 2019 00:15:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2rpkek6fgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 00:15:20 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3B0FENT001490;
        Thu, 11 Apr 2019 00:15:19 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Apr 2019 17:15:14 -0700
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and
 scheduling.
To:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
References: <20190218173514.667598558@infradead.org>
 <1554835135-11814-1-git-send-email-jdesfossez@digitalocean.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <3514bb97-33bc-3a14-3f15-767682b2f035@oracle.com>
Date:   Wed, 10 Apr 2019 17:11:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554835135-11814-1-git-send-email-jdesfossez@digitalocean.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100157
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/9/19 11:38 AM, Julien Desfossez wrote:
> We found the source of the major performance regression we discussed
> previously. It turns out there was a pattern where a task (a kworker in this
> case) could be woken up, but the core could still end up idle before that
> task had a chance to run.
>
> Example sequence, cpu0 and cpu1 and siblings on the same core, task1 and
> task2 are in the same cgroup with the tag enabled (each following line
> happens in the increasing order of time):
> - task1 running on cpu0, task2 running on cpu1
> - sched_waking(kworker/0, target_cpu=cpu0)
> - task1 scheduled out of cpu0
> - kworker/0 cannot run on cpu0 because of task2 is still running on cpu1
>    cpu0 is idle
> - task2 scheduled out of cpu1
> - cpu1 doesn’t select kworker/0 for cpu0, because the optimization path ends
>    the task selection if core_cookie is NULL for currently selected process
>    and the cpu1’s runqueue.
> - cpu1 is idle
> --> both siblings are idle but kworker/0 is still in the run queue of cpu0.
>      Cpu0 may stay idle for longer if it goes deep idle.
>
> With the fix below, we ensure to send an IPI to the sibling if it is idle
> and has tasks waiting in its runqueue.
> This fixes the performance issue we were seeing.
>
> Now here is what we can measure with a disk write-intensive benchmark:
> - no performance impact with enabling core scheduling without any tagged
>    task,
> - 5% overhead if one tagged task is competing with an untagged task,
> - 10% overhead if 2 tasks tagged with a different tag are competing
>    against each other.
>
> We are starting more scaling tests, but this is very encouraging !
>
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e1fa10561279..02c862a5e973 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3779,7 +3779,22 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   
>   				trace_printk("unconstrained pick: %s/%d %lx\n",
>   						next->comm, next->pid, next->core_cookie);
> +				rq->core_pick = NULL;
>   
> +				/*
> +				 * If the sibling is idling, we might want to wake it
> +				 * so that it can check for any runnable but blocked tasks
> +				 * due to previous task matching.
> +				 */
> +				for_each_cpu(j, smt_mask) {
> +					struct rq *rq_j = cpu_rq(j);
> +					rq_j->core_pick = NULL;
> +					if (j != cpu && is_idle_task(rq_j->curr) && rq_j->nr_running) {
> +						resched_curr(rq_j);
> +						trace_printk("IPI(%d->%d[%d]) idle preempt\n",
> +							     cpu, j, rq_j->nr_running);
> +					}
> +				}
>   				goto done;
>   			}
>   
I see similar improvement with this patch as removing the condition I
earlier mentioned. So that's not needed. I also included the patch for the
priority fix. For 2 DB instances, HT disabling stands at -22% for 32 users
(from earlier emails).


1 DB instance

users  baseline   %idle    core_sched %idle
16     1          84       -4.9% 84
24     1          76       -6.7% 75
32     1          69       -2.4% 69

2 DB instance

users  baseline   %idle    core_sched %idle
16     1          66       -19.5% 69
24     1          54       -9.8% 57
32     1          42       -27.2%        48
