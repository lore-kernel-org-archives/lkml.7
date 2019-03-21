Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABCFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4161521874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfCUNqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:46:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfCUNqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:46:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B454E1E308;
        Thu, 21 Mar 2019 13:46:07 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1087C600C0;
        Thu, 21 Mar 2019 13:46:05 +0000 (UTC)
Date:   Thu, 21 Mar 2019 09:46:04 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH RESEND 0/3] mm modifications / helpers for emulated
 GPU coherent memory
Message-ID: <20190321134603.GB2904@redhat.com>
References: <20190321132140.114878-1-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190321132140.114878-1-thellstrom@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 21 Mar 2019 13:46:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 01:22:22PM +0000, Thomas Hellstrom wrote:
> Resending since last series was sent through a mis-configured SMTP server.
> 
> Hi,
> This is an early RFC to make sure I don't go too far in the wrong direction.
> 
> Non-coherent GPUs that can't directly see contents in CPU-visible memory,
> like VMWare's SVGA device, run into trouble when trying to implement
> coherent memory requirements of modern graphics APIs. Examples are
> Vulkan and OpenGL 4.4's ARB_buffer_storage.
> 
> To remedy, we need to emulate coherent memory. Typically when it's detected
> that a buffer object is about to be accessed by the GPU, we need to
> gather the ranges that have been dirtied by the CPU since the last operation,
> apply an operation to make the content visible to the GPU and clear the
> the dirty tracking.
> 
> Depending on the size of the buffer object and the access pattern there are
> two major possibilities:
> 
> 1) Use page_mkwrite() and pfn_mkwrite(). (GPU buffer objects are backed
> either by PCI device memory or by driver-alloced pages).
> The dirty-tracking needs to be reset by write-protecting the affected ptes
> and flush tlb. This has a complexity of O(num_dirty_pages), but the
> write page-fault is of course costly.
> 
> 2) Use hardware dirty-flags in the ptes. The dirty-tracking needs to be reset
> by clearing the dirty bits and flush tlb. This has a complexity of
> O(num_buffer_object_pages) and dirty bits need to be scanned in full before
> each gpu-access.
> 
> So in practice the two methods need to be interleaved for best performance.
> 
> So to facilitate this, I propose two new helpers, apply_as_wrprotect() and
> apply_as_clean() ("as" stands for address-space) both inspired by
> unmap_mapping_range(). Users of these helpers are in the making, but needs
> some cleaning-up.

To be clear this should _only be use_ for mmap of device file ? If so
the API should try to enforce that as much as possible for instance by
mandating the file as argument so that the function can check it is
only use in that case. Also big scary comment to make sure no one just
start using those outside this very limited frame.

> 
> There's also a change to x_mkwrite() to allow dropping the mmap_sem while
> waiting.

This will most likely conflict with userfaultfd write protection. Maybe
building your thing on top of that would be better.

https://lwn.net/Articles/783571/

I will take a cursory look at the patches.

Cheers,
Jérôme
