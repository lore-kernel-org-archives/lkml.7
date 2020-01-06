Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583EDC00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B31C206F0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgAFDAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 22:00:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:33502 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727323AbgAFDA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:00:29 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 644158C70891016C964B;
        Mon,  6 Jan 2020 11:00:27 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.196) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 6 Jan 2020
 11:00:20 +0800
From:   "liwei (GF)" <liwei391@huawei.com>
Subject: Re: [RFC PATCH] perf tools: cs-etm: fix endless record after being
 terminated
To:     Leo Yan <leo.yan@linaro.org>
CC:     <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <ilubashe@akamai.com>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>
References: <20200102074144.10407-1-liwei391@huawei.com>
 <20200103082414.GB9814@leoy-ThinkPad-X240s>
Message-ID: <acc0afd9-5d0e-dcb8-d56a-ac5680049c8c@huawei.com>
Date:   Mon, 6 Jan 2020 11:00:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200103082414.GB9814@leoy-ThinkPad-X240s>
Content-Type: multipart/mixed;
        boundary="------------529A4C9796225E3A20E1E87B"
X-Originating-IP: [10.173.221.196]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------529A4C9796225E3A20E1E87B
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit

Hi Leo,

Thanks for your test and sorry for missing the reproducing info.
The attachment is my test procedure, i can reproduce this issue
with it on kernel 5.5-rc4 definitely.

I have tested these patches on kernel 5.5-rc4, with intel-pt on Xeon
Gold 6140 (72 cores) and arm-spe on HiSilicon Hi1620 (128 cores).
But i can not test CoreSight temporarily, could you please test it
with the test procedure again?

P.s. Running the test procedure as a normal process is enough.

Thanks£¬
Wei

On 2020/1/3 16:24, Leo Yan wrote:

> 
> I took some time to test on Arm CoreSight, the perf program can be
> terminated by Ctrl+c with SIGINT signal on the mainline kernel.
> 
> And after capturing ftrace data with below log:
> 
> 5242      migration/2-19    [002] d..3  4648.383155: sched_migrate_task: comm=perf pid=1692 prio=120 orig_cpu=2 dest_cpu=0
> 5243      migration/2-19    [002] d..2  4648.383167: sched_switch: prev_comm=migration/2 prev_pid=19 prev_prio=0 prev_state=S ==> next_comm=swapper/2 next_pid=0 next_prio=120
> 5244           <idle>-0     [000] d..2  4648.383167: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=1692 next_prio=120
> 5245             perf-1692  [000] d..2  4648.383193: sched_stat_runtime: comm=perf pid=1692 runtime=35420 [ns] vruntime=1636633943 [ns]
> 5246             perf-1692  [000] d..3  4648.383200: sched_waking: comm=migration/0 pid=11 prio=0 target_cpu=000
> 5247             perf-1692  [000] dN.4  4648.383203: sched_wakeup: comm=migration/0 pid=11 prio=0 target_cpu=000
> 5248             perf-1692  [000] dN.2  4648.383205: sched_stat_runtime: comm=perf pid=1692 runtime=9340 [ns] vruntime=1636643283 [ns]
> 5249             perf-1692  [000] d..2  4648.383208: sched_switch: prev_comm=perf prev_pid=1692 prev_prio=120 prev_state=R+ ==> next_comm=migration/0 next_pid=11 next_prio=0
> 5250      migration/0-11    [000] d..3  4648.383215: sched_migrate_task: comm=perf pid=1692 prio=120 orig_cpu=0 dest_cpu=1
> 5251       algorithm1-721   [001] dN.2  4648.383225: sched_stat_runtime: comm=algorithm1 pid=721 runtime=2906000 [ns] vruntime=3501282256244 [ns]
> 5252       algorithm1-721   [001] d..2  4648.383229: sched_switch: prev_comm=algorithm1 prev_pid=721 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=1692 next_prio=120
> 5253      migration/0-11    [000] d..2  4648.383235: sched_switch: prev_comm=migration/0 prev_pid=11 prev_prio=0 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
> 5254       algorithm1-721   [001] d..4  4648.383241: <stack trace>
> 5255  => kprobe_breakpoint_handler
> 5256  => call_break_hook
> 5257  => brk_handler
> 5258  => do_debug_exception
> 5259  => el1_sync_handler
> 5260  => el1_sync
> 5261  => etm_event_stop
> 5262  => event_sched_out.isra.106
> 5263  => group_sched_out.part.108
> 5264  => ctx_sched_out
> 5265  => task_ctx_sched_out
> 5266  => __perf_event_task_sched_out
> 5267  => __schedule
> 5268  => schedule
> 5269  => do_notify_resume
> 5270  => work_pending
> 
> We can see after send SIGINT signal, the process 'perf' will be
> migrated from CPU2 to CPU0 (line 5242) and it will preempt process
> 'algorithm1' (line 5252); after the process 'algorithm1' is scheduled
> out, the function etm_event_stop() will be invoked to stop tracing.
> 
> If we connect with the code in cs_etm_read_finish(), it tries to call
> ioctl PERF_EVENT_IOC_ENABLE, but because the process 'algorithm1' is
> scheduled out, so the perf event should not be enabled afterwards.
> 
> I may miss something at here ... Could you confirm what's the type of
> attached process?  normal process or RT process?
> 
> Thanks,
> Leo
> 
> P.s. I tested IntelPT with 5.2-rc3 kernel, it also can be terminated
> properly.
> 
>>  	return -EINVAL;
>> -- 
>> 2.17.1
>>
> 
> .
> 


--------------529A4C9796225E3A20E1E87B
Content-Type: text/plain; charset="UTF-8"; name="perf_endless_record.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="perf_endless_record.c"

#define _GNU_SOURCE

#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/sysinfo.h>
#include <unistd.h>
#include <sched.h>
#include <ctype.h>
#include <string.h>
#include <pthread.h>

int num = 0;
int test[65535];

int mess_rw(int data)
{
    int i;

    while (1) {
        for (i = 0; i < (sizeof(test) / sizeof(test[0])); i++) {
            if (test[i] != data)
                test[i] = data;
        }
    }
}

void *test_thread(void *arg)
{
    int cpu = *(int *)arg;
    cpu_set_t mask;

    CPU_ZERO(&mask);
    CPU_SET(cpu, &mask);
    if (!sched_setaffinity(0, sizeof(mask), &mask))
        printf("thread %d: running on cpu %d\n", cpu, cpu);
    else
        printf("thread %d: fail to set CPU affinity\n", cpu);

    mess_rw(cpu);

    return NULL;
}

int main(int argc, char *argv[])
{
    num = sysconf(_SC_NPROCESSORS_CONF);
    pthread_t thread[num];
    int id[num];
    int i;

    printf("PID %d on system with %d processor(s)\n", getpid(), num);

    for (i = 0; i < num; i++) {
        id[i] = i;
        pthread_create(&thread[i], NULL, test_thread, (void *)&id[i]);
    }

    for (i = 0; i < num; i++) {
        pthread_join(thread[i], NULL);
    }

    return 0;
}


--------------529A4C9796225E3A20E1E87B--
