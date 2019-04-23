Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ABCC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4564A20843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OY0kxQQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfDWIzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:55:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46544 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vzytoljj+XSZztNSEXF/+jHuvarC7Phi+bRc5Lds+2A=; b=OY0kxQQCWaRRFvkHxaJDDH859D
        doWhg6jMgGLA2qRh0WfVL/ddu4Vh2aX0cvCWc/bIv+uWFJLp72sDTev5Fv71xin+ob6VuaaOqMLiq
        QsHPWqnIph1yIh2nHyb6oYyiM00+ru8vQPfFBkBTWxUJ6o7624/yf80Ve9cfq5y7GXw15gsoY8vqr
        XtFVBZWWJ8rD7frh7Hz8E/EmqdEAN+o19CfwdEvTrJojsmmZmwI5c0II2G2J1T0NFzqMErUS5sKnx
        2DSRihH4gZVdTtuParDoBhWKnqTH6ThfX/euuVzAu0Be8x3dVocjoO0Al4I1AVfng9SResQ7Zkq8p
        3CgMcKQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIrDD-0001M3-DP; Tue, 23 Apr 2019 08:55:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB27329B47DCB; Tue, 23 Apr 2019 10:55:33 +0200 (CEST)
Date:   Tue, 23 Apr 2019 10:55:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 3/5] numa: introduce per-cgroup preferred numa node
Message-ID: <20190423085533.GF11158@hirez.programming.kicks-ass.net>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <77452c03-bc4c-7aed-e605-d5351f868586@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77452c03-bc4c-7aed-e605-d5351f868586@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:13:36AM +0800, 王贇 wrote:
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index af171ccb56a2..6513504373b4 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2031,6 +2031,10 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
> 
>  	pol = get_vma_policy(vma, addr);
> 
> +	page = alloc_page_numa_preferred(gfp, order);
> +	if (page)
> +		goto out;
> +
>  	if (pol->mode == MPOL_INTERLEAVE) {
>  		unsigned nid;
> 

This I think is wrong, it overrides app specific mbind() requests.
