Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537ABC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CFC20692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568113320;
	bh=KhCFmP/zLXOK9nSI5U3q58K7y20dOqNlMJ6w2G+x8Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b3fpobWZaIchceazUn6th221XQgdVrIveMlArBL7yht7iQzFreTTgdo4rTkkSVF+N
	 dZTcpMvLAZ1ewgSRLDOfteJrOZCiD++648sADZzu9IS+I0L7HLC42aoaGKTtc+paac
	 Q+lyesHtFUerj9BgORQ1XKbe7Z+LYUgo9K7HkBIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbfIJLB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:01:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:50192 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728293AbfIJLB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:01:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E5C8AF25;
        Tue, 10 Sep 2019 11:01:56 +0000 (UTC)
Date:   Tue, 10 Sep 2019 13:01:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
Message-ID: <20190910110155.GO2063@dhcp22.suse.cz>
References: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
 <20190909185035.GC2063@dhcp22.suse.cz>
 <07576292-e129-5949-6a2e-45fff067ca5a@huawei.com>
 <20190910072425.GI2063@dhcp22.suse.cz>
 <434aff9a-2acb-73d7-83fa-43d5494471c0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434aff9a-2acb-73d7-83fa-43d5494471c0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-09-19 18:40:12, Yunsheng Lin wrote:
> On 2019/9/10 15:24, Michal Hocko wrote:
> > Our emails crossed, sorry about that.
> > 
> > On Tue 10-09-19 15:08:20, Yunsheng Lin wrote:
> >> On 2019/9/10 2:50, Michal Hocko wrote:
> >>> On Mon 09-09-19 14:04:23, Yunsheng Lin wrote:
> > [...]
> >>>> Even if a device's numa node is not specified, the device really
> >>>> does belong to a node.
> >>>
> >>> What does this mean?
> >>
> >> It means some one need to guess the node id if the node is not
> >> specified.
> > 
> > I have asked about this in other email so let's not cross the
> > communication even more.
> 
> I may just answer your question here.
> 
> Besides the page allocator, cpu allocator or scheduler may need to
> know about the node id to figure out which cpu to run is more
> optimized, like in workqueue_select_cpu_near().

OK, I can see some point there. Which of them do not handle this case
properly? At least workqueue_select_cpu_near seems to handle it
reasonably by not making any numa topology assumptions.

> >>>> This patch sets the device node to node 0 in device_add() if the
> >>>> device's node id is not specified and it either has no parent
> >>>> device, or the parent device also does not have a valid node id.
> >>>
> >>> Why is node 0 special? I have seen platforms with node 0 missing or
> >>> being memory less. The changelog also lacks an actual problem
> >>
> >> by node 0 missing, how do we know if node 0 is missing?
> >> by node_online(0)?
> > 
> > No, this is a dynamic situation. Node might get offline via hotremove.
> > In most cases it wouldn't because there will likely be some kernel
> > memory on node0 but you cannot really make any assumptions here. Besides
> > that nothing should really care.
> 
> >From the node checking:
> '(unsigned)node_id >= nr_node_ids'
> 
> If the nr_node_ids > 0, then node 0 is a valid node according to
> the above checking, is there a function to check if a node is
> missing?

What does that mean, really?

> Also, I am not sure if I understand "nothing should really care".
> Does it means a device still can be a numa that is missing, just
> have some performance degradation?

It really depends on what that numa affinity really represent. If the
affinity is to a non existent NUMA node then it likely has to hop over
some interconnect and pay some performance penalty. If there is no
affinity then it likely makes no difference on which node it sits and
which memory it gets.
 
> >>> descripton. Why do we even care about NUMA_NO_NODE? E.g. the page
> >>> allocator interprets NUMA_NO_NODE as the closest node with a memory.
> >>> And by closest it really means to the CPU which is performing the
> >>> allocation.
> >>
> >> Yes, I should have mentioned that in the commit log.
> >>
> >> I mentioned the below in the RFC, but somehow deleted when sending
> >> V1:
> >> "There may be explicit handling out there relying on NUMA_NO_NODE,
> >> like in nvme_probe()."
> > 
> > This code, and other doing similar things, is very likely bogus. Just
> > look at what the code does. It takes the node affinity from the dev and
> > uses it for an allocation. So far so good. But it tries to be clever
> > and special cases NUMA_NO_NODE to be first_node. So now the allocator
> > has used a proper fallback to the nearest node with memory for the
> > current CPU that is executing the code while dev will point to a
> > first_node which might be a completely different one. See the
> > discrepancy?
> 
> Do you mean let kzalloc_node handle the NUMA_NO_NODE case, if node
> id is NUMA_NO_NODE, kzalloc_node handles it as numa_mem_id().

Which is what the page allocator does and makes sense IMHO. So what is
the actual problem?

-- 
Michal Hocko
SUSE Labs
