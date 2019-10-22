Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1257CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912C420B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfJVH5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 03:57:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:48178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726978AbfJVH5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 03:57:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B15CB85D;
        Tue, 22 Oct 2019 07:57:47 +0000 (UTC)
Date:   Tue, 22 Oct 2019 09:57:45 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     n-horiguchi@ah.jp.nec.com, mhocko@kernel.org,
        mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 15/16] mm/hwpoison-inject: Rip off duplicated
 checks
Message-ID: <20191022075745.GC19060@linux>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-16-osalvador@suse.de>
 <1aa1f09a-1210-d0bc-86ac-9674828bff49@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aa1f09a-1210-d0bc-86ac-9674828bff49@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:40:39AM +0200, David Hildenbrand wrote:
> I explored somewhere already why this code was added:
> 
> 
> commit 31d3d3484f9bd263925ecaa341500ac2df3a5d9b
> Author: Wu Fengguang <fengguang.wu@intel.com>
> Date:   Wed Dec 16 12:19:59 2009 +0100
> 
>     HWPOISON: limit hwpoison injector to known page types
>     
>     __memory_failure()'s workflow is
>     
>             set PG_hwpoison
>             //...
>             unset PG_hwpoison if didn't pass hwpoison filter
>     
>     That could kill unrelated process if it happens to page fault on the
>     page with the (temporary) PG_hwpoison. The race should be big enough to
>     appear in stress tests.
>     
>     Fix it by grabbing the page and checking filter at inject time.  This
>     also avoids the very noisy "Injecting memory failure..." messages.
>     
>     - we don't touch madvise() based injection, because the filters are
>       generally not necessary for it.
>     - if we want to apply the filters to h/w aided injection, we'd better to
>       rearrange the logic in __memory_failure() instead of this patch.
>     
>     AK: fix documentation, use drain all, cleanups
> 
> 
> You should justify why it is okay to do rip that code out now.
> It's not just duplicate checks.
> 
> Was the documented race fixed?
> Will we fix the race within memory_failure() later?
> Don't we care?
> 
> Also, you should add that this fixes the access of uninitialized memmaps
> now and makes the interface work correctly with devmem.

Thanks for bringuing this up David.
I guess I was carried away.

Since I have to do another re-spin to re-work a couple of things, I will
work on this as well.

-- 
Oscar Salvador
SUSE L3
