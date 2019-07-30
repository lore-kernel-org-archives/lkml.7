Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D11C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBB92087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564471483;
	bh=9+toDDS0IeJCx5z2IDpjA3h7rsOMw9bEbFITMy2LdSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2wkCl5HXLLUIIo2CzRIZRntRrkS7FVBZGM//vj4qnE/8FVEnqzAusbp0LA9A0huwg
	 841MNgHbFYswJr8VxdjMSrmDwtuX2xew+IIHUVnG9E5yYOvZSTD3k+QcCB7c0jCJlw
	 CORB0BnqXeely3V/J5Vd0FH2NaIa3QI2pxkvuczU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfG3HYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:24:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:52754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727527AbfG3HYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:24:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B770AE5C;
        Tue, 30 Jul 2019 07:24:40 +0000 (UTC)
Date:   Tue, 30 Jul 2019 09:24:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v3] sched/core: Don't use dying mm as active_mm of
 kthreads
Message-ID: <20190730072439.GL9330@dhcp22.suse.cz>
References: <20190729210728.21634-1-longman@redhat.com>
 <ec9effc07a94b28ecf364de40dee183bcfb146fc.camel@surriel.com>
 <3e2ff4c9-c51f-8512-5051-5841131f4acb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e2ff4c9-c51f-8512-5051-5841131f4acb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-07-19 17:42:20, Waiman Long wrote:
> On 7/29/19 5:21 PM, Rik van Riel wrote:
> > On Mon, 2019-07-29 at 17:07 -0400, Waiman Long wrote:
> >> It was found that a dying mm_struct where the owning task has exited
> >> can stay on as active_mm of kernel threads as long as no other user
> >> tasks run on those CPUs that use it as active_mm. This prolongs the
> >> life time of dying mm holding up some resources that cannot be freed
> >> on a mostly idle system.
> > On what kernels does this happen?
> >
> > Don't we explicitly flush all lazy TLB CPUs at exit
> > time, when we are about to free page tables?
> 
> There are still a couple of calls that will be done until mm_count
> reaches 0:
> 
> - mm_free_pgd(mm);
> - destroy_context(mm);
> - mmu_notifier_mm_destroy(mm);
> - check_mm(mm);
> - put_user_ns(mm->user_ns);
> 
> These are not big items, but holding it off for a long time is still not
> a good thing.

It would be helpful to give a ball park estimation of how much that
actually is. If we are talking about few pages worth of pages per idle
cpu in the worst case then I am not sure we want to find an elaborate
way around that. We are quite likely having more in per-cpu caches in
different subsystems already. It is also quite likely that large
machines with many CPUs will have a lot of memory as well.
-- 
Michal Hocko
SUSE Labs
