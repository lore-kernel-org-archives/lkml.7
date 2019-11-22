Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7AAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6253120714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfKVPuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:50:15 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:36257 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKVPuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:50:15 -0500
Received: from localhost (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id CA1E1100010;
        Fri, 22 Nov 2019 15:49:31 +0000 (UTC)
Date:   Fri, 22 Nov 2019 23:49:07 +0800
From:   Pengfei Li <fly@kernel.page>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@kernel.org, vbabka@suse.cz, cl@linux.com,
        iamjoonsoo.kim@lge.com, guro@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, fly@kernel.page
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
Message-ID: <20191122234907.4da3bc81.fly@kernel.page>
In-Reply-To: <1bb37491-72a7-feaa-722d-a5825813a409@redhat.com>
References: <20191121151811.49742-1-fly@kernel.page>
        <1bb37491-72a7-feaa-722d-a5825813a409@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 11:03:30 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 21.11.19 16:17, Pengfei Li wrote:
> > Motivation
> > ----------
> > Currently if we want to iterate through all the nodes we have to
> > traverse all the zones from the zonelist.
> > 
> > So in order to reduce the number of loops required to traverse node,
> > this series of patches modified the zonelist to nodelist.
> > 
> > Two new macros have been introduced:
> > 1) for_each_node_nlist
> > 2) for_each_node_nlist_nodemask
> > 
> > 
> > Benefit
> > -------
> > 1. For a NUMA system with N nodes, each node has M zones, the number
> >     of loops is reduced from N*M times to N times when traversing
> > node.
> > 
> > 2. The size of pg_data_t is much reduced.
> > 
> > 
> > Test Result
> > -----------
> > Currently I have only performed a simple page allocation benchmark
> > test on my laptop, and the results show that the performance of a
> > system with only one node is almost unaffected.
> > 
> 
> So you are seeing no performance changes. I am wondering why do we
> need this, then - because your motivation sounds like a performance 
> improvement? (not completely against this, just trying to understand
> the value of this :) )

Thanks for your comments.

I am sorry that I did not make it clear. I want to express this series
of patches will benefit NUMA systems with multiple nodes.

The main benefit is that it will be more efficient when traversing all
nodes (for example when performing page reclamation).

