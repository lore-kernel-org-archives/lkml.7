Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC772C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886F72133F
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390301AbfHWL2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 07:28:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388570AbfHWL2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 07:28:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50611308FBA7;
        Fri, 23 Aug 2019 11:28:21 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1AB15D6B2;
        Fri, 23 Aug 2019 11:28:16 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x7NBSGO7008523;
        Fri, 23 Aug 2019 07:28:16 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x7NBSGxR008520;
        Fri, 23 Aug 2019 07:28:16 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 23 Aug 2019 07:28:16 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Zhang Tao <kontais@zoho.com>
cc:     agk@redhat.com, snitzer@redhat.com,
        Zhang Tao <zhangtao27@lenovo.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH] dm table: fix a potential array out of
 bounds
In-Reply-To: <1566351211-13280-1-git-send-email-kontais@zoho.com>
Message-ID: <alpine.LRH.2.02.1908230705510.5296@file01.intranet.prod.int.rdu2.redhat.com>
References: <1566351211-13280-1-git-send-email-kontais@zoho.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 23 Aug 2019 11:28:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I tested it and the bug is real - with some table sizes, 
dm_table_find_target will access memory out of bounds if the sector 
argument is beyond limit.

Your patch fixes some of these cases, but not all of them.

I used this script to test all possible table sizes:
#!/bin/bash -e
sync
dmsetup remove_all || true
rmmod dm_mod || true
>t.txt
for i in `seq 1 10000`; do
        echo $i
        echo $((i-1)) 1 error >>t.txt
        dmsetup create error <t.txt
        dmsetup remove error
done

and I modified dm_table_find_target to call dm_table_find_target with too 
high sector number. Without your patch, it fails on table with 16 entries; 
with your patch applied, it fails on 144 entries.

I'll make another patch that passes the test.

Mikulas


On Wed, 21 Aug 2019, Zhang Tao wrote:

> From: Zhang Tao <zhangtao27@lenovo.com>
> 
> allocate num + 1 for target and offset array, n_highs need num + 1
> elements, the last element will be used for node lookup in function
> dm_table_find_target.
> 
> Signed-off-by: Zhang Tao <zhangtao27@lenovo.com>
> ---
>  drivers/md/dm-table.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 7b6c3ee..fd7f604 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -160,20 +160,22 @@ static int alloc_targets(struct dm_table *t, unsigned int num)
>  {
>  	sector_t *n_highs;
>  	struct dm_target *n_targets;
> +	unsigned int alloc_num;
>  
>  	/*
>  	 * Allocate both the target array and offset array at once.
>  	 * Append an empty entry to catch sectors beyond the end of
>  	 * the device.
>  	 */
> -	n_highs = (sector_t *) dm_vcalloc(num + 1, sizeof(struct dm_target) +
> +	alloc_num = num + 1;
> +	n_highs = (sector_t *) dm_vcalloc(alloc_num, sizeof(struct dm_target) +
>  					  sizeof(sector_t));
>  	if (!n_highs)
>  		return -ENOMEM;
>  
> -	n_targets = (struct dm_target *) (n_highs + num);
> +	n_targets = (struct dm_target *) (n_highs + alloc_num);
>  
> -	memset(n_highs, -1, sizeof(*n_highs) * num);
> +	memset(n_highs, -1, sizeof(*n_highs) * alloc_num);
>  	vfree(t->highs);
>  
>  	t->num_allocated = num;
> -- 
> 1.8.3.1
> 
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
> 
