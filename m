Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B24CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695C9214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552371947;
	bh=Yo77a/j/DxyOgAnZMiznLHziwuvOKmQPZUxgFBdJk/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Jq/0wp3yg45Y1OJmDUiA0aKWcHLVl/rt5O20UGCTeFHrufi210kDjJq4KWN0cf210
	 TmUIkARdadG1lu04PRMRw3DzaY8N7kHCV3iPr2fIwsW6LR1OeTa0uI7iKuu5c3ZuSb
	 V9p5GpcBaIo3KwaUo1HV0lTddMwboEZl0FCAFcTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfCLGZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:25:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfCLGZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:25:45 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 60EA2B1F;
        Tue, 12 Mar 2019 06:25:44 +0000 (UTC)
Date:   Mon, 11 Mar 2019 23:25:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Shakeel Butt <shakeelb@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: KASAN: null-ptr-deref Read in reclaim_high
Message-Id: <20190311232541.db8571d2e3e0ca636785f31f@linux-foundation.org>
In-Reply-To: <CACT4Y+byKQSOCte3JS9XOnyr+aVSEFtBvLxG2-HUrZX3-82Hcg@mail.gmail.com>
References: <0000000000001fd5780583d1433f@google.com>
        <20190311163747.f56cceebd9c2661e4519bdfc@linux-foundation.org>
        <CACT4Y+byKQSOCte3JS9XOnyr+aVSEFtBvLxG2-HUrZX3-82Hcg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 07:08:38 +0100 Dmitry Vyukov <dvyukov@google.com> wrote:

> On Tue, Mar 12, 2019 at 12:37 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Mon, 11 Mar 2019 06:08:01 -0700 syzbot <syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com> wrote:
> >
> > > syzbot has bisected this bug to:
> > >
> > > commit 29a4b8e275d1f10c51c7891362877ef6cffae9e7
> > > Author: Shakeel Butt <shakeelb@google.com>
> > > Date:   Wed Jan 9 22:02:21 2019 +0000
> > >
> > >      memcg: schedule high reclaim for remote memcgs on high_work
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155bf5db200000
> > > start commit:   29a4b8e2 memcg: schedule high reclaim for remote memcgs on..
> > > git tree:       linux-next
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=175bf5db200000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=135bf5db200000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=611f89e5b6868db
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=fa11f9da42b46cea3b4a
> > > userspace arch: amd64
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14259017400000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141630a0c00000
> > >
> > > Reported-by: syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com
> > > Fixes: 29a4b8e2 ("memcg: schedule high reclaim for remote memcgs on
> > > high_work")
> >
> > The following patch
> > memcg-schedule-high-reclaim-for-remote-memcgs-on-high_work-v3.patch
> > might have fixed this.  Was it applied?
> 
> Hi Andrew,
> 
> You mean if the patch was applied during the bisection?
> No, it wasn't. Bisection is very specifically done on the same tree
> where the bug was hit. There are already too many factors that make
> the result flaky/wrong/inconclusive without changing the tree state.
> Now, if syzbot would know about any pending fix for this bug, then it
> would not do the bisection at all. But it have not seen any patch in
> upstream/linux-next with the Reported-by tag, nor it received any syz
> fix commands for this bugs. Should have been it aware of the fix? How?

memcg-schedule-high-reclaim-for-remote-memcgs-on-high_work-v3.patch was
added to linux-next on Jan 10.  I take it that this bug was hit when
testing the entire linux-next tree, so we can assume that
memcg-schedule-high-reclaim-for-remote-memcgs-on-high_work-v3.patch
does not fix it, correct?

In which case, over to Shakeel!
