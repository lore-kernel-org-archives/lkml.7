Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC92C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD01C21904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553219696;
	bh=VLyxdcDfHaRNm0WV1OV3klkgzJj7Vu993zsKJg4MnIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=i0SGqKL/pGvqtWXzAst+Xc913NKiP30/x5QNACGsS1/MRCAKaH0cRQhwbYHCiTpF7
	 qRKfSG6gbCTNXPxKmAKiP3dwIEvknTvAALA2/raKwtIu0ebWq2UbnRVNp1gMeP26WD
	 h7LG0SWRDcYl+YqJdlQxnlAcG4dhs8hTVr+58kaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfCVByz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:54:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42396 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfCVByz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:54:55 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33DD4E48;
        Fri, 22 Mar 2019 01:54:54 +0000 (UTC)
Date:   Thu, 21 Mar 2019 18:54:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/6] mm: memcontrol: replace node summing with
 memcg_page_state()
Message-Id: <20190321185453.6458679180e1e41893e7312b@linux-foundation.org>
In-Reply-To: <20190228163020.24100-4-hannes@cmpxchg.org>
References: <20190228163020.24100-1-hannes@cmpxchg.org>
        <20190228163020.24100-4-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 11:30:17 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Instead of adding up the node counters, use memcg_page_state() to get
> the memcg state directly. This is a bit cheaper and more stream-lined.
> 
> ...
>
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -746,10 +746,13 @@ static unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
>  			unsigned int lru_mask)
>  {
>  	unsigned long nr = 0;
> -	int nid;
> +	enum lru_list lru;
>  
> -	for_each_node_state(nid, N_MEMORY)
> -		nr += mem_cgroup_node_nr_lru_pages(memcg, nid, lru_mask);
> +	for_each_lru(lru) {
> +		if (!(BIT(lru) & lru_mask))
> +			continue;
> +		nr += memcg_page_state(memcg, NR_LRU_BASE + lru);
> +	}

Might be able to use for_each_set_bit(&lru_mnask) here, but it's much
of a muchness.

