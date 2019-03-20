Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AB2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66C620857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553111118;
	bh=KTyzkR7QySN9g7uDELSMMAXCCuMKo2ojYXAVHggk9sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=en14ULkiKsEI9OuYW3lG7ERsXf+0QEcvVKGY3KxVj6nSe+HJBis70AFKA+DXMruxS
	 UUT91KtbDmMpD2PMny2+WsMJp4aUnx1yb6y1QSTufR4H+MsivHsehIEBb3z+ZThXrE
	 tOJXAkw1f+dYsReaJpBvs6JxIsA0/tOwEWpXxeuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfCTTpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:45:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:57272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbfCTTpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:45:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77ACAAEA0;
        Wed, 20 Mar 2019 19:45:15 +0000 (UTC)
Date:   Wed, 20 Mar 2019 20:45:12 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     syzbot <syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com>,
        chanho.min@lge.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        rafael.j.wysocki@intel.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, Ingo Molnar <mingo@elte.hu>
Subject: Re: WARNING: syz-executor still has locks held!
Message-ID: <20190320194512.GD8696@dhcp22.suse.cz>
References: <0000000000000e4a41057b6c9792@google.com>
 <0000000000004cdec6058485b2ce@google.com>
 <20190320131655.GA8696@dhcp22.suse.cz>
 <20190320132410.GB21673@redhat.com>
 <20190320132936.GB8696@dhcp22.suse.cz>
 <20190320150053.GD21673@redhat.com>
 <20190320151242.GC8696@dhcp22.suse.cz>
 <20190320173041.GE21673@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320173041.GE21673@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-03-19 18:30:42, Oleg Nesterov wrote:
> On 03/20, Michal Hocko wrote:
> >
> > [Cc Ingo and Chanho Min - the thread starts here
> > http://lkml.kernel.org/r/0000000000004cdec6058485b2ce@google.com]
> >
> > On Wed 20-03-19 16:00:54, Oleg Nesterov wrote:
> > > On 03/20, Michal Hocko wrote:
> > > >
> > > > On Wed 20-03-19 14:24:11, Oleg Nesterov wrote:
> > > > > On 03/20, Michal Hocko wrote:
> > > > > >
> > > > > > Yes we do hold the cgred mutex while calling freezable_schedule but why
> > > > > > are we getting a warning is not really clear to me. The task should be
> > > > > > hidden from the freezer so why do we warn at all?
> > > > >
> > > > > try_to_freeze() calls debug_check_no_locks_held() and this makes sense.
> > > >
> > > > Yes it does. But it already ignores PF_NOFREEZE tasks and I fail to see
> > > > why is PF_FREEZER_SKIP any different.
> > >
> > > But they differ. PF_NOFREEZE is a "sticky" flag for kthreads. Set by default,
> > > cleared by set_freezable() if you want a freezable kthread.
> > >
> > > PF_FREEZER_SKIP means that a sleeping freezable task will call try_to_freeze()
> > > right after schedule() returns, so try_to_freeze_tasks() can safely count it as
> > > "already frozen".
> >
> > But the fundamental semantic is the same right? Both might be sitting on
> > locks that might interfere with other tasks and we should be _extra_
> > careful when using them. In an ideal world, none of them is really
> > needed.
> 
> Ah, it seems that we misunderstood each other... see below.
> 
> > So my question remains. Can we drop the warning for PF_FREEZER_SKIP
> > tasks as well?
> 
> But why?

To drop the warning which led to the revert.

> It is obviously wrong to call try_to_freeze() with a lock held.

It is but the question what do we care about more. A task blocking
suspend so that the operation fails or a process being frozen with cgred
held. We have discussed that during the review of the original patch and
concluded that this is the only way for now AFAIR.

> Probably you meant the
> 
> 	if (!(current->flags & PF_NOFREEZE))
> 
> check in try_to_freeze() when you said "already ignores PF_NOFREEZE tasks".

Yes, that is the check I've had in mind.
-- 
Michal Hocko
SUSE Labs
