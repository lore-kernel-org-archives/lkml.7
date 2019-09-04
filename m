Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D85C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FE32339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfIDLZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:25:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfIDLZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:25:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9693EB049;
        Wed,  4 Sep 2019 11:24:59 +0000 (UTC)
Subject: Re: [PATCH] mm: Unsigned 'nr_pages' always larger than zero
To:     zhong jiang <zhongjiang@huawei.com>, akpm@linux-foundation.org,
        mhocko@kernel.org
Cc:     anshuman.khandual@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <1567592763-25282-1-git-send-email-zhongjiang@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5505fa16-117e-8890-0f48-38555a61a036@suse.cz>
Date:   Wed, 4 Sep 2019 13:24:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567592763-25282-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 12:26 PM, zhong jiang wrote:
> With the help of unsigned_lesser_than_zero.cocci. Unsigned 'nr_pages"'
> compare with zero. And __get_user_pages_locked will return an long value.
> Hence, Convert the long to compare with zero is feasible.

It would be nicer if the parameter nr_pages was long again instead of unsigned
long (note there are two variants of the function, so both should be changed).

> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Fixes: 932f4a630a69 ("mm/gup: replace get_user_pages_longterm() with FOLL_LONGTERM")

(which changed long to unsigned long)

AFAICS... stable shouldn't be needed as the only "risk" is that we goto
check_again even when we fail, which should be harmless.

Vlastimil

> ---
>  mm/gup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 23a9f9c..956d5a1 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1508,7 +1508,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
>  						   pages, vmas, NULL,
>  						   gup_flags);
>  
> -		if ((nr_pages > 0) && migrate_allow) {
> +		if (((long)nr_pages > 0) && migrate_allow) {
>  			drain_allow = true;
>  			goto check_again;
>  		}
> 

