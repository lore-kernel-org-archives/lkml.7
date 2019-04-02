Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33549C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F380B20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbfDBNmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:42:13 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43734 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731543AbfDBNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:12 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe4-0002oP-6Y; Tue, 02 Apr 2019 14:40:08 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdy-0004xh-01; Tue, 02 Apr 2019 14:40:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David Hildenbrand" <david@redhat.com>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Oscar Salvador" <osalvador@suse.com>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.577740229@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 90/99] hwpoison, memory_hotplug: allow hwpoisoned
 pages to be offlined
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

commit b15c87263a69272423771118c653e9a1d0672caa upstream.

We have received a bug report that an injected MCE about faulty memory
prevents memory offline to succeed on 4.4 base kernel.  The underlying
reason was that the HWPoison page has an elevated reference count and the
migration keeps failing.  There are two problems with that.  First of all
it is dubious to migrate the poisoned page because we know that accessing
that memory is possible to fail.  Secondly it doesn't make any sense to
migrate a potentially broken content and preserve the memory corruption
over to a new location.

Oscar has found out that 4.4 and the current upstream kernels behave
slightly differently with his simply testcase

===

int main(void)
{
        int ret;
        int i;
        int fd;
        char *array = malloc(4096);
        char *array_locked = malloc(4096);

        fd = open("/tmp/data", O_RDONLY);
        read(fd, array, 4095);

        for (i = 0; i < 4096; i++)
                array_locked[i] = 'd';

        ret = mlock((void *)PAGE_ALIGN((unsigned long)array_locked), sizeof(array_locked));
        if (ret)
                perror("mlock");

        sleep (20);

        ret = madvise((void *)PAGE_ALIGN((unsigned long)array_locked), 4096, MADV_HWPOISON);
        if (ret)
                perror("madvise");

        for (i = 0; i < 4096; i++)
                array_locked[i] = 'd';

        return 0;
}
===

+ offline this memory.

In 4.4 kernels he saw the hwpoisoned page to be returned back to the LRU
list
kernel:  [<ffffffff81019ac9>] dump_trace+0x59/0x340
kernel:  [<ffffffff81019e9a>] show_stack_log_lvl+0xea/0x170
kernel:  [<ffffffff8101ac71>] show_stack+0x21/0x40
kernel:  [<ffffffff8132bb90>] dump_stack+0x5c/0x7c
kernel:  [<ffffffff810815a1>] warn_slowpath_common+0x81/0xb0
kernel:  [<ffffffff811a275c>] __pagevec_lru_add_fn+0x14c/0x160
kernel:  [<ffffffff811a2eed>] pagevec_lru_move_fn+0xad/0x100
kernel:  [<ffffffff811a334c>] __lru_cache_add+0x6c/0xb0
kernel:  [<ffffffff81195236>] add_to_page_cache_lru+0x46/0x70
kernel:  [<ffffffffa02b4373>] extent_readpages+0xc3/0x1a0 [btrfs]
kernel:  [<ffffffff811a16d7>] __do_page_cache_readahead+0x177/0x200
kernel:  [<ffffffff811a18c8>] ondemand_readahead+0x168/0x2a0
kernel:  [<ffffffff8119673f>] generic_file_read_iter+0x41f/0x660
kernel:  [<ffffffff8120e50d>] __vfs_read+0xcd/0x140
kernel:  [<ffffffff8120e9ea>] vfs_read+0x7a/0x120
kernel:  [<ffffffff8121404b>] kernel_read+0x3b/0x50
kernel:  [<ffffffff81215c80>] do_execveat_common.isra.29+0x490/0x6f0
kernel:  [<ffffffff81215f08>] do_execve+0x28/0x30
kernel:  [<ffffffff81095ddb>] call_usermodehelper_exec_async+0xfb/0x130
kernel:  [<ffffffff8161c045>] ret_from_fork+0x55/0x80

And that latter confuses the hotremove path because an LRU page is
attempted to be migrated and that fails due to an elevated reference
count.  It is quite possible that the reuse of the HWPoisoned page is some
kind of fixed race condition but I am not really sure about that.

With the upstream kernel the failure is slightly different.  The page
doesn't seem to have LRU bit set but isolate_movable_page simply fails and
do_migrate_range simply puts all the isolated pages back to LRU and
therefore no progress is made and scan_movable_pages finds same set of
pages over and over again.

Fix both cases by explicitly checking HWPoisoned pages before we even try
to get reference on the page, try to unmap it if it is still mapped.  As
explained by Naoya:

: Hwpoison code never unmapped those for no big reason because
: Ksm pages never dominate memory, so we simply didn't have strong
: motivation to save the pages.

Also put WARN_ON(PageLRU) in case there is a race and we can hit LRU
HWPoison pages which shouldn't happen but I couldn't convince myself about
that.  Naoya has noted the following:

: Theoretically no such gurantee, because try_to_unmap() doesn't have a
: guarantee of success and then memory_failure() returns immediately
: when hwpoison_user_mappings fails.
: Or the following code (comes after hwpoison_user_mappings block) also impli=
: es
: that the target page can still have PageLRU flag.
:
:         /*
:          * Torn down by someone else?
:          */
:         if (PageLRU(p) && !PageSwapCache(p) && p->mapping =3D=3D NULL) {
:                 action_result(pfn, MF_MSG_TRUNCATED_LRU, MF_IGNORED);
:                 res =3D -EBUSY;
:                 goto out;
:         }
:
: So I think it's OK to keep "if (WARN_ON(PageLRU(page)))" block in
: current version of your patch.

Link: http://lkml.kernel.org/r/20181206120135.14079-1-mhocko@kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Oscar Salvador <osalvador@suse.com>
Debugged-by: Oscar Salvador <osalvador@suse.com>
Tested-by: Oscar Salvador <osalvador@suse.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/memory_hotplug.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -32,6 +32,7 @@
 #include <linux/hugetlb.h>
 #include <linux/memblock.h>
 #include <linux/bootmem.h>
+#include <linux/rmap.h>
 
 #include <asm/tlbflush.h>
 
@@ -1393,6 +1394,21 @@ do_migrate_range(unsigned long start_pfn
 			continue;
 		}
 
+		/*
+		 * HWPoison pages have elevated reference counts so the migration would
+		 * fail on them. It also doesn't make any sense to migrate them in the
+		 * first place. Still try to unmap such a page in case it is still mapped
+		 * (e.g. current hwpoison implementation doesn't unmap KSM pages but keep
+		 * the unmap as the catch all safety net).
+		 */
+		if (PageHWPoison(page)) {
+			if (WARN_ON(PageLRU(page)))
+				isolate_lru_page(page);
+			if (page_mapped(page))
+				try_to_unmap(page, TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS);
+			continue;
+		}
+
 		if (!get_page_unless_zero(page))
 			continue;
 		/*

