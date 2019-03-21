Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4573C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF2A218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfCUUYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:24:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbfCUUYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:24:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84F6E5945D;
        Thu, 21 Mar 2019 20:24:49 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA45E60BE2;
        Thu, 21 Mar 2019 20:24:47 +0000 (UTC)
Date:   Thu, 21 Mar 2019 16:24:46 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "riel@surriel.com" <riel@surriel.com>
Subject: Re: [RFC PATCH RESEND 2/3] mm: Add an apply_to_pfn_range interface
Message-ID: <20190321202445.GA15074@redhat.com>
References: <20190321132140.114878-1-thellstrom@vmware.com>
 <20190321132140.114878-3-thellstrom@vmware.com>
 <20190321135202.GC2904@redhat.com>
 <c9d05087a0fb9002145aa2f7c58552615a694e9e.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9d05087a0fb9002145aa2f7c58552615a694e9e.camel@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 21 Mar 2019 20:24:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 07:59:35PM +0000, Thomas Hellstrom wrote:
> On Thu, 2019-03-21 at 09:52 -0400, Jerome Glisse wrote:
> > On Thu, Mar 21, 2019 at 01:22:35PM +0000, Thomas Hellstrom wrote:
> > > This is basically apply_to_page_range with added functionality:
> > > Allocating missing parts of the page table becomes optional, which
> > > means that the function can be guaranteed not to error if
> > > allocation
> > > is disabled. Also passing of the closure struct and callback
> > > function
> > > becomes different and more in line with how things are done
> > > elsewhere.
> > > 
> > > Finally we keep apply_to_page_range as a wrapper around
> > > apply_to_pfn_range
> > 
> > The apply_to_page_range() is dangerous API it does not follow other
> > mm patterns like mmu notifier. It is suppose to be use in arch code
> > or vmalloc or similar thing but not in regular driver code. I see
> > it has crept out of this and is being use by few device driver. I am
> > not sure we should encourage that.
> 
> I can certainly remove the EXPORT of the new apply_to_pfn_range() which
> will make sure its use stays within the mm code. I don't expect any
> additional usage except for the two address-space utilities.
> 
> I'm looking for examples to see how it could be more in line with the
> rest of the mm code. The main difference from the pattern in, for
> example, page_mkclean() seems to be that it's lacking the
> mmu_notifier_invalidate_start() and mmu_notifier_invalidate_end()?
> Perhaps the intention is to have the pte leaf functions notify on pte
> updates? How does this relate to arch_enter_lazy_mmu() which is called
> outside of the page table locks? The documentation appears a bit
> scarce...

Best is to use something like walk_page_range() and have proper mmu
notifier in the callback. The apply_to_page_range() is broken for
huge page (THP) and other things like that. Thought you should not
have THP within mmap of a device file (at least i do not thing any
driver does that).

Cheers,
Jérôme
