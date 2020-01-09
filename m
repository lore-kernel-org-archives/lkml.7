Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3A2C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BE22072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578562444;
	bh=qY4HFfA903QkzmdrSxz+dUyVuwkP0B4l+IilQQzsYuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T4oBUezM98AKdt4NFUg+8UpvLQcpLDiA8niuioYKjeb4fyiCOVT3AI9/pQCZMPdLL
	 XZ+7DV+QmjM5ai7F7138vPrEcTMF+9cdApvXlsC9BLslESyifwz8VcmaqIhajxH8j0
	 jxm/X6QnaLXQzcySYiBrJ77wC8ckClqL+uxOZyL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgAIJeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:34:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729577AbgAIJeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:34:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE69D2072A;
        Thu,  9 Jan 2020 09:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578562441;
        bh=qY4HFfA903QkzmdrSxz+dUyVuwkP0B4l+IilQQzsYuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k4OYJCmAgq8JXkpUp8l52tVn4Qpi5A2jfGUVko689wmJEx92UmDybjWinH/650FBN
         gU/uoPx2eM99/pW1cty04TLlUQ2bxZPZASez37bVkmqOQ5o69ZdVjqPmbqTNLiRd81
         Ydvd7Z64G9SPVVUvoxD71c0gGjduVKAGqhb3DtEA=
Date:   Thu, 9 Jan 2020 10:33:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>, nathanl@linux.ibm.com,
        ricklind@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-ID: <20200109093359.GA44349@kroah.com>
References: <20191121195952.3728-1-cheloha@linux.vnet.ibm.com>
 <20191217193238.3098-1-cheloha@linux.vnet.ibm.com>
 <20200107214801.GN32178@dhcp22.suse.cz>
 <20200109084955.GI4951@dhcp22.suse.cz>
 <20200109085623.GB2583500@kroah.com>
 <20200109091934.GK4951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109091934.GK4951@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 10:19:34AM +0100, Michal Hocko wrote:
> On Thu 09-01-20 09:56:23, Greg KH wrote:
> > On Thu, Jan 09, 2020 at 09:49:55AM +0100, Michal Hocko wrote:
> > > On Tue 07-01-20 22:48:04, Michal Hocko wrote:
> > > > [Cc Andrew]
> > > > 
> > > > On Tue 17-12-19 13:32:38, Scott Cheloha wrote:
> > > > > Searching for a particular memory block by id is slow because each block
> > > > > device is kept in an unsorted linked list on the subsystem bus.
> > > > 
> > > > Noting that this is O(N^2) would be useful.
> > > > 
> > > > > Lookup is much faster if we cache the blocks in a radix tree.
> > > > 
> > > > While this is really easy and straightforward, is there any reason why
> > > > subsys_find_device_by_id has to use such a slow lookup? I suspect nobody
> > > > simply needed a more optimized data structure for that purpose yet.
> > > > Would it be too hard to use radix tree for all lookups rather than
> > > > adding a shadow copy for memblocks?
> > > 
> > > Greg, Rafael, this seems to be your domain. Do you have any opinion on
> > > this?
> > 
> > No one has cared about the speed of that call as it has never been on
> > any "fast path" that I know of.  And it should just be O(N), isn't it
> > just walking the list of devices in order?
> 
> Which means that if you have to call it N times then it is O(N^2) and
> that is the case here because you are adding N memblocks. See
> memory_dev_init
>   for each memblock
>     add_memory_block
>       init_memory_block
>         find_memory_block_by_id # checks all existing devices
>         register_memory
> 	  device_register # add new device
>   
> In this particular case find_memory_block_by_id is called mostly to make
> sure we are no re-registering something multiple times which shouldn't
> happen so it sucks to spend a lot of time on that. We might think of
> removing that for boot time but who knows what kind of surprises we
> might see from crazy HW setups.

Ok, so this is a self-inflicted issue, not a driver core issue :)

> > If the "memory subsystem" wants a faster lookup for their objects,
> > there's nothing stopping you from using your own data structure for the
> > pointers to the objects if you want.  Just be careful about the lifetime
> > rules.
> 
> The main question is whether replacing the linked list with a radix tree
> in the generic code is something more meaningful.

I strongly doubt it, it looks like you all are doing something very
specific to your subsystem that would need this type of speed/lookup.  I
suggest doing it on your own for now.

thanks,

greg k-h
