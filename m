Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAFFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D7120857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfCZKIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:08:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZKIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:08:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B4FB3082AFA;
        Tue, 26 Mar 2019 10:08:21 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 917992636E;
        Tue, 26 Mar 2019 10:08:20 +0000 (UTC)
Date:   Tue, 26 Mar 2019 18:08:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rppt@linux.ibm.com, osalvador@suse.de,
        willy@infradead.org, william.kucharski@oracle.com
Subject: Re: [PATCH v2 2/4] mm/sparse: Optimize sparse_add_one_section()
Message-ID: <20190326100817.GV3659@MiWiFi-R3L-srv>
References: <20190326090227.3059-1-bhe@redhat.com>
 <20190326090227.3059-3-bhe@redhat.com>
 <20190326092936.GK28406@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326092936.GK28406@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 26 Mar 2019 10:08:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/19 at 10:29am, Michal Hocko wrote:
> On Tue 26-03-19 17:02:25, Baoquan He wrote:
> > Reorder the allocation of usemap and memmap since usemap allocation
> > is much simpler and easier. Otherwise hard work is done to make
> > memmap ready, then have to rollback just because of usemap allocation
> > failure.
> 
> Is this really worth it? I can see that !VMEMMAP is doing memmap size
> allocation which would be 2MB aka costly allocation but we do not do
> __GFP_RETRY_MAYFAIL so the allocator backs off early.

In !VMEMMAP case, it truly does simple allocation directly. surely
usemap which size is 32 is smaller. So it doesn't matter that much who's
ahead or who's behind. However, this benefit a little in VMEMMAP case.

And this make code a little cleaner, e.g the error handling at the end
is taken away.

> 
> > And also check if section is present earlier. Then don't bother to
> > allocate usemap and memmap if yes.
> 
> Moving the check up makes some sense.
> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> The patch is not incorrect but I am wondering whether it is really worth
> it for the current code base. Is it fixing anything real or it is a mere
> code shuffling to please an eye?

It's not a fixing, just a tiny code refactorying inside
sparse_add_one_section(), seems it doesn't worsen thing if I got the
!VMEMMAP case correctly, not quite sure. I am fine to drop it if it's
not worth. I could miss something in different cases.

Thanks
Baoquan

> 
> > ---
> > v1->v2:
> >   Do section existence checking earlier to further optimize code.
> > 
> >  mm/sparse.c | 29 +++++++++++------------------
> >  1 file changed, 11 insertions(+), 18 deletions(-)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index b2111f996aa6..f4f34d69131e 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -714,20 +714,18 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
> >  	ret = sparse_index_init(section_nr, nid);
> >  	if (ret < 0 && ret != -EEXIST)
> >  		return ret;
> > -	ret = 0;
> > -	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> > -	if (!memmap)
> > -		return -ENOMEM;
> > -	usemap = __kmalloc_section_usemap();
> > -	if (!usemap) {
> > -		__kfree_section_memmap(memmap, altmap);
> > -		return -ENOMEM;
> > -	}
> >  
> >  	ms = __pfn_to_section(start_pfn);
> > -	if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
> > -		ret = -EEXIST;
> > -		goto out;
> > +	if (ms->section_mem_map & SECTION_MARKED_PRESENT)
> > +		return -EEXIST;
> > +
> > +	usemap = __kmalloc_section_usemap();
> > +	if (!usemap)
> > +		return -ENOMEM;
> > +	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> > +	if (!memmap) {
> > +		kfree(usemap);
> > +		return  -ENOMEM;
> >  	}
> >  
> >  	/*
> > @@ -739,12 +737,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
> >  	section_mark_present(ms);
> >  	sparse_init_one_section(ms, section_nr, memmap, usemap);
> >  
> > -out:
> > -	if (ret < 0) {
> > -		kfree(usemap);
> > -		__kfree_section_memmap(memmap, altmap);
> > -	}
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  #ifdef CONFIG_MEMORY_HOTREMOVE
> > -- 
> > 2.17.2
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
