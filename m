Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9BFCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA3621906
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571731721;
	bh=+MlWSvS5f8l1gqIcAKPVX8o4bHZEGgrMxsGD7+3vMfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KWYPQ8HYlMLGuRJzbsoFPM+Bz8ztJbKfhWMVqycLTkdvxmI2p58D3iUDGS+WQcnSu
	 fBTxw77FhANnKA58KjnPpTG8L4Z/xjiAS+oxasubSRQp+ufsaQZVE4S51/cmnlfwMF
	 9cJuK8GO94bZFwdvRYg0Xag8L6vs9OFJYbG49rMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbfJVIIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:08:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:56856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388047AbfJVIIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:08:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 945C8B12D;
        Tue, 22 Oct 2019 08:08:37 +0000 (UTC)
Date:   Tue, 22 Oct 2019 10:08:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 0/2] mm: Memory offlining + page isolation cleanups
Message-ID: <20191022080835.GZ9379@dhcp22.suse.cz>
References: <20191021172353.3056-1-david@redhat.com>
 <25d3f071-3268-298b-e0c8-9c307d1015fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d3f071-3268-298b-e0c8-9c307d1015fe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 08:52:28, David Hildenbrand wrote:
> On 21.10.19 19:23, David Hildenbrand wrote:
> > Two cleanups that popped up while working on (and discussing) virtio-mem:
> >   https://lkml.org/lkml/2019/9/19/463
> > 
> > Tested with DIMMs on x86.
> > 
> > As discussed with michal in v1, I'll soon look into removing the use
> > of PG_reserved during memory onlining completely - most probably
> > disallowing to offline memory blocks with holes, cleaning up the
> > onlining+offlining code.
> 
> BTW, I remember that ZONE_DEVICE pages are still required to be set
> PG_reserved. That has to be sorted out first.

Do they?

> I remember that somebody was
> working on it a while ago but didn't hear about that again. Will look into
> that as well - should be as easy as adding a zone check (if there isn't a
> pfn_to_online_page() check already). But of course, there might be special
> cases ....

I remember Alexander didn't want to change the PageReserved handling
because he was worried about unforeseeable side effects. I have a vague
recollection he (or maybe Dan) has promissed some follow up clean ups
which didn't seem to materialize.
-- 
Michal Hocko
SUSE Labs
