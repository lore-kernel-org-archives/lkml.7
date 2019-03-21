Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F86C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E1421925
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfCUU2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:28:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbfCUU2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:28:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACF8A85541;
        Thu, 21 Mar 2019 20:28:14 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 419DF5C659;
        Thu, 21 Mar 2019 20:28:13 +0000 (UTC)
Date:   Thu, 21 Mar 2019 16:28:11 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "riel@surriel.com" <riel@surriel.com>
Subject: Re: [RFC PATCH RESEND 0/3] mm modifications / helpers for emulated
 GPU coherent memory
Message-ID: <20190321202811.GB15074@redhat.com>
References: <20190321132140.114878-1-thellstrom@vmware.com>
 <20190321134603.GB2904@redhat.com>
 <428b30355f4df864235428eaa24e207b8ba6c1ea.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <428b30355f4df864235428eaa24e207b8ba6c1ea.camel@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 21 Mar 2019 20:28:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 07:51:16PM +0000, Thomas Hellstrom wrote:
> Hi, Jérôme,
> 
> Thanks for commenting. I have a couple of questions / clarifications
> below.
> 
> On Thu, 2019-03-21 at 09:46 -0400, Jerome Glisse wrote:
> > On Thu, Mar 21, 2019 at 01:22:22PM +0000, Thomas Hellstrom wrote:
> > > Resending since last series was sent through a mis-configured SMTP
> > > server.
> > > 
> > > Hi,
> > > This is an early RFC to make sure I don't go too far in the wrong
> > > direction.
> > > 
> > > Non-coherent GPUs that can't directly see contents in CPU-visible
> > > memory,
> > > like VMWare's SVGA device, run into trouble when trying to
> > > implement
> > > coherent memory requirements of modern graphics APIs. Examples are
> > > Vulkan and OpenGL 4.4's ARB_buffer_storage.
> > > 
> > > To remedy, we need to emulate coherent memory. Typically when it's
> > > detected
> > > that a buffer object is about to be accessed by the GPU, we need to
> > > gather the ranges that have been dirtied by the CPU since the last
> > > operation,
> > > apply an operation to make the content visible to the GPU and clear
> > > the
> > > the dirty tracking.
> > > 
> > > Depending on the size of the buffer object and the access pattern
> > > there are
> > > two major possibilities:
> > > 
> > > 1) Use page_mkwrite() and pfn_mkwrite(). (GPU buffer objects are
> > > backed
> > > either by PCI device memory or by driver-alloced pages).
> > > The dirty-tracking needs to be reset by write-protecting the
> > > affected ptes
> > > and flush tlb. This has a complexity of O(num_dirty_pages), but the
> > > write page-fault is of course costly.
> > > 
> > > 2) Use hardware dirty-flags in the ptes. The dirty-tracking needs
> > > to be reset
> > > by clearing the dirty bits and flush tlb. This has a complexity of
> > > O(num_buffer_object_pages) and dirty bits need to be scanned in
> > > full before
> > > each gpu-access.
> > > 
> > > So in practice the two methods need to be interleaved for best
> > > performance.
> > > 
> > > So to facilitate this, I propose two new helpers,
> > > apply_as_wrprotect() and
> > > apply_as_clean() ("as" stands for address-space) both inspired by
> > > unmap_mapping_range(). Users of these helpers are in the making,
> > > but needs
> > > some cleaning-up.
> > 
> > To be clear this should _only be use_ for mmap of device file ? If so
> > the API should try to enforce that as much as possible for instance
> > by
> > mandating the file as argument so that the function can check it is
> > only use in that case. Also big scary comment to make sure no one
> > just
> > start using those outside this very limited frame.
> 
> Fine with me. Perhaps we could BUG() / WARN() on certain VMA flags 
> instead of mandating the file as argument. That can make sure we
> don't accidently hit pages we shouldn't hit.

You already provide the mapping as argument it should not be hard to
check it is a mapping to a device file as the vma flags will not be
enough to identify this case.

> 
> > 
> > > There's also a change to x_mkwrite() to allow dropping the mmap_sem
> > > while
> > > waiting.
> > 
> > This will most likely conflict with userfaultfd write protection. 
> 
> Are you referring to the x_mkwrite() usage itself or the mmap_sem
> dropping facilitation?

Both i believe, however i have not try to apply your patches on top of
the userfaultfd patchset

Cheers,
Jérôme
