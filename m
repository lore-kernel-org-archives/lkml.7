Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC57AC31E54
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEB7218D1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560753203;
	bh=oWt1zYIeA5Kx5VKst9FEy3MpcTv86iNxDjxAa15fs2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KH1tn1ntn7maSCLowXJW5G9ZWTyHcm2Xi5JlTJwyNo4iE+jSSbx37BM41+AIazM/o
	 6rvOsoHcWnDlqAcVGaeH737+orxiFmU8ETHA8vHx2YVzZbA/bsIEtbQpxjT0iw4T/Y
	 XD5k/pjmCwwCNreTrg9J3bWowrWJnA2bjfA/NkK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfFQGdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 02:33:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:47278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfFQGdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 02:33:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF6EDAFC9;
        Mon, 17 Jun 2019 06:33:20 +0000 (UTC)
Date:   Mon, 17 Jun 2019 08:33:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     syzbot <syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuzhoujian@didichuxing.com
Subject: Re: general protection fault in oom_unkillable_task
Message-ID: <20190617063319.GB30420@dhcp22.suse.cz>
References: <0000000000004143a5058b526503@google.com>
 <CALvZod72=KuBZkSd0ey5orJFGFpwx462XY=cZvO3NOXC0MogFw@mail.gmail.com>
 <20190615134955.GA28441@dhcp22.suse.cz>
 <CALvZod4hT39PfGt9Ohj+g77om5=G0coHK=+G1=GKcm-PowkXsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4hT39PfGt9Ohj+g77om5=G0coHK=+G1=GKcm-PowkXsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 15-06-19 09:11:37, Shakeel Butt wrote:
> On Sat, Jun 15, 2019 at 6:50 AM Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 5a58778c91d4..43eb479a5dc7 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -161,8 +161,8 @@ static bool oom_unkillable_task(struct task_struct *p,
> >                 return true;
> >
> >         /* When mem_cgroup_out_of_memory() and p is not member of the group */
> > -       if (memcg && !task_in_mem_cgroup(p, memcg))
> > -               return true;
> > +       if (memcg)
> > +               return false;
> 
> This will break the dump_tasks() usage of oom_unkillable_task(). We
> can change dump_tasks() to traverse processes like
> mem_cgroup_scan_tasks() for memcg OOMs.

Right you are. Doing a similar trick to the oom victim selection is
indeed better. We should really strive to not doing a global process
iteration when we can do a targeted scan. Care to send a patch?

Thanks!
-- 
Michal Hocko
SUSE Labs
