Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03292C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C838320679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfG2VmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbfG2VmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:42:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D74D308FC47;
        Mon, 29 Jul 2019 21:42:23 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7831260167;
        Mon, 29 Jul 2019 21:42:21 +0000 (UTC)
Subject: Re: [PATCH v3] sched/core: Don't use dying mm as active_mm of
 kthreads
To:     Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Michal Hocko <mhocko@kernel.org>
References: <20190729210728.21634-1-longman@redhat.com>
 <ec9effc07a94b28ecf364de40dee183bcfb146fc.camel@surriel.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <3e2ff4c9-c51f-8512-5051-5841131f4acb@redhat.com>
Date:   Mon, 29 Jul 2019 17:42:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ec9effc07a94b28ecf364de40dee183bcfb146fc.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 29 Jul 2019 21:42:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 5:21 PM, Rik van Riel wrote:
> On Mon, 2019-07-29 at 17:07 -0400, Waiman Long wrote:
>> It was found that a dying mm_struct where the owning task has exited
>> can stay on as active_mm of kernel threads as long as no other user
>> tasks run on those CPUs that use it as active_mm. This prolongs the
>> life time of dying mm holding up some resources that cannot be freed
>> on a mostly idle system.
> On what kernels does this happen?
>
> Don't we explicitly flush all lazy TLB CPUs at exit
> time, when we are about to free page tables?

There are still a couple of calls that will be done until mm_count
reaches 0:

- mm_free_pgd(mm);
- destroy_context(mm);
- mmu_notifier_mm_destroy(mm);
- check_mm(mm);
- put_user_ns(mm->user_ns);

These are not big items, but holding it off for a long time is still not
a good thing.

> Does this happen only on the CPU where the task in
> question is exiting, or also on other CPUs?

What I have found is that a long running process on a mostly idle system
with many CPUs is likely to cycle through a lot of the CPUs during its
lifetime and leave behind its mm in the active_mm of those CPUs.  My
2-socket test system have 96 logical CPUs. After running the test
program for a minute or so, it leaves behind its mm in about half of the
CPUs with a mm_count of 45 after exit. So the dying mm will stay until
all those 45 CPUs get new user tasks to run.


>
> If it is only on the CPU where the task is exiting,
> would the TASK_DEAD handling in finish_task_switch()
> be a better place to handle this?

I need to switch the mm off the dying one. mm switching is only done in
context_switch(). I don't think finish_task_switch() is the right place.

-Longman

