Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54F0C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A702171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDLQwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:52:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:56536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726624AbfDLQwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:52:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AEC46AE28;
        Fri, 12 Apr 2019 16:52:44 +0000 (UTC)
Date:   Fri, 12 Apr 2019 09:52:35 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 2/2] hugetlb: use same fault hash key for shared and
 private mappings
Message-ID: <20190412165235.t4sscoujczfhuiyt@linux-r8p5>
Mail-Followup-To: Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20190328234704.27083-1-mike.kravetz@oracle.com>
 <20190328234704.27083-3-mike.kravetz@oracle.com>
 <0b1d1faf-ff72-a51f-b48a-175c9c5cab53@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0b1d1faf-ff72-a51f-b48a-175c9c5cab53@oracle.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019, Mike Kravetz wrote:

>On 3/28/19 4:47 PM, Mike Kravetz wrote:
>> hugetlb uses a fault mutex hash table to prevent page faults of the
>> same pages concurrently.  The key for shared and private mappings is
>> different.  Shared keys off address_space and file index.  Private
>> keys off mm and virtual address.  Consider a private mappings of a
>> populated hugetlbfs file.  A write fault will first map the page from
>> the file and then do a COW to map a writable page.
>
>Davidlohr suggested adding the stack trace to the commit log.  When I
>originally 'discovered' this issue I was debugging something else.  The
>routine remove_inode_hugepages() contains the following:
>
>			 * ...
>			 * This race can only happen in the hole punch case.
>			 * Getting here in a truncate operation is a bug.
>			 */
>			if (unlikely(page_mapped(page))) {
>				BUG_ON(truncate_op);
>
>				i_mmap_lock_write(mapping);
>				hugetlb_vmdelete_list(&mapping->i_mmap,
>					index * pages_per_huge_page(h),
>					(index + 1) * pages_per_huge_page(h));
>				i_mmap_unlock_write(mapping);
>			}
>
>			lock_page(page);
>			/*
>			 * We must free the huge page and remove from page
>			 * ...
>			 */
>			VM_BUG_ON(PagePrivate(page));
>			remove_huge_page(page);
>			freed++;
>
>I observed that the page could be mapped (again) before the call to lock_page
>if we raced with a private write fault.  However, for COW faults the faulting
>code is holding the page lock until it unmaps the file page.  Hence, we will
>not call remove_huge_page() with the page mapped.  That is good.  However, for
>simple read faults the page remains mapped after releasing the page lock and
>we can call remove_huge_page with a mapped page and BUG.
>
>Sorry, the original commit message was not completely accurate in describing
>the issue.  I was basing the change on behavior experienced during debug of
>a another issue.  Actually, it is MUCH easier to BUG by making private read
>faults race with hole punch.  As a result, I now think this should go to
>stable.
>
>Andrew, below is an updated commit message.  No changes to code.  Would you
>like me to send an updated patch?  Also, need to add stable.
>
>hugetlb uses a fault mutex hash table to prevent page faults of the
>same pages concurrently.  The key for shared and private mappings is
>different.  Shared keys off address_space and file index.  Private
>keys off mm and virtual address.  Consider a private mappings of a
>populated hugetlbfs file.  A fault will map the page from the file
>and if needed do a COW to map a writable page.
>
>Hugetlbfs hole punch uses the fault mutex to prevent mappings of file
>pages.  It uses the address_space file index key.  However, private
>mappings will use a different key and could race with this code to map
>the file page.  This causes problems (BUG) for the page cache remove
>code as it expects the page to be unmapped.  A sample stack is:
>
>page dumped because: VM_BUG_ON_PAGE(page_mapped(page))
>kernel BUG at mm/filemap.c:169!
>...
>RIP: 0010:unaccount_page_cache_page+0x1b8/0x200
>...
>Call Trace:
>__delete_from_page_cache+0x39/0x220
>delete_from_page_cache+0x45/0x70
>remove_inode_hugepages+0x13c/0x380
>? __add_to_page_cache_locked+0x162/0x380
>hugetlbfs_fallocate+0x403/0x540
>? _cond_resched+0x15/0x30
>? __inode_security_revalidate+0x5d/0x70
>? selinux_file_permission+0x100/0x130
>vfs_fallocate+0x13f/0x270
>ksys_fallocate+0x3c/0x80
>__x64_sys_fallocate+0x1a/0x20
>do_syscall_64+0x5b/0x180
>entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>There seems to be another potential COW issue/race with this approach
>of different private and shared keys as noted in commit 8382d914ebf7
>("mm, hugetlb: improve page-fault scalability").
>
>Since every hugetlb mapping (even anon and private) is actually a file
>mapping, just use the address_space index key for all mappings.  This
>results in potentially more hash collisions.  However, this should not
>be the common case.

This is fair enough as most mappings will be shared anyway (it would be
lovely to have some machinery to measure collisions in kernel hash tables,
in general).

>Fixes: b5cec28d36f5 ("hugetlbfs: truncate_hugepages() takes a range of pages")

Ok the issue was introduced after we had the mutex table.

>Cc: <stable@vger.kernel.org>

Thanks for the details, I'm definitely seeing the idx mismatch issue now.

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
