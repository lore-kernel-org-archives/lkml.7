Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBD2C47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DB321D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572003997;
	bh=lGjz8gy0Y5na7wHec/PcVIUh15wOsnIocUZ3BwpOGhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mL/pgGtwLDAuvLycZO24QlrM+x4bE0FE5La/ftwc++Kzaeb5bSACclh8azxQGwM5I
	 Sj8fiIaBKkvkb3kF+6acAnuP91KUQh6sH4jLBo6aJHcKXATeaXXbru/f3HvPVD+jId
	 hHcGscuZOLKoEKEpQ2ZfXQJ6E8+UbFfW9WQSy/dU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502125AbfJYLqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:46:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:42326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730372AbfJYLqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:46:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 570B6B454;
        Fri, 25 Oct 2019 11:46:34 +0000 (UTC)
Date:   Fri, 25 Oct 2019 13:46:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     snazy@snazy.de
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191025114633.GE17610@dhcp22.suse.cz>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
 <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
 <20191025092143.GE658@dhcp22.suse.cz>
 <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-10-19 13:02:23, Robert Stupp wrote:
> On Fri, 2019-10-25 at 11:21 +0200, Michal Hocko wrote:
> > On Thu 24-10-19 16:34:46, Randy Dunlap wrote:
> > > [adding linux-mm + people]
> > >
> > > On 10/24/19 12:36 AM, Robert Stupp wrote:
> > > > Hi guys,
> > > >
> > > > I've got an issue with `mlockall(MCL_CURRENT)` after upgrading
> > > > Ubuntu 19.04 to 19.10 - i.e. kernel version change from 5.0.x to
> > > > 5.3.x.
> > > >
> > > > The following simple program hangs forever with one CPU running
> > > > at 100% (kernel):
> >
> > Can you capture everal snapshots of proc/$(pidof $YOURTASK)/stack
> > while
> > this is happening?
> 
> Sure,
> 
> Approach:
> - one shell running
>   while true; do cat /proc/$(pidof test)/stack; done
> - starting ./test in another shell + ctrl-c quite some times
> 
> Vast majority of all ./test invocations return an empty 'stack' file.
> Some tries, maybe 1 out of 20, returned these snapshots.
> Was running 5.3.7 for this test.
> 
> 
> [<0>] __handle_mm_fault+0x4c5/0x7a0
> [<0>] handle_mm_fault+0xca/0x1f0
> [<0>] __get_user_pages+0x230/0x770
> [<0>] populate_vma_page_range+0x74/0x80
> [<0>] __mm_populate+0xb1/0x150
> [<0>] __x64_sys_mlockall+0x11c/0x190
> [<0>] do_syscall_64+0x5a/0x130
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [<0>] __handle_mm_fault+0x4c5/0x7a0
> [<0>] handle_mm_fault+0xca/0x1f0
> [<0>] __get_user_pages+0x230/0x770
> [<0>] populate_vma_page_range+0x74/0x80
> [<0>] __mm_populate+0xb1/0x150
> [<0>] __x64_sys_mlockall+0x11c/0x190
> [<0>] do_syscall_64+0x5a/0x130
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> [<0>] __handle_mm_fault+0x4c5/0x7a0
> [<0>] handle_mm_fault+0xca/0x1f0
> [<0>] __get_user_pages+0x230/0x770
> [<0>] populate_vma_page_range+0x74/0x80
> [<0>] __mm_populate+0xb1/0x150
> [<0>] __x64_sys_mlockall+0x11c/0x190
> [<0>] do_syscall_64+0x5a/0x130
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> [<0>] __do_fault+0x3c/0x130
> [<0>] do_fault+0x248/0x640
> [<0>] __handle_mm_fault+0x4c5/0x7a0
> [<0>] handle_mm_fault+0xca/0x1f0
> [<0>] __get_user_pages+0x230/0x770
> [<0>] populate_vma_page_range+0x74/0x80
> [<0>] __mm_populate+0xb1/0x150
> [<0>] __x64_sys_mlockall+0x11c/0x190
> [<0>] do_syscall_64+0x5a/0x130
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 

This is expected.

> // doubt this one is relevant
> [<0>] __wake_up_common_lock+0x7c/0xc0
> [<0>] __wake_up_sync_key+0x1e/0x30
> [<0>] __wake_up_parent+0x26/0x30
> [<0>] do_notify_parent+0x1cc/0x280
> [<0>] do_exit+0x703/0xaf0
> [<0>] do_group_exit+0x47/0xb0
> [<0>] get_signal+0x165/0x880
> [<0>] do_signal+0x34/0x280
> [<0>] exit_to_usermode_loop+0xbf/0x160
> [<0>] do_syscall_64+0x10f/0x130
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Hmm, this means that the task has exited so how come there are 
other syscalls happening. Are you sure you are collecting stacks for the
correct task?
-- 
Michal Hocko
SUSE Labs
