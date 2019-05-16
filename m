Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9233AC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4452082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEPIUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:20:03 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52178 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfEPIUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:20:03 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4G8JFRQ017674;
        Thu, 16 May 2019 17:19:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Thu, 16 May 2019 17:19:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4G8J9Bw017640
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 16 May 2019 17:19:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/hung_task.c: Monitor killed tasks.
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Liu Chuansheng <chuansheng.liu@intel.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
References: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190515105540.vyzh6n62rqi5imqv@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ee7501c6-d996-1684-1652-f0f838ba69c3@i-love.sakura.ne.jp>
Date:   Thu, 16 May 2019 17:19:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515105540.vyzh6n62rqi5imqv@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/15 19:55, Petr Mladek wrote:
>> +	if (!stamp) {
>> +		stamp = jiffies;
>> +		if (!stamp)
>> +			stamp++;
>> +		t->killed_time = stamp;
>> +		return;
>> +	}
> 
> I might be too dumb but the above code looks pretty tricky to me.
> It would deserve a comment. Or better, I would remove
> trick to handle overflow. If it happens, we would just
> lose one check period.

We can use

  static inline unsigned long jiffies_nonzero(void)
  {
      const unsigned long stamp = jiffies;

      return stamp ? stamp : -1;
  }

or even shortcut "jiffies | 1" because difference by one jiffie
is an measurement error for multiple HZ of timeout.

> 
> Alternative solution would be to set the timestamp in
> complete_signal(). Then we would know that the timestamp
> is always valid when a fatal signal is pending.

Yes. But I guess that since signal might be delivered just before
setting PF_FROZEN and the thread might be kept frozen for longer
than timeout, we will need to reset the timestamp just before
clearing PF_FROZEN.



>> +	if (time_is_after_jiffies(stamp + timeout * HZ))
>> +		return;
>> +	trace_sched_process_hang(t);
>> +	if (sysctl_hung_task_panic) {
>> +		console_verbose();
>> +		hung_task_call_panic = true;
> 
> IMHO, the delayed task exit is much less fatal than sleeping
> in an uninterruptible state.
> 
> Anyway, the check is much less reliable. In case of hung_task,
> it is enough when the task gets scheduled. In the new check,
> the task has to do some amount of work until the signal
> gets handled and do_exit() is called.
> 
> The panic should either get enabled separately or we should
> never panic in this case.

OK, we should not share existing sysctl settings.

But in the context of syzbot's testing where there are only 2 CPUs
in the target VM (which means that only small number of threads and
not so much memory) and threads get SIGKILL after 5 seconds from fork(),
being unable to reach do_exit() within 10 seconds is likely a sign of
something went wrong. For example, 6 out of 7 trials of a reproducer for
https://syzkaller.appspot.com/bug?id=835a0b9e75b14b55112661cbc61ca8b8f0edf767
resulted in "no output from test machine" rather than "task hung".
This patch is revealing that such killed threads are failing to reach
do_exit() because they are trapped at unkillable retry loop due to a
race bug.

Therefore, I would like to try this patch in linux-next.git for feasibility
testing whether this patch helps finding more bugs and reproducers for such
bugs, by bringing "unable to terminate threads" reports out of "no output from
test machine" reports. We can add sysctl settings before sending to linux.git.

Any questions?

