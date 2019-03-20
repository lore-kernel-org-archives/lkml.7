Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB27DC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F392186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfCTP12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:27:28 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:53413 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfCTP10 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 20 Mar 2019 11:27:26 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 20 Mar 2019 16:27:23 +0100
Received: from d104.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Wed, 20 Mar 2019 15:27:04 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, david@redhat.com, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH resend 1/2] mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
Date:   Wed, 20 Mar 2019 16:26:57 +0100
Message-Id: <20190320152658.10855-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190320152658.10855-1-osalvador@suse.de>
References: <20190320152658.10855-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64, 1GB-hugetlb pages could never be offlined due to the fact
that hugepage_migration_supported() returned false for PUD_SHIFT.
So whenever we wanted to offline a memblock containing a gigantic
hugetlb page, we never got beyond has_unmovable_pages() check.
This changed with [1], where now we also return true for PUD_SHIFT.

After that patch, the check in has_unmovable_pages() and scan_movable_pages()
returned true, but we still had a final barrier in do_migrate_range():

if (compound_order(head) > PFN_SECTION_SHIFT) {
	ret = -EBUSY;
	break;
}

This is not really nice, and we do not really need it.
It is perfectly possible to migrate a gigantic page as long as another node has
a spare gigantic page for us.
In alloc_huge_page_nodemask(), we calculate the __real__ number of free pages,
and if any, we try to dequeue one from another node.

This all works fine when we do have another node with a spare gigantic page,
but if that is not the case, alloc_huge_page_nodemask() ends up calling
alloc_migrate_huge_page() which bails out if the wanted page is gigantic.
That is mainly because finding a 1GB (or even 16GB on powerpc) contiguous
memory is quite unlikely when the system has been running for a while.

In that situation, we will keep looping forever because scan_movable_pages()
will give us the same page and we will fail again because there is no node
where we can dequeue a gigantic page from.
This is not nice, and it has been raised that we might want to treat -ENOMEM
as a fatal error in do_migrate_range(), but this has to be checked further.

Anyway, I would tend say that this is the administrator's job, to make sure
that the system can keep up with the memory to be offlined, so that would mean
that if we want to use gigantic pages, make sure that the other nodes have at
least enough gigantic pages to keep up in case we need to offline memory.

Just for the sake of completeness, this is one of the tests done:

 # echo 1 > /sys/devices/system/node/node1/hugepages/hugepages-1048576kB/nr_hugepages
 # echo 1 > /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/nr_hugepages

 # cat /sys/devices/system/node/node1/hugepages/hugepages-1048576kB/nr_hugepages
   1
 # cat /sys/devices/system/node/node1/hugepages/hugepages-1048576kB/free_hugepages
   1

 # cat /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/nr_hugepages
   1
 # cat /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/free_hugepages
   1

 (hugetlb1gb is a program that maps 1GB region using MAP_HUGE_1GB)

 # numactl -m 1 ./hugetlb1gb
 # cat /sys/devices/system/node/node1/hugepages/hugepages-1048576kB/free_hugepages
   0
 # cat /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/free_hugepages
   1

 # offline node1 memory
 # cat /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/free_hugepages
   0

[1] https://lore.kernel.org/patchwork/patch/998796/

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f767582af4f8..02283732544e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1381,10 +1381,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 
 		if (PageHuge(page)) {
 			struct page *head = compound_head(page);
-			if (compound_order(head) > PFN_SECTION_SHIFT) {
-				ret = -EBUSY;
-				break;
-			}
 			pfn = page_to_pfn(head) + (1<<compound_order(head)) - 1;
 			isolate_huge_page(head, &source);
 			continue;
-- 
2.13.7

