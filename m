Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7018BFA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493E720854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571224046;
	bh=4eXJkKP3+/VLUz/fy1V09BdMuW06HSCSbEpWUswI4ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=en8EFbZq2E96Y0zu05j9aLHQpS+53NofIGMSs1gplkKPkdTGVIgVwX9scFto6/p8e
	 Kuv9gB0X2dqY9VLxNeJzQc8W7LcMMQHWnAXUenWYMOVeZYWaEYDD+tKzDMEInHuO9g
	 SIwwJRoAyZnK56b19ZBsrBgd38HbavwC3pDWvSgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390775AbfJPLHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:07:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:46524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbfJPLHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:07:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 012BAB1FF;
        Wed, 16 Oct 2019 11:07:23 +0000 (UTC)
Date:   Wed, 16 Oct 2019 13:07:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 3/3] mm/vmalloc: add more comments to the
 adjust_va_to_fit_type()
Message-ID: <20191016110722.GU317@dhcp22.suse.cz>
References: <20191016095438.12391-1-urezki@gmail.com>
 <20191016095438.12391-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016095438.12391-3-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 11:54:38, Uladzislau Rezki (Sony) wrote:
> When fit type is NE_FIT_TYPE there is a need in one extra object.
> Usually the "ne_fit_preload_node" per-CPU variable has it and
> there is no need in GFP_NOWAIT allocation, but there are exceptions.
> 
> This commit just adds more explanations, as a result giving
> answers on questions like when it can occur, how often, under
> which conditions and what happens if GFP_NOWAIT gets failed.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmalloc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 593bf554518d..2290a0d270e4 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -969,6 +969,19 @@ adjust_va_to_fit_type(struct vmap_area *va,
>  			 * There are a few exceptions though, as an example it is
>  			 * a first allocation (early boot up) when we have "one"
>  			 * big free space that has to be split.
> +			 *
> +			 * Also we can hit this path in case of regular "vmap"
> +			 * allocations, if "this" current CPU was not preloaded.
> +			 * See the comment in alloc_vmap_area() why. If so, then
> +			 * GFP_NOWAIT is used instead to get an extra object for
> +			 * split purpose. That is rare and most time does not
> +			 * occur.
> +			 *
> +			 * What happens if an allocation gets failed. Basically,
> +			 * an "overflow" path is triggered to purge lazily freed
> +			 * areas to free some memory, then, the "retry" path is
> +			 * triggered to repeat one more time. See more details
> +			 * in alloc_vmap_area() function.
>  			 */
>  			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
>  			if (!lva)
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
