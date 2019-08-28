Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B43C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FA422CF4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfH1FCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 01:02:54 -0400
Received: from mail.loongson.cn ([114.242.206.163]:59859 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfH1FCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 01:02:53 -0400
Received: from [10.50.122.134] (unknown [10.50.122.134])
        by mail (Coremail) with SMTP id QMiowPCxecz1CmZdWCM0AA--.2381S3;
        Wed, 28 Aug 2019 13:02:46 +0800 (CST)
Subject: Re: [PATCH] sched/fair: update_curr changed sum_exec_runtime to 1
 when sum_exec_runtime is 0 beacuse some kernel code use sum_exec_runtime==0
 to test task just be forked.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20190826114650.10948-1-qiaochong@loongson.cn>
 <20190827143632.GF2332@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?5LmU5bSH?= <qiaochong@loongson.cn>
Message-ID: <e9b3ea46-550e-e850-57a1-f5df2c7b33d1@loongson.cn>
Date:   Wed, 28 Aug 2019 13:02:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190827143632.GF2332@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
X-CM-TRANSID: QMiowPCxecz1CmZdWCM0AA--.2381S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFy7Zr17Aw4ruw13Kw1fCrg_yoWxXr4fpa
        ykXa4ftrWrXry0qr1UArn7ZFy5J348J3W5Xr4rGa42yr45KryIqr12qrWj9F1UCr48Za47
        Za15X342vw4qyw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkvb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOb18UUUUU=
X-CM-SenderInfo: 5tld0upkrqwqxorr0wxvrqhubq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I find this when I run a docker test script.

#-----script begin--

for((i=0; i<1000000; i++))
do
     echo "=================================== test $i start 
================================"
     rm -rf /media/ram/docker/test/*
     docker run -d --name test -h test -v 
/media/docker/app/dataindex:/media/dataindex -v 
/media/ram/docker/test:/run -v /media/docker/app/test:/media/container 
-v /media/wave:/media/wave:ro -v /run/systemd/journal/dev-log:/dev/log 
--ipc=host --log-driver=journald --init arpubt:mips64el-1.2

     docker ps -s
     docker stats --no-stream

     cp /media/arp/testsvc.tar.gz /media/ram/docker/test/
     docker exec -it test app-manager install testsvc
     sleep 3

     docker ps -s
     docker stats --no-stream
     docker exec -it test monit status
     sleep 3

     docker exec -it test app-manager disable testsvc
     sleep 1

     docker exec -it test monit status
     sleep 3

     docker exec -it test app-manager enable testsvc
     sleep 1

     docker exec -it test app-manager disable testsvc
     sleep 1

     docker exec -it test app-manager enable testsvc
     sleep 1

     docker exec -it test app-manager disable testsvc
     sleep 1

     docker exec -it test app-manager enable testsvc
     sleep 1

     docker ps -s
     docker stats --no-stream
     sleep 1

     docker exec -it test app-manager uninstall testsvc
     sleep 1

     docker rm -f test

     sleep 1
     docker ps -s
     docker stats --no-stream

     echo "================================== test $i end 
=================================="
done

#---- script end---

some times, docker exec will stop longtime.

testsvc is a busy loop application.

int i;

int main()

{

while(1) i++;

}

When use kgdb, I see there are two tasks on run queue,  docker exec's 
vruntime is very large, but which is  value is almost same to  linux 
cgroup's min_vruntime. like bellow:

CFS0 0x98000002de50f6e0, enter cgroup 0xffffffff81349900
CFS1 0x98000002dba65700, enter cgroup 0x98000002dbc4a700
SE:0x98000002dab95618 vruntime:49388638792 14348 14344 runc:[2:INIT] 
ra=0xffffffff80e8e110 sp=0x98000002d2b33d40 epc=0x12006b0f0 
usp=0xffeafc6810 task=0x98000002dab955b0 tinfo=0x98000002d2b30000 
uregs=0x98000002d2b33eb0 stat=0x1
CFS2 0x98000002dba57700, enter cgroup 0x98000000014bf100
se:0x98000002daa92a78 vruntime:49391638792 (always run)14266 13758 
testsvc ra=0xffffffff80e8e110 sp=0x98000002d2cbfe30 epc=0x1200017f0 
usp=0xffffc8bc10 task=0x98000002daa92a10 tinfo=0x98000002d2cbc000 
uregs=0x98000002d2cbfeb0 stat=0x0
se:0x98000002dab5b488 vruntime:242669408647 (large) 14349 14344 
runc:[2:INIT] ra=0xffffffff80e8e110 sp=0x98000002d2b37ba0 
epc=0x12006b3d8 usp=0xffea7c6798 task=0x98000002dab5b420 
tinfo=0x98000002d2b34000 uregs=0x98000002d2b37eb0 stat=0x0

I add check code in sched_move_task, and found that  task has been run 
and is stopped(on_rq == 0), vruntime is not changed through 
sched_move_task function, because se->sum_exec_runtime == 0

I add debug code in update_curr:

     if (unlikely((s64)delta_exec <= 0))
     {
      if (!curr->sum_exec_runtime)
      {
         struct task_struct *p;
         p = container_of(curr, struct task_struct, se);
         if ((p->nvcsw + p->nivcsw) != 0 && entity_is_task(curr))
         {
          curr->sum_exec_runtime += 1;
          dump_stack();
         }
      }
dump_stack also sometimes  was called.

Now after I read your letter, I know the reason is:

     unsigned long long __weak sched_clock(void)
       {
               return (unsigned long long)(jiffies - INITIAL_JIFFIES)
                                               * (NSEC_PER_SEC / HZ);
      }

My kernel use default sched_clock, which use jiffies as schedule clock.

I should use another high resolution schedule clock, then update_curr's  
dalta_exec will not be 0.

So thanks alot, but I still think curr->sum_exec_runtime check code is 
not accurate enough.


在 2019/8/27 下午10:36, Peter Zijlstra 写道:
> On Mon, Aug 26, 2019 at 07:46:50PM +0800, QiaoChong wrote:
>> From: Chong Qiao <qiaochong@loongson.cn>
>>
>> Such as:
>> cpu_cgroup_attach>
>>   sched_move_task>
>>    task_change_group_fair>
>>     task_move_group_fair>
>>      detach_task_cfs_rq>
>>       vruntime_normalized>
>>
>> 	/*
>> 	 * When !on_rq, vruntime of the task has usually NOT been normalized.
>> 	 * But there are some cases where it has already been normalized:
>> 	 *
>> 	 * - A forked child which is waiting for being woken up by
>> 	 *   wake_up_new_task().
>> 	 * - A task which has been woken up by try_to_wake_up() and
>> 	 *   waiting for actually being woken up by sched_ttwu_pending().
>> 	 */
>> 	if (!se->sum_exec_runtime ||
>> 	    (p->state == TASK_WAKING && p->sched_remote_wakeup))
>> 		return true;
>>
>> p->se.sum_exec_runtime is 0, does not mean task not been run (A forked child which is waiting for being woken up by  wake_up_new_task()).
>>
>> Task may have been scheduled multimes, but p->se.sum_exec_runtime is still 0, because delta_exec maybe 0 in update_curr.
>>
>> static void update_curr(struct cfs_rq *cfs_rq)
>> {
>> ...
>> 	delta_exec = now - curr->exec_start;
>> 	if (unlikely((s64)delta_exec <= 0))
>> 		return;
>> ...
>>
>> 	curr->sum_exec_runtime += delta_exec;
>> ...
>> }
>>
>> Task has been run and is stopped(on_rq == 0), vruntime not been normalized, but se->sum_exec_runtime == 0.
>> This cause vruntime_normalized set on_rq 1, and does not normalize vruntime.
>> This may cause task use old vruntime in old cgroup, which maybe very large than task's vruntime in new cgroup.
>> Which may cause task may not scheduled in run queue for long time after been waked up.
>>
>> Now I change sum_exec_runtime to 1 when sum_exec_runtime == 0 in update_curr to make sun_exec_runtime not 0.
> Have you actually observed this? It is very hard to have a 0 delta
> between two scheduling events.
>

-- 


乔崇 qiaochong@loongson.cn

2019年 08月 28日 星期三 11:31:43 CST

