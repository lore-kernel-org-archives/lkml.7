Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E38C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DBC217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554982330;
	bh=8qBkcwk+TchEptzBwBB4C57DDcjNiJn5LTYIWEDDYVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wgEtyTpqtcsL5ZrnwaO8z2pJdR3HIggSPtGlc35L3IXNGby+VEmaYYldmKZ5mcZS3
	 sUy8+AoVheBJaSBhQThki7YqYw4EUUQBfs+EIlnjgQeS0MhAWUDId4bVhT8OAI1MXK
	 9EscqINo/Tr8XXyJdV1XYmQAySFiY45eRzWpaH0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfDKLcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:32:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:59120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726599AbfDKLcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:32:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36B57AC5B;
        Thu, 11 Apr 2019 11:32:07 +0000 (UTC)
Date:   Thu, 11 Apr 2019 13:32:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH] mm/memory_hotplug: Drop memory device reference after
 find_memory_block()
Message-ID: <20190411113206.GU10383@dhcp22.suse.cz>
References: <20190410101455.17338-1-david@redhat.com>
 <20190411084141.GQ10383@dhcp22.suse.cz>
 <0bbe632f-cb85-4a98-0c79-ded11cf39081@redhat.com>
 <20190411105617.GS10383@dhcp22.suse.cz>
 <711db571-ee39-eb64-4551-baaa5b562579@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <711db571-ee39-eb64-4551-baaa5b562579@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-04-19 13:18:07, David Hildenbrand wrote:
> On 11.04.19 12:56, Michal Hocko wrote:
> > On Thu 11-04-19 11:11:05, David Hildenbrand wrote:
> >> On 11.04.19 10:41, Michal Hocko wrote:
> >>> On Wed 10-04-19 12:14:55, David Hildenbrand wrote:
> >>>> While current node handling is probably terribly broken for memory block
> >>>> devices that span several nodes (only possible when added during boot,
> >>>> and something like that should be blocked completely), properly put the
> >>>> device reference we obtained via find_memory_block() to get the nid.
> >>>
> >>> The changelog could see some improvements I believe. (Half) stating
> >>> broken status of multinode memblock is not really useful without a wider
> >>> context so I would simply remove it. More to the point, it would be much
> >>> better to actually describe the actual problem and the user visible
> >>> effect.
> >>>
> >>> "
> >>> d0dc12e86b31 ("mm/memory_hotplug: optimize memory hotplug") has started
> >>> using find_memory_block to get a nodeid for the beginnig of the onlined
> >>> pfn range. The commit has missed that the memblock contains a reference
> >>> counted object and a missing put_device will leak the kobject behind
> >>> which ADD THE USER VISIBLE EFFECT HERE.
> >>> "
> >>
> >> I don't think mentioning the commit a second time is really needed.
> >>
> >> "
> >> Right now we are using find_memory_block() to get the node id for the
> >> pfn range to online. We are missing to drop a reference to the memory
> >> block device. While the device still gets unregistered via
> >> device_unregister(), resulting in no user visible problem, the device is
> >> never released via device_release(), resulting in a memory leak. Fix
> >> that by properly using a put_device().
> >> "
> > 
> > OK, sounds good to me. I was not sure about all the sysfs machinery
> > and the kobj dependencies but if there are no sysfs files leaking and
> > crashing upon a later access then a leak of a small amount of memory
> > that is not user controlable then this is not super urgent.
> > 
> > Thanks!
> 
> I think it can be triggered by onlining/offlining memory in a loop. 

which is a privileged operation so the impact is limited.

> But as you said, only leaks of small amount of memory.

Yes, as long as there are no other side sysfs related effects.
-- 
Michal Hocko
SUSE Labs
