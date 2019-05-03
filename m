Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871A7C04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637C32075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfECHfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:35:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:53224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726561AbfECHfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:35:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E529AE28;
        Fri,  3 May 2019 07:35:53 +0000 (UTC)
Date:   Fri, 3 May 2019 09:35:50 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/12] mm/sparsemem: Introduce struct mem_section_usage
Message-ID: <20190503073550.GB15740@linux>
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155677652762.2336373.6522945152928524695.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155677652762.2336373.6522945152928524695.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:55:27PM -0700, Dan Williams wrote:
> Towards enabling memory hotplug to track partial population of a
> section, introduce 'struct mem_section_usage'.
> 
> A pointer to a 'struct mem_section_usage' instance replaces the existing
> pointer to a 'pageblock_flags' bitmap. Effectively it adds one more
> 'unsigned long' beyond the 'pageblock_flags' (usemap) allocation to
> house a new 'map_active' bitmap.  The new bitmap enables the memory
> hot{plug,remove} implementation to act on incremental sub-divisions of a
> section.
> 
> The primary motivation for this functionality is to support platforms
> that mix "System RAM" and "Persistent Memory" within a single section,
> or multiple PMEM ranges with different mapping lifetimes within a single
> section. The section restriction for hotplug has caused an ongoing saga
> of hacks and bugs for devm_memremap_pages() users.
> 
> Beyond the fixups to teach existing paths how to retrieve the 'usemap'
> from a section, and updates to usemap allocation path, there are no
> expected behavior changes.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
