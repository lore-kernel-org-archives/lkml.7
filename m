Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DC3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043AD21903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403837AbfDXRbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:31:34 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53060 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403814AbfDXRbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:31:31 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3OHUlvr073958;
        Thu, 25 Apr 2019 02:30:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Thu, 25 Apr 2019 02:30:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3OHUfYh073950
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 25 Apr 2019 02:30:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 3.18 031/104] locking/lockdep: Add debug_locks check in
 __lock_downgrade()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     stable@vger.kernel.org,
        syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20190424170839.996641496@linuxfoundation.org>
 <20190424170857.262137613@linuxfoundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <36884649-83bb-67b6-168b-7b178ead7ddf@i-love.sakura.ne.jp>
Date:   Thu, 25 Apr 2019 02:30:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424170857.262137613@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/04/25 2:08, Greg Kroah-Hartman wrote:
> [ Upstream commit 71492580571467fb7177aade19c18ce7486267f5 ]
> 
> Tetsuo Handa had reported he saw an incorrect "downgrading a read lock"
> warning right after a previous lockdep warning. It is likely that the
> previous warning turned off lock debugging causing the lockdep to have
> inconsistency states leading to the lock downgrade warning.
> 
> Fix that by add a check for debug_locks at the beginning of
> __lock_downgrade().

Excuse me?

> 
> Debugged-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Reported-by: syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com
> Signed-off-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Link: https://lkml.kernel.org/r/1547093005-26085-1-git-send-email-longman@redhat.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/locking/lockdep.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index fb90ca3a296e..27de98428367 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3312,6 +3312,9 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
>  	unsigned int depth;
>  	int i;
>  
> +	if (unlikely(!debug_locks))
> +		return 0;
> +

This is __lock_set_class() function rather than __lock_downgrade() function.
__lock_downgrade() is available in 4.12+.

For 3.18-stable, downgrade_write() is in kernel/locking/rwsem.c . Therefore,
we should check whether adding this check into __lock_set_class() is what
we want to do...

>  	depth = curr->lockdep_depth;
>  	/*
>  	 * This function is about (re)setting the class of a held lock,
> 
