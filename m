Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E452C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2C120863
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568120024;
	bh=z5rsMlNBWBVt1XjnIJ7MFPDPOclpdloP3D9XosYHE7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZNCX4U/tpeil2v2bqTIUxTXj+3+XPvTFep/u4a39SVayOmYwwsv2NwB8hyOGc0Ai5
	 l+9YJSxFZzvHKO5ULxnXyoMmR4cwhkT9+GZ/ilOq2HqttKVkhwVhy6VoQOQxdjx9pe
	 URiFdKnhA2H1Lu/lgRx6/N1pVkSrDfe86MMRIfmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390761AbfIJMxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:53:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:46410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729140AbfIJMxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:53:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7C16AFCD;
        Tue, 10 Sep 2019 12:53:40 +0000 (UTC)
Date:   Tue, 10 Sep 2019 14:53:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
Message-ID: <20190910125339.GZ2063@dhcp22.suse.cz>
References: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
 <20190909095347.GB6314@kroah.com>
 <9598b359-ab96-7d61-687a-917bee7a5cd9@huawei.com>
 <20190910093114.GA19821@kroah.com>
 <34feca56-c95e-41a6-e09f-8fc2d2fd2bce@huawei.com>
 <20190910110451.GP2063@dhcp22.suse.cz>
 <20190910111252.GA8970@kroah.com>
 <5a5645d2-030f-7921-432f-ff7d657405b8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a5645d2-030f-7921-432f-ff7d657405b8@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-09-19 20:47:40, Yunsheng Lin wrote:
> On 2019/9/10 19:12, Greg KH wrote:
> > On Tue, Sep 10, 2019 at 01:04:51PM +0200, Michal Hocko wrote:
> >> On Tue 10-09-19 18:58:05, Yunsheng Lin wrote:
> >>> On 2019/9/10 17:31, Greg KH wrote:
> >>>> On Tue, Sep 10, 2019 at 02:43:32PM +0800, Yunsheng Lin wrote:
> >>>>> On 2019/9/9 17:53, Greg KH wrote:
> >>>>>> On Mon, Sep 09, 2019 at 02:04:23PM +0800, Yunsheng Lin wrote:
> >>>>>>> Currently a device does not belong to any of the numa nodes
> >>>>>>> (dev->numa_node is NUMA_NO_NODE) when the node id is neither
> >>>>>>> specified by fw nor by virtual device layer and the device has
> >>>>>>> no parent device.
> >>>>>>
> >>>>>> Is this really a problem?
> >>>>>
> >>>>> Not really.
> >>>>> Someone need to guess the node id when it is not specified, right?
> >>>>
> >>>> No, why?  Guessing guarantees you will get it wrong on some systems.
> >>>>
> >>>> Are you seeing real problems because the id is not being set?  What
> >>>> problem is this fixing that you can actually observe?
> >>>
> >>> When passing the return value of dev_to_node() to cpumask_of_node()
> >>> without checking the node id if the node id is not valid, there is
> >>> global-out-of-bounds detected by KASAN as below:
> >>
> >> OK, I seem to remember this being brought up already. And now when I
> >> think about it, we really want to make cpumask_of_node NUMA_NO_NODE
> >> aware. That means using the same trick the allocator does for this
> >> special case.
> > 
> > That seems reasonable to me, and much more "obvious" as to what is going
> > on.
> > 
> 
> Ok, thanks for the suggestion.
> 
> For arm64 and x86, there are two versions of cpumask_of_node().
> 
> when CONFIG_DEBUG_PER_CPU_MAPS is defined, the cpumask_of_node()
>    in arch/x86/mm/numa.c is used, which does partial node id checking:
> 
> const struct cpumask *cpumask_of_node(int node)
> {
>         if (node >= nr_node_ids) {
>                 printk(KERN_WARNING
>                         "cpumask_of_node(%d): node > nr_node_ids(%u)\n",
>                         node, nr_node_ids);
>                 dump_stack();
>                 return cpu_none_mask;
>         }
>         if (node_to_cpumask_map[node] == NULL) {
>                 printk(KERN_WARNING
>                         "cpumask_of_node(%d): no node_to_cpumask_map!\n",
>                         node);
>                 dump_stack();
>                 return cpu_online_mask;
>         }
>         return node_to_cpumask_map[node];
> }
> 
> when CONFIG_DEBUG_PER_CPU_MAPS is undefined, the cpumask_of_node()
>    in arch/x86/include/asm/topology.h is used:
> 
> static inline const struct cpumask *cpumask_of_node(int node)
> {
>         return node_to_cpumask_map[node];
> }

I would simply go with. There shouldn't be any need for heavy weight
checks that CONFIG_DEBUG_PER_CPU_MAPS has.

static inline const struct cpumask *cpumask_of_node(int node)
{
	/* A nice comment goes here */
	if (node == NUMA_NO_NODE)
		return node_to_cpumask_map[numa_mem_id()];
        return node_to_cpumask_map[node];
}
-- 
Michal Hocko
SUSE Labs
