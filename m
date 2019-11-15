Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1789C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BAB2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfKOVN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:13:27 -0500
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:45045 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727414AbfKOVNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:13:25 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4CEEF1800972C;
        Fri, 15 Nov 2019 21:13:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sheet88_3ab5708df5b0a
X-Filterd-Recvd-Size: 1924
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 Nov 2019 21:13:23 +0000 (UTC)
Message-ID: <f15994ec5b9c311677064583ff968b3cf881d4ab.camel@perches.com>
Subject: Re: [PATCH] iommu/iova: silence warnings under memory pressure
From:   Joe Perches <joe@perches.com>
To:     Qian Cai <cai@lca.pw>, jroedel@suse.de
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 Nov 2019 13:13:03 -0800
In-Reply-To: <1573851046-32384-1-git-send-email-cai@lca.pw>
References: <1573851046-32384-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 15:50 -0500, Qian Cai wrote:
> When running heavy memory pressure workloads, this 5+ old system is
> throwing endless warnings below because disk IO is too slow to recover
> from swapping. Since the volume from alloc_iova_fast() could be large,
> once it calls printk(), it will trigger disk IO (writing to the log
> files) and pending softirqs which could cause a loop and no progress
> from memory reclaim for days.
[]
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
[]
> @@ -233,7 +233,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  
>  struct iova *alloc_iova_mem(void)
>  {
> -	return kmem_cache_alloc(iova_cache, GFP_ATOMIC);
> +	return kmem_cache_alloc(iova_cache, GFP_ATOMIC | __GFP_NOWARN);
>  }
>  EXPORT_SYMBOL(alloc_iova_mem);

Is notification ever useful?

If so, maybe something like:

struct iova *alloc_iova_mem(void)
{
	void *mem = kmem_cache_alloc(iova_cache, GFP_ATOMIC | __GFP_NOWARN)_

	WARN_RATELIMIT(!mem, "%s: unable to alloc cache\n", __func__);

	return mem;
}

or maybe use printk_deferred or prink_deferred_once

?


