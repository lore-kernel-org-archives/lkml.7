Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C62C06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEE12053B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561985241;
	bh=wqvbG8SukW7hkjqXYXOq5/npv3vWhrih67TqeY9kADk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pLUisTCgV1pJj203ECbREvfNlbPlqNchFDt2EQmIelEsuWx4FQ2EtlE/kNKsCrNSh
	 i10qDAeAEVonuNQ6TcriGuCBdOVjrIZ24Vc02eq5zQ8Lkgo+bpZU9I0ErigvjStc/o
	 KrVdoEFhGN2t9Dxrfbd4F/EBAa2xDvKpGvZCYmmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfGAMrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 08:47:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:50884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727479AbfGAMrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:47:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8ACFAEF5;
        Mon,  1 Jul 2019 12:47:17 +0000 (UTC)
Date:   Mon, 1 Jul 2019 14:47:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.com>
Subject: Re: [PATCH v3 03/11] s390x/mm: Implement arch_remove_memory()
Message-ID: <20190701124717.GU6376@dhcp22.suse.cz>
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-4-david@redhat.com>
 <20190701074503.GD6376@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701074503.GD6376@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-07-19 09:45:03, Michal Hocko wrote:
> On Mon 27-05-19 13:11:44, David Hildenbrand wrote:
> > Will come in handy when wanting to handle errors after
> > arch_add_memory().
> 
> I do not understand this. Why do you add a code for something that is
> not possible on this HW (based on the comment - is it still valid btw?)

Same as the previous patch (drop it).

> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Oscar Salvador <osalvador@suse.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  arch/s390/mm/init.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> > index d552e330fbcc..14955e0a9fcf 100644
> > --- a/arch/s390/mm/init.c
> > +++ b/arch/s390/mm/init.c
> > @@ -243,12 +243,13 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >  void arch_remove_memory(int nid, u64 start, u64 size,
> >  			struct vmem_altmap *altmap)
> >  {
> > -	/*
> > -	 * There is no hardware or firmware interface which could trigger a
> > -	 * hot memory remove on s390. So there is nothing that needs to be
> > -	 * implemented.
> > -	 */
> > -	BUG();
> > +	unsigned long start_pfn = start >> PAGE_SHIFT;
> > +	unsigned long nr_pages = size >> PAGE_SHIFT;
> > +	struct zone *zone;
> > +
> > +	zone = page_zone(pfn_to_page(start_pfn));
> > +	__remove_pages(zone, start_pfn, nr_pages, altmap);
> > +	vmem_remove_mapping(start, size);
> >  }
> >  #endif
> >  #endif /* CONFIG_MEMORY_HOTPLUG */
> > -- 
> > 2.20.1
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
