Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFB5C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C552192D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553113940;
	bh=i26OIVqyD4AXBCk81Cyq/sIjwaBYeGD56JMD5bqnv6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ji1MNTCqlkLgOdm0yznydB+8awppmzaLyN+Qb8mV2mZfLRrK9+3bWeaylMJeb+gdt
	 zAGl5PmAfEpU1WW/5XKhOBP7gesY2png0y0bEq9y5uO2H3ZP99KM9BQYKmQtcgnvU9
	 KVngMv58VQOIXHFwnv8SFiFMfZBCqADXcKKBsltE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCTUcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:32:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:34610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbfCTUcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:32:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 091A0AEDF;
        Wed, 20 Mar 2019 20:32:18 +0000 (UTC)
Date:   Wed, 20 Mar 2019 21:32:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     syzbot <syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com>,
        chanho.min@lge.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        rafael.j.wysocki@intel.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, Ingo Molnar <mingo@elte.hu>
Subject: Re: WARNING: syz-executor still has locks held!
Message-ID: <20190320203216.GF8696@dhcp22.suse.cz>
References: <0000000000000e4a41057b6c9792@google.com>
 <0000000000004cdec6058485b2ce@google.com>
 <20190320131655.GA8696@dhcp22.suse.cz>
 <20190320132410.GB21673@redhat.com>
 <20190320132936.GB8696@dhcp22.suse.cz>
 <20190320150053.GD21673@redhat.com>
 <20190320151242.GC8696@dhcp22.suse.cz>
 <20190320173041.GE21673@redhat.com>
 <20190320194512.GD8696@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320194512.GD8696@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-03-19 20:45:12, Michal Hocko wrote:
> On Wed 20-03-19 18:30:42, Oleg Nesterov wrote:
> > On 03/20, Michal Hocko wrote:
> > >
> > > [Cc Ingo and Chanho Min - the thread starts here
> > > http://lkml.kernel.org/r/0000000000004cdec6058485b2ce@google.com]
> > >
> > > On Wed 20-03-19 16:00:54, Oleg Nesterov wrote:
> > > > On 03/20, Michal Hocko wrote:
> > > > >
> > > > > On Wed 20-03-19 14:24:11, Oleg Nesterov wrote:
> > > > > > On 03/20, Michal Hocko wrote:
> > > > > > >
> > > > > > > Yes we do hold the cgred mutex while calling freezable_schedule but why
> > > > > > > are we getting a warning is not really clear to me. The task should be
> > > > > > > hidden from the freezer so why do we warn at all?
> > > > > >
> > > > > > try_to_freeze() calls debug_check_no_locks_held() and this makes sense.
> > > > >
> > > > > Yes it does. But it already ignores PF_NOFREEZE tasks and I fail to see
> > > > > why is PF_FREEZER_SKIP any different.
> > > >
> > > > But they differ. PF_NOFREEZE is a "sticky" flag for kthreads. Set by default,
> > > > cleared by set_freezable() if you want a freezable kthread.
> > > >
> > > > PF_FREEZER_SKIP means that a sleeping freezable task will call try_to_freeze()
> > > > right after schedule() returns, so try_to_freeze_tasks() can safely count it as
> > > > "already frozen".
> > >
> > > But the fundamental semantic is the same right? Both might be sitting on
> > > locks that might interfere with other tasks and we should be _extra_
> > > careful when using them. In an ideal world, none of them is really
> > > needed.
> > 
> > Ah, it seems that we misunderstood each other... see below.
> > 
> > > So my question remains. Can we drop the warning for PF_FREEZER_SKIP
> > > tasks as well?
> > 
> > But why?
> 
> To drop the warning which led to the revert.

Ble, I should have checked the code more closely. freezer_count does
clear the flag before it goes to the fridge. My bad. So we need
freezable_schedule_unsafe unsafe here to workaround the original problem
and do not trigger the warning.
-- 
Michal Hocko
SUSE Labs
