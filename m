Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE79C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539732184E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563486303;
	bh=AvFJMXMixH9pwAZAEJiAZGH5BdBKz6e6rNwXKbc10vQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cku7QwHWyZxCABXw6FFgqOSrCVt0Bwqt0ezljkQxmtnu3yDKFRoix/fL6zyZELob3
	 iIm2jrAwEfq6QuzAvGveyfFG4yhcKT2RnURnZPgYw83xNd1LgahJFqq3AGREHuTyK5
	 142emx/pxfYbkoOSaW1XwiBNJdvCPHD0EIKmvhzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391477AbfGRVpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbfGRVpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:45:01 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3875C208C0;
        Thu, 18 Jul 2019 21:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563486300;
        bh=AvFJMXMixH9pwAZAEJiAZGH5BdBKz6e6rNwXKbc10vQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=huhpkdvr2Y7vQhrHeuDIvSjajTwPYanZe0q2sPxAQRnBrgSKZ6zEd5/vzFjiv3Px6
         occ2gbieMwwsnJWBjF/ZVOLPIcJNzWVFaCFwlcdSojX4q9Oj8RbROxWnRHELdAAXDx
         WiLHeAEsTgwwQxf8M7bbAA+8Gd2IDWrbC1qldSNg=
Date:   Thu, 18 Jul 2019 14:44:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, hughd@google.com,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 2/2] mm: thp: fix false negative of shmem vma's THP
 eligibility
Message-Id: <20190718144459.7a20ac42ee16e093bdfcfab4@linux-foundation.org>
In-Reply-To: <5dde4380-68b4-66ee-2c3c-9b9da0c243ca@linux.alibaba.com>
References: <1560401041-32207-1-git-send-email-yang.shi@linux.alibaba.com>
        <1560401041-32207-3-git-send-email-yang.shi@linux.alibaba.com>
        <4a07a6b8-8ff2-419c-eac8-3e7dc17670df@suse.cz>
        <5dde4380-68b4-66ee-2c3c-9b9da0c243ca@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019 09:28:42 -0700 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> > Sorry for replying rather late, and not in the v2 thread, but unlike
> > Hugh I'm not convinced that we should include vma size/alignment in the
> > test for reporting THPeligible, which was supposed to reflect
> > administrative settings and madvise hints. I guess it's mostly a matter
> > of personal feeling. But one objective distinction is that the admin
> > settings and madvise do have an exact binary result for the whole VMA,
> > while this check is more fuzzy - only part of the VMA's span might be
> > properly sized+aligned, and THPeligible will be 1 for the whole VMA.
> 
> I think THPeligible is used to tell us if the vma is suitable for 
> allocating THP. Both anonymous and shmem THP checks vma size/alignment 
> to decide to or not to allocate THP.
> 
> And, if vma size/alignment is not checked, THPeligible may show "true" 
> for even 4K mapping. This doesn't make too much sense either.

This discussion seems rather inconclusive.  I'll merge up the patchset
anyway.  Vlastimil, if you think some changes are needed here then
please let's get them sorted out over the next few weeks?

