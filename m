Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95540C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2F3208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564579538;
	bh=M3Lc1QkF5wR2TF7GuhcWC1aRi3S9OZRyyxj+KuwdLfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PlO1W5FNpIR1SL19hpw7FF7nKM1M6e37KqhL+TLA9F3bS+ifv1N6tMT8hQoIJKeqS
	 owkiMIbLsHm5c9GLwLG/A8Ia9J9IwHb/mzW6T3bfgLLPZJ5qnW8p3c0Ym4rqLDyw3P
	 N7G3vchpBe4cutNbyzg1ba5j1qyDSqF5U/UERNvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbfGaNZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:25:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:33532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbfGaNZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:25:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD6DAAE21;
        Wed, 31 Jul 2019 13:25:34 +0000 (UTC)
Date:   Wed, 31 Jul 2019 15:25:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] drivers/base/memory.c: Don't store end_section_nr in
 memory blocks
Message-ID: <20190731132534.GQ9330@dhcp22.suse.cz>
References: <20190731122213.13392-1-david@redhat.com>
 <20190731124356.GL9330@dhcp22.suse.cz>
 <f0894c30-105a-2241-a505-7436bc15b864@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0894c30-105a-2241-a505-7436bc15b864@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-07-19 15:12:12, David Hildenbrand wrote:
> On 31.07.19 14:43, Michal Hocko wrote:
> > On Wed 31-07-19 14:22:13, David Hildenbrand wrote:
> >> Each memory block spans the same amount of sections/pages/bytes. The size
> >> is determined before the first memory block is created. No need to store
> >> what we can easily calculate - and the calculations even look simpler now.
> > 
> > While this cleanup helps a bit, I am not sure this is really worth
> > bothering. I guess we can agree when I say that the memblock interface
> > is suboptimal (to put it mildly).  Shouldn't we strive for making it
> > a real hotplug API in the future? What do I mean by that? Why should
> > be any memblock fixed in size? Shouldn't we have use hotplugable units
> > instead (aka pfn range that userspace can work with sensibly)? Do we
> > know of any existing userspace that would depend on the current single
> > section res. 2GB sized memblocks?
> 
> Short story: It is already ABI (e.g.,
> /sys/devices/system/memory/block_size_bytes) - around since 2005 (!) -
> since we had memory block devices.
> 
> I suspect that it is mainly manually used. But I might be wrong.

Any pointer to the real userspace depending on it? Most usecases I am
aware of rely on udev events and either onlining or offlining the memory
in the handler.

I know we have documented this as an ABI and it is really _sad_ that
this ABI didn't get through normal scrutiny any user visible interface
should go through but these are sins of the past...

> Long story:
> 
> How would you want to number memory blocks? At least no longer by phys
> index. For now, memory blocks are ordered and numbered by their block id.

memory_${mem_section_nr_of_start_pfn}

> Admins might want to online parts of a DIMM MOVABLE/NORMAL, to more
> reliably use huge pages but still have enough space for kernel memory
> (e.g., page tables). They might like that a DIMM is actually a set of
> memory blocks instead of one big chunk.

They might. Do they though? There are many theoretical usecases but
let's face it, there is a cost given to the current state. E.g. the
number of memblock directories is already quite large on machines with a
lot of memory even though they use large blocks. That has negative
implications already (e.g. the number of events you get, any iteration
on the /sys etc.). Also 2G memblocks are quite arbitrary and they
already limit the above usecase some, right?

> IOW: You can consider it a restriction to add e.g., DIMMs only in one
> bigger chunks.
> 
> > 
> > All that being said, I do not oppose to the patch but can we start
> > thinking about the underlying memblock limitations rather than micro
> > cleanups?
> 
> I am pro cleaning up what we have right now, not expect it to eventually
> change some-when in the future. (btw, I highly doubt it will change)

I do agree, but having the memblock fixed size doesn't really go along
with variable memblock size if we ever go there. But as I've said I am
not really against the patch.
-- 
Michal Hocko
SUSE Labs
