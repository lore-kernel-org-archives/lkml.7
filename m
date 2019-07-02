Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BC5C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4B5206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562076157;
	bh=MZgX5sU/XRjeAzDp56w/YlqBRVrZHRQIP5z1yX/tNhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xEySxeL/ntCVvRxNNKsGVPoSHO92e5bTRNnkeayvs1Pif2jtYA8TTO6ndt2aaqf8m
	 UNscQbCZMo/qC3/HiTnv3YIhyx72K41ulCD37Sai5otkc+3Gwm+BovGGWTFRF6OiRW
	 z6A8AgeIGyBMATZ0YphOnCl8vUu/Jio+fVm7Zeic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfGBOCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:02:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:50036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbfGBOCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:02:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1C2CB6FE;
        Tue,  2 Jul 2019 14:02:34 +0000 (UTC)
Date:   Tue, 2 Jul 2019 16:02:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>, Qian Cai <cai@lca.pw>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_isolate: change the prototype of
 undo_isolate_page_range()
Message-ID: <20190702140232.GH978@dhcp22.suse.cz>
References: <1562075604-8979-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562075604-8979-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-07-19 21:53:24, Pingfan Liu wrote:
> undo_isolate_page_range() never fails, so no need to return value.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: linux-kernel@vger.kernel.org

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/page-isolation.h | 2 +-
>  mm/page_isolation.c            | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index 280ae96..1099c2f 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -50,7 +50,7 @@ start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>   * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
>   * target range is [start_pfn, end_pfn)
>   */
> -int
> +void
>  undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  			unsigned migratetype);
>  
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index e3638a5..89c19c0 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -230,7 +230,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  /*
>   * Make isolated pages available again.
>   */
> -int undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
> +void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  			    unsigned migratetype)
>  {
>  	unsigned long pfn;
> @@ -247,7 +247,6 @@ int undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  			continue;
>  		unset_migratetype_isolate(page, migratetype);
>  	}
> -	return 0;
>  }
>  /*
>   * Test all pages in the range is free(means isolated) or not.
> -- 
> 2.7.5

-- 
Michal Hocko
SUSE Labs
