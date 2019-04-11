Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A39AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AA12083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554995960;
	bh=od3IvrSSpbcFSbg5/xte3EY3u8w1UD6su+DWu9RTRjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XBYA47ZuHay1kvJHw3rXQ58Dmtl/D63UDJwT4X5CI9hyNo1b11yJHWRWwWyrhvzYD
	 iIHRXkQjmYv+RrKbO00bB1RGcFml0vhT/AZtI5ba1NYuzULt8/5v8PP/0gK9z1LXL5
	 N9aqzBfCfcPUyx/bjvlTnUqNCi7JbE5t6gIhJGIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfDKPTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:19:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:48070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726630AbfDKPTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:19:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B93ADABE1;
        Thu, 11 Apr 2019 15:19:15 +0000 (UTC)
Date:   Thu, 11 Apr 2019 17:19:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH 0/2] mm/memcontrol: Finer-grained memory control
Message-ID: <20190411151911.GZ10383@dhcp22.suse.cz>
References: <20190410191321.9527-1-longman@redhat.com>
 <20190410195443.GL10383@dhcp22.suse.cz>
 <daef5f22-0bc2-a637-fa3d-833205623fb6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daef5f22-0bc2-a637-fa3d-833205623fb6@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-04-19 10:02:16, Waiman Long wrote:
> On 04/10/2019 03:54 PM, Michal Hocko wrote:
> > On Wed 10-04-19 15:13:19, Waiman Long wrote:
> >> The current control mechanism for memory cgroup v2 lumps all the memory
> >> together irrespective of the type of memory objects. However, there
> >> are cases where users may have more concern about one type of memory
> >> usage than the others.
> >>
> >> We have customer request to limit memory consumption on anonymous memory
> >> only as they said the feature was available in other OSes like Solaris.
> > Please be more specific about a usecase.
> 
> From that customer's point of view, page cache is more like common goods
> that can typically be shared by a number of different groups. Depending
> on which groups touch the pages first, it is possible that most of those
> pages can be disproportionately attributed to one group than the others.
> Anonymous memory, on the other hand, are not shared and so can more
> correctly represent the memory footprint of an application. Of course,
> there are certainly cases where an application can have large private
> files that can consume a lot of cache pages. These are probably not the
> case for the applications used by that customer.

So you are essentially interested in the page cache limiting, right?
This has been proposed several times already and always rejected because
this is not a good idea.

I would really like to see a more specific example where this makes
sense. False sharing can be certainly happen, no questions about that
but then the how big of a problem that is? Please more specifics.

> >> To allow finer-grained control of memory, this patchset 2 new control
> >> knobs for memory controller:
> >>  - memory.subset.list for specifying the type of memory to be under control.
> >>  - memory.subset.high for the high limit of memory consumption of that
> >>    memory type.
> > Please be more specific about the semantic.
> >
> > I am really skeptical about this feature to be honest, though.
> >
> 
> Please see patch 1 which has a more detailed description. This is just
> an overview for the cover letter.

No, please describe the whole design in high level in the cover letter.
I am not going to spend time reviewing specific patches if the whole
idea is not clear beforhand. Design should be clear first before diving
into technical details.
 
> >> For simplicity, the limit is not hierarchical and applies to only tasks
> >> in the local memory cgroup.
> > This is a no-go to begin with.
> 
> The reason for doing that is to introduce as little overhead as
> possible.

We are not going to break semantic based on very vague hand waving about
overhead.

> We can certainly make it hierarchical, but it will complicate
> the code and increase runtime overhead. Another alternative is to limit
> this feature to only leaf memory cgroups. That should be enough to cover
> what the customer is asking for and leave room for future hierarchical
> extension, if needed.

No, this is a broken design that doesn't fall into the over cgroups
design.

-- 
Michal Hocko
SUSE Labs
