Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A38BC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7A2204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfG3VBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:01:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfG3VBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:01:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85ACC85A07;
        Tue, 30 Jul 2019 21:01:40 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA2B05D9C5;
        Tue, 30 Jul 2019 21:01:38 +0000 (UTC)
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
 <3e2ff4c9-c51f-8512-5051-5841131f4acb@redhat.com>
 <8021be4426fdafdce83517194112f43009fb9f6d.camel@surriel.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b5a462b8-8ef6-6d2c-89aa-b5009c194000@redhat.com>
Date:   Tue, 30 Jul 2019 17:01:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8021be4426fdafdce83517194112f43009fb9f6d.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 30 Jul 2019 21:01:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 8:26 PM, Rik van Riel wrote:
> On Mon, 2019-07-29 at 17:42 -0400, Waiman Long wrote:
>
>> What I have found is that a long running process on a mostly idle
>> system
>> with many CPUs is likely to cycle through a lot of the CPUs during
>> its
>> lifetime and leave behind its mm in the active_mm of those CPUs.  My
>> 2-socket test system have 96 logical CPUs. After running the test
>> program for a minute or so, it leaves behind its mm in about half of
>> the
>> CPUs with a mm_count of 45 after exit. So the dying mm will stay
>> until
>> all those 45 CPUs get new user tasks to run.
> OK. On what kernel are you seeing this?
>
> On current upstream, the code in native_flush_tlb_others()
> will send a TLB flush to every CPU in mm_cpumask() if page
> table pages have been freed.
>
> That should cause the lazy TLB CPUs to switch to init_mm
> when the exit->zap_page_range path gets to the point where
> it frees page tables.
>
I was using the latest upstream 5.3-rc2 kernel. It may be the case that
the mm has been switched, but the mm_count field of the active_mm of the
kthread is not being decremented until a user task runs on a CPU.


>>> If it is only on the CPU where the task is exiting,
>>> would the TASK_DEAD handling in finish_task_switch()
>>> be a better place to handle this?
>> I need to switch the mm off the dying one. mm switching is only done
>> in
>> context_switch(). I don't think finish_task_switch() is the right
>> place.
> mm switching is also done in flush_tlb_func_common,
> if the CPU received a TLB shootdown IPI while in lazy
> TLB mode.
>
I see.

Cheers,
Longman

