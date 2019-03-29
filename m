Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4426C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E3C2184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1iL4joG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfC2Rru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:47:50 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:51239 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbfC2Rrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:47:49 -0400
Received: by mail-pl1-f201.google.com with SMTP id t17so3107plj.18
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KkbObhazcqZn021nZHNNPAhwea543VJsHp1ie7WsQS4=;
        b=q1iL4joGvSC0SWToSbwIk7h6Qw0Wb7TsIpPlSjnGJ5khNWGgoW6HoIP4C4lYwbmThG
         E1aFKEsCc4VKFp2/QV7UANYkePMHJTvOhIpjHSTTOc4wi3+B9lTrqCf+8V1E6ODwIbWT
         ih9i2SwjFA5nj9xkVXZRJ7/2iypFpTJZb+ULj26lcaW/fh25fO2pReE+UhaFQq73PV/E
         zk051W9ZXHLYHg/f818uqCJN/C8ZzYbQ2Y7pVeFXgZyjqSUT9Q8mm8z81JCeH35RqrTI
         p8ybWL2qwqcck/fugZG9mwJPQ+zKo1pR4FNVc1iKkLFp2CPLDruCK3gnUpxTqIMvc5I8
         yoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KkbObhazcqZn021nZHNNPAhwea543VJsHp1ie7WsQS4=;
        b=Nq2RXa1VxH8BJM/Hi8I6jMBtkg1vt30Qzr2qtChajYX6d8UDPh8Qto8thX53dx73zE
         0APEqJe+atVozt2YwaDWJ7fmr5Ll9y3sq1I4CDiqD6HXDN++5rduHU+N64eudnYmG7bZ
         pSAj2Z5ncmtWlFLo/w51zk/hAcWOA56VAc141SJYlFeYorPBffX7R6K8IjRLZIxm7jxJ
         yaYHLFXlk+52J/EiN5lfymQpwJEP6+WbfkhiG+LVY+qJhiuCJJIkUxDf9LpoE15q+/WY
         3ZkT+XVAq/QL007VxAzHzndNmG0Fj9eT7xUG4gnEh64TCTZJrAXrhCFvWFC77lP4Q8si
         vtaw==
X-Gm-Message-State: APjAAAX/9tBbIf/MlSyohaFX0QGvQbM3e892cb3pNGGCcMxkToMXOO9t
        z/89WKMAcrggnfSBt0fpHVD8bvoAyHZu
X-Google-Smtp-Source: APXvYqxXhjZZFeoHf4Hk+3gXZNWGmuUCXzlgNhD2c84zWNsCYlOZQnhIri7FEmZ36ZU3YB0RStIcvl2gjIeB
X-Received: by 2002:a62:3444:: with SMTP id b65mr634398pfa.27.1553881668537;
 Fri, 29 Mar 2019 10:47:48 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:47:46 -0700
In-Reply-To: <20190321164453.46143c8bf2dd8bfd0f91d71c@linux-foundation.org>
Message-Id: <xr93muldwp19.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20190307165632.35810-1-gthelen@google.com> <20190321164453.46143c8bf2dd8bfd0f91d71c@linux-foundation.org>
Subject: Re: [PATCH] writeback: sum memcg dirty counters as needed
From:   Greg Thelen <gthelen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu,  7 Mar 2019 08:56:32 -0800 Greg Thelen <gthelen@google.com> wrote:
>
>> Since commit a983b5ebee57 ("mm: memcontrol: fix excessive complexity in
>> memory.stat reporting") memcg dirty and writeback counters are managed
>> as:
>> 1) per-memcg per-cpu values in range of [-32..32]
>> 2) per-memcg atomic counter
>> When a per-cpu counter cannot fit in [-32..32] it's flushed to the
>> atomic.  Stat readers only check the atomic.
>> Thus readers such as balance_dirty_pages() may see a nontrivial error
>> margin: 32 pages per cpu.
>> Assuming 100 cpus:
>>    4k x86 page_size:  13 MiB error per memcg
>>   64k ppc page_size: 200 MiB error per memcg
>> Considering that dirty+writeback are used together for some decisions
>> the errors double.
>> 
>> This inaccuracy can lead to undeserved oom kills.  One nasty case is
>> when all per-cpu counters hold positive values offsetting an atomic
>> negative value (i.e. per_cpu[*]=32, atomic=n_cpu*-32).
>> balance_dirty_pages() only consults the atomic and does not consider
>> throttling the next n_cpu*32 dirty pages.  If the file_lru is in the
>> 13..200 MiB range then there's absolutely no dirty throttling, which
>> burdens vmscan with only dirty+writeback pages thus resorting to oom
>> kill.
>> 
>> It could be argued that tiny containers are not supported, but it's more
>> subtle.  It's the amount the space available for file lru that matters.
>> If a container has memory.max-200MiB of non reclaimable memory, then it
>> will also suffer such oom kills on a 100 cpu machine.
>> 
>> ...
>> 
>> Make balance_dirty_pages() and wb_over_bg_thresh() work harder to
>> collect exact per memcg counters when a memcg is close to the
>> throttling/writeback threshold.  This avoids the aforementioned oom
>> kills.
>> 
>> This does not affect the overhead of memory.stat, which still reads the
>> single atomic counter.
>> 
>> Why not use percpu_counter?  memcg already handles cpus going offline,
>> so no need for that overhead from percpu_counter.  And the
>> percpu_counter spinlocks are more heavyweight than is required.
>> 
>> It probably also makes sense to include exact dirty and writeback
>> counters in memcg oom reports.  But that is saved for later.
>
> Nice changelog, thanks.
>
>> Signed-off-by: Greg Thelen <gthelen@google.com>
>
> Did you consider cc:stable for this?  We may as well - the stablebots
> backport everything which might look slightly like a fix anyway :(

Good idea.  Done in -v2 of the patch.

>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -573,6 +573,22 @@ static inline unsigned long memcg_page_state(struct mem_cgroup *memcg,
>>  	return x;
>>  }
>>  
>> +/* idx can be of type enum memcg_stat_item or node_stat_item */
>> +static inline unsigned long
>> +memcg_exact_page_state(struct mem_cgroup *memcg, int idx)
>> +{
>> +	long x = atomic_long_read(&memcg->stat[idx]);
>> +#ifdef CONFIG_SMP
>> +	int cpu;
>> +
>> +	for_each_online_cpu(cpu)
>> +		x += per_cpu_ptr(memcg->stat_cpu, cpu)->count[idx];
>> +	if (x < 0)
>> +		x = 0;
>> +#endif
>> +	return x;
>> +}
>
> This looks awfully heavyweight for an inline function.  Why not make it
> a regular function and avoid the bloat and i-cache consumption?

Done in -v2.

> Also, did you instead consider making this spill the percpu counters
> into memcg->stat[idx]?  That might be more useful for potential future
> callers.  It would become a little more expensive though.

I looked at that approach, but couldn't convince myself it was safe.  I
kept staring at "Remote [...] Write accesses can cause unique problems
due to the relaxed synchronization requirements for this_cpu
operations." from this_cpu_ops.txt.  So I'd like to delay this possible
optimization for a later patch.
