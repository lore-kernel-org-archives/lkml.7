Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DA9CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 02:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CE121D7C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 02:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d097UHLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfJTCHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 22:07:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53602 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfJTCHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 22:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=loqJkqMzlVxDcukelK7SOp/qyy0wTiV9aAPSa734+ac=; b=d097UHLLElOGNwpFNfCX8uZT6
        wiqz2KjmgfViFjejzMw0Zr2KSLcq/Ol4uZ8fhH1WypKsarjphl31GhcdecHRv0ZCJ22U87F5oh4eA
        5bYp+RxoO4Ok1znwLHjUp9cVvzcfxfqskt5HnhQdtGij+2H+nVwvsMQBI5LdmHWcvZwEUJ8q+eYsd
        Iw1Xvtrg96eZ3IavaN9e2mGM4yU5UsHKTgC9epVU/Sa+2POLmRxgbzwI1zlDz9SGkKXc1QMW7AZ9U
        0eh2/ofeNuCKMR3DXumHycPZgE88vWcPHbaU+lCRsi3JLy7BMtfrhuQ+fFnq2J+unYA0XpmOHkmKv
        ohAazOIGg==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iM0cq-0008AT-IK; Sun, 20 Oct 2019 02:07:20 +0000
Subject: Re: [PATCH] mm/vmstat: do not use size of vmstat_text as count of
 /proc/vmstat items
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <157152151769.4139.15423465513138349343.stgit@buzz>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <83d18a9b-2a3e-d35a-a2c0-ba7be2141ec5@infradead.org>
Date:   Sat, 19 Oct 2019 19:07:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157152151769.4139.15423465513138349343.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/19 2:45 PM, Konstantin Khlebnikov wrote:
> Strings from vmstat_text[] will be used for printing memory cgroup
> statistics which exists even if CONFIG_VM_EVENT_COUNTERS=n.
> 
> This should be applied before patch "mm/memcontrol: use vmstat names
> for printing statistics".
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Link: https://lore.kernel.org/linux-mm/cd1c42ae-281f-c8a8-70ac-1d01d417b2e1@infradead.org/T/#u

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  mm/vmstat.c |   26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 590aeca27cab..13e36da70f3c 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1638,25 +1638,23 @@ static const struct seq_operations zoneinfo_op = {
>  	.show	= zoneinfo_show,
>  };
>  
> +#define NR_VMSTAT_ITEMS (NR_VM_ZONE_STAT_ITEMS + \
> +			 NR_VM_NUMA_STAT_ITEMS + \
> +			 NR_VM_NODE_STAT_ITEMS + \
> +			 NR_VM_WRITEBACK_STAT_ITEMS + \
> +			 (IS_ENABLED(CONFIG_VM_EVENT_COUNTERS) ? \
> +			  NR_VM_EVENT_ITEMS : 0))
> +
>  static void *vmstat_start(struct seq_file *m, loff_t *pos)
>  {
>  	unsigned long *v;
> -	int i, stat_items_size;
> +	int i;
>  
> -	if (*pos >= ARRAY_SIZE(vmstat_text))
> +	if (*pos >= NR_VMSTAT_ITEMS)
>  		return NULL;
> -	stat_items_size = NR_VM_ZONE_STAT_ITEMS * sizeof(unsigned long) +
> -			  NR_VM_NUMA_STAT_ITEMS * sizeof(unsigned long) +
> -			  NR_VM_NODE_STAT_ITEMS * sizeof(unsigned long) +
> -			  NR_VM_WRITEBACK_STAT_ITEMS * sizeof(unsigned long);
> -
> -#ifdef CONFIG_VM_EVENT_COUNTERS
> -	stat_items_size += sizeof(struct vm_event_state);
> -#endif
>  
> -	BUILD_BUG_ON(stat_items_size !=
> -		     ARRAY_SIZE(vmstat_text) * sizeof(unsigned long));
> -	v = kmalloc(stat_items_size, GFP_KERNEL);
> +	BUILD_BUG_ON(ARRAY_SIZE(vmstat_text) < NR_VMSTAT_ITEMS);
> +	v = kmalloc_array(NR_VMSTAT_ITEMS, sizeof(unsigned long), GFP_KERNEL);
>  	m->private = v;
>  	if (!v)
>  		return ERR_PTR(-ENOMEM);
> @@ -1689,7 +1687,7 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
>  static void *vmstat_next(struct seq_file *m, void *arg, loff_t *pos)
>  {
>  	(*pos)++;
> -	if (*pos >= ARRAY_SIZE(vmstat_text))
> +	if (*pos >= NR_VMSTAT_ITEMS)
>  		return NULL;
>  	return (unsigned long *)m->private + *pos;
>  }
> 


-- 
~Randy

