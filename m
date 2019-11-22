Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA6FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0470E2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKVRgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:36:35 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34203 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:36:34 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 93CF01BF207;
        Fri, 22 Nov 2019 17:36:26 +0000 (UTC)
Date:   Sat, 23 Nov 2019 01:36:13 +0800
From:   Pengfei Li <fly@kernel.page>
To:     Christopher Lameter <cl@linux.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, guro@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, fly@kernel.page
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
Message-ID: <20191123013613.566bb40a.fly@kernel.page>
In-Reply-To: <alpine.DEB.2.21.1911221551570.10063@www.lameter.com>
References: <20191121151811.49742-1-fly@kernel.page>
        <1bb37491-72a7-feaa-722d-a5825813a409@redhat.com>
        <20191122234907.4da3bc81.fly@kernel.page>
        <alpine.DEB.2.21.1911221551570.10063@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 15:53:57 +0000 (UTC)
Christopher Lameter <cl@linux.com> wrote:

> On Fri, 22 Nov 2019, Pengfei Li wrote:
> 
> > I am sorry that I did not make it clear. I want to express this
> > series of patches will benefit NUMA systems with multiple nodes.
> 
> Ok but that benefit needs to be quantified somehow.
> 

Thanks for your comments.

Yes, I will add detailed performance test data in v2.

> > The main benefit is that it will be more efficient when traversing
> > all nodes (for example when performing page reclamation).
> 
> And you loose the prioritization of allocations through these
> different zones.

Sorry, I forgot to mention that the information about the zones that
are available to the node is still there.

The old for_each_zone_zonelist has been replaced with
for_each_zone_nodelist.

I will add some key implementation details in v2. 

> We create zonelists with a certain sequence of the
> zones in order to prefer allocations from certain zones. This is in
> particular important for the smaller DMA zones which may be easily
> exhausted.
> 

I'm not sure if I understand what you mean, but since commit
c9bff3eebc09 ("mm, page_alloc: rip out ZONELIST_ORDER_ZONE"), the
zonelist is always in "Node" order, so building the nodelist is fine.

-- 
Pengfei
