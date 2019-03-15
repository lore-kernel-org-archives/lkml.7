Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E610C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBAA21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfCOOdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:33:10 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:59941 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729221AbfCOOdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 10:33:10 -0400
Received: by suse.de (Postfix, from userid 1000)
        id D4ADD459A; Fri, 15 Mar 2019 15:33:07 +0100 (CET)
Date:   Fri, 15 Mar 2019 15:33:07 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, anshuman.khandual@arm.com,
        william.kucharski@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: Fix __dump_page when mapping->host is not set
Message-ID: <20190315143304.pkuvj4qwtlzgm7iq@d104.suse.de>
References: <20190315121826.23609-1-osalvador@suse.de>
 <20190315124733.GE15672@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315124733.GE15672@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 01:47:33PM +0100, Michal Hocko wrote:
> diff --git a/mm/debug.c b/mm/debug.c
> index 1611cf00a137..499c26d5ebe5 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -78,6 +78,9 @@ void __dump_page(struct page *page, const char *reason)
>  	else if (PageKsm(page))
>  		pr_warn("ksm ");
>  	else if (mapping) {
> +		if (PageSwapCache(page))
> +			mapping = page_swap_info(page)->swap_file->f_mapping;
> +
>  		pr_warn("%ps ", mapping->a_ops);
>  		if (mapping->host->i_dentry.first) {
>  			struct dentry *dentry;

This looks like a much nicer fix, indeed.
I gave it a spin and it works.

Since the mapping is set during the swapon, I would assume that this should
always work for swap.
Although I am not sure if once you start playing with e.g zswap the picture can
change.

Let us wait for Hugh and Jan.

Thanks Michal

-- 
Oscar Salvador
SUSE L3
