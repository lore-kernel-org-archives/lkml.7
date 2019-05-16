Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459E1C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207B920815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfEPMjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 08:39:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54764 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfEPMjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:39:13 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4GCcWWP091178;
        Thu, 16 May 2019 21:38:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Thu, 16 May 2019 21:38:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4GCcWGO091151
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 16 May 2019 21:38:32 +0900 (JST)
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
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190515105540.vyzh6n62rqi5imqv@pathway.suse.cz>
 <ee7501c6-d996-1684-1652-f0f838ba69c3@i-love.sakura.ne.jp>
 <20190516115758.6v7oitg3vbkfhh5j@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a3d9de97-46e8-aa43-1743-ebf66b434830@i-love.sakura.ne.jp>
Date:   Thu, 16 May 2019 21:38:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516115758.6v7oitg3vbkfhh5j@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/16 20:57, Petr Mladek wrote:
> CCed Stephen to discuss linux-next related question at the bottom
> of the mail.
> 
> On Thu 2019-05-16 17:19:12, Tetsuo Handa wrote:
>> On 2019/05/15 19:55, Petr Mladek wrote:
>> But in the context of syzbot's testing where there are only 2 CPUs
>> in the target VM (which means that only small number of threads and
>> not so much memory) and threads get SIGKILL after 5 seconds from fork(),
>> being unable to reach do_exit() within 10 seconds is likely a sign of
>> something went wrong. For example, 6 out of 7 trials of a reproducer for
>> https://syzkaller.appspot.com/bug?id=835a0b9e75b14b55112661cbc61ca8b8f0edf767
>> resulted in "no output from test machine" rather than "task hung".
>> This patch is revealing that such killed threads are failing to reach
>> do_exit() because they are trapped at unkillable retry loop due to a
>> race bug.
>>
>> Therefore, I would like to try this patch in linux-next.git for feasibility
>> testing whether this patch helps finding more bugs and reproducers for such
>> bugs, by bringing "unable to terminate threads" reports out of "no output from
>> test machine" reports. We can add sysctl settings before sending to linux.git.
> 
> In this case, the watchdog should get enabled on with
> CONFIG_DEBUG_AID_FOR_SYZBOT

Since "[PATCH] printk: Monitor change of console loglevel." is one time (only
needed until we find the reason of silence), testing on only linux-next.git
is sufficient and it gets enabled on with CONFIG_DEBUG_AID_FOR_SYZBOT.

> 
> Also we should ask/inform Stephen about this. I am not sure
> if he is willing to resolve eventual conflicts for these
> syzboot-specific patches that are not upstream candidates.
> 
> A solution might be to create sysbot-specific for-next branch
> that Stephen might simply ignore when there are conflicts.
> And you would be responsible for updating it.

syzbot tests not only linux-next.git but also various trees, and tests
attempted depends on target git tree. Therefore, apart from whether we
can introduce a kernel config option for fuzzing testing,
"[PATCH] kernel/hung_task.c: Monitor killed tasks." is expected to be
in linux.git. This patch will eventually become upstream candidate.
