Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95684C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55430214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554361998;
	bh=H0SYkQqKepUPt8a0R+ZbQdTTrj8kqa8aE18A99AhfWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z1K9Y4d/yYbEktATw2wsQk94ZMgr2GBsmeNx21UHHCbyy6rLGAd/8SVz3KlciLuYn
	 JEXkSll+GHM9aEft9lM9nnzawPymVPyq1JIcMd6fBvRTzwjobqfJzrtUCNzAn+C3+j
	 6zxgV9EVsKLBt39o58u1gk7E5KrUBqaFebR9UA7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfDDHNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:13:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:43524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbfDDHNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:13:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 046F0B11F;
        Thu,  4 Apr 2019 07:13:14 +0000 (UTC)
Date:   Thu, 4 Apr 2019 09:13:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     ziy@nvidia.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        Javier Cabezas <jcabezas@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 00/25] Accelerate page migration and use memcg for
 PMEM management
Message-ID: <20190404071312.GD12864@dhcp22.suse.cz>
References: <20190404020046.32741-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404020046.32741-1-zi.yan@sent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-04-19 19:00:21, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Thanks to Dave Hansen's patches, which make PMEM as part of memory as NUMA nodes.
> How to use PMEM along with normal DRAM remains an open problem. There are
> several patchsets posted on the mailing list, proposing to use page migration to
> move pages between PMEM and DRAM using Linux page replacement policy [1,2,3].
> There are some important problems not addressed in these patches:
> 1. The page migration in Linux does not provide high enough throughput for us to
> fully exploit PMEM or other use cases.
> 2. Linux page replacement is running too infrequent to distinguish hot and cold
> pages.
[...]
>  33 files changed, 4261 insertions(+), 162 deletions(-)

For a patch _this_ large you should really start with a real world
usecasing hitting bottlenecks with the current implementation. Should
microbenchmarks can trigger bottlenecks much easier but do real
application do the same? Please give us some numbers.
-- 
Michal Hocko
SUSE Labs
