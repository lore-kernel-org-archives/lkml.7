Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D004DC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98222207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XIZg3vu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441974AbfIXUqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 16:46:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfIXUqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z0xiBs2cJrYnnyGrqBU9K+45izSjXuYKxVFKoNAvjMA=; b=XIZg3vu6BOS2FeDU0hiloQmee
        A85KCXeh4u+VpfP5n4uHuxhCOZ+FFpBRSKoUHHTzdEU4DKkQb2nW/WLoTQMzmwN/s1VtrCpbKFpXk
        230t6233IkeEJ4fLik0cJR4nKIAAo6HPencihsIMm1OeMGCNM6k0UfgJ1Ht5kKwkhFKO/NztZCPAP
        VMV1+xPKuD2KJ3d1RWn1UswhxfZaTluOtCykoxZLoLaqkWaQfhGdCUh8MAmx9ircGrkfMVcZ2DHoD
        nUwbQ83/pi1fXpF0iCRCFavaaDy0tPJhtJwIHdkLDvgdZDOrR0wqSJOAepPkEfdH/NdNAohSz9qiJ
        Fk0YuoHbA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCrhI-00045Q-F4; Tue, 24 Sep 2019 20:46:08 +0000
Date:   Tue, 24 Sep 2019 13:46:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: drop mmap_sem before calling balance_dirty_pages()
 in write fault
Message-ID: <20190924204608.GI1855@bombadil.infradead.org>
References: <20190924171518.26682-1-hannes@cmpxchg.org>
 <20190924174809.GH1855@bombadil.infradead.org>
 <20190924194238.GA29030@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924194238.GA29030@cmpxchg.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 03:42:38PM -0400, Johannes Weiner wrote:
> > I'm not a fan of moving file_update_time() to _before_ the
> > balance_dirty_pages call.
> 
> Can you elaborate why? If the filesystem has a page_mkwrite op, it
> will have already called file_update_time() before this function is
> entered. If anything, this change makes the sequence more consistent.

Oh, that makes sense.  I thought it should be updated after all the data
was written, but it probably doesn't make much difference.

> > Also, this is now the third place that needs
> > maybe_unlock_mmap_for_io, see
> > https://lore.kernel.org/linux-mm/20190917120852.x6x3aypwvh573kfa@box/
> 
> Good idea, I moved the helper to internal.h and converted to it.
> 
> I left the shmem site alone, though. It doesn't require the file
> pinning, so it shouldn't pointlessly bump the file refcount and
> suggest such a dependency - that could cost somebody later quite a bit
> of time trying to understand the code.

The problem for shmem is this:

                        spin_unlock(&inode->i_lock);
                        schedule();

                        spin_lock(&inode->i_lock);
                        finish_wait(shmem_falloc_waitq, &shmem_fault_wait);
                        spin_unlock(&inode->i_lock);

While scheduled, the VMA can go away and the inode be reclaimed, making
this a use-after-free.  The initial suggestion was an increment on
the inode refcount, but since we already have a pattern which involves
pinning the file, I thought that was a better way to go.

> From: Johannes Weiner <jweiner@fb.com>
> Date: Wed, 8 May 2019 13:53:38 -0700
> Subject: [PATCH v2] mm: drop mmap_sem before calling balance_dirty_pages()
>  in write fault
> 
> One of our services is observing hanging ps/top/etc under heavy write
> IO, and the task states show this is an mmap_sem priority inversion:
> 
> A write fault is holding the mmap_sem in read-mode and waiting for
> (heavily cgroup-limited) IO in balance_dirty_pages():
> 
> [<0>] balance_dirty_pages+0x724/0x905
> [<0>] balance_dirty_pages_ratelimited+0x254/0x390
> [<0>] fault_dirty_shared_page.isra.96+0x4a/0x90
> [<0>] do_wp_page+0x33e/0x400
> [<0>] __handle_mm_fault+0x6f0/0xfa0
> [<0>] handle_mm_fault+0xe4/0x200
> [<0>] __do_page_fault+0x22b/0x4a0
> [<0>] page_fault+0x45/0x50
> [<0>] 0xffffffffffffffff
> 
> Somebody tries to change the address space, contending for the
> mmap_sem in write-mode:
> 
> [<0>] call_rwsem_down_write_failed_killable+0x13/0x20
> [<0>] do_mprotect_pkey+0xa8/0x330
> [<0>] SyS_mprotect+0xf/0x20
> [<0>] do_syscall_64+0x5b/0x100
> [<0>] entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> [<0>] 0xffffffffffffffff
> 
> The waiting writer locks out all subsequent readers to avoid lock
> starvation, and several threads can be seen hanging like this:
> 
> [<0>] call_rwsem_down_read_failed+0x14/0x30
> [<0>] proc_pid_cmdline_read+0xa0/0x480
> [<0>] __vfs_read+0x23/0x140
> [<0>] vfs_read+0x87/0x130
> [<0>] SyS_read+0x42/0x90
> [<0>] do_syscall_64+0x5b/0x100
> [<0>] entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> [<0>] 0xffffffffffffffff
> 
> To fix this, do what we do for cache read faults already: drop the
> mmap_sem before calling into anything IO bound, in this case the
> balance_dirty_pages() function, and return VM_FAULT_RETRY.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
