Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE14C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D7F21855
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="KrCCbqJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFQG6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 02:58:50 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:35392 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFQG6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 02:58:50 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id E03DF2DC007F;
        Mon, 17 Jun 2019 02:58:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1560754726;
        bh=qtYoLQ9Jtz+QdOMQZQtS2I0PlmfBJLpviCQHIugyg54=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KrCCbqJwEDVPV1oa+HDQWzTzSNiFMcYGZMMOmYQw9F/WU0Jd4mbKK/W8AOXM4EUKo
         2FvKl6qyBtjfe8KwP88PsTOZUtfb1lAKkW+GyjR/YztolKQC2u2lUUgOK8+z0uNz4J
         heIGsVRcVkbaedZxOqjsigKFfYIwCfDjfUcdiedzqqwaR0H6flnOErGxjEB72K6Pwi
         hnKIJPA2PLyLlLICu+LYKqf92ky5qtgblyZ1hir94RpASmsX+yK9T2W1xlnEePXrWr
         Jjm95kC+O3yA0EfVTx7qgTnb1nVw6TO4XEzRdcRmQFoDKjpFKJKQiNFnx6x8sYBoSJ
         R50tcEWqLSW49YKe2nalt5ISXsrcOlJ4PCklJz+kkhsv364+gPdAfq/KebM41n/MRR
         pBmPcDdbJf0/BKltr9bwIm1Hq0wnzPwv81DkVG6PWTGwcwMAJh6rgZdMqxthd3kawu
         OdXg8gLwAPQlFgCHO1aSj08TT6/6qqFEzVQ1tNsUZYusRL67Jiq8XTm9x/S1p1ShgL
         mdfEj/o61fknpMcUGqQ2YqCmNhKllEDvSt1oczBtefKutI0qT3iDpF19pUfeWCXbcI
         w8n3qi6ggAcV8tEQevpUrxAF+jNxm4D/L78u7wXQsnUsA5eig/n2+Rz8ekfgXQYoce
         sShKw4GRp7OoxN+XmPZ+gEi4=
Received: from adsilva.ozlabs.ibm.com (static-82-10.transact.net.au [122.99.82.10] (may be forged))
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x5H6wNQI056924
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 16:58:38 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
Message-ID: <790f8e0126abfa199cb690270c94ce163eca458d.camel@d-silva.org>
Subject: Re: [PATCH 4/5] mm/hotplug: Avoid RCU stalls when removing large
 amounts of memory
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Juergen Gross <jgross@suse.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Arun KS <arunks@codeaurora.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Jun 2019 16:58:22 +1000
In-Reply-To: <20190617065357.GD16810@rapoport-lnx>
References: <20190617043635.13201-1-alastair@au1.ibm.com>
         <20190617043635.13201-5-alastair@au1.ibm.com>
         <20190617065357.GD16810@rapoport-lnx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Mon, 17 Jun 2019 16:58:42 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-17 at 09:53 +0300, Mike Rapoport wrote:
> On Mon, Jun 17, 2019 at 02:36:30PM +1000, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > When removing sufficiently large amounts of memory, we trigger RCU
> > stall
> > detection. By periodically calling cond_resched(), we avoid bogus
> > stall
> > warnings.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >  mm/memory_hotplug.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index e096c987d261..382b3a0c9333 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -578,6 +578,9 @@ void __remove_pages(struct zone *zone, unsigned
> > long phys_start_pfn,
> >  		__remove_section(zone, __pfn_to_section(pfn),
> > map_offset,
> >  				 altmap);
> >  		map_offset = 0;
> > +
> > +		if (!(i & 0x0FFF))
> 
> No magic numbers please. And a comment would be appreciated.
> 

Agreed, thanks for the review.

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva    
Twitter: @EvilDeece
blog: http://alastair.d-silva.org


