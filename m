Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B3FC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6D920715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKVP3U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:29:20 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:40691 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVP3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:29:20 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7FDC91C001A;
        Fri, 22 Nov 2019 15:29:05 +0000 (UTC)
Date:   Fri, 22 Nov 2019 23:28:47 +0800
From:   Pengfei Li <fly@kernel.page>
To:     "lixinhai.lxh@gmail.com" <lixinhai.lxh@gmail.com>
Cc:     akpm <akpm@linux-foundation.org>,
        mgorman <mgorman@techsingularity.net>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>, cl <cl@linux.com>,
        "iamjoonsoo.kim" <iamjoonsoo.kim@lge.com>, guro <guro@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, fly@kernel.page
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
Message-ID: <20191122232847.3ad94414.fly@kernel.page>
In-Reply-To: <2019112215245905276118@gmail.com>
References: <20191121151811.49742-1-fly@kernel.page>
        <2019112215245905276118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 15:25:00 +0800
"lixinhai.lxh@gmail.com" <lixinhai.lxh@gmail.com> wrote:

> On 2019-11-21 at 23:17 Pengfei Li wrote:
> >Motivation
> >----------
> >Currently if we want to iterate through all the nodes we have to
> >traverse all the zones from the zonelist.
> >
> >So in order to reduce the number of loops required to traverse node,
> >this series of patches modified the zonelist to nodelist.
> >
> >Two new macros have been introduced:
> >1) for_each_node_nlist
> >2) for_each_node_nlist_nodemask
> >
> >
> >Benefit
> >-------
> >1. For a NUMA system with N nodes, each node has M zones, the number
> >   of loops is reduced from N*M times to N times when traversing
> >node.
> > 
> 
> It looks to me that we don't really have system which has N nodes and 
> each node with M zones in its address range. 
> We may have systems which has several nodes, but only the first node
> has all zone types, other nodes only have NORMAL zone. (Evenly
> distribute the !NORMAL zones on all nodes is not reasonable, as those
> zones have limited size)
> So iterate over zones to reach nodes should at N level, not M*N level.
> 

Thanks for your comments.

In the case you said, the number of loops required to traverse all
nodes is similar to traversing all zones.

I have two main reasons to explain that this series of patches is
beneficial.

1. When node has more than one zone, it will take fewer cycles to
traverse all nodes. (for example, ZONE_MOVABLE?)

2. Using zonelist to traverse all nodes is inefficient, pgdat must be
obtained indirectly via zone->zone_pgdat, and additional judgment must
be made.

E.g
1) Using zonelist to traverse all nodes

	last_pgdat = NULL;	
	for_each_zone_zonelist(zone, xxx) {
		pgdat = zone->zone_pgdat;
		if (pgdat == last_pgdat)
			continue;

		last_pgdat = pgdat;
		do_something(pgdat);
	}

2) Using nodelist to traverse all nodes

	for_each_node_nodelist(node, xxx) {
		do_something(NODE_INFO(node));
	}
