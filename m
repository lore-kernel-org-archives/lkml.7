Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9208DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66955206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfDDSBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:01:49 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:28429 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfDDSBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:01:49 -0400
Received: by suse.de (Postfix, from userid 1000)
        id E817F4828; Thu,  4 Apr 2019 20:01:47 +0200 (CEST)
Date:   Thu, 4 Apr 2019 20:01:47 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm, memory_hotplug: provide a more generic
 restrictions for memory hotplug
Message-ID: <20190404180144.lgpf6qgnp67ib5s7@d104.suse.de>
References: <20190404125916.10215-1-osalvador@suse.de>
 <20190404125916.10215-3-osalvador@suse.de>
 <880c5d09-7d4e-2a97-e826-a8a6572216b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <880c5d09-7d4e-2a97-e826-a8a6572216b2@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 04:57:03PM +0200, David Hildenbrand wrote:

> >  #ifdef CONFIG_MEMORY_HOTPLUG
> > -int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
> > -		    bool want_memblock)
> > +int arch_add_memory(int nid, u64 start, u64 size,
> > +			struct mhp_restrictions *restrictions)
> 
> Should the restrictions be marked const?

We could, but maybe some platforms want to override something later on
depending on x or y configurations, so we could be more flexible here.

> > +/*
> > + * Do we want sysfs memblock files created. This will allow userspace to online
> > + * and offline memory explicitly. Lack of this bit means that the caller has to
> > + * call move_pfn_range_to_zone to finish the initialization.
> > + */
> 
> I think you can be more precise here.
> 
> "Create memory block devices for added pages. This is usually the case
> for all system ram (and only system ram), as only this way memory can be
> onlined/offlined by user space and kdump to correctly detect the new
> memory using udev events."
> 
> Maybe we should even go a step further and call this
> 
> MHP_SYSTEM_RAM
> 
> Because that is what it is right now.

I agree that that is nicer explanation, and I would not mind to add it.
In the end, the more information and commented code the better.

But I am not really convinced by MHP_SYSTEM_RAM name, and I think we should stick
with MHP_MEMBLOCK_API because it represents __what__ is that flag about and its
function, e.g: create memory block devices.

> > @@ -1102,6 +1102,7 @@ int __ref add_memory_resource(int nid, struct resource *res)
> >  	u64 start, size;
> >  	bool new_node = false;
> >  	int ret;
> > +	struct mhp_restrictions restrictions = {};
> 
> I'd make this the very first variable.
> 
> Also eventually
> 
> struct mhp_restrictions restrictions = {
> 	.restrictions = MHP_MEMBLOCK_API
> };

It might be more right.
Actually, that is the way we tend to pre-initialize fields in structs.

About the identation, I  am really puzzled, I checked my branch and I
cannot see any space that should be a tab.
Maybe it got screwed up when sending it.

Anyway, thanks for the feedback David ;-)

-- 
Oscar Salvador
SUSE L3
