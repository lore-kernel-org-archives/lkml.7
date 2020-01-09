Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF35C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1C72073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578560187;
	bh=b+hzRZ7EinZwy2ent6p1hdlXlywTgzM6RtEIQw2Q2i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aZiOiby0+WS4f+ZNp6D+0DOHPnP6Vvhul0mLYDakmhxsbFBNsA49sh948+oQIAPEp
	 KDPt1kJDW6DmxmUnRkkYEPoEAq/vI/NkEdwq6WLlFNia83WSTTI+FU+k9/QRJrnJv3
	 Dyy5//41/Ly9F0n9HWoWMvRufNocA5MWmd5rhiuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgAII40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:56:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbgAII40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:56:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE8420678;
        Thu,  9 Jan 2020 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578560185;
        bh=b+hzRZ7EinZwy2ent6p1hdlXlywTgzM6RtEIQw2Q2i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rOVsSkfpgxUiCtrOv/r1QmUSiAQd8ipkLDF3dccgiiBXW8jiU8FvuK+CChDJW5fdQ
         VMEsxiMxBxrKfjRUEKERjNkzOS+FUbpg0VyQyN5aKR5a3BPxbvfvPiZQfLLSNYbBEL
         bNXmYNM4dZoRAXvyfk21Ds+oq7DfDOvDWpc06u8A=
Date:   Thu, 9 Jan 2020 09:56:23 +0100
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
Message-ID: <20200109085623.GB2583500@kroah.com>
References: <20191121195952.3728-1-cheloha@linux.vnet.ibm.com>
 <20191217193238.3098-1-cheloha@linux.vnet.ibm.com>
 <20200107214801.GN32178@dhcp22.suse.cz>
 <20200109084955.GI4951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109084955.GI4951@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:49:55AM +0100, Michal Hocko wrote:
> On Tue 07-01-20 22:48:04, Michal Hocko wrote:
> > [Cc Andrew]
> > 
> > On Tue 17-12-19 13:32:38, Scott Cheloha wrote:
> > > Searching for a particular memory block by id is slow because each block
> > > device is kept in an unsorted linked list on the subsystem bus.
> > 
> > Noting that this is O(N^2) would be useful.
> > 
> > > Lookup is much faster if we cache the blocks in a radix tree.
> > 
> > While this is really easy and straightforward, is there any reason why
> > subsys_find_device_by_id has to use such a slow lookup? I suspect nobody
> > simply needed a more optimized data structure for that purpose yet.
> > Would it be too hard to use radix tree for all lookups rather than
> > adding a shadow copy for memblocks?
> 
> Greg, Rafael, this seems to be your domain. Do you have any opinion on
> this?

No one has cared about the speed of that call as it has never been on
any "fast path" that I know of.  And it should just be O(N), isn't it
just walking the list of devices in order?

If the "memory subsystem" wants a faster lookup for their objects,
there's nothing stopping you from using your own data structure for the
pointers to the objects if you want.  Just be careful about the lifetime
rules.

thanks,

greg k-h
