Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D8FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E61420881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfEOPLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:11:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:36678 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfEOPLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:11:48 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hQvYr-0001X3-3M; Wed, 15 May 2019 18:11:17 +0300
Content-Transfer-Encoding: 7bit
Subject: [PATCH RFC 0/5] mm: process_vm_mmap() -- syscall for duplication a
 process mapping
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        ktkhai@virtuozzo.com, mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, pasha.tatashin@oracle.com,
        alexander.h.duyck@linux.intel.com, ira.weiny@intel.com,
        andreyknvl@google.com, arunks@codeaurora.org, vbabka@suse.cz,
        cl@linux.com, riel@surriel.com, keescook@chromium.org,
        hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 15 May 2019 18:11:15 +0300
Message-ID: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a new syscall, which makes possible
to clone a mapping from a process to another process.
The syscall supplements the functionality provided
by process_vm_writev() and process_vm_readv() syscalls,
and it may be useful in many situation.

For example, it allows to make a zero copy of data,
when process_vm_writev() was previously used:

	struct iovec local_iov, remote_iov;
	void *buf;

	buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
		   MAP_PRIVATE|MAP_ANONYMOUS, ...);
	recv(sock, buf, n * PAGE_SIZE, 0);

	local_iov->iov_base = buf;
	local_iov->iov_len = n * PAGE_SIZE;
	remove_iov = ...;

	process_vm_writev(pid, &local_iov, 1, &remote_iov, 1 0);
	munmap(buf, n * PAGE_SIZE);

	(Note, that above completely ignores error handling)

There are several problems with process_vm_writev() in this example:

1)it causes pagefault on remote process memory, and it forces
  allocation of a new page (if was not preallocated);

2)amount of memory for this example is doubled in a moment --
  n pages in current and n pages in remote tasks are occupied
  at the same time;

3)received data has no a chance to be properly swapped for
  a long time.

The third is the most critical in case of remote process touches
the data pages some time after process_vm_writev() was made.
Imagine, node is under memory pressure:

a)kernel moves @buf pages into swap right after recv();
b)process_vm_writev() reads the data back from swap to pages;
c)process_vm_writev() allocates duplicate pages in remote
  process and populates them;
d)munmap() unmaps @buf;
e)5 minutes later remote task touches data.

In stages "a" and "b" kernel submits unneeded IO and makes
system IO throughput worse. To make "b" and "c", kernel
reclaims memory, and moves pages of some other processes
to swap, so they have to read pages from swap back. Also,
unneeded copying of pages is occured, while zero-copy is
more preferred.

We observe similar problem during online migration of big enough
containers, when after doubling of container's size, the time
increases 100 times. The system resides under high IO and
throwing out of useful cashes.

The proposed syscall aims to introduce an interface, which
supplements currently existing process_vm_writev() and
process_vm_readv(), and allows to solve the problem with
anonymous memory transfer. The above example may be rewritten as:

	void *buf;

	buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
		   MAP_PRIVATE|MAP_ANONYMOUS, ...);
	recv(sock, buf, n * PAGE_SIZE, 0);

	/* Sign of @pid is direction: "from @pid task to current" or vice versa. */
	process_vm_mmap(-pid, buf, n * PAGE_SIZE, remote_addr, PVMMAP_FIXED);
	munmap(buf, n * PAGE_SIZE);

It is swap-friendly: in case of memory is swapped right after recv(),
the syscall just copies pagetable entries like we do on fork(),
so real access to pages does not occurs, and no IO is needed.
No excess pages are reclaimed, and number of pages is not doubled.
Also, zero-copy takes a place, and this also reduces overhead.

The patchset does not introduce much new code, since we simply
reuse existing copy_page_range() and copy_vma() functions.
We extend copy_vma() to be able merge VMAs in remote task [2/5],
and teach copy_page_range() to work with different local and
remote addresses [3/5]. Patch [5/5] introduces the syscall logic,
which mostly consists of sanity checks. The rest of patches
are preparations.

This syscall may be used for page servers like in example
above, for migration (I assume, even virtual machines may
want something like this), for zero-copy desiring users
of process_vm_writev() and process_vm_readv(), for debug
purposes, etc. It requires the same permittions like
existing proc_vm_xxx() syscalls have.

The tests I used may be obtained here:

[1]https://gist.github.com/tkhai/198d32fdc001ec7812a5e1ccf091f275
[2]https://gist.github.com/tkhai/f52dbaeedad5a699f3fb386fda676562

---

Kirill Tkhai (5):
      mm: Add process_vm_mmap() syscall declaration
      mm: Extend copy_vma()
      mm: Extend copy_page_range()
      mm: Export round_hint_to_min()
      mm: Add process_vm_mmap()


 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    2 
 include/linux/huge_mm.h                |    6 +
 include/linux/mm.h                     |   11 ++
 include/linux/mm_types.h               |    2 
 include/linux/mman.h                   |   14 +++
 include/linux/syscalls.h               |    5 +
 include/uapi/asm-generic/mman-common.h |    5 +
 include/uapi/asm-generic/unistd.h      |    5 +
 init/Kconfig                           |    9 +-
 kernel/fork.c                          |    5 +
 kernel/sys_ni.c                        |    2 
 mm/huge_memory.c                       |   30 ++++--
 mm/memory.c                            |  165 +++++++++++++++++++++-----------
 mm/mmap.c                              |  154 ++++++++++++++++++++++++++----
 mm/mremap.c                            |    4 -
 mm/process_vm_access.c                 |   71 ++++++++++++++
 17 files changed, 392 insertions(+), 99 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
