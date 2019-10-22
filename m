Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4E5CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECE92064B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbfJVIAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:00:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:49322 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387946AbfJVIAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:00:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D973AB34B;
        Tue, 22 Oct 2019 08:00:51 +0000 (UTC)
Date:   Tue, 22 Oct 2019 10:00:49 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/16] mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
Message-ID: <20191022080049.GE19060@linux>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-10-osalvador@suse.de>
 <20191021070439.GC9037@hori.linux.bs1.fc.nec.co.jp>
 <20191021095106.GA22933@www9186uo.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021095106.GA22933@www9186uo.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 06:51:09PM +0900, Naoya Horiguchi wrote:
> Here's the one.  So Oscar, If you like, could you append this to
> your tree in the next spin (with your credit or signed-off-by)?

Sure, I will add it.

Thanks

> 
> Thanks,
> Naoya Horiguchi
> ---
> From b920f965485f6679ddc27e1a51da5bff7a5cc81a Mon Sep 17 00:00:00 2001
> From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Date: Mon, 21 Oct 2019 18:42:33 +0900
> Subject: [PATCH] mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
> 
> memory_failure() is supposed to call action_result() when it handles
> a memory error event, but there's one missing case. So let's add it.
> 
> I find that include/ras/ras_event.h has some other MF_MSG_* undefined,
> so this patch also adds them.
> 
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> ---
>  include/linux/mm.h      | 1 +
>  include/ras/ras_event.h | 3 +++
>  mm/memory-failure.c     | 5 ++++-
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3eba26324ff1..022033cc6782 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2818,6 +2818,7 @@ enum mf_action_page_type {
>  	MF_MSG_BUDDY,
>  	MF_MSG_BUDDY_2ND,
>  	MF_MSG_DAX,
> +	MF_MSG_UNSPLIT_THP,
>  	MF_MSG_UNKNOWN,
>  };
>  
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index 36c5c5e38c1d..0bdbc0d17d2f 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -361,6 +361,7 @@ TRACE_EVENT(aer_event,
>  	EM ( MF_MSG_POISONED_HUGE, "huge page already hardware poisoned" )	\
>  	EM ( MF_MSG_HUGE, "huge page" )					\
>  	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
> +	EM ( MF_MSG_NON_PMD_HUGE, "non-pmd-sized huge page" )		\
>  	EM ( MF_MSG_UNMAP_FAILED, "unmapping failed page" )		\
>  	EM ( MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page" )		\
>  	EM ( MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page" )		\
> @@ -373,6 +374,8 @@ TRACE_EVENT(aer_event,
>  	EM ( MF_MSG_TRUNCATED_LRU, "already truncated LRU page" )	\
>  	EM ( MF_MSG_BUDDY, "free buddy page" )				\
>  	EM ( MF_MSG_BUDDY_2ND, "free buddy page (2nd try)" )		\
> +	EM ( MF_MSG_DAX, "dax page" )					\
> +	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
>  	EMe ( MF_MSG_UNKNOWN, "unknown page" )
>  
>  /*
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 46ca856703f6..b15086ad8948 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -583,6 +583,7 @@ static const char * const action_page_types[] = {
>  	[MF_MSG_BUDDY]			= "free buddy page",
>  	[MF_MSG_BUDDY_2ND]		= "free buddy page (2nd try)",
>  	[MF_MSG_DAX]			= "dax page",
> +	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
>  	[MF_MSG_UNKNOWN]		= "unknown page",
>  };
>  
> @@ -1361,8 +1362,10 @@ int memory_failure(unsigned long pfn, int flags)
>  	}
>  
>  	if (PageTransHuge(hpage)) {
> -		if (try_to_split_thp_page(p, "Memory Failure") < 0)
> +		if (try_to_split_thp_page(p, "Memory Failure") < 0) {
> +			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
>  			return -EBUSY;
> +		}
>  		VM_BUG_ON_PAGE(!page_count(p), p);
>  		hpage = compound_head(p);
>  	}
> -- 
> 2.17.1
> 

-- 
Oscar Salvador
SUSE L3
