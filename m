Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEDEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494F32147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552407487;
	bh=zjlL+GMe3QK8WSPfUp7FLw17V98DjLEQ/i81NIZ9WF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qF/uy3yaqFI6JwW1pfJkfLcJMFfXUEfhNGiUFFMOcJZJmK7dWl3D8Lfrxi3is4a+f
	 q3Ntk6TIabXxvO4CVJ10kixJo7AkKagOC5YufIguYlm7cQf9cZXEptqI054oa3FQum
	 qJRYMTGHsNm6kxGKTpauzJHWOZ9kMp4lNXBTbGz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfCLQSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:18:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:52328 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfCLQSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:18:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CA88AC3C;
        Tue, 12 Mar 2019 16:18:03 +0000 (UTC)
Date:   Tue, 12 Mar 2019 17:18:03 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     vbabka@suse.cz, jrdr.linux@gmail.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shaoyafang@didiglobal.com
Subject: Re: [PATCH] mm: compaction: some tracepoints should be defined only
 when CONFIG_COMPACTION is set
Message-ID: <20190312161803.GC5721@dhcp22.suse.cz>
References: <1551501538-4092-1-git-send-email-laoar.shao@gmail.com>
 <1551501538-4092-2-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551501538-4092-2-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 02-03-19 12:38:58, Yafang Shao wrote:
> Only mm_compaction_isolate_{free, migrate}pages may be used when
> CONFIG_COMPACTION is not set.
> All others are used only when CONFIG_COMPACTION is set.

Why is this an improvement?

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/trace/events/compaction.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
> index 6074eff..3e42078 100644
> --- a/include/trace/events/compaction.h
> +++ b/include/trace/events/compaction.h
> @@ -64,6 +64,7 @@
>  	TP_ARGS(start_pfn, end_pfn, nr_scanned, nr_taken)
>  );
>  
> +#ifdef CONFIG_COMPACTION
>  TRACE_EVENT(mm_compaction_migratepages,
>  
>  	TP_PROTO(unsigned long nr_all,
> @@ -132,7 +133,6 @@
>  		__entry->sync ? "sync" : "async")
>  );
>  
> -#ifdef CONFIG_COMPACTION
>  TRACE_EVENT(mm_compaction_end,
>  	TP_PROTO(unsigned long zone_start, unsigned long migrate_pfn,
>  		unsigned long free_pfn, unsigned long zone_end, bool sync,
> @@ -166,7 +166,6 @@
>  		__entry->sync ? "sync" : "async",
>  		__print_symbolic(__entry->status, COMPACTION_STATUS))
>  );
> -#endif
>  
>  TRACE_EVENT(mm_compaction_try_to_compact_pages,
>  
> @@ -195,7 +194,6 @@
>  		__entry->prio)
>  );
>  
> -#ifdef CONFIG_COMPACTION
>  DECLARE_EVENT_CLASS(mm_compaction_suitable_template,
>  
>  	TP_PROTO(struct zone *zone,
> @@ -296,7 +294,6 @@
>  
>  	TP_ARGS(zone, order)
>  );
> -#endif
>  
>  TRACE_EVENT(mm_compaction_kcompactd_sleep,
>  
> @@ -352,6 +349,7 @@
>  
>  	TP_ARGS(nid, order, classzone_idx)
>  );
> +#endif
>  
>  #endif /* _TRACE_COMPACTION_H */
>  
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
