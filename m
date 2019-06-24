Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96389C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C8920665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbfFXUpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:45:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:45074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726920AbfFXUpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:45:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC8C4AE34;
        Mon, 24 Jun 2019 20:45:31 +0000 (UTC)
Message-ID: <1561409129.3058.1.camel@suse.de>
Subject: Re: [PATCH v10 09/13] mm/sparsemem: Support sub-section hotplug
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 22:45:29 +0200
In-Reply-To: <156092354368.979959.6232443923440952359.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
         <156092354368.979959.6232443923440952359.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-18 at 22:52 -0700, Dan Williams wrote:
> The libnvdimm sub-system has suffered a series of hacks and broken
> workarounds for the memory-hotplug implementation's awkward
> section-aligned (128MB) granularity. For example the following
> backtrace
> is emitted when attempting arch_add_memory() with physical address
> ranges that intersect 'System RAM' (RAM) with 'Persistent Memory'
> (PMEM)
> within a given section:
> 
>     # cat /proc/iomem | grep -A1 -B1 Persistent\ Memory
>     100000000-1ffffffff : System RAM
>     200000000-303ffffff : Persistent Memory (legacy)
>     304000000-43fffffff : System RAM
>     440000000-23ffffffff : Persistent Memory
>     2400000000-43bfffffff : Persistent Memory
>       2400000000-43bfffffff : namespace2.0
> 
>     WARNING: CPU: 38 PID: 928 at arch/x86/mm/init_64.c:850
> add_pages+0x5c/0x60
>     [..]
>     RIP: 0010:add_pages+0x5c/0x60
>     [..]
>     Call Trace:
>      devm_memremap_pages+0x460/0x6e0
>      pmem_attach_disk+0x29e/0x680 [nd_pmem]
>      ? nd_dax_probe+0xfc/0x120 [libnvdimm]
>      nvdimm_bus_probe+0x66/0x160 [libnvdimm]
> 
> It was discovered that the problem goes beyond RAM vs PMEM collisions
> as
> some platform produce PMEM vs PMEM collisions within a given section.
> The libnvdimm workaround for that case revealed that the libnvdimm
> section-alignment-padding implementation has been broken for a long
> while. A fix for that long-standing breakage introduces as many
> problems
> as it solves as it would require a backward-incompatible change to
> the
> namespace metadata interpretation. Instead of that dubious route [1],
> address the root problem in the memory-hotplug implementation.
> 
> Note that EEXIST is no longer treated as success as that is how
> sparse_add_section() reports subsection collisions, it was also
> obviated
> by recent changes to perform the request_region() for 'System RAM'
> before arch_add_memory() in the add_memory() sequence.
> 
> [1]: https://lore.kernel.org/r/155000671719.348031.234736316014111923
> 7.stgit@dwillia2-desk3.amr.corp.intel.com
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
