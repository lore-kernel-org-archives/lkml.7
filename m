Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E34C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9806E21770
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfK1KCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:02:05 -0500
Received: from foss.arm.com ([217.140.110.172]:33040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfK1KCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:02:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEB171FB;
        Thu, 28 Nov 2019 02:02:04 -0800 (PST)
Received: from [10.163.1.7] (unknown [10.163.1.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C0383F6C4;
        Thu, 28 Nov 2019 02:02:02 -0800 (PST)
Subject: Re: [PATCH] mm: use the existing variable instead of a duplicate
 statement
To:     Hao Lee <haolee.swjtu@gmail.com>, akpm@linux-foundation.org
Cc:     mgorman@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20191125145320.GA21484@haolee.github.io>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c8e88092-ddbe-2934-aa61-5db6cbad0c11@arm.com>
Date:   Thu, 28 Nov 2019 15:32:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191125145320.GA21484@haolee.github.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/2019 08:23 PM, Hao Lee wrote:
> The address of zone has been stored in variable 'zone', so there is no need
> to get it again with a duplicate statement.
> 
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> ---
>  mm/vmscan.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ee4eecc7e1c2..de4b2d1e66be 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -363,22 +363,21 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
>  	for (zid = zone_idx + 1; zid < MAX_NR_ZONES; zid++) {
>  		struct zone *zone = &lruvec_pgdat(lruvec)->node_zones[zid];
>  		unsigned long size;
>  
>  		if (!managed_zone(zone))
>  			continue;
>  
>  		if (!mem_cgroup_disabled())
>  			size = mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
>  		else
> -			size = zone_page_state(&lruvec_pgdat(lruvec)->node_zones[zid],
> -				       NR_ZONE_LRU_BASE + lru);
> +			size = zone_page_state(zone, NR_ZONE_LRU_BASE + lru);

Is not this already merged with following commit on next-20191126 ?

54eacdb0dd8f9a ("mm: vmscan: simplify lruvec_lru_size()")

>  		lru_size -= min(size, lru_size);
>  	}
>  
>  	return lru_size;
>  
>  }
>  
>  /*
>   * Add a shrinker callback to be called from the vm.
>   */
> 
