Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339EBC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 22:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026BB2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 22:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554847744;
	bh=Ka6j1KRZJ/zIII2hkQddriO93pBHn8gvucp+Khwge/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HVJ44Vz/XeqfxAU7P1OAJDG4aSfMsTY+JotpxX9gC5Sc6gVZVitlNake+8zRzzgx2
	 GEZ4IxR1X5R+W6IUoENUUSZNpwXCg8fiTy1xYVgyUch5rtyZs0baGsstgg8vNTyK78
	 7cxT89jCU+v6l/XpUa9Pv6TFeTjo3nZHjWnbp51Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDIWI7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 18:08:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37628 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfDIWI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 18:08:59 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0C27A1059;
        Tue,  9 Apr 2019 22:08:57 +0000 (UTC)
Date:   Tue, 9 Apr 2019 15:08:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     jglisse@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1?= =?UTF-8?Q?=C5=99?= 
        <rkrcmar@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 0/8] mmu notifier provide context informations
Message-Id: <20190409150855.a6cfee7e7c5698a9cd8ecb7c@linux-foundation.org>
In-Reply-To: <20190326164747.24405-1-jglisse@redhat.com>
References: <20190326164747.24405-1-jglisse@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 12:47:39 -0400 jglisse@redhat.com wrote:

> From: Jérôme Glisse <jglisse@redhat.com>
> 
> (Andrew this apply on top of my HMM patchset as otherwise you will have
>  conflict with changes to mm/hmm.c)
> 
> Changes since v5:
>     - drop KVM bits waiting for KVM people to express interest if they
>       do not then i will post patchset to remove change_pte_notify as
>       without the changes in v5 change_pte_notify is just useless (it
>       it is useless today upstream it is just wasting cpu cycles)
>     - rebase on top of lastest Linus tree
> 
> Previous cover letter with minor update:
> 
> 
> Here i am not posting users of this, they already have been posted to
> appropriate mailing list [6] and will be merge through the appropriate
> tree once this patchset is upstream.
> 
> Note that this serie does not change any behavior for any existing
> code. It just pass down more information to mmu notifier listener.
> 
> The rational for this patchset:
> 
> CPU page table update can happens for many reasons, not only as a
> result of a syscall (munmap(), mprotect(), mremap(), madvise(), ...)
> but also as a result of kernel activities (memory compression, reclaim,
> migration, ...).
> 
> This patch introduce a set of enums that can be associated with each
> of the events triggering a mmu notifier:
> 
>     - UNMAP: munmap() or mremap()
>     - CLEAR: page table is cleared (migration, compaction, reclaim, ...)
>     - PROTECTION_VMA: change in access protections for the range
>     - PROTECTION_PAGE: change in access protections for page in the range
>     - SOFT_DIRTY: soft dirtyness tracking
> 
> Being able to identify munmap() and mremap() from other reasons why the
> page table is cleared is important to allow user of mmu notifier to
> update their own internal tracking structure accordingly (on munmap or
> mremap it is not longer needed to track range of virtual address as it
> becomes invalid). Without this serie, driver are force to assume that
> every notification is an munmap which triggers useless trashing within
> drivers that associate structure with range of virtual address. Each
> driver is force to free up its tracking structure and then restore it
> on next device page fault. With this serie we can also optimize device
> page table update [6].
> 
> More over this can also be use to optimize out some page table updates
> like for KVM where we can update the secondary MMU directly from the
> callback instead of clearing it.

We seem to be rather short of review input on this patchset.  ie: there
is none.

> ACKS AMD/RADEON https://lkml.org/lkml/2019/2/1/395

OK, kind of ackish, but not a review.

> ACKS RDMA https://lkml.org/lkml/2018/12/6/1473

This actually acks the infiniband part of a patch which isn't in this
series.


So we have some work to do, please.  Who would be suitable reviewers?
