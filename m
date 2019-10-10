Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E28C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9D9218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696634;
	bh=sPv+ZyDulKHp04w0XAu6498xfyesROKAukGS+K8XOPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iDfcD8lqCNIHkXScLuOuO858YGhM9zzdlnxwEZaQDJF5MPSNQR8iHsD1q28rBgm7q
	 +Vhux+bShtUQKwZNVacgkkBL2PfFG7rB3TantcJ8LlA6Dy+RvWZ+NK3/trJLltC9cl
	 fiwvwfT8a9qV8e2e9jhV6t02WQ5m7jHg6h4Vh2T0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733170AbfJJIhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:37:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:36290 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729932AbfJJIhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:37:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1BA0BB048;
        Thu, 10 Oct 2019 08:37:11 +0000 (UTC)
Date:   Thu, 10 Oct 2019 10:37:10 +0200
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
Message-ID: <20191010083710.GF18412@dhcp22.suse.cz>
References: <20191007144937.GO2381@dhcp22.suse.cz>
 <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
 <20191008082752.GB6681@dhcp22.suse.cz>
 <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
 <1570550917.5576.303.camel@lca.pw>
 <1157b3ae-006e-5b8e-71f0-883918992ecc@linux.ibm.com>
 <20191009142623.GE6681@dhcp22.suse.cz>
 <20191010051201.GA78180@jagdpanzerIV>
 <20191010074049.GD18412@dhcp22.suse.cz>
 <20191010081629.GA120986@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010081629.GA120986@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10-10-19 17:16:29, Sergey Senozhatsky wrote:
> On (10/10/19 09:40), Michal Hocko wrote:
> [..]
> > > > Considering that console.write is called from essentially arbitrary code
> > > > path IIUC then all the locks used in this path should be pretty much
> > > > tail locks or console internal ones without external dependencies.
> > > 
> > > That's a good expectation, but I guess it's not always the case.
> > > 
> > > One example might be NET console - net subsystem locks, net device
> > > drivers locks, maybe even some MM locks (skb allocations?).
> > 
> > I am not familiar with the netconsole code TBH. If there is absolutely
> > no way around that then we might have to bite a bullet and consider some
> > of MM locks a land of no printk.
> 
> So this is what netconsole does (before we pass on udp to net device
> driver code, which *may be* can do more allocations, I don't know):
> 
> write_msg()
>  netpoll_send_udp()
>   find_skb()
>    alloc_skb(len, GFP_ATOMIC)
>     kmem_cache_alloc_node()
> 
> You are the right person to ask this question to - how many MM
> locks are involved when we do GFP_ATOMIC kmem_cache allocation?
> Is there anything to be concerned about?

At least zone->lock might involved. Maybe even more.
-- 
Michal Hocko
SUSE Labs
