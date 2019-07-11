Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A33AC71142
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B5F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KqgMVRLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfGKRqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:46:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38399 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfGKRqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:46:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so3099831pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=p6qEv8fgTgyqvoOypH+wlalxdPH8SzcdGhJs/o+CWGY=;
        b=KqgMVRLIbqcIGHDrID8LNbN5FhzJf6sWR5x8kG4hVZMGkWfXDf4dYYgqqc9r74+D+Q
         wuINI9UEqv8qDAKzJm7CB83/eFNwxqxmhTHeLQRHGOESUpu0vBwWu1oxtA4oCCPSOsSe
         r3X9iDMN0fhiQ0e+5Kzvg0Y5s1qlC2rBHCD/GPNlEWMvgnuaaSpfgpu/rVdBbyzwvEud
         kXhE2cDpi24HZpVLDoJFTL5cQbavH/wqeOH18eTMBQFMOhOXXCSDf5tMRrXiX9gepxCr
         TMVcBc9/J0pn9iK4Cx/Zb+IxnoRu7OGZSSUPMBZ/1QmXnWGAL1wphIaCkt+Giijcu9nw
         YI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=p6qEv8fgTgyqvoOypH+wlalxdPH8SzcdGhJs/o+CWGY=;
        b=rj7k4cpa0/MyuQG5ou/DmeYHeDisA0rLaKu+ipWZddbpmDZSQ14tUeiX2Hjx0eU0lf
         nU0cATlIa3oL/osXr8xfa96JP/lNQOUkuw1X1WxZnEIgQKMz7t5nbyShNCpQePCNYGVT
         6SaQMjkzSXT8AFrAw6qWQ2ReNsfbvI2j7mOen1aR3QNqgRBo259awkMRzZP87e9QAssq
         Mb1jbL6CU4kDMw1zzR3hujaSC6lMU2oQOqfkgedqEFOoiZob+f8NYUiL5ZZq1PiPHo96
         wSpAVJDxMh1nFGhqOxNwFHxISC0Yivj4y1ZQZwVSoge7FOPWYj1E3KIseAzmQwO4/FCT
         Uv7w==
X-Gm-Message-State: APjAAAWNonD4Drn8NjIRYvMtwun+4GT1+ONLoj3YSMx8l16mfbg5acxE
        xjt5jdDALweHUFickk1Mc6qJ1g==
X-Google-Smtp-Source: APXvYqw1QkrRAzsxd2h5YvqzpXFKBpulU11tj9hJY93uhZyX+IEDc6Hma+dKamdBB6NDC4DWsXYMZQ==
X-Received: by 2002:a63:1046:: with SMTP id 6mr5833405pgq.111.1562867180047;
        Thu, 11 Jul 2019 10:46:20 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id 14sm10447986pfj.36.2019.07.11.10.46.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 10:46:19 -0700 (PDT)
From:   bsegall@google.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Chiluk <chiluk+linux@indeed.com>,
        Pqhil Auld <pauld@redhat.com>, Peter Oskolkov <posk@posk.io>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v5 1/1] sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
        <1561664970-1555-1-git-send-email-chiluk+linux@indeed.com>
        <1561664970-1555-2-git-send-email-chiluk+linux@indeed.com>
        <xm26lfxhwlxr.fsf@bsegall-linux.svl.corp.google.com>
        <20190711095102.GX3402@hirez.programming.kicks-ass.net>
Date:   Thu, 11 Jul 2019 10:46:18 -0700
In-Reply-To: <20190711095102.GX3402@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Thu, 11 Jul 2019 11:51:02 +0200")
Message-ID: <xm26v9w8jwgl.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> FWIW, good to see progress, still waiting for you guys to agree :-)
>
> On Mon, Jul 01, 2019 at 01:15:44PM -0700, bsegall@google.com wrote:
>
>> - Taking up-to-every rq->lock is bad and expensive and 5ms may be too
>>   short a delay for this. I haven't tried microbenchmarks on the cost of
>>   this vs min_cfs_rq_runtime = 0 vs baseline.
>
> Yes, that's tricky, SGI/HPE have definite ideas about that.
>
>> @@ -4781,12 +4790,41 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>   */
>>  static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>>  {
>> -	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
>> +	u64 runtime = 0;
>>  	unsigned long flags;
>>  	u64 expires;
>> +	struct cfs_rq *cfs_rq, *temp;
>> +	LIST_HEAD(temp_head);
>> +
>> +	local_irq_save(flags);
>> +
>> +	raw_spin_lock(&cfs_b->lock);
>> +	cfs_b->slack_started = false;
>> +	list_splice_init(&cfs_b->slack_cfs_rq, &temp_head);
>> +	raw_spin_unlock(&cfs_b->lock);
>> +
>> +
>> +	/* Gather all left over runtime from all rqs */
>> +	list_for_each_entry_safe(cfs_rq, temp, &temp_head, slack_list) {
>> +		struct rq *rq = rq_of(cfs_rq);
>> +		struct rq_flags rf;
>> +
>> +		rq_lock(rq, &rf);
>> +
>> +		raw_spin_lock(&cfs_b->lock);
>> +		list_del_init(&cfs_rq->slack_list);
>> +		if (!cfs_rq->nr_running && cfs_rq->runtime_remaining > 0 &&
>> +		    cfs_rq->runtime_expires == cfs_b->runtime_expires) {
>> +			cfs_b->runtime += cfs_rq->runtime_remaining;
>> +			cfs_rq->runtime_remaining = 0;
>> +		}
>> +		raw_spin_unlock(&cfs_b->lock);
>> +
>> +		rq_unlock(rq, &rf);
>> +	}
>
> But worse still, you take possibly every rq->lock without ever
> re-enabling IRQs.
>

Yeah, I'm not sure why I did that, it isn't correctness.
