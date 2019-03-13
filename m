Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06104C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2022171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfCMHwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 03:52:18 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:50711 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfCMHwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 03:52:18 -0400
Received: by suse.de (Postfix, from userid 1000)
        id AB5F84552; Wed, 13 Mar 2019 08:52:16 +0100 (CET)
Date:   Wed, 13 Mar 2019 08:52:16 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hotplug: fix offline undo_isolate_page_range()
Message-ID: <20190313075212.wc3pbwixx3ppwxua@d104.suse.de>
References: <20190313014216.36782-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313014216.36782-1-cai@lca.pw>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 09:42:16PM -0400, Qian Cai wrote:
> +
> +	/*
> +	 * Onlining will reset pagetype flags and makes migrate type
> +	 * MOVABLE, so just need to decrease the number of isolated
> +	 * pageblocks zone counter here.
> +	 */
> +	for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages) {
> +		int i;
> +
> +		for (i = 0; i < pageblock_nr_pages; i++)
> +			if (pfn_valid_within(pfn + i)) {
> +				zone->nr_isolate_pageblock--;
> +				break;
> +			}
> +	}
> +

I do not really like this.

I first thought about saving the value before entering start_isolate_page_range,
but that could race with alloc_contig_range for instance.
So, why not make start_isolate_page_range to return the actual number of isolated
pageblocks?
Sure, that would mean to change a bit how we threat its return code, but
I think that it is pretty simple.
In that way, we would only have to substract the value start_isolate_page_range
gave us at the end of __offline__pages() to set nr_isolate_pageblock back to
its original value.

-- 
Oscar Salvador
SUSE L3
