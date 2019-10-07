Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE38C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3F421835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570434983;
	bh=tvh3aij0pQkggz49M8dnwAjKQ1loXb3d4tP0QNdBEmQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=D1l/m9GSSsn2TJChtjKAT+r7i5LJln1/2E28rbzGhXR0ucrn7Q6stDouwyHP6C+Fp
	 /sMX3m32u59QkNLfNrGPsm4Q70gUPh6mozfMCSgAeNZkDsIjuTJhA1lhmIN539Itu3
	 Xpr3kZ7anxaKBRhLWgWDCrLGcSSfPbpt1ncSq6Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfJGH4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 03:56:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35983 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfJGH4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 03:56:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id h2so11503339edn.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 00:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0tjelzRG35F/5Gai2v8Luw9ZVlOg6fVlANdh8tu9bww=;
        b=UB9Ty9i2WRWBab7Ww2yFnsCP5LNsDApB+hwT7XHt90i6APQIkK+4cU1wnnIeetah/d
         7szH+fuO+LCP6QHPkxrb/Va3t9VrQRLdx2Te3Tao4hHq9muS1HjU5HjvB/QVI1xVkNbf
         in7qzb1NkrsuhFvCBbWC4RhIWwQdbIFGebOheOypf6gQXSaKIvtEJyTraf68LcO6SbdD
         dCf0QGAhaI7jhfXldBRptXA0p8WzGH/u4eeUVR5HopacJMlXYbcpCyuFt17zz0FXOsbo
         LniSeAnicOATbvkj5Z6BwmXUAb/0jVSdJMq2sRR6bVcbFhgU5mBPHYkeJwbc9f3DTjLC
         JH3Q==
X-Gm-Message-State: APjAAAVKwpKamv3fHxL5I/3uZsjrtPPagCcC9XqJQdVn42j5/He+r4MC
        OqAWrYEMEbwnsOoDI0rDdzY=
X-Google-Smtp-Source: APXvYqwmcNNs5iKMHquWb4x1twV+ehVRh1QfIiji4ASsPTW3uMJ6qimeC3PZd8PVD6QiagO42OVRdg==
X-Received: by 2002:a50:b6c8:: with SMTP id f8mr27997836ede.33.1570434979680;
        Mon, 07 Oct 2019 00:56:19 -0700 (PDT)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id g19sm1733059eje.0.2019.10.07.00.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 00:56:18 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm, hugetlb: allow hugepage allocations to excessively reclaim
Date:   Mon,  7 Oct 2019 09:55:48 +0200
Message-Id: <20191007075548.12456-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Rientjes <rientjes@google.com>

b39d0ee2632d ("mm, page_alloc: avoid expensive reclaim when compaction
may not succeed") has chnaged the allocator to bail out from the
allocator early to prevent from a potentially excessive memory
reclaim. __GFP_RETRY_MAYFAIL is designed to retry the allocation,
reclaim and compaction loop as long as there is a reasonable chance to
make a forward progress. Neither COMPACT_SKIPPED nor COMPACT_DEFERRED
at the INIT_COMPACT_PRIORITY compaction attempt gives this feedback.

The most obvious affected subsystem is hugetlbfs which allocates huge
pages based on an admin request (or via admin configured overcommit).
I have done a simple test which tries to allocate half of the memory
for hugetlb pages while the memory is full of a clean page cache. This
is not an unusual situation because we try to cache as much of the
memory as possible and sysctl/sysfs interface to allocate huge pages is
there for flexibility to allocate hugetlb pages at any time.

System has 1GB of RAM and we are requesting 515MB worth of hugetlb pages
after the memory is prefilled by a clean page cache:
root@test1:~# cat hugetlb_test.sh

set -x
echo 0 > /proc/sys/vm/nr_hugepages
echo 3 > /proc/sys/vm/drop_caches
echo 1 > /proc/sys/vm/compact_memory
dd if=/mnt/data/file-1G of=/dev/null bs=$((4<<10))
TS=$(date +%s)
echo 256 > /proc/sys/vm/nr_hugepages
cat /proc/sys/vm/nr_hugepages

The results for 2 consecutive runs on clean 5.3
root@test1:~# sh hugetlb_test.sh
+ echo 0
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 21.0694 s, 51.0 MB/s
+ date +%s
+ TS=1569905284
+ echo 256
+ cat /proc/sys/vm/nr_hugepages
256
root@test1:~# sh hugetlb_test.sh
+ echo 0
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 21.7548 s, 49.4 MB/s
+ date +%s
+ TS=1569905311
+ echo 256
+ cat /proc/sys/vm/nr_hugepages
256

Now with b39d0ee2632d applied
root@test1:~# sh hugetlb_test.sh
+ echo 0
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 20.1815 s, 53.2 MB/s
+ date +%s
+ TS=1569905516
+ echo 256
+ cat /proc/sys/vm/nr_hugepages
11
root@test1:~# sh hugetlb_test.sh
+ echo 0
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 21.9485 s, 48.9 MB/s
+ date +%s
+ TS=1569905541
+ echo 256
+ cat /proc/sys/vm/nr_hugepages
12

The success rate went down by factor of 20!

Although hugetlb allocation requests might fail and it is reasonable to
expect them to under extremely fragmented memory or when the memory is
under a heavy pressure but the above situation is not that case.

Fix the regression by reverting back to the previous behavior for
__GFP_RETRY_MAYFAIL requests and disable the beail out heuristic for
those requests.

[mhocko@suse.com: reworded changelog]
Fixes: b39d0ee2632d ("mm, page_alloc: avoid expensive reclaim when compaction may not succeed")
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---

Hi,
this has been posted by David as an RFC [1]. David doesn't seem to
appreciate the level of regression so I have largely rewritten the
changelog to be more explicit. I haven't changed the patch itself
so I have preserved his s-o-b.

I would also like to emphasise that I am not overly happy about the
patch. Vlastimil has posted [2] an alternative solution which looks
better but it is also slightly more complex. We can do that in a follow
up though so let's go with the simplest hack^Wsolution for now.

[1] http://lkml.kernel.org/r/alpine.DEB.2.21.1910021556270.187014@chino.kir.corp.google.com
[2] http://lkml.kernel.org/r/20191001054343.GA15624@dhcp22.suse.cz

 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 15c2050c629b..01aa46acee76 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4467,12 +4467,14 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		if (page)
 			goto got_pg;
 
-		 if (order >= pageblock_order && (gfp_mask & __GFP_IO)) {
+		 if (order >= pageblock_order && (gfp_mask & __GFP_IO) &&
+		     !(gfp_mask & __GFP_RETRY_MAYFAIL)) {
 			/*
 			 * If allocating entire pageblock(s) and compaction
 			 * failed because all zones are below low watermarks
 			 * or is prohibited because it recently failed at this
-			 * order, fail immediately.
+			 * order, fail immediately unless the allocator has
+			 * requested compaction and reclaim retry.
 			 *
 			 * Reclaim is
 			 *  - potentially very expensive because zones are far
-- 
2.20.1

