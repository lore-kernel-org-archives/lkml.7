Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9CEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7F32183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfC2OmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:42:03 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:14055 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728869AbfC2OmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:42:03 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 1B094474E; Fri, 29 Mar 2019 15:42:01 +0100 (CET)
Date:   Fri, 29 Mar 2019 15:42:01 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Alex Ghiti <alex@ghiti.fr>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>
Subject: Re: [PATCH REBASED] hugetlbfs: fix potential over/underflow setting
 node specific nr_hugepages
Message-ID: <20190329144158.d55gn24qzrdfykvb@d104.suse.de>
References: <20190328220533.19884-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328220533.19884-1-mike.kravetz@oracle.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 03:05:33PM -0700, Mike Kravetz wrote:
> The number of node specific huge pages can be set via a file such as:
> /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages
> When a node specific value is specified, the global number of huge
> pages must also be adjusted.  This adjustment is calculated as the
> specified node specific value + (global value - current node value).
> If the node specific value provided by the user is large enough, this
> calculation could overflow an unsigned long leading to a smaller
> than expected number of huge pages.
> 
> To fix, check the calculation for overflow.  If overflow is detected,
> use ULONG_MAX as the requested value.  This is inline with the user
> request to allocate as many huge pages as possible.
> 
> It was also noticed that the above calculation was done outside the
> hugetlb_lock.  Therefore, the values could be inconsistent and result
> in underflow.  To fix, the calculation is moved within the routine
> set_max_huge_pages() where the lock is held.
> 
> In addition, the code in __nr_hugepages_store_common() which tries to
> handle the case of not being able to allocate a node mask would likely
> result in incorrect behavior.  Luckily, it is very unlikely we will
> ever take this path.  If we do, simply return ENOMEM.
> 
> Reported-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
