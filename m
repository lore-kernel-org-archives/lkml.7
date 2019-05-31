Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528FDC28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29257269F3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559311257;
	bh=CJrzlzhg50T+Ztm9mZ3NVQXrrTb54XS8+0pIiXUrQC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pkA/2blLLimGqKE5JBaLWMuITFzEPoGTDJY7f41zNaiRHx13ug+c96DwigrduI7xc
	 VIO6GT2Khjsfp1JpBjxuakx9h9PoGj6uQaE4ZqMrw9b7V36J0kqqTWfoCxkev0WfHP
	 Y3qF8OUQ1nXEYx7XfrkrnuuSxnh+xBdSv6O57P5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEaOA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:00:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:55234 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbfEaOAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:00:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C44A5AFD1;
        Fri, 31 May 2019 14:00:52 +0000 (UTC)
Date:   Fri, 31 May 2019 16:00:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com
Subject: Re: [RFCv2 5/6] mm: introduce external memory hinting API
Message-ID: <20190531140050.GS6896@dhcp22.suse.cz>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-6-minchan@kernel.org>
 <20190531083757.GH6896@dhcp22.suse.cz>
 <20190531131859.GB195463@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531131859.GB195463@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31-05-19 22:19:00, Minchan Kim wrote:
> On Fri, May 31, 2019 at 10:37:57AM +0200, Michal Hocko wrote:
> > On Fri 31-05-19 15:43:12, Minchan Kim wrote:
> > > There is some usecase that centralized userspace daemon want to give
> > > a memory hint like MADV_[COLD|PAGEEOUT] to other process. Android's
> > > ActivityManagerService is one of them.
> > > 
> > > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > > required to make the reclaim decision is not known to the app. Instead,
> > > it is known to the centralized userspace daemon(ActivityManagerService),
> > > and that daemon must be able to initiate reclaim on its own without
> > > any app involvement.
> > > 
> > > To solve the issue, this patch introduces new syscall process_madvise(2).
> > > It could give a hint to the exeternal process of pidfd.
> > > 
> > >  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> > > 			unsigned long cookie, unsigned long flag);
> > > 
> > > Since it could affect other process's address range, only privileged
> > > process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> > > gives it the right to ptrace the process could use it successfully.
> > > 
> > > The syscall has a cookie argument to privode atomicity(i.e., detect
> > > target process's address space change since monitor process has parsed
> > > the address range of target process so the operaion could fail in case
> > > of happening race). Although there is no interface to get a cookie
> > > at this moment, it could be useful to consider it as argument to avoid
> > > introducing another new syscall in future. It could support *atomicity*
> > > for disruptive hint(e.g., MADV_DONTNEED|FREE).
> > > flag argument is reserved for future use if we need to extend the API.
> > 
> > Providing an API that is incomplete will not fly. Really. As this really
> > begs for much more discussion and it would be good to move on with the
> > core idea of the pro active memory memory management from userspace
> > usecase. Could you split out the core change so that we can move on and
> > leave the external for a later discussion. I believe this would lead to
> > a smoother integration.
> 
> No problem but I need to understand what you want a little bit more because
> I thought this patchset is already step by step so if we reach the agreement
> of part of them like [1-5/6], it could be merged first.
> 
> Could you say how you want to split the patchset for forward progress?

I would start with new madvise modes and once they are in a shape to be
merged then we can start the remote madvise API. I believe that even
local process reclaim modes are interesting and useful. I haven't heard
anybody objecting to them without having a remote API so far.
-- 
Michal Hocko
SUSE Labs
