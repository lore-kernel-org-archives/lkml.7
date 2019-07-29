Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E962C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF2B2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="rLXHXVSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfG2MQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:16:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33142 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfG2MQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:16:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so59129324edq.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 05:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MZIUVHdjLMQukRWc0f7u5fJGuVGb54YkwkBwhwkBOCo=;
        b=rLXHXVSoA/vHF6iJ0hCyWlDw84arO1P1aKv/LcwtKun9ZKApSzDsRFaLhmAnPrYNsY
         3Pag5W4aiGUAbsFcW+bQXDgCo5THCMvaywcGhqf7lFRkkNd8we47tukoN64Bf8tO6/W0
         VRVOS9FF4P/AggwZNVEwZhKztJ9HKzFUPQKLdBXQtsQ9IuxQvRDJvLtM4xiq8jmugzui
         kk0RfDFT9mLvKbs7SCJvllTOez7+FejB3Mh1InBkQLGDs46xdTl23b9Sw8iOpvfJxUuQ
         KivoVMG+JfxzLpmhhoLIkNfaiWBrpXZ8Fq1WzaYwMeyngeD4hKu1vAr1PC2Y608jY6Xq
         1GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MZIUVHdjLMQukRWc0f7u5fJGuVGb54YkwkBwhwkBOCo=;
        b=YQOzBEPfpEB6XfuYuY5haw+uMVQh6fSm+QwjQmIhztjW67V9DZsiF1dIuYPe+lQqAt
         QGIDBTxrQ9SBazFO4MGQ/REUNoPquwk7SQyZmHdxMnNuP2Gbf9R4oLa0flvBDVfzxWBY
         Nsy3ZuAtC1XSsGCNRvppM4LGr8LO/crndIfruh7KvFhKuaAAY5X4KMtgQwUwhCakgWU0
         cs2kM0icIPPHm9eUFXo341U5jHKGDJL88s7nXmc3wUONmYCs2TqenIBnKPWiXqVT3kqh
         fgm+qggrek9iWD58Dlur9ft12OXhlR/c4FuYJ3ODvwS30olNOQ/3pFbRQcMKmdmEiuKr
         qiOg==
X-Gm-Message-State: APjAAAVCEYLXkaVho+dSo62qLBgovHyGsOP3C553PwcGWt4LxHG/06lA
        FCe3d/Mga/YGT5ltVk7kM8I=
X-Google-Smtp-Source: APXvYqzCEHNO+b+ZRVDCAXHzaAwouiWsLwZuuQJ7YuzBUJUjRh8R+h4M03xwIcsycGOGmmYH/TsddA==
X-Received: by 2002:a50:92cd:: with SMTP id l13mr93556388eda.136.1564402582487;
        Mon, 29 Jul 2019 05:16:22 -0700 (PDT)
Received: from localhost (5ec096bd.skybroadband.com. [94.192.150.189])
        by smtp.gmail.com with ESMTPSA id j30sm15833311edb.8.2019.07.29.05.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 05:16:21 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:16:20 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] sched/topology: Improve load balancing on AMD EPYC
Message-ID: <20190729121620.GD6909@codeblueprint.co.uk>
References: <20190723104830.26623-1-matt@codeblueprint.co.uk>
 <a8241850-7111-2d93-2330-d28b00797e56@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8241850-7111-2d93-2330-d28b00797e56@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul, at 04:37:06PM, Suthikulpanit, Suravee wrote:
> 
> I am testing this patch on the Linux-5.2, and I actually do not
> notice difference pre vs post patch.
> 
> Besides the case above, I have also run an experiment with
> a different number of threads across two sockets:
> 
> (Note: I only focus on thread0 of each core.)
> 
> sXnY = Socket X Node Y
> 
>      * s0n0 + s0n1 + s1n0 + s1n1
>      numactl -C 0-15,32-47 ./spinner 32
> 
>      * s0n2 + s0n3 + s1n2 + s1n3
>      numactl -C 16-31,48-63 ./spinner 32
> 
>      * s0 + s1
>      numactl -C 0-63 ./spinner 64
> 
> My observations are:
> 
>      * I still notice improper load-balance on one of the task initially
>        for a few seconds before they are load-balanced correctly.
> 
>      * It is taking longer to load balance w/ more number of tasks.
> 
> I wonder if you have tried with a different kernel base?

It was tested with one of the 5.2 -rc kernels.

I'll take another look at this behaviour, but for the benefit of LKML
readers, here's the summary I gave before. It's specific to using
cgroups to partitions tasks:

    It turns out there's a secondary issue to do with how run queue load
    averages are compared between sched groups.
    
    Load averages for a sched_group (a group within a domain) are
    effectively "scaled" by the number of CPUs in that group. This has a
    direct influence on how quickly load ramps up in a group.
    
    What's happening on my system when running with $(numactl -C
    0-7,32-39) is that the load for the top NUMA sched_domain (domain4) is
    scaling the load by 64 CPUs -- even though the workload can't use all
    64 due to scheduler affinity.
    
    So because the load balancer thinks there's plenty of room left to run
    tasks, it doesn't balance very well across sockets even with the
    SD_BALANCE_FORK flag.
    
    This super quick and ugly patch, which caps the number of CPUs at 8, gets both
    sockets used by fork() on my system.
    
    ---->8----
    
    diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
    index 40bd1e27b1b7..9444c34d038c 100644
    --- a/kernel/sched/fair.c
    +++ b/kernel/sched/fair.c
    @@ -5791,6 +5791,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
     	int imbalance_scale = 100 + (sd->imbalance_pct-100)/2;
     	unsigned long imbalance = scale_load_down(NICE_0_LOAD) *
     				(sd->imbalance_pct-100) / 100;
    +	unsigned long capacity;
     
     	if (sd_flag & SD_BALANCE_WAKE)
     		load_idx = sd->wake_idx;
    @@ -5835,10 +5836,15 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
     		}
     
     		/* Adjust by relative CPU capacity of the group */
    +		capacity = group->sgc->capacity;
    +
    +		if (capacity > (SCHED_CAPACITY_SCALE * 8))
    +			capacity = SCHED_CAPACITY_SCALE * 8;
    +
     		avg_load = (avg_load * SCHED_CAPACITY_SCALE) /
    -					group->sgc->capacity;
    +					capacity;
     		runnable_load = (runnable_load * SCHED_CAPACITY_SCALE) /
    -					group->sgc->capacity;
    +					capacity;
     
     		if (local_group) {
     			this_runnable_load = runnable_load;
    
    ----8<----
    
    There's still an issue with the active load balancer kicking in after a few
    seconds, but I suspect that is related to the use of group capacity elsewhere
    in the load balancer code (like update_sg_lb_stats()).


-- 
Matt Fleming
SUSE Performance Team
