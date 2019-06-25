Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA55C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1B4214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfFYIJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:09:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:37426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726951AbfFYIJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:09:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA1A8AD43;
        Tue, 25 Jun 2019 08:09:16 +0000 (UTC)
Date:   Tue, 25 Jun 2019 10:09:14 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, pasha.tatashin@soleen.com,
        Jonathan.Cameron@huawei.com, anshuman.khandual@arm.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] drivers/base/memory: Remove unneeded check in
 remove_memory_block_devices
Message-ID: <20190625080909.GA15394@linux>
References: <20190625075227.15193-1-osalvador@suse.de>
 <20190625075227.15193-2-osalvador@suse.de>
 <3e820fee-f82f-3336-ff34-31c66dbbbbfe@redhat.com>
 <0ed2f4ec-cc6f-8b81-46b0-d56d90ac1e86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ed2f4ec-cc6f-8b81-46b0-d56d90ac1e86@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:03:31AM +0200, David Hildenbrand wrote:
> On 25.06.19 10:01, David Hildenbrand wrote:
> > On 25.06.19 09:52, Oscar Salvador wrote:
> >> remove_memory_block_devices() checks for the range to be aligned
> >> to memory_block_size_bytes, which is our current memory block size,
> >> and WARNs_ON and bails out if it is not.
> >>
> >> This is the right to do, but we do already do that in try_remove_memory(),
> >> where remove_memory_block_devices() gets called from, and we even are
> >> more strict in try_remove_memory, since we directly BUG_ON in case the range
> >> is not properly aligned.
> >>
> >> Since remove_memory_block_devices() is only called from try_remove_memory(),
> >> we can safely drop the check here.
> >>
> >> To be honest, I am not sure if we should kill the system in case we cannot
> >> remove memory.
> >> I tend to think that WARN_ON and return and error is better.
> > 
> > I failed to parse this sentence.
> > 
> >>
> >> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> >> ---
> >>  drivers/base/memory.c | 4 ----
> >>  1 file changed, 4 deletions(-)
> >>
> >> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> >> index 826dd76f662e..07ba731beb42 100644
> >> --- a/drivers/base/memory.c
> >> +++ b/drivers/base/memory.c
> >> @@ -771,10 +771,6 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
> >>  	struct memory_block *mem;
> >>  	int block_id;
> >>  
> >> -	if (WARN_ON_ONCE(!IS_ALIGNED(start, memory_block_size_bytes()) ||
> >> -			 !IS_ALIGNED(size, memory_block_size_bytes())))
> >> -		return;
> >> -
> >>  	mutex_lock(&mem_sysfs_mutex);
> >>  	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
> >>  		mem = find_memory_block_by_id(block_id, NULL);
> >>
> > 
> > As I said when I introduced this, I prefer to have such duplicate checks
> > in place in case we have dependent code splattered over different files.
> > (especially mm/ vs. drivers/base). Such simple checks avoid to document
> > "start and size have to be aligned to memory blocks".
> 
> Lol, I even documented it as well. So yeah, if you're going to drop this
> once, also drop the one in create_memory_block_devices().

TBH, I would not mind sticking with it.
What sticked out the most was that in the previous check, we BUG_on while
here we just print out a warning, so it seemed quite "inconsistent" to me.

And I only stumbled upon this when I was testing a kernel module that
hot-removed memory in a different granularity.

Anyway, I do not really feel strong here, I can perfectly drop this patch as I
would rather have the focus in the following-up patches, which are the important
ones IMO.

> 
> > 
> > If you still insist, then also remove the same sequence from
> > create_memory_block_devices().
> > 
> 
> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
> 

-- 
Oscar Salvador
SUSE L3
