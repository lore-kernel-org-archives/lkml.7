Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010F1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEAF2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfCTJGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:06:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfCTJGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:06:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF3D830821FA;
        Wed, 20 Mar 2019 09:06:29 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 26FE02E02C;
        Wed, 20 Mar 2019 09:06:26 +0000 (UTC)
Date:   Wed, 20 Mar 2019 17:06:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        osalvador@suse.de, david@redhat.com, richard.weiyang@gmail.com,
        rppt@linux.ibm.com
Subject: Re: [PATCH] mm, memory_hotplug: Fix the wrong usage of N_HIGH_MEMORY
Message-ID: <20190320090624.GN18740@MiWiFi-R3L-srv>
References: <20190320080732.14933-1-bhe@redhat.com>
 <20190320084600.GG30433@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320084600.GG30433@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 20 Mar 2019 09:06:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/19 at 09:46am, Michal Hocko wrote:
> On Wed 20-03-19 16:07:32, Baoquan He wrote:
> > In function node_states_check_changes_online(), N_HIGH_MEMORY is used
> > to substitute ZONE_HIGHMEM directly. This is not right. N_HIGH_MEMORY
> > always has value '3' if CONFIG_HIGHMEM=y, while ZONE_HIGHMEM's value
> > is not. It depends on whether CONFIG_ZONE_DMA/CONFIG_ZONE_DMA32 are
> > enabled. Obviously it's not true for CONFIG_ZONE_DMA32 on 32bit system,
> > and CONFIG_ZONE_DMA is also optional.
> > 
> > Replace it with ZONE_HIGHMEM.
> 
> N*MEMORY is confusing as hell but I am really curious whether we have
> ZONE_DMA32 and ZONE_HIGMEM together?

Not sure. AFAIK, on x86_32 it can't be.

> 
> That being said N.*MEMORY is intended to check for nodes rather than
> zones so the patch looks good to me but I think the above explanation is
> misleading and will add even more mud to the picture when somebody tries
> to understand what the heck is going on here.

Yes, agree. I also thought this again after I sent out patch, feel log is not
good. As you said, they are value of enum node_states and enum zone_type
separately.

How about this:

~~~
In function node_states_check_changes_online(), N_HIGH_MEMORY is used
to substitute ZONE_HIGHMEM directly. This is not right. N_HIGH_MEMORY
is to mark the memory state of node. Here zone index is checked, which
should be compared with 'ZONE_HIGHMEM' accordingly.

Replace it with ZONE_HIGHMEM.
~~~
> 
> > Fixes: 8efe33f40f3e ("mm/memory_hotplug.c: simplify node_states_check_changes_online")
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/memory_hotplug.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 6b05576fb4ec..09911d34a3be 100644
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
> > -- 
> > 2.17.2
> 
> -- 
> Michal Hocko
> SUSE Labs
