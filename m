Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A33DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315CA2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfCTIDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:03:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbfCTIDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:03:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44C1AC01089C;
        Wed, 20 Mar 2019 08:03:40 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2823A6B499;
        Wed, 20 Mar 2019 08:03:36 +0000 (UTC)
Date:   Wed, 20 Mar 2019 16:03:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pasha.tatashin@oracle.com, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, richard.weiyang@gmail.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm/sparse: Optimize sparse_add_one_section()
Message-ID: <20190320080334.GM18740@MiWiFi-R3L-srv>
References: <20190320073540.12866-1-bhe@redhat.com>
 <20190320073540.12866-2-bhe@redhat.com>
 <20190320075649.GC13626@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320075649.GC13626@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 20 Mar 2019 08:03:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/19 at 09:56am, Mike Rapoport wrote:
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 0a0f82c5d969..054b99f74181 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -697,16 +697,17 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
> >  	ret = sparse_index_init(section_nr, nid);
> >  	if (ret < 0 && ret != -EEXIST)
> >  		return ret;
> > -	ret = 0;
> > -	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> > -	if (!memmap)
> > -		return -ENOMEM;
> > +
> >  	usemap = __kmalloc_section_usemap();
> > -	if (!usemap) {
> > -		__kfree_section_memmap(memmap, altmap);
> > +	if (!usemap)
> > +		return -ENOMEM;
> > +	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> > +	if (!memmap) {
> > +		kfree(usemap);
> 
> If you are anyway changing this why not to switch to goto's for error
> handling?

OK, I am fine to switch to 'goto'. Will update and repost. Thanks.

> 
> >  		return -ENOMEM;
> >  	}
> > 
> > +	ret = 0;
> >  	ms = __pfn_to_section(start_pfn);
> >  	if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
> >  		ret = -EEXIST;
> > -- 
> > 2.17.2
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 
