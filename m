Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB533C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 07:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22AB20722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 07:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DCLt52pO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfLYHSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 02:18:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfLYHSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 02:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xL/ShzqmK+fdXFZ8cvAFgi6FxlFBuujEZnDwxTOQeWk=; b=DCLt52pOPxfiGYTHJ1thRI2R0
        XZc0HDmgcULjW63q7xC8UyAyDqlrcVwy7UxzYCN690hHnK3k0VqnnrqQOw6svzBwXlmOORjrYepGq
        AnhggJ+Es0O/3za2DU6wte4ed5sEzpjhb1L/VgTwoS6Mlm4QgJr2/PyeMV+mlGYDnA1PVMq+pwApc
        OTnz+is44y2QupqKzL1GP2b8DLCk7Mdr2kFfK74wsjWi+hZRCoTiNdv509q3dnlmc6+jPNxQ3kjqf
        7Emxqug9FEgI+YojGt4Gk+CPZYXOS65d1xDQKFsbGwd3WrchHOm0mM6QRpTKyA+ejtV1itFWR4rMj
        xUGWCrlqg==;
Received: from [2601:1c0:6280:3f0::fee9]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ik0wI-0002Pr-LZ; Wed, 25 Dec 2019 07:18:38 +0000
Subject: Re: [PATCH 1/1] Fix undefined reference to 'node_reclaim_distance'.
To:     Matt Fleming <matt@codeblueprint.co.uk>,
        Gonsolo <gonsolo@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191216103522.32215-1-gonsolo@gmail.com>
 <20191216103522.32215-2-gonsolo@gmail.com>
 <CAMuHMdVotJuotVKa3rxgR3ujCedoWM19-HhwhbTC9g6gV_EVNw@mail.gmail.com>
 <CANL0fFS81NgFBcMBdWo6OKefz04h_FeXadcau9Rkcna7Ap5PDw@mail.gmail.com>
 <CAMuHMdVtm6BGx6d+F8-Bw+fD-M-DugspLkBvCtTKGgWiPvJnSA@mail.gmail.com>
 <CANL0fFSNdzM-e=u+w0BTUqg5sQP_DuVBuJe9m0JDQnVTOPDMNQ@mail.gmail.com>
 <20191223164220.GA14394@codeblueprint.co.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <29b721c1-b5a7-6fc1-4471-f42109d509ed@infradead.org>
Date:   Tue, 24 Dec 2019 23:18:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191223164220.GA14394@codeblueprint.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/19 8:42 AM, Matt Fleming wrote:
> On Mon, 16 Dec, at 02:50:49PM, Gonsolo wrote:
>>> The offending commit seems to be a55c7454a8c887b2 ("sched/topology:
>>> Improve load balancing on AMD EPYC systems").
>>>
>>> Probably the node_reclaim_distance variable should be moved from
>>> an SMP-specific file to a NUMA-specific file.
>>
>> There are two variables that are used elsewhere:
>>
>> int                             sched_max_numa_distance;
>>
>> Used in kernel/sched/fair.c and kernel/sched/topology.c. I would move
>> it to fair.c.
>>
>> int __read_mostly               node_reclaim_distance = RECLAIM_DISTANCE;
>>
>> Used in
>> arch/x86/kernel/cpu/amd.c, line 894
>> kernel/sched/topology.c
>> mm/khugepaged.c, line 725
>> mm/page_alloc.c, line 3529
>>
>> I'm not sure where to move this one.
> 
> Can someone test out this patch on one of the failing architectures?
> (sh, ppc64)

Yes, it fixes the arch/sh/ build errors in my testing.
I don't have a failing ppc64 .config file to test.

thanks.

> ---->8----
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 6ec1e595b1d4..bf20e5883026 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1281,7 +1281,6 @@ static int			sched_domains_curr_level;
>  int				sched_max_numa_distance;
>  static int			*sched_domains_numa_distance;
>  static struct cpumask		***sched_domains_numa_masks;
> -int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
>  #endif
>  
>  /*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4785a8a2040e..733890d913ea 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3523,6 +3523,7 @@ bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
>  }
>  
>  #ifdef CONFIG_NUMA
> +int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
>  static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
>  {
>  	return node_distance(zone_to_nid(local_zone), zone_to_nid(zone)) <=
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
