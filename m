Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5F7C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49B8214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566458498;
	bh=YrrYzS7VJUb1dvv13ntfn8EPHV31xDrEpIVFZXMZ6oU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lip8heN7gbYSkgWgjgv1199VRAoP+ek15pJqsGc2gLdTIf4FntAyI07rXGYuU7sas
	 pT4AoTXhFpbSa+Dubso4oalESVBJ+i22tJxL5jQcM45KxakdRg2RvP0MWCpY2wJZAI
	 tYyJkLB+eiZl2lvH01hDEqVGknb4gX8yLZxSCg4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbfHVHVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:21:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:35268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727310AbfHVHVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:21:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56018AE1C;
        Thu, 22 Aug 2019 07:21:35 +0000 (UTC)
Date:   Thu, 22 Aug 2019 09:21:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Edward Chron <echron@arista.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Subject: Re: [PATCH] mm/oom: Add oom_score_adj value to oom Killed process
 message
Message-ID: <20190822072134.GD12785@dhcp22.suse.cz>
References: <20190821001445.32114-1-echron@arista.com>
 <alpine.DEB.2.21.1908202024300.141379@chino.kir.corp.google.com>
 <20190821064732.GW3111@dhcp22.suse.cz>
 <alpine.DEB.2.21.1908210017320.177871@chino.kir.corp.google.com>
 <20190821074721.GY3111@dhcp22.suse.cz>
 <CAM3twVR5Z1LG4+pqMF94mCw8R0sJ3VJtnggQnu+047c7jxJVug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM3twVR5Z1LG4+pqMF94mCw8R0sJ3VJtnggQnu+047c7jxJVug@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-08-19 16:12:08, Edward Chron wrote:
[...]
> Additionally (which you know, but mentioning for reference) the OOM
> output used to look like this:
> 
> Nov 14 15:23:48 oldserver kernel: [337631.991218] Out of memory: Kill
> process 19961 (python) score 17 or sacrifice child
> Nov 14 15:23:48 oldserver kernel: [337631.991237] Killed process 31357
> (sh) total-vm:5400kB, anon-rss:252kB, file-rss:4kB, shmem-rss:0kB
> 
> It now looks like this with 5.3.0-rc5 (minus the oom_score_adj):
> 
> Jul 22 10:42:40 newserver kernel:
> oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/user.slice/user-10383.slice/user@10383.service,task=oomprocs,pid=3035,uid=10383
> Jul 22 10:42:40 newserver kernel: Out of memory: Killed process 3035
> (oomprocs) total-vm:1056800kB, anon-rss:8kB, file-rss:4kB,
> shmem-rss:0kB
> Jul 22 10:42:40 newserver kernel: oom_reaper: reaped process 3035
> (oomprocs), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> 
> The old output did explain that a oom_score of 17 must have either
> tied for highest or was the highest.
> This did document why OOM selected the process it did, even if ends up
> killing the related sh process.
> 
> With the newer format that added constraint message, it does provide
> uid which can be helpful and
> the oom_reaper showing that the memory was reclaimed is certainly reassuring.
> 
> My understanding now is that printing the oom_score is discouraged.
> This seems unfortunate.  The oom_score_adj can be adjusted
> appropriately if oom_score is known.
> So It would be useful to have both.

As already mentioned in our previous discussion I am really not happy
about exporting oom_score withtout a larger context - aka other tasks
scores to have something to compare against. Other than that the value
is an internal implementation detail and it is meaningless without
knowing the exact algorithm which can change at any times so no
userspace should really depend on it. All important metrics should be
displayed by the oom report message already.

-- 
Michal Hocko
SUSE Labs
