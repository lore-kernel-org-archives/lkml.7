Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FBDECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0B2218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570632206;
	bh=LXkVwdwxi6dhLgKLBPf7u0duHW3JVRoVbFhzCiczVFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nX7MPtoQYQnXdH+9GoyKPI7BvRnI7w0J3+WfoEJJL8rZSCUNZvWGyzsoRgTheEX1y
	 xx0VJQsFIQ159YfCMiOQv5+4gYcELlU5HUQU/eoV+pB7Sx8hfOi0kBugr8ysHj8u7a
	 X8hSjXXG1aVzR5jfCSjh/AzqOxzvQt5KyJVw3NM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbfJIOnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:43:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:35940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730674AbfJIOnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:43:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A297DAD12;
        Wed,  9 Oct 2019 14:43:23 +0000 (UTC)
Date:   Wed, 9 Oct 2019 16:43:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
Message-ID: <20191009144323.GH6681@dhcp22.suse.cz>
References: <20191009142435.3975-1-david@redhat.com>
 <20191009142435.3975-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009142435.3975-3-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-10-19 16:24:35, David Hildenbrand wrote:
> We should check for pfn_to_online_page() to not access uninitialized
> memmaps. Reshuffle the code so we don't have to duplicate the error
> message.
> 
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory-failure.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 7ef849da8278..e866e6e5660b 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1253,17 +1253,19 @@ int memory_failure(unsigned long pfn, int flags)
>  	if (!sysctl_memory_failure_recovery)
>  		panic("Memory failure on page %lx", pfn);
>  
> -	if (!pfn_valid(pfn)) {
> +	p = pfn_to_online_page(pfn);
> +	if (!p) {
> +		if (pfn_valid(pfn)) {
> +			pgmap = get_dev_pagemap(pfn, NULL);
> +			if (pgmap)
> +				return memory_failure_dev_pagemap(pfn, flags,
> +								  pgmap);
> +		}
>  		pr_err("Memory failure: %#lx: memory outside kernel control\n",
>  			pfn);
>  		return -ENXIO;

Don't we need that earlier at hwpoison_inject level?

-- 
Michal Hocko
SUSE Labs
