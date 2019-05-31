Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5684FC28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDE6269DD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559310985;
	bh=0KfI7mpirsDEQB4YFaw+9JpeAIyIdzCLmeys0V7RWDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q3o4gICpJQV0lDh4iCQyeoBEn0iDnU6pDkiRdeFfluqggXxbHM70zX85QpgyDFcgT
	 gYlInuinEq0z/fhm15nDbh3WT9urDYBug0LPbSdkQRqy/RlJg00OPL2qxY8kZokl5f
	 60xr0UMe1SppJ6Ykw7jlzGcBPp0R7oyfWA7P0b3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfEaN4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 09:56:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:54376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbfEaN4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 09:56:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98465AF21;
        Fri, 31 May 2019 13:56:22 +0000 (UTC)
Date:   Fri, 31 May 2019 15:56:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [HELP] How to get task_struct from mm
Message-ID: <20190531135621.GR6896@dhcp22.suse.cz>
References: <5cf71366-ba01-8ef0-3dbd-c9fec8a2b26f@linux.alibaba.com>
 <20190530154119.GF6703@dhcp22.suse.cz>
 <352de468-9091-9866-ccbd-10d80c25ebb4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <352de468-9091-9866-ccbd-10d80c25ebb4@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31-05-19 20:51:05, Yang Shi wrote:
> 
> 
> On 5/30/19 11:41 PM, Michal Hocko wrote:
> > On Thu 30-05-19 14:57:46, Yang Shi wrote:
> > > Hi folks,
> > > 
> > > 
> > > As what we discussed about page demotion for PMEM at LSF/MM, the demotion
> > > should respect to the mempolicy and allowed mems of the process which the
> > > page (anonymous page only for now) belongs to.
> > cpusets memory mask (aka mems_allowed) is indeed tricky and somehow
> > awkward.  It is inherently an address space property and I never
> > understood why we have it per _thread_. This just doesn't make any
> > sense to me. This just leads to weird corner cases. What should happen
> > if different threads disagree about the allocation affinity while
> > working on a shared address space?
> 
> I'm supposed (just my guess) such restriction should just apply for the
> first allocation. Just like memcg charge, who does it first, whose policy
> gets applied.

I am not really sure that was the deliberate design choice. Maybe
somebody has a different recollection though.

> > > The vma that the page is mapped to can be retrieved from rmap walk easily,
> > > but we need know the task_struct that the vma belongs to. It looks there is
> > > not such API, and container_of seems not work with pointer member.
> > I do not think this is a good idea. As you point out in the reply we
> > have that for memcgs but we really hope to get rid of mm->owner there
> > as well. It is just more tricky there. Moreover such a reverse mapping
> > would be incorrect. Just think of a disagreeing yet overlapping cpusets
> > for different threads mapping the same page.
> > 
> > Is it such a big deal to document that the node migrate is not
> > compatible with cpusets?
> 
> Not only cpuset, but get_vma_policy() also needs find task_struct from vma.
> Currently, get_vma_policy() just uses "current", so it just returns the
> current process's mempolicy if the vma doesn't have mempolicy. For the node
> migrate case, "current" is definitely not correct.
>
> It looks there is not an easy way to workaround it unless we claim node
> migrate is not compatible with both cpusets and mempolicy.

yep, it seems so.
-- 
Michal Hocko
SUSE Labs
