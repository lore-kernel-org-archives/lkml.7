Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EDBC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9492175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553109133;
	bh=d9tk0Ua+fCtbmRTbRRVa4EF3wyUb4zoYH6DUfhR5+Mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kY0PKi/49uixaZN9wQ3zbmermIltr5pTxw5WdStclDJj9n7s3A4CZv5T7aYfQU1uI
	 qnG6qcJasJ8ZcQlKt1BF7UQZUPJLWQ0t2qCFGv/8Wvzk5FZ2k3cBxOW2Wdp4tuIJcw
	 8y8sVrbr/rOwbB8JPL/04W6JlzsomU2vODnRUsxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfCTTMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:12:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53296 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTTML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:12:11 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9CB24CA1;
        Wed, 20 Mar 2019 19:12:10 +0000 (UTC)
Date:   Wed, 20 Mar 2019 12:12:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, osalvador@suse.de, mhocko@suse.com,
        david@redhat.com, richard.weiyang@gmail.com, rppt@linux.ibm.com,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm, memory_hotplug: Fix the wrong usage of
 N_HIGH_MEMORY
Message-Id: <20190320121209.5cd30d7b15f299df7d97d51e@linux-foundation.org>
In-Reply-To: <20190320080732.14933-1-bhe@redhat.com>
References: <20190320080732.14933-1-bhe@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 16:07:32 +0800 Baoquan He <bhe@redhat.com> wrote:

> In function node_states_check_changes_online(), N_HIGH_MEMORY is used
> to substitute ZONE_HIGHMEM directly. This is not right. N_HIGH_MEMORY
> always has value '3' if CONFIG_HIGHMEM=y, while ZONE_HIGHMEM's value
> is not. It depends on whether CONFIG_ZONE_DMA/CONFIG_ZONE_DMA32 are
> enabled. Obviously it's not true for CONFIG_ZONE_DMA32 on 32bit system,
> and CONFIG_ZONE_DMA is also optional.
> 
> Replace it with ZONE_HIGHMEM.
> 
> Fixes: 8efe33f40f3e ("mm/memory_hotplug.c: simplify node_states_check_changes_online")

What are the runtime effects of this change?

> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -712,7 +712,7 @@ static void node_states_check_changes_online(unsigned long nr_pages,
>  	if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
>  		arg->status_change_nid_normal = nid;
>  #ifdef CONFIG_HIGHMEM
> -	if (zone_idx(zone) <= N_HIGH_MEMORY && !node_state(nid, N_HIGH_MEMORY))
> +	if (zone_idx(zone) <= ZONE_HIGHMEM && !node_state(nid, N_HIGH_MEMORY))
>  		arg->status_change_nid_high = nid;
>  #endif
>  }

