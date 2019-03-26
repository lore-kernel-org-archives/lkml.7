Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649B2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD9A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfCZJbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:31:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfCZJbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:31:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A2E5307D923;
        Tue, 26 Mar 2019 09:31:00 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 838371001E6B;
        Tue, 26 Mar 2019 09:30:59 +0000 (UTC)
Date:   Tue, 26 Mar 2019 17:30:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rppt@linux.ibm.com, osalvador@suse.de,
        willy@infradead.org, william.kucharski@oracle.com
Subject: Re: [PATCH v2 1/4] mm/sparse: Clean up the obsolete code comment
Message-ID: <20190326093057.GS3659@MiWiFi-R3L-srv>
References: <20190326090227.3059-1-bhe@redhat.com>
 <20190326090227.3059-2-bhe@redhat.com>
 <20190326092324.GJ28406@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326092324.GJ28406@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 26 Mar 2019 09:31:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/19 at 10:23am, Michal Hocko wrote:
> On Tue 26-03-19 17:02:24, Baoquan He wrote:
> > The code comment above sparse_add_one_section() is obsolete and
> > incorrect, clean it up and write new one.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> Please note that you need /** to start a kernel doc. Other than that.

I didn't find a template in coding-style.rst, and saw someone is using
/*, others use /**. I will use '/**' instead. Thanks for telling.

> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> > ---
> > v1-v2:
> >   Add comments to explain what the returned value means for
> >   each error code.
> > 
> >  mm/sparse.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 69904aa6165b..b2111f996aa6 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -685,9 +685,18 @@ static void free_map_bootmem(struct page *memmap)
> >  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> >  
> >  /*
> > - * returns the number of sections whose mem_maps were properly
> > - * set.  If this is <=0, then that means that the passed-in
> > - * map was not consumed and must be freed.
> > + * sparse_add_one_section - add a memory section
> > + * @nid: The node to add section on
> > + * @start_pfn: start pfn of the memory range
> > + * @altmap: device page map
> > + *
> > + * This is only intended for hotplug.
> > + *
> > + * Returns:
> > + *   0 on success.
> > + *   Other error code on failure:
> > + *     - -EEXIST - section has been present.
> > + *     - -ENOMEM - out of memory.
> >   */
> >  int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
> >  				     struct vmem_altmap *altmap)
> > -- 
> > 2.17.2
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
