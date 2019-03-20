Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42933C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B07421850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfCTLxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:53:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17955 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfCTLxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:53:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D47D03084259;
        Wed, 20 Mar 2019 11:53:36 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BE516014E;
        Wed, 20 Mar 2019 11:53:35 +0000 (UTC)
Date:   Wed, 20 Mar 2019 19:53:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pasha.tatashin@oracle.com, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, richard.weiyang@gmail.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/sparse: Clean up the obsolete code comment
Message-ID: <20190320115333.GR18740@MiWiFi-R3L-srv>
References: <20190320073540.12866-1-bhe@redhat.com>
 <20190320111959.GV19508@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320111959.GV19508@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 20 Mar 2019 11:53:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/19 at 04:19am, Matthew Wilcox wrote:
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

OK, will update per your comments. Thanks.
> 
