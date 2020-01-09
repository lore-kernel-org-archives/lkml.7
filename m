Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD30C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4F6206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578562917;
	bh=XeGxp62T1pZACZokfTvyGsRVQwaMnNA33mQ9b7jPwto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=og1yo7m9qnfexIAxgve4+fBEPj543s8o6yWW0F4m6qSxmTQe1LMeBcX0CVXe9qtU2
	 SEL7zd/2stSdLocs+RYFLC60tcHCjygu41Rj0UZeAT15m+Fkb3kfgFpuxJc/tDBM/r
	 Jl2OZqg2Q1UtZp6oAgeo+sUYHUEpuAkDJfhbV3FA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgAIJl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:41:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbgAIJl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:41:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BB2A20678;
        Thu,  9 Jan 2020 09:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578562915;
        bh=XeGxp62T1pZACZokfTvyGsRVQwaMnNA33mQ9b7jPwto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSBiZxWNRSrilNm9ZiDnvGgQgXNqA1lNoNgOnQDIx4IGEHr1rjCUlYrJC4exyvPaS
         Me9UPZM88ZeTCnPAHJ41V9djDhGc8pjkc3QLtMp8k57wdsAQoQIEHH8Or1LXH6TksT
         cFjpXL0gS8/p8Ak5Y8H3egvIeQTSN22r12EyeUvc=
Date:   Thu, 9 Jan 2020 10:41:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-ID: <20200109094153.GA45666@kroah.com>
References: <20191121195952.3728-1-cheloha@linux.vnet.ibm.com>
 <20191217193238.3098-1-cheloha@linux.vnet.ibm.com>
 <20200107214801.GN32178@dhcp22.suse.cz>
 <20200109084955.GI4951@dhcp22.suse.cz>
 <20200109085623.GB2583500@kroah.com>
 <20200109091934.GK4951@dhcp22.suse.cz>
 <4a0e4024-b4a1-f6aa-ae2b-7951a72b90aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a0e4024-b4a1-f6aa-ae2b-7951a72b90aa@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 10:31:21AM +0100, David Hildenbrand wrote:
> On 09.01.20 10:19, Michal Hocko wrote:
> > On Thu 09-01-20 09:56:23, Greg KH wrote:
> >> On Thu, Jan 09, 2020 at 09:49:55AM +0100, Michal Hocko wrote:
> >>> On Tue 07-01-20 22:48:04, Michal Hocko wrote:
> >>>> [Cc Andrew]
> >>>>
> >>>> On Tue 17-12-19 13:32:38, Scott Cheloha wrote:
> >>>>> Searching for a particular memory block by id is slow because each block
> >>>>> device is kept in an unsorted linked list on the subsystem bus.
> >>>>
> >>>> Noting that this is O(N^2) would be useful.
> >>>>
> >>>>> Lookup is much faster if we cache the blocks in a radix tree.
> >>>>
> >>>> While this is really easy and straightforward, is there any reason why
> >>>> subsys_find_device_by_id has to use such a slow lookup? I suspect nobody
> >>>> simply needed a more optimized data structure for that purpose yet.
> >>>> Would it be too hard to use radix tree for all lookups rather than
> >>>> adding a shadow copy for memblocks?
> >>>
> >>> Greg, Rafael, this seems to be your domain. Do you have any opinion on
> >>> this?
> >>
> >> No one has cared about the speed of that call as it has never been on
> >> any "fast path" that I know of.  And it should just be O(N), isn't it
> >> just walking the list of devices in order?
> > 
> > Which means that if you have to call it N times then it is O(N^2) and
> > that is the case here because you are adding N memblocks. See
> > memory_dev_init
> >   for each memblock
> >     add_memory_block
> >       init_memory_block
> >         find_memory_block_by_id # checks all existing devices
> >         register_memory
> > 	  device_register # add new device
> >   
> > In this particular case find_memory_block_by_id is called mostly to make
> > sure we are no re-registering something multiple times which shouldn't
> > happen so it sucks to spend a lot of time on that. We might think of
> > removing that for boot time but who knows what kind of surprises we
> > might see from crazy HW setups.
> 
> Oh, and please note (as discussed in v1 or v2 of this patch as well)
> that the lookup is also performed in walk_memory_blocks() for each
> memory block in the range, e.g., via link_mem_sections() on system boot.
> There we have O(N^2) as well.

Ok, again self-inflicted, I suggest you all roll your own logic for this
highly accessed set of things :)

thanks,

greg k-h
