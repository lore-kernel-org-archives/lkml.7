Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4C6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E480F218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbfB1KTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:19:54 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:7654 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732282AbfB1KTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:19:54 -0500
Received: by suse.de (Postfix, from userid 1000)
        id D6D3F4401; Thu, 28 Feb 2019 11:19:52 +0100 (CET)
Date:   Thu, 28 Feb 2019 11:19:52 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        mike.kravetz@oracle.com
Subject: Re: [RFC PATCH] mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
Message-ID: <20190228101949.qnnzgdhyn6deevnm@d104.suse.de>
References: <20190221094212.16906-1-osalvador@suse.de>
 <20190228092154.GV10588@dhcp22.suse.cz>
 <20190228094104.wbeaowsx25ckpcc7@d104.suse.de>
 <20190228095535.GX10588@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228095535.GX10588@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:55:35AM +0100, Michal Hocko wrote:
> You seemed to miss my point or I am wrong here. If scan_movable_pages
> skips over a hugetlb page then there is nothing to migrate it and it
> will stay in the pfn range and the range will not become idle.

I might be misunterstanding you, but I am not sure I get you.

scan_movable_pages() can either skip or not a hugetlb page.
In case it does, pfn will be incremented to skip the whole hugetlb
range.
If that happens, pfn will hold the next non-hugetlb page.

If it happens that the end of the hugetlb page is also the end
of the memory range, scan_movable_pages() will return 0 and we will
eventually break the loop in __offline_pages().

If this is not what you meant, could you please elaborate a bit more your concern?

-- 
Oscar Salvador
SUSE L3
