Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37080C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46362177E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="x2JnfuyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfC1IVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:21:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36346 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1IVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:21:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id t206so15068409oib.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 01:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77jRvNRDYvOYIIwmPFjd/sDUifx+fyO+d5UR0CetH+8=;
        b=x2JnfuyNdHPAlLNql7+Hd+SIRPDYgD49+I3PBuwvdsWB3cuDoDV8QGLwo0NpqvN9/X
         KrPk/6cdaxf6pXJdbxK2KC8FbkBvLIUjydhssTiKJxkHkM6k2uxmA21cWqC3biP6ZjVB
         up/F6AENtCBV2rJmLVrvG9kSe64MIpMzf9J4WSvVOsJMWSAe567u30iM4Zb9aK7MaWoX
         5K/9ejxMvEgEfPG+EMO353pkAwP9A0CFKoQHspa6bo6Q+bJXLBXGOnH9iQZrHJinQzGg
         uobwkWeh8RhT7FoycdocpKohPG1l3ax2SjteWTsxWClXHOjmg2MJNzLvTMoI9xF9fo5C
         n/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77jRvNRDYvOYIIwmPFjd/sDUifx+fyO+d5UR0CetH+8=;
        b=XcwGsC1cHJ/Pv9UhC1PDzchCOyGDyu/uSdAbAzK93JeXLYH13mcZJ7elEQIYLZyHo9
         iDyK+UB4RF1mBoiDmAIMmHttgxs0iHtmgG96KUPhK/EsNe9JaGGv8ZwILcFGHjbZNwql
         nIcQROP0zH8jFcBlrXI9JaI2Ntf2xN02GPoDl4fotDjQAxwMhTp8ByKDnxZWQocUG03u
         OGdbYQBLZWR98wisjnCQM5ZIlRk6FRwqxcnIV3hwrd+MmCCX7DHsvyo0qc+t+f7yU3kb
         T3P7r5zyRQRM+oUTgPOQPqT7oin4YA0LLJgImw+Mcun7zZbaJWuoPbJAXILt6TAL+e0h
         YMfw==
X-Gm-Message-State: APjAAAUKMGHoitFEh51xs9u96qm9TF9DhdCVz5sD92n1xMGnhbCrX2Uu
        B5lHHQjWs2hJZFQwi7h/hGlEck+qTQQPSX6H+hqKBg==
X-Google-Smtp-Source: APXvYqwUDaQSZRlXkxLdn8Ktoc7WDC+3ppHol9nwM1pxOZhHFWsQT1TKlLs73I8ZPb5FRaOOtzcq5GgbEYyMY53kW3g=
X-Received: by 2002:aca:e64f:: with SMTP id d76mr19187454oih.105.1553761275036;
 Thu, 28 Mar 2019 01:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190326135837.GP28406@dhcp22.suse.cz> <43a1a59d-dc4a-6159-2c78-e1faeb6e0e46@linux.alibaba.com>
 <20190326183731.GV28406@dhcp22.suse.cz> <f08fb981-d129-3357-e93a-a6b233aa9891@linux.alibaba.com>
 <20190327090100.GD11927@dhcp22.suse.cz> <CAPcyv4heiUbZvP7Ewoy-Hy=-mPrdjCjEuSw+0rwdOUHdjwetxg@mail.gmail.com>
 <c3690a19-e2a6-7db7-b146-b08aa9b22854@linux.alibaba.com> <20190327193918.GP11927@dhcp22.suse.cz>
 <6f8b4c51-3f3c-16f9-ca2f-dbcd08ea23e6@linux.alibaba.com>
