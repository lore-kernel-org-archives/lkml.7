Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C39C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68273206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570541850;
	bh=Yi9JCPbELBiVusSY2wzUw0dhpptkn0LIP1Ap2KhWFME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oWXLjvdB82WRRuQ9JUGkee/tCkXLww7WD9gdLcCsSPHEptMncwwfPqvQX2gqmao9K
	 JXcBF5xOZ6QvmqxkF2s1fDmWIF/o3zsrJv2QdJWyoWAdbxvvzmC9Y4tVrRNKXJsvyM
	 bDw3Tem8KPSKeBe2ud17EbMhcP6rqSnYc2c/Bw10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfJHNh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:37:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:41526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfJHNh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:37:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BC46B021;
        Tue,  8 Oct 2019 13:37:28 +0000 (UTC)
Date:   Tue, 8 Oct 2019 15:37:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008133727.GK6681@dhcp22.suse.cz>
References: <20191008103907.GE6681@dhcp22.suse.cz>
 <3836DE34-9DD2-4815-9E1E-CB87D881B9AD@lca.pw>
 <20191008123920.GI6681@dhcp22.suse.cz>
 <1570539989.5576.295.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570539989.5576.295.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-10-19 09:06:29, Qian Cai wrote:
> On Tue, 2019-10-08 at 14:39 +0200, Michal Hocko wrote:
> > On Tue 08-10-19 08:00:43, Qian Cai wrote:
> > > 
> > > 
> > > > On Oct 8, 2019, at 6:39 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > > > 
> > > > Have you actually triggered any real deadlock? With a zone->lock in
> > > > place it would be pretty clear with hard lockups detected.
> > > 
> > > Yes, I did trigger here and there, and those lockdep splats are
> > > especially useful to figure out why.
> > 
> > Can you provide a lockdep splat from an actual deadlock please? I am
> > sorry but your responses tend to be really cryptic and I never know when
> > you are talking about actual deadlocks and lockdep splats. I have asked
> > about the former several times never receiving a specific answer.
> 
> It is very time-consuming to confirm a lockdep splat is 100% matching a deadlock
> giving that it is not able to reproduce on will yet, so when I did encounter a
> memory offline deadlock where "echo offline > memory/state" just hang, but there
> is no hard lockup probably because the hard lockup detector did not work
> properly for some reasons or it keep trying to acquire a spin lock that only
> keep the CPU 100%.

If there is a real deadlock due to zone->lock then you would certainly
get a hard lockup splat. So I strongly suspect that you are seeing a
completely different problem. Most likely some pages cannot be migrated
and the offlining code will retry for ever. You can terminate that from
the userspace by a fatal signal of course.

-- 
Michal Hocko
SUSE Labs
