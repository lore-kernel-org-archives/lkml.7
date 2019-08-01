Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E540CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AC9206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564640029;
	bh=Jj9wJvJ89lJJZmTX8SZoqNsBI9iuT/BCiqI4U8oMFWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RBoOuAFjYUxRyNsw9pHE1feKMqy9ahRFJy/PnyTmLbHo1JQG334N96V/jTd3hZj+P
	 PB+w72xjwP/R43Z82NkW+4QPgGlMk5jZqMztuQEmi307E0/8TxnOMvqIdsCdNqJ8in
	 y+wu1lTdIDEZi0lrUXtHrrJSbNPR+x56rTqIfb4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfHAGNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:13:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:38558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726783AbfHAGNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:13:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C65CCACEF;
        Thu,  1 Aug 2019 06:13:46 +0000 (UTC)
Date:   Thu, 1 Aug 2019 08:13:44 +0200
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
Message-ID: <20190801061344.GA11627@dhcp22.suse.cz>
References: <20190731122213.13392-1-david@redhat.com>
 <20190731124356.GL9330@dhcp22.suse.cz>
 <f0894c30-105a-2241-a505-7436bc15b864@redhat.com>
 <20190731132534.GQ9330@dhcp22.suse.cz>
 <58bd9479-051b-a13b-b6d0-c93aac2ed1b3@redhat.com>
 <20190731141411.GU9330@dhcp22.suse.cz>
 <c92a4d6f-b0f2-e080-5157-b90ab61a8c49@redhat.com>
 <20190731143714.GX9330@dhcp22.suse.cz>
 <d9db33a5-ca83-13bd-5fcb-5f7d5b3c1bfb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9db33a5-ca83-13bd-5fcb-5f7d5b3c1bfb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-07-19 16:43:58, David Hildenbrand wrote:
> On 31.07.19 16:37, Michal Hocko wrote:
> > On Wed 31-07-19 16:21:46, David Hildenbrand wrote:
> > [...]
> >>> Thinking about it some more, I believe that we can reasonably provide
> >>> both APIs controlable by a command line parameter for backwards
> >>> compatibility. It is the hotplug code to control sysfs APIs.  E.g.
> >>> create one sysfs entry per add_memory_resource for the new semantic.
> >>
> >> Yeah, but the real question is: who needs it. I can only think about
> >> some DIMM scenarios (some, not all). I would be interested in more use
> >> cases. Of course, to provide and maintain two APIs we need a good reason.
> > 
> > Well, my 3TB machine that has 7 movable nodes could really go with less
> > than
> > $ find /sys/devices/system/memory -name "memory*" | wc -l
> > 1729>
> 
> The question is if it would be sufficient to increase the memory block
> size even further for these kinds of systems (e.g., via a boot parameter
> - I think we have that on uv systems) instead of having blocks of
> different sizes. Say, 128GB blocks because you're not going to hotplug
> 128MB DIMMs into such a system - at least that's my guess ;)

The system has
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x10000000000-0x17fffffffff]
[    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x80000000000-0x87fffffffff]
[    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0x90000000000-0x97fffffffff]
[    0.000000] ACPI: SRAT: Node 4 PXM 4 [mem 0x100000000000-0x107fffffffff]
[    0.000000] ACPI: SRAT: Node 5 PXM 5 [mem 0x110000000000-0x117fffffffff]
[    0.000000] ACPI: SRAT: Node 6 PXM 6 [mem 0x180000000000-0x183fffffffff]
[    0.000000] ACPI: SRAT: Node 7 PXM 7 [mem 0x190000000000-0x191fffffffff]

hotplugable memory. I would love to have those 7 memory blocks to work
with. Any smaller grained split is just not helping as the platform will
not be able to hotremove it anyway.
-- 
Michal Hocko
SUSE Labs
