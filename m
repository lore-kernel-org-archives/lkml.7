Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA686C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF4B20659
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570728647;
	bh=OADWXb31pxpne9eU4N/eWDE2zYL52xoyympOs/9bU8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X3FUjOyRKPgDPxvHUimzsNhiFiC6hB8QP7N8ODltotPsxq5zGsgqHsm6lfBp5JyHl
	 XH5ng2Kmvt0gteY7NmRHpZL3wwgQwcaGICh+cri/8GB6GND1Q5eyo8GEDLj4kRD0+I
	 zBTVwJUAA6Y/5EKeuwr0GbB5z1PXe9siLtjum5WM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfJJRaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:30:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:54486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfJJRaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:30:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4233AD9C;
        Thu, 10 Oct 2019 17:30:43 +0000 (UTC)
Date:   Thu, 10 Oct 2019 19:30:40 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Petr Mladek <pmladek@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191010173040.GK18412@dhcp22.suse.cz>
References: <20191009162339.GI6681@dhcp22.suse.cz>
 <6AAB77B5-092B-43E3-9F4B-0385DE1890D9@lca.pw>
 <20191010105927.GG18412@dhcp22.suse.cz>
 <1570713112.5937.26.camel@lca.pw>
 <20191010141820.GI18412@dhcp22.suse.cz>
 <1570718858.5937.28.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570718858.5937.28.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10-10-19 10:47:38, Qian Cai wrote:
> On Thu, 2019-10-10 at 16:18 +0200, Michal Hocko wrote:
> > On Thu 10-10-19 09:11:52, Qian Cai wrote:
> > > On Thu, 2019-10-10 at 12:59 +0200, Michal Hocko wrote:
> > > > On Thu 10-10-19 05:01:44, Qian Cai wrote:
> > > > > 
> > > > > 
> > > > > > On Oct 9, 2019, at 12:23 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > > > > > 
> > > > > > If this was only about the memory offline code then I would agree. But
> > > > > > we are talking about any printk from the zone->lock context and that is
> > > > > > a bigger deal. Besides that it is quite natural that the printk code
> > > > > > should be more universal and allow to be also called from the MM
> > > > > > contexts as much as possible. If there is any really strong reason this
> > > > > > is not possible then it should be documented at least.
> > > > > 
> > > > > Where is the best place to document this? I am thinking about under
> > > > > the “struct zone” definition’s lock field in mmzone.h.
> > > > 
> > > > I am not sure TBH and I do not think we have reached the state where
> > > > this would be the only way forward.
> > > 
> > > How about I revised the changelog to focus on memory offline rather than making
> > > a rule that nobody should call printk() with zone->lock held?
> > 
> > If you are to remove the CONFIG_DEBUG_VM printk then I am all for it. I
> > am still not convinced that fiddling with dump_page in the isolation
> > code is justified though.
> 
> No, dump_page() there has to be fixed together for memory offline to be useful.
> What's the other options it has here?

I would really prefer to not repeat myself
http://lkml.kernel.org/r/20191010074049.GD18412@dhcp22.suse.cz

> By not holding zone->lock in dump_page()
> from set_migratetype_isolate(), it even has a good side-effect to increase the
> system throughput as dump_page() could be time-consuming. It may make the code a
> bit cleaner by introducing a has_unmovable_pages_locked() version.

I do not see why we should really optimize this cold path.
-- 
Michal Hocko
SUSE Labs
