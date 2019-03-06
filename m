Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4858C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770A120684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KdFadkKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfCFMik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:38:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfCFMik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 07:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kfpJRDy1xHfMNuiuhzjAegVPQHwdm/b8Qr2fOAvHYnY=; b=KdFadkKbW3zq3TxtZ6EirhzG4
        2QdeIQYbfDSeIhBVFUngQN1eTI3sQwErkck/zPUUMOopg24wctk42NGWZbKlA0x54/0nqohyXfv54
        YFBMpkZuM2w8Lka39kgLdsBZLmyRZ0lunXKMya9l2Vs9XghTRIy9pOmKq9kqTSydx6DK6TsRHiCvs
        n22gIuneWfnzcP0XQ8bzkbmgEb25Pu1JIFuZ7YJrAmJFN/+bjZDshQ6NuWI//yOSg/8vxrrMgCD55
        Foc04CqsmfZr0i0PgkloqObM8Csrhfuycj6AnzY4F4C2yrapCiBWhSPVXv0ro+RLCpM2Yrxoyb/1M
        ja9BjUHTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1Voj-0001ID-Dp; Wed, 06 Mar 2019 12:38:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4410B2029E064; Wed,  6 Mar 2019 13:38:34 +0100 (CET)
Date:   Wed, 6 Mar 2019 13:38:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        shaoyafang@didiglobal.com
Subject: Re: [PATCH] sched: fair: fix missed CONFIG_SCHEDSTATS
Message-ID: <20190306123834.GW32494@hirez.programming.kicks-ass.net>
References: <1551861826-12592-1-git-send-email-laoar.shao@gmail.com>
 <20190306100907.GT32477@hirez.programming.kicks-ass.net>
 <CALOAHbC1zqzU8-ikcLOUMKY5cbyuW_B6MK5rz7G6rTK-SoyMTQ@mail.gmail.com>
 <20190306112707.GU32477@hirez.programming.kicks-ass.net>
 <CALOAHbB7EZ83R3gHcGa9oZWq=7CEgBkL2cXav_7N13u4U44+uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbB7EZ83R3gHcGa9oZWq=7CEgBkL2cXav_7N13u4U44+uA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 07:49:36PM +0800, Yafang Shao wrote:


$ grep SCHEDSTAT defconfig-build/.config
# CONFIG_SCHEDSTATS is not set
$ obbjdump -dr defconfig-build/kernel/sched/fair.o | awk '/>:$/ { F=$2 } /sched_stat/ { print F " " $0 }'
<update_curr>:                  24cd: R_X86_64_32S      __tracepoint_sched_stat_runtime+0x28
<update_curr>:                  24d9: R_X86_64_PC32     __tracepoint_sched_stat_runtime+0x24
$ patch -p1 < foo
patching file kernel/sched/fair.c
$ make O=defconfig-build kernel/sched/
make[1]: Entering directory '/usr/src/linux-2.6/defconfig-build'
Using .. as source for kernel
GEN     Makefile
CALL    ../scripts/checksyscalls.sh
CALL    ../scripts/atomic/check-atomics.sh
DESCEND  objtool
CC      kernel/sched/fair.o
AR      kernel/sched/built-in.a
make[1]: Leaving directory '/usr/src/linux-2.6/defconfig-build'
$ objdump -dr defconfig-build/kernel/sched/fair.o | awk '/>:$/ { F=$2 } /sched_stat/ { print F " " $0 }'
$ cat foo
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8213ff6e365d..6e5ceec3b662 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -839,7 +839,8 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (entity_is_task(curr)) {
 		struct task_struct *curtask = task_of(curr);
 
-		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
+		if (schedstat_enabled())
+			trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
 		cgroup_account_cputime(curtask, delta_exec);
 		account_group_exec_runtime(curtask, delta_exec);
 	}


_1_ line, where you wanted to add _6_ ugly #ifdefs
