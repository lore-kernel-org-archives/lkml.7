Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCD3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B722206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfJHNm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:42:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43446 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfJHNm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:42:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B3BDB1AB;
        Tue,  8 Oct 2019 13:42:56 +0000 (UTC)
Date:   Tue, 8 Oct 2019 15:42:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        david@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008134256.5ti6rjkvadn5b5q4@pathway.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <1570460350.5576.290.camel@lca.pw>
 <20191007151237.GP2381@dhcp22.suse.cz>
 <1570462407.5576.292.camel@lca.pw>
 <20191008081510.ptwmb7zflqiup5py@pathway.suse.cz>
 <20191008091349.6195830d@gandalf.local.home>
 <1570541032.5576.297.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570541032.5576.297.camel@lca.pw>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-10-08 09:23:52, Qian Cai wrote:
> On Tue, 2019-10-08 at 09:13 -0400, Steven Rostedt wrote:
> > On Tue, 8 Oct 2019 10:15:10 +0200
> > Petr Mladek <pmladek@suse.com> wrote:
> > 
> > > There are basically three possibilities:
> > > 
> > > 1. Do crazy exercises with locks all around the kernel to
> > >    avoid the deadlocks. It is usually not worth it. And
> > >    it is a "whack a mole" approach.
> > > 
> > > 2. Use printk_deferred() in problematic code paths. It is
> > >    a "whack a mole" approach as well. And we would end up
> > >    with printk_deferred() used almost everywhere.
> > > 
> > > 3. Always deffer the console handling in printk(). This would
> > >    help also to avoid soft lockups. Several people pushed
> > >    against this last few years because it might reduce
> > >    the chance to see the message in case of system crash.
> > > 
> > > As I said, there has finally been agreement to always do
> > > the offload few weeks ago. John Ogness is working on it.
> > > So we might have the systematic solution for these deadlocks
> > > rather sooner than later.
> > 
> > Another solution is to add the printk_deferred() in these places that
> > cause lockdep splats, and when John's work is done, it would be easy to
> > grep for them and remove them as they would no longer be needed.
> > 
> > This way we don't play whack-a-mole forever (only until we have a
> > proper solution) and everyone is happy that we no longer have these
> > false positive or I-don't-care lockdep splats which hide real lockdep
> > splats because lockdep shuts off as soon as it discovers its first
> > splat.
> 
> I feel like that is what I trying to do, but there seems a lot of resistances
> with that approach where pragmatism met with perfectionism.

No, the resistance was against complicated code changes (games with
locks) and against removing useful messages. Such changes might cause
more harm than good.

I am not -mm maintainer so I could not guarantee that a patch
using printk_deferred() will get accepted. But it will have much
bigger chance than the original patch.

Anyway, printk_deferred() is a lost war. It is temporary solution
for one particular scenario. But as you said, there might be many
others. The long term solution is the printk rework.

Best Regards,
Petr
