Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19923C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70122083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553111609;
	bh=4Jgy3ijQmOE+WDX+l3HCoLNIUje0+pxoHh8fgZgF+Go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WGN6MbqizxM1k0Ru5OXEc9epmIVHPZ0QQCQ8/6aeb4Tx32AjOGkpSEuUq/OHhsqiT
	 JWMLp0EmvTcoS8220AVeBHoJf/M8+9PiO9rF0cIMcqmOcBPCpn+dh0/8hCOeoHWLNi
	 +BpLla3nPyrZbl5yPhc69jxn9Hwbj9jsue6WFQ/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfCTTx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:53:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:58230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbfCTTxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:53:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C219AEF5;
        Wed, 20 Mar 2019 19:53:23 +0000 (UTC)
Date:   Wed, 20 Mar 2019 20:53:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        osalvador@suse.de, david@redhat.com, richard.weiyang@gmail.com,
        rppt@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH] mm, memory_hotplug: Fix the wrong usage of N_HIGH_MEMORY
Message-ID: <20190320195321.GE8696@dhcp22.suse.cz>
References: <20190320080732.14933-1-bhe@redhat.com>
 <20190320121209.5cd30d7b15f299df7d97d51e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320121209.5cd30d7b15f299df7d97d51e@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-03-19 12:12:09, Andrew Morton wrote:
> On Wed, 20 Mar 2019 16:07:32 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > In function node_states_check_changes_online(), N_HIGH_MEMORY is used
> > to substitute ZONE_HIGHMEM directly. This is not right. N_HIGH_MEMORY
> > always has value '3' if CONFIG_HIGHMEM=y, while ZONE_HIGHMEM's value
> > is not. It depends on whether CONFIG_ZONE_DMA/CONFIG_ZONE_DMA32 are
> > enabled. Obviously it's not true for CONFIG_ZONE_DMA32 on 32bit system,
> > and CONFIG_ZONE_DMA is also optional.
> > 
> > Replace it with ZONE_HIGHMEM.
> > 
> > Fixes: 8efe33f40f3e ("mm/memory_hotplug.c: simplify node_states_check_changes_online")
> 
> What are the runtime effects of this change?

There shouldn't be none. The code is just messy. The newer changelog
should make it more clear I believe.

> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -712,7 +712,7 @@ static void node_states_check_changes_online(unsigned long nr_pages,
> >  	if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
> >  		arg->status_change_nid_normal = nid;
> >  #ifdef CONFIG_HIGHMEM
> > -	if (zone_idx(zone) <= N_HIGH_MEMORY && !node_state(nid, N_HIGH_MEMORY))
> > +	if (zone_idx(zone) <= ZONE_HIGHMEM && !node_state(nid, N_HIGH_MEMORY))
> >  		arg->status_change_nid_high = nid;
> >  #endif
> >  }
> 

-- 
Michal Hocko
SUSE Labs
