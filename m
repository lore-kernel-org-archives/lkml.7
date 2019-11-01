Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB12CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE092080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfKALNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:13:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:33264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbfKALNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:13:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53013B25F;
        Fri,  1 Nov 2019 11:13:10 +0000 (UTC)
Date:   Fri, 1 Nov 2019 11:13:08 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC 02/10] autonuma: Reduce cache footprint when scanning page
 tables
Message-ID: <20191101111308.GO28938@suse.de>
References: <20191101075727.26683-1-ying.huang@intel.com>
 <20191101075727.26683-3-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191101075727.26683-3-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 03:57:19PM +0800, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> In auto NUMA balancing page table scanning, if the pte_protnone() is
> true, the PTE needs not to be changed because it's in target state
> already.  So other checking on corresponding struct page is
> unnecessary too.
> 
> So, if we check pte_protnone() firstly for each PTE, we can avoid
> unnecessary struct page accessing, so that reduce the cache footprint
> of NUMA balancing page table scanning.
> 
> In the performance test of pmbench memory accessing benchmark with
> 80:20 read/write ratio and normal access address distribution on a 2
> socket Intel server with Optance DC Persistent Memory, perf profiling
> shows that the autonuma page table scanning time reduces from 1.23% to
> 0.97% (that is, reduced 21%) with the patch.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

Acked-by: Mel Gorman <mgorman@suse.de>

This patch is independent of the series and should be resent separately.
Alternatively Andrew, please pick this patch up on its own.

-- 
Mel Gorman
SUSE Labs
