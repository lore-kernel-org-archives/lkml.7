Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05CCC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A353720863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568203340;
	bh=Qc3hlFF9+Xg0m7O9h3ZwZt5x8AAS+U9qpshK4Qhom80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yZqDsiItdBRS/aztjs+pd11UNigrNv3tcZEiDZDTJXpoY/I3tUmY4nCiZe97tgAtB
	 uLxiRuj/Mlpeu75gDdfZYvQvqe9AjVHReQ9v0qw0Itc0ENOXqyCKBT/0C3Kmi8kZ+w
	 XvTP/QnPVyqNezeZ/hZhlLacAWlpejuHycQZUU7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfIKMCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:02:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:43992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726702AbfIKMCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:02:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3217B660;
        Wed, 11 Sep 2019 12:02:17 +0000 (UTC)
Date:   Wed, 11 Sep 2019 14:02:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
Message-ID: <20190911120217.GR4023@dhcp22.suse.cz>
References: <20190910111252.GA8970@kroah.com>
 <5a5645d2-030f-7921-432f-ff7d657405b8@huawei.com>
 <20190910125339.GZ2063@dhcp22.suse.cz>
 <20190911053334.GH4023@dhcp22.suse.cz>
 <ca590101-bfc8-3934-d803-537aacb707e0@huawei.com>
 <20190911064926.GJ4023@dhcp22.suse.cz>
 <3b977388-5f25-d0b5-bdc9-f963a9be2bd1@huawei.com>
 <20190911073451.GM4023@dhcp22.suse.cz>
 <d828d48c-cae7-f3c2-fb2e-c8b25995cbef@huawei.com>
 <97ad9ede-3a69-bd9e-e6c9-c2a893459565@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97ad9ede-3a69-bd9e-e6c9-c2a893459565@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-09-19 19:41:44, Yunsheng Lin wrote:
> On 2019/9/11 19:03, Yunsheng Lin wrote:
> > On 2019/9/11 15:34, Michal Hocko wrote:
> >> On Wed 11-09-19 15:22:30, Yunsheng Lin wrote:
> >> [...]
> >>> It seems that there is no protection that prevent setting the node
> >>> of device to an invalid node.
> >>> And the kernel does have a few different check now:
> >>> 1) some does " < 0" check;
> >>> 2) some does "== NUMA_NO_NODE" check;
> >>> 3) some does ">= MAX_NUMNODES" check;
> >>> 4) some does "< 0 || >= MAX_NUMNODES || !node_online(node)" check.
> >>>
> >>> We need to be consistent about the checking, right?
> >>
> >> You can try and chase each of them and see what to do with them. I
> >> suspect they are a result of random attempts to fortify the code in many
> >> cases. Consistency is certainly good but spreading more checks all over
> >> the place just adds more cargo cult. Each check should be reasonably
> >> justified.
> > 
> > Ok, Let me focus on making the node_to_cpumask_map() NUMA_NO_NODE aware
> > by only checking "node == NUMA_NO_NODE" first.
> 
> Hi, Michal
>     It that ok for me to add your name to "Suggested-by" tag, since I am
> going to quote some of your words on the commit log.

Sure, no problem. Thanks!
-- 
Michal Hocko
SUSE Labs
