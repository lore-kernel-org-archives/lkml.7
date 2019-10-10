Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0247C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE30021D56
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570693253;
	bh=aStxV3/TmGs7vBQxybimYSvNYkwtst58Ijuad9uoZWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2uMw8p3FFW5DmK+p11k2h4MHVPKf5fdKMpSdufLkydQwQ4e4FaWGkQi/giRv4dX6P
	 Aq8TUTBL28TT8lcBhGCqiiH+5bu9QmBMcf0NE7dyWD83/hV4bb87gZMzXII5SgmYHV
	 ZSKNpFL8PYpP5uenVyfI0z1WUGoWu/247eBl908U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbfJJHkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:40:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:51922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733088AbfJJHkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:40:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7AC7FAF61;
        Thu, 10 Oct 2019 07:40:50 +0000 (UTC)
Date:   Thu, 10 Oct 2019 09:40:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191010074049.GD18412@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <20191007144937.GO2381@dhcp22.suse.cz>
 <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
 <20191008082752.GB6681@dhcp22.suse.cz>
 <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
 <1570550917.5576.303.camel@lca.pw>
 <1157b3ae-006e-5b8e-71f0-883918992ecc@linux.ibm.com>
 <20191009142623.GE6681@dhcp22.suse.cz>
 <20191010051201.GA78180@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010051201.GA78180@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10-10-19 14:12:01, Sergey Senozhatsky wrote:
> On (10/09/19 16:26), Michal Hocko wrote:
> > On Wed 09-10-19 15:56:32, Peter Oberparleiter wrote:
> > [...]
> > > A generic solution would be preferable from my point of view though,
> > > because otherwise each console driver owner would need to ensure that any
> > > lock taken in their console.write implementation is never held while
> > > memory is allocated/released.
> >
> > Considering that console.write is called from essentially arbitrary code
> > path IIUC then all the locks used in this path should be pretty much
> > tail locks or console internal ones without external dependencies.
> 
> That's a good expectation, but I guess it's not always the case.
> 
> One example might be NET console - net subsystem locks, net device
> drivers locks, maybe even some MM locks (skb allocations?).

I am not familiar with the netconsole code TBH. If there is absolutely
no way around that then we might have to bite a bullet and consider some
of MM locks a land of no printk. I have already said that in this
thread. I am mostly pushing back on "let's just go the simplest way"
approach.
 
> But even more "commonly used" consoles sometimes break that
> expectation. E.g. 8250
> 
> serial8250_console_write()
>  serial8250_modem_status()
>   wake_up_interruptible()

By that expectation you mean they are using external locks or that they
really _need_ to allocate. Because if you are pointing to
wake_up_interruptible and therefore the rq then this is a well known
thing and I was under impression even documented but I can only see
LOGLEVEL_SCHED that is arguably a very obscure way to document the fact.

-- 
Michal Hocko
SUSE Labs
