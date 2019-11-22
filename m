Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB72AC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9194B20721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bMOmi7yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfKVPx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:53:26 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39057 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKVPx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:53:26 -0500
Received: by mail-qt1-f193.google.com with SMTP id t8so8330869qtc.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 07:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GkZzui3E9R3KSyvipQDNYjoE7WRU9+0cmj9xVI1nge4=;
        b=bMOmi7ygSWmpbSxd0KtFQM18DSKQIWiDhQXCEWRVzL4ABA+tQ4p/noNyDwbyeZ7pYW
         /nyBWQS5gqF+TouRNoVIdFOyqMlsbpaGqnNdJJ4FeNta2eJdhG6vEAZ3dLikvY11PpGG
         My9zL0y6GgxmYbylX/Dfkqr+e1adRx++jyTSsP1J97qhavhjUNFqq+uynHc6eCuOLoxI
         /sEgg+vSw6PShFw89sKe8mZ3zfocz/Bb3qxBX1whZwTBAfc6aRRs8xlO+lt8KC6z8l1o
         GrIBblPQrr+pqA9AaTdu0oDn1rF6es5c/+TKWiT77Cvj+O0hmiYlClcTnAILhfe/eNq+
         QPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GkZzui3E9R3KSyvipQDNYjoE7WRU9+0cmj9xVI1nge4=;
        b=O2ltt1FjfePZrJ0bM5/nk6pq3YjMsbqWj+NNhFBg6JSM2p7YrKS/RbU3SzFGzjQ4W8
         NYFK5nANQF+m6HF4yYy9m2gFniA20Um44tMSgCVRy23ve24d/tka5ArRf5p3DPj96Cib
         IvPntiGNqFF7pu9U7gfV4RTLZsvUbO5wwQpbjTop92LMY84SbOLDH1WwkULmjxXvB11w
         +O987CLQozxWX4XQs0YiiaFQvzw1HqnDL8bpd27LYjxnb8slN/MIUGNBUlkAKLlj1FPF
         PIH5RYdsJ0Q5I0zF4UtV/2G6uDUfPsv8c8Ra9wHvqhNPc3ArggLJ1w7VZ5Qd+qefXh2s
         aMBg==
X-Gm-Message-State: APjAAAUfu8rgQNWNcmQWnX6IpBWPxZr0z8N/W0pEMfxk5lTMMImabNGq
        6oHsxrCy9S+A1MoD4tulqGCBVg==
X-Google-Smtp-Source: APXvYqz4nUTeANeIQEGSerWAMv7XxTLPv6XFuTte7s/zwHjmvMG890BYNrElq2UiAZfiDt/guQ3u0w==
X-Received: by 2002:ac8:2f54:: with SMTP id k20mr879767qta.235.1574438005031;
        Fri, 22 Nov 2019 07:53:25 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d13sm3609264qta.67.2019.11.22.07.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 07:53:24 -0800 (PST)
Message-ID: <1574438002.9585.24.camel@lca.pw>
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
From:   Qian Cai <cai@lca.pw>
To:     Pengfei Li <fly@kernel.page>,
        "lixinhai.lxh@gmail.com" <lixinhai.lxh@gmail.com>
Cc:     akpm <akpm@linux-foundation.org>,
        mgorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, cl <cl@linux.com>,
        "iamjoonsoo.kim" <iamjoonsoo.kim@lge.com>, guro <guro@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Date:   Fri, 22 Nov 2019 10:53:22 -0500
In-Reply-To: <20191122232847.3ad94414.fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
         <2019112215245905276118@gmail.com>
         <20191122232847.3ad94414.fly@kernel.page>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-22 at 23:28 +0800, Pengfei Li wrote:
> On Fri, 22 Nov 2019 15:25:00 +0800
> "lixinhai.lxh@gmail.com" <lixinhai.lxh@gmail.com> wrote:
> 
> > On 2019-11-21 at 23:17 Pengfei Li wrote:
> > > Motivation
> > > ----------
> > > Currently if we want to iterate through all the nodes we have to
> > > traverse all the zones from the zonelist.
> > > 
> > > So in order to reduce the number of loops required to traverse node,
> > > this series of patches modified the zonelist to nodelist.
> > > 
> > > Two new macros have been introduced:
> > > 1) for_each_node_nlist
> > > 2) for_each_node_nlist_nodemask
> > > 
> > > 
> > > Benefit
> > > -------
> > > 1. For a NUMA system with N nodes, each node has M zones, the number
> > >    of loops is reduced from N*M times to N times when traversing
> > > node.
> > > 
> > 
> > It looks to me that we don't really have system which has N nodes and 
> > each node with M zones in its address range. 
> > We may have systems which has several nodes, but only the first node
> > has all zone types, other nodes only have NORMAL zone. (Evenly
> > distribute the !NORMAL zones on all nodes is not reasonable, as those
> > zones have limited size)
> > So iterate over zones to reach nodes should at N level, not M*N level.
> > 
> 
> Thanks for your comments.
> 
> In the case you said, the number of loops required to traverse all
> nodes is similar to traversing all zones.
> 
> I have two main reasons to explain that this series of patches is
> beneficial.
> 
> 1. When node has more than one zone, it will take fewer cycles to
> traverse all nodes. (for example, ZONE_MOVABLE?)

ZONE_MOVABLE is broken for ages (non-movable allocations are there all the time
last time I tried) which indicates there is very few people care about it, so it
is rather weak to use that as a justification for the churns it might cause.

> 
> 2. Using zonelist to traverse all nodes is inefficient, pgdat must be
> obtained indirectly via zone->zone_pgdat, and additional judgment must
> be made.
> 
> E.g
> 1) Using zonelist to traverse all nodes
> 
> 	last_pgdat = NULL;	
> 	for_each_zone_zonelist(zone, xxx) {
> 		pgdat = zone->zone_pgdat;
> 		if (pgdat == last_pgdat)
> 			continue;
> 
> 		last_pgdat = pgdat;
> 		do_something(pgdat);
> 	}
> 
> 2) Using nodelist to traverse all nodes
> 
> 	for_each_node_nodelist(node, xxx) {
> 		do_something(NODE_INFO(node));
> 	}
> 
