Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93962C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C8F21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfCTRas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:30:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbfCTRaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:30:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA6BE4627A;
        Wed, 20 Mar 2019 17:30:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7D4F419C59;
        Wed, 20 Mar 2019 17:30:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 20 Mar 2019 18:30:44 +0100 (CET)
Date:   Wed, 20 Mar 2019 18:30:42 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com>,
        chanho.min@lge.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        rafael.j.wysocki@intel.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, Ingo Molnar <mingo@elte.hu>
Subject: Re: WARNING: syz-executor still has locks held!
Message-ID: <20190320173041.GE21673@redhat.com>
References: <0000000000000e4a41057b6c9792@google.com>
 <0000000000004cdec6058485b2ce@google.com>
 <20190320131655.GA8696@dhcp22.suse.cz>
 <20190320132410.GB21673@redhat.com>
 <20190320132936.GB8696@dhcp22.suse.cz>
 <20190320150053.GD21673@redhat.com>
 <20190320151242.GC8696@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320151242.GC8696@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 20 Mar 2019 17:30:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20, Michal Hocko wrote:
>
> [Cc Ingo and Chanho Min - the thread starts here
> http://lkml.kernel.org/r/0000000000004cdec6058485b2ce@google.com]
>
> On Wed 20-03-19 16:00:54, Oleg Nesterov wrote:
> > On 03/20, Michal Hocko wrote:
> > >
> > > On Wed 20-03-19 14:24:11, Oleg Nesterov wrote:
> > > > On 03/20, Michal Hocko wrote:
> > > > >
> > > > > Yes we do hold the cgred mutex while calling freezable_schedule but why
> > > > > are we getting a warning is not really clear to me. The task should be
> > > > > hidden from the freezer so why do we warn at all?
> > > >
> > > > try_to_freeze() calls debug_check_no_locks_held() and this makes sense.
> > >
> > > Yes it does. But it already ignores PF_NOFREEZE tasks and I fail to see
> > > why is PF_FREEZER_SKIP any different.
> >
> > But they differ. PF_NOFREEZE is a "sticky" flag for kthreads. Set by default,
> > cleared by set_freezable() if you want a freezable kthread.
> >
> > PF_FREEZER_SKIP means that a sleeping freezable task will call try_to_freeze()
> > right after schedule() returns, so try_to_freeze_tasks() can safely count it as
> > "already frozen".
>
> But the fundamental semantic is the same right? Both might be sitting on
> locks that might interfere with other tasks and we should be _extra_
> careful when using them. In an ideal world, none of them is really
> needed.

Ah, it seems that we misunderstood each other... see below.

> So my question remains. Can we drop the warning for PF_FREEZER_SKIP
> tasks as well?

But why? It is obviously wrong to call try_to_freeze() with a lock held.

Probably you meant the

	if (!(current->flags & PF_NOFREEZE))

check in try_to_freeze() when you said "already ignores PF_NOFREEZE tasks".

I am not sure we actually need this check, a PF_NOFREEZE kthread shouldn't
call try_to_freeze() at least directly.

However, note that freezing() will return false if PF_NOFREEZE is set, so
try_to_freeze() is nop in this case. Probably this is why PF_NOFREEZE is
also checked before debug_check_no_locks_held().

> > > as removing the cgred is way way too complicated.
> >
> > We need to do this anyway, this leads to other more serious problems...
>
> Yes but this is far away and it doesn't really seem like a stable tree
> material

strace -f can hang ;) so this is the stable material.

Oleg.

