Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B937CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8891F21916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCUWgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:36:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:22607 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfCUWgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:36:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:36:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="154574896"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 21 Mar 2019 15:36:08 -0700
Date:   Thu, 21 Mar 2019 16:37:08 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [PATCH 0/5] Page demotion for memory reclaim
Message-ID: <20190321223706.GA29817@localhost.localdomain>
References: <20190321200157.29678-1-keith.busch@intel.com>
 <5B5EFBC2-2979-4B9F-A43A-1A14F16ACCE1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B5EFBC2-2979-4B9F-A43A-1A14F16ACCE1@nvidia.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 02:20:51PM -0700, Zi Yan wrote:
> 1. The name of “page demotion” seems confusing to me, since I thought it was about large pages
> demote to small pages as opposite to promoting small pages to THPs. Am I the only
> one here?

If you have a THP, we'll skip the page migration and fall through to
split_huge_page_to_list(), then the smaller pages can be considered,
migrated and reclaimed individually. Not that we couldn't try to migrate
a THP directly. It was just simpler implementation for this first attempt.

> 2. For the demotion path, a common case would be from high-performance memory, like HBM
> or Multi-Channel DRAM, to DRAM, then to PMEM, and finally to disks, right? More general
> case for demotion path would be derived from the memory performance description from HMAT[1],
> right? Do you have any algorithm to form such a path from HMAT?

Yes, I have a PoC for the kernel setting up a demotion path based on
HMAT properties here:

  https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?h=mm-migrate&id=4d007659e1dd1b0dad49514348be4441fbe7cadb

The above is just from an experimental branch.

> 3. Do you have a plan for promoting pages from lower-level memory to higher-level memory,
> like from PMEM to DRAM? Will this one-way demotion make all pages sink to PMEM and disk?

Promoting previously demoted pages would require the application do
something to make that happen if you turn demotion on with this series.
Kernel auto-promotion is still being investigated, and it's a little
trickier than reclaim.

If it sinks to disk, though, the next access behavior is the same as
before, without this series.

> 4. In your patch 3, you created a new method migrate_demote_mapping() to migrate pages to
> other memory node, is there any problem of reusing existing migrate_pages() interface?

Yes, we may not want to migrate everything in the shrink_page_list()
pages. We might want to keep a page, so we have to do those checks first. At
the point we know we want to attempt migration, the page is already
locked and not in a list, so it is just easier to directly invoke the
new __unmap_and_move_locked() that migrate_pages() eventually also calls.
 
> 5. In addition, you only migrate base pages, is there any performance concern on migrating THPs?
> Is it too costly to migrate THPs?

It was just easier to consider single pages first, so we let a THP split
if possible. I'm not sure of the cost in migrating THPs directly.
