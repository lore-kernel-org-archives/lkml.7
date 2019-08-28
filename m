Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96F2C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7794B2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567001577;
	bh=dz18tzwMiEmMepsea5vYt1tQn56YQUeTsLhLRrAEEz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZzP1B9BnxieT3Ux/NGUqDA5ktfyR4O1h9yZVMcujWbgiD4UfEEp52tXRPhT0olzqS
	 HYui6yAGJjZ2b6OW2iJ/vGvCO6SBTPb3TqXglveujeR/HFgrm+zTEKTpR2IRhw1UFv
	 Gru9V6/5xHSqoXZd3ZfIflnxBE1pTJ7M6ms2XF50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfH1OM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:12:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:43640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbfH1OM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:12:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16B1EAE92;
        Wed, 28 Aug 2019 14:12:54 +0000 (UTC)
Date:   Wed, 28 Aug 2019 16:12:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH -mm] mm: account deferred split THPs into MemAvailable
Message-ID: <20190828141253.GM28313@dhcp22.suse.cz>
References: <20190826131538.64twqx3yexmhp6nf@box>
 <20190827060139.GM7538@dhcp22.suse.cz>
 <20190827110210.lpe36umisqvvesoa@box>
 <aaaf9742-56f7-44b7-c3db-ad078b7b2220@suse.cz>
 <20190827120923.GB7538@dhcp22.suse.cz>
 <20190827121739.bzbxjloq7bhmroeq@box>
 <20190827125911.boya23eowxhqmopa@box>
 <d76ec546-7ae8-23a3-4631-5c531c1b1f40@linux.alibaba.com>
 <20190828075708.GF7386@dhcp22.suse.cz>
 <20190828140329.qpcrfzg2hmkccnoq@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828140329.qpcrfzg2hmkccnoq@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-08-19 17:03:29, Kirill A. Shutemov wrote:
> On Wed, Aug 28, 2019 at 09:57:08AM +0200, Michal Hocko wrote:
> > On Tue 27-08-19 10:06:20, Yang Shi wrote:
> > > 
> > > 
> > > On 8/27/19 5:59 AM, Kirill A. Shutemov wrote:
> > > > On Tue, Aug 27, 2019 at 03:17:39PM +0300, Kirill A. Shutemov wrote:
> > > > > On Tue, Aug 27, 2019 at 02:09:23PM +0200, Michal Hocko wrote:
> > > > > > On Tue 27-08-19 14:01:56, Vlastimil Babka wrote:
> > > > > > > On 8/27/19 1:02 PM, Kirill A. Shutemov wrote:
> > > > > > > > On Tue, Aug 27, 2019 at 08:01:39AM +0200, Michal Hocko wrote:
> > > > > > > > > On Mon 26-08-19 16:15:38, Kirill A. Shutemov wrote:
> > > > > > > > > > Unmapped completely pages will be freed with current code. Deferred split
> > > > > > > > > > only applies to partly mapped THPs: at least on 4k of the THP is still
> > > > > > > > > > mapped somewhere.
> > > > > > > > > Hmm, I am probably misreading the code but at least current Linus' tree
> > > > > > > > > reads page_remove_rmap -> [page_remove_anon_compound_rmap ->\ deferred_split_huge_page even
> > > > > > > > > for fully mapped THP.
> > > > > > > > Well, you read correctly, but it was not intended. I screwed it up at some
> > > > > > > > point.
> > > > > > > > 
> > > > > > > > See the patch below. It should make it work as intened.
> > > > > > > > 
> > > > > > > > It's not bug as such, but inefficientcy. We add page to the queue where
> > > > > > > > it's not needed.
> > > > > > > But that adding to queue doesn't affect whether the page will be freed
> > > > > > > immediately if there are no more partial mappings, right? I don't see
> > > > > > > deferred_split_huge_page() pinning the page.
> > > > > > > So your patch wouldn't make THPs freed immediately in cases where they
> > > > > > > haven't been freed before immediately, it just fixes a minor
> > > > > > > inefficiency with queue manipulation?
> > > > > > Ohh, right. I can see that in free_transhuge_page now. So fully mapped
> > > > > > THPs really do not matter and what I have considered an odd case is
> > > > > > really happening more often.
> > > > > > 
> > > > > > That being said this will not help at all for what Yang Shi is seeing
> > > > > > and we need a more proactive deferred splitting as I've mentioned
> > > > > > earlier.
> > > > > It was not intended to fix the issue. It's fix for current logic. I'm
> > > > > playing with the work approach now.
> > > > Below is what I've come up with. It appears to be functional.
> > > > 
> > > > Any comments?
> > > 
> > > Thanks, Kirill and Michal. Doing split more proactive is definitely a choice
> > > to eliminate huge accumulated deferred split THPs, I did think about this
> > > approach before I came up with memcg aware approach. But, I thought this
> > > approach has some problems:
> > > 
> > > First of all, we can't prove if this is a universal win for the most
> > > workloads or not. For some workloads (as I mentioned about our usecase), we
> > > do see a lot THPs accumulated for a while, but they are very short-lived for
> > > other workloads, i.e. kernel build.
> > > 
> > > Secondly, it may be not fair for some workloads which don't generate too
> > > many deferred split THPs or those THPs are short-lived. Actually, the cpu
> > > time is abused by the excessive deferred split THPs generators, isn't it?
> > 
> > Yes this is indeed true. Do we have any idea on how much time that
> > actually is?
> 
> For uncontented case, splitting 1G worth of pages (2MiB x 512) takes a bit
> more than 50 ms in my setup. But it's best-case scenario: pages not shared
> across multiple processes, no contention on ptl, page lock, etc.

Any idea about a bad case?

> > > With memcg awareness, the deferred split THPs actually are isolated and
> > > capped by memcg. The long-lived deferred split THPs can't be accumulated too
> > > many due to the limit of memcg. And, cpu time spent in splitting them would
> > > just account to the memcgs who generate that many deferred split THPs, who
> > > generate them who pay for it. This sounds more fair and we could achieve
> > > much better isolation.
> > 
> > On the other hand, deferring the split and free up a non trivial amount
> > of memory is a problem I consider quite serious because it affects not
> > only the memcg workload which has to do the reclaim but also other
> > consumers of memory beucase large memory blocks could be used for higher
> > order allocations.
> 
> Maybe instead of drive the split from number of pages on queue we can take
> a hint from compaction that is struggles to get high order pages?

This is still unbounded in time.

> We can also try to use schedule_delayed_work() instead of plain
> schedule_work() to give short-lived page chance to get freed before
> splitting attempt.

No problem with that as long as this is well bound in time.
-- 
Michal Hocko
SUSE Labs
