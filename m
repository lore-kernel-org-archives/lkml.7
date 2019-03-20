Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5998DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190E82075C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfCTMUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:20:17 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:16898 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726366AbfCTMUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:20:16 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 6683C4622; Wed, 20 Mar 2019 13:20:15 +0100 (CET)
Date:   Wed, 20 Mar 2019 13:20:15 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        mhocko@suse.com, rppt@linux.vnet.ibm.com,
        richard.weiyang@gmail.com, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/sparse: Clean up the obsolete code comment
Message-ID: <20190320122011.stuoqugpjdt3d7cd@d104.suse.de>
References: <20190320073540.12866-1-bhe@redhat.com>
 <20190320111959.GV19508@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320111959.GV19508@bombadil.infradead.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 04:19:59AM -0700, Matthew Wilcox wrote:
> On Wed, Mar 20, 2019 at 03:35:38PM +0800, Baoquan He wrote:
> >  /*
> > - * returns the number of sections whose mem_maps were properly
> > - * set.  If this is <=0, then that means that the passed-in
> > - * map was not consumed and must be freed.
> > + * sparse_add_one_section - add a memory section
> > + * @nid:	The node to add section on
> > + * @start_pfn:	start pfn of the memory range
> > + * @altmap:	device page map
> > + *
> > + * Return 0 on success and an appropriate error code otherwise.
> >   */
> 
> I think it's worth documenting what those error codes are.  Seems to be
> just -ENOMEM and -EEXIST, but it'd be nice for users to know what they
> can expect under which circumstances.
> 
> Also, -EEXIST is a bad errno to return here:
> 
> $ errno EEXIST
> EEXIST 17 File exists
> 
> What file?  I think we should be using -EBUSY instead in case this errno
> makes it back to userspace:
> 
> $ errno EBUSY
> EBUSY 16 Device or resource busy

We return -EEXIST in case the section we are trying to add is already
there, and that error is being caught by __add_pages(), which ignores the
error in case is -EXIST and keeps going with further sections.

Sure we can change that for -EBUSY, but I think -EEXIST makes more sense,
plus that kind of error is never handed back to userspace.

-- 
Oscar Salvador
SUSE L3
