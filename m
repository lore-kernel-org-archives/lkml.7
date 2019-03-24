Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7FBC10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674F32133F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553465978;
	bh=mYgskR40nTFhXJ1RAp7B+npZAGg9e3LSMKOZAiE0Gjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wbMsIsgtJjt2H0I4OYvixUn+jA/FjYGt7yyvcGSVchmKencxEvc5riDDX3QrMcEdR
	 rN1OQkW0X8o7gtxcWCA2HFpFSgzOAML2vUdPMI+4RYeS2Vr/qX+OY+N7TSJr2NvVTz
	 0k7tRgR99RDrOLW/rVK85IDE0a5yaWSgdTqWGkFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfCXWTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:19:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:46004 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728963AbfCXWTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:19:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 15:19:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="331609997"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 24 Mar 2019 15:19:34 -0700
Date:   Sun, 24 Mar 2019 16:20:41 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] mm: vmscan: demote anon DRAM pages to PMEM node
Message-ID: <20190324222040.GE31194@localhost.localdomain>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <1553316275-21985-7-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553316275-21985-7-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 12:44:31PM +0800, Yang Shi wrote:
>  		/*
> +		 * Demote DRAM pages regardless the mempolicy.
> +		 * Demot anonymous pages only for now and skip MADV_FREE
> +		 * pages.
> +		 */
> +		if (PageAnon(page) && !PageSwapCache(page) &&
> +		    (node_isset(page_to_nid(page), def_alloc_nodemask)) &&
> +		    PageSwapBacked(page)) {
> +
> +			if (has_nonram_online()) {
> +				list_add(&page->lru, &demote_pages);
> +				unlock_page(page);
> +				continue;
> +			}
> +		}
> +
> +		/*
>  		 * Anonymous process memory has backing store?
>  		 * Try to allocate it some swap space here.
>  		 * Lazyfree page could be freed directly
> @@ -1477,6 +1507,25 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  		VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
>  	}
>  
> +	/* Demote pages to PMEM */
> +	if (!list_empty(&demote_pages)) {
> +		int err, target_nid;
> +		nodemask_t used_mask;
> +
> +		nodes_clear(used_mask);
> +		target_nid = find_next_best_node(pgdat->node_id, &used_mask,
> +						 true);
> +
> +		err = migrate_pages(&demote_pages, alloc_new_node_page, NULL,
> +				    target_nid, MIGRATE_ASYNC, MR_DEMOTE);
> +
> +		if (err) {
> +			putback_movable_pages(&demote_pages);
> +
> +			list_splice(&ret_pages, &demote_pages);
> +		}
> +	}
> +
>  	mem_cgroup_uncharge_list(&free_pages);
>  	try_to_unmap_flush();
>  	free_unref_page_list(&free_pages);

How do these pages eventually get to swap when migration fails? Looks
like that's skipped.

And page cache demotion is useful too, we shouldn't consider only
anonymous for this feature.