In-Reply-To: <6f8b4c51-3f3c-16f9-ca2f-dbcd08ea23e6@linux.alibaba.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 28 Mar 2019 01:21:03 -0700
Message-ID: <CAPcyv4g2FuormkwNNWy7kU4JF6_-sX3WnSVS7YggMJMMOCehMQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 7:09 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
> On 3/27/19 1:09 PM, Michal Hocko wrote:
> > On Wed 27-03-19 11:59:28, Yang Shi wrote:
> >>
> >> On 3/27/19 10:34 AM, Dan Williams wrote:
> >>> On Wed, Mar 27, 2019 at 2:01 AM Michal Hocko <mhocko@kernel.org> wrote:
> >>>> On Tue 26-03-19 19:58:56, Yang Shi wrote:
> > [...]
> >>>>> It is still NUMA, users still can see all the NUMA nodes.
> >>>> No, Linux NUMA implementation makes all numa nodes available by default
> >>>> and provides an API to opt-in for more fine tuning. What you are
> >>>> suggesting goes against that semantic and I am asking why. How is pmem
> >>>> NUMA node any different from any any other distant node in principle?
> >>> Agree. It's just another NUMA node and shouldn't be special cased.
> >>> Userspace policy can choose to avoid it, but typical node distance
> >>> preference should otherwise let the kernel fall back to it as
> >>> additional memory pressure relief for "near" memory.
> >> In ideal case, yes, I agree. However, in real life world the performance is
> >> a concern. It is well-known that PMEM (not considering NVDIMM-F or HBM) has
> >> higher latency and lower bandwidth. We observed much higher latency on PMEM
> >> than DRAM with multi threads.
> > One rule of thumb is: Do not design user visible interfaces based on the
> > contemporary technology and its up/down sides. This will almost always
> > fire back.
>
> Thanks. It does make sense to me.
>
> >
> > Btw. if you keep arguing about performance without any numbers. Can you
> > present something specific?
>
> Yes, I did have some numbers. We did simple memory sequential rw latency
> test with a designed-in-house test program on PMEM (bind to PMEM) and
> DRAM (bind to DRAM). When running with 20 threads the result is as below:
>
>               Threads          w/lat            r/lat
> PMEM      20                537.15         68.06
> DRAM      20                14.19           6.47
>
> And, sysbench test with command: sysbench --time=600 memory
> --memory-block-size=8G --memory-total-size=1024T --memory-scope=global
> --memory-oper=read --memory-access-mode=rnd --rand-type=gaussian
> --rand-pareto-h=0.1 --threads=1 run
>
> The result is:
>                     lat/ms
> PMEM      103766.09
> DRAM      31946.30
>
> >
> >> In real production environment we don't know what kind of applications would
> >> end up on PMEM (DRAM may be full, allocation fall back to PMEM) then have
> >> unexpected performance degradation. I understand to have mempolicy to choose
> >> to avoid it. But, there might be hundreds or thousands of applications
> >> running on the machine, it sounds not that feasible to me to have each
> >> single application set mempolicy to avoid it.
> > we have cpuset cgroup controller to help here.
> >
> >> So, I think we still need a default allocation node mask. The default value
> >> may include all nodes or just DRAM nodes. But, they should be able to be
> >> override by user globally, not only per process basis.
> >>
> >> Due to the performance disparity, currently our usecases treat PMEM as
> >> second tier memory for demoting cold page or binding to not memory access
> >> sensitive applications (this is the reason for inventing a new mempolicy)
> >> although it is a NUMA node.
> > If the performance sucks that badly then do not use the pmem as NUMA,
> > really. There are certainly other ways to export the pmem storage. Use
> > it as a fast swap storage. Or try to work on a swap caching mechanism
> > that still allows much faster access than a slow swap storage. But do
> > not try to pretend to abuse the NUMA interface while you are breaking
> > some of its long term established semantics.
>
> Yes, we are looking into using it as a fast swap storage too and perhaps
> other usecases.
>
> Anyway, though nobody thought it makes sense to restrict default
> allocation nodes, it sounds over-engineered. I'm going to drop it.
>
> One question, when doing demote and promote we need define a path, for
> example, DRAM <-> PMEM (assume two tier memory). When determining what
> nodes are "DRAM" nodes, does it make sense to assume the nodes with both
> cpu and memory are DRAM nodes since PMEM nodes are typically cpuless nodes?

For ACPI platforms the HMAT is effectively going to enforce "cpu-less"
nodes for any memory range that has differentiated performance from
the conventional memory pool, or differentiated performance for a
specific initiator. So "memory-less == PMEM" is not a robust
assumption.

The plan is to use the HMAT to populate the default fallback order,
but allow for an override if the HMAT information is missing or
incorrect.
