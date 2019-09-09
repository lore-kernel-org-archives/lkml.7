Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B808C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0FC21479
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404748AbfIIMlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:41:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55602 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfIIMlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:41:13 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x89CeRLt047567;
        Mon, 9 Sep 2019 21:40:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Mon, 09 Sep 2019 21:40:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x89CeRQo047564
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 9 Sep 2019 21:40:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH (resend)] mm,oom: Defer dump_tasks() output.
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <1567159493-5232-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <7de2310d-afbd-e616-e83a-d75103b986c6@i-love.sakura.ne.jp>
 <20190909113627.GJ27159@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <579a27d2-52fb-207e-9278-fc20a2154394@i-love.sakura.ne.jp>
Date:   Mon, 9 Sep 2019 21:40:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190909113627.GJ27159@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/09/09 20:36, Michal Hocko wrote:
> On Sat 07-09-19 19:54:32, Tetsuo Handa wrote:
>> (Resending to LKML as linux-mm ML dropped my posts.)
>>
>> If /proc/sys/vm/oom_dump_tasks != 0, dump_header() can become very slow
>> because dump_tasks() synchronously reports all OOM victim candidates, and
>> as a result ratelimit test for dump_header() cannot work as expected.
>>
>> This patch defers dump_tasks() output till oom_lock is released. As a
>> result of this patch, the latency between out_of_memory() is called and
>> SIGKILL is sent (and the OOM reaper starts reclaiming memory) will be
>> significantly reduced.
>>
>> Since CONFIG_PRINTK_CALLER was introduced, concurrent printk() became less
>> problematic. But we still need to correlate synchronously printed messages
>> and asynchronously printed messages if we defer dump_tasks() messages.
>> Thus, this patch also prefixes OOM killer messages using "OOM[$serial]:"
>> format. As a result, OOM killer messages would look like below.
>>
>>   [   31.935015][   T71] OOM[1]: kworker/4:1 invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=-1, oom_score_adj=0
>>   (...snipped....)
>>   [   32.052635][   T71] OOM[1]: oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),global_oom,task_memcg=/,task=firewalld,pid=737,uid=0
>>   [   32.056886][   T71] OOM[1]: Out of memory: Killed process 737 (firewalld) total-vm:358672kB, anon-rss:22640kB, file-rss:12328kB, shmem-rss:0kB, UID:0 pgtables:421888kB oom_score_adj:0
>>   [   32.064291][   T71] OOM[1]: Tasks state (memory values in pages):
>>   [   32.067807][   T71] OOM[1]: [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
>>   [   32.070057][   T54] oom_reaper: reaped process 737 (firewalld), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
>>   [   32.072417][   T71] OOM[1]: [    548]     0   548     9772     1172   110592        0             0 systemd-journal
>>   (...snipped....)
>>   [   32.139566][   T71] OOM[1]: [    737]     0   737    89668     8742   421888        0             0 firewalld
>>   (...snipped....)
>>   [   32.221990][   T71] OOM[1]: [   1300]    48  1300    63025     1788   532480        0             0 httpd
>>
>> This patch might affect panic behavior triggered by panic_on_oom or no
>> OOM-killable tasks, for dump_header(oc, NULL) will not report OOM victim
>> candidates if there are not-yet-reported OOM victim candidates from past
>> rounds of OOM killer invocations. I don't know if that matters.
>>
>> For now this patch embeds "struct oom_task_info" into each
>> "struct task_struct". In order to avoid bloating "struct task_struct",
>> future patch might detach from "struct task_struct" because one
>> "struct oom_task_info" for one "struct signal_struct" will be enough.
> 
> This is not an improvement. It detaches the oom report and tasks_dump
> for an arbitrary amount of time because the worder context might be
> stalled for an arbitrary time. Even long after the oom is resolved.

A new worker thread is created if all existing worker threads are busy
because this patch solves OOM situation quickly when a new worker thread
cannot be created due to OOM situation.

Also, if a worker thread cannot run due to CPU starvation, the same thing
applies to dump_tasks(). In other words, dump_tasks() cannot complete due
to CPU starvation, which results in more costly and serious consequences.
Being able to send SIGKILL and reclaim memory as soon as possible is
an improvement.

> Not to mention that 1:1 (oom to tasks) information dumping is
> fundamentally broken. Any task might be on an oom list of different
> OOM contexts in different oom scopes (think of OOM happening in disjunct
> NUMA sets).

I can't understand what you are talking about. This patch just defers
printk() from /proc/sys/vm/oom_dump_tasks != 0. Please look at the patch
carefully. If you are saying that it is bad that OOM victim candidates for
OOM domain B, C, D ... cannot be printed if printing of OOM victim candidates
for OOM domain A has not finished, I can update this patch to print them.

> 
> This is just adding more kludges and making the code more complex
> without trying to address an underlying problems. So
> Nacked-by: Michal Hocko <mhocko@suse.com>

Since I'm sure that you are misunderstanding, this Nacked-by is invalid.

> 
> And more importantly it is _known_ that dump_tasks might be costly.

So what? That's an unfortunate reason people have to use
/proc/sys/vm/oom_dump_tasks == 0. That's not a reason we must not
offload costly dump_tasks().

Preemption from dump_tasks() is _fatally_ costly (e.g. SCHED_IDLE tasks
calls out_of_memory() while there are many realtime tasks running around).
This patch minimizes latency between "an allocating thread decided to
invoke the OOM killer" and "the OOM killer sends SIGKILL (and the OOM
reaper starts reclaiming memory)". In other words, this patch reduces
unoperational duration due to OOM condition.

> People who really need that information have to live with that fact.
> There is the way to disable this functionality. I wish we could have it
> disabled by default but it seems I am alone in that thinking so I am not
> going to push for it.

Setting /proc/sys/vm/oom_dump_tasks == 0 is not a solution.
We need a solution which can work with /proc/sys/vm/oom_dump_tasks != 0.

