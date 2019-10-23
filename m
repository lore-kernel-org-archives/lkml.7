Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1125DCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DBD20650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404626AbfJWLDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:03:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:34178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390486AbfJWLDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:03:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4F88ACFA;
        Wed, 23 Oct 2019 11:03:36 +0000 (UTC)
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
To:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20190904205522.GA9871@redhat.com>
 <alpine.DEB.2.21.1909051400380.217933@chino.kir.corp.google.com>
 <20190909193020.GD2063@dhcp22.suse.cz>
 <20190925070817.GH23050@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com>
 <20190927074803.GB26848@dhcp22.suse.cz>
 <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com>
 <20190930112817.GC15942@dhcp22.suse.cz>
 <20191001054343.GA15624@dhcp22.suse.cz>
 <20191001083743.GC15624@dhcp22.suse.cz>
 <20191018141550.GS5017@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <53c4a6ca-a4d0-0862-8744-f999b17d82d8@suse.cz>
Date:   Wed, 23 Oct 2019 13:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191018141550.GS5017@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/19 4:15 PM, Michal Hocko wrote:
> It's been some time since I've posted these results. The hugetlb issue
> got resolved but I would still like to hear back about these findings
> because they suggest that the current bail out strategy doesn't seem
> to produce very good results. Essentially it doesn't really help THP
> locality (on moderately filled up nodes) and it introduces a strong
> dependency on kswapd which is not a source of the high order pages.
> Also the overral THP success rate is decreased on a pretty standard "RAM
> is used for page cache" workload.
> 
> That makes me think that the only possible workload that might really
> benefit from this heuristic is a THP demanding one on a heavily
> fragmented node with a lot of free memory while other nodes are not
> fragmented and have quite a lot of free memory. If that is the case, is
> this something to optimize for?
> 
> I am keeping all the results for the reference in a condensed form
> 
> On Tue 01-10-19 10:37:43, Michal Hocko wrote:
>> I have split out my kvm machine into two nodes to get at least some
>> idea how these patches behave
>> $ numactl -H
>> available: 2 nodes (0-1)
>> node 0 cpus: 0 2
>> node 0 size: 475 MB
>> node 0 free: 432 MB
>> node 1 cpus: 1 3
>> node 1 size: 503 MB
>> node 1 free: 458 MB
>>
>> First run with 5.3 and without THP
>> $ echo never > /sys/kernel/mm/transparent_hugepage/enabled
>> root@test1:~# sh thp_test.sh 
>> 7f4bdefec000 prefer:1 anon=102400 dirty=102400 active=86115 N0=41963 N1=60437 kernelpagesize_kB=4
>> 7fd0f248b000 prefer:1 anon=102400 dirty=102400 active=86909 N0=40079 N1=62321 kernelpagesize_kB=4
>> 7f2a69fc3000 prefer:1 anon=102400 dirty=102400 active=85244 N0=44455 N1=57945 kernelpagesize_kB=4
>>
>> So we get around 56-60% pages to the preferred node
>>
>> Now let's enable THPs
>> AnonHugePages:    407552 kB
>> 7f05c6dee000 prefer:1 anon=102400 dirty=102400 active=52718 N0=50688 N1=51712 kernelpagesize_kB=4
>> Few more runs
>> AnonHugePages:    407552 kB
>> 7effca1b9000 prefer:1 anon=102400 dirty=102400 active=65977 N0=53760 N1=48640 kernelpagesize_kB=4
>> AnonHugePages:    407552 kB
>> 7f474bfc4000 prefer:1 anon=102400 dirty=102400 active=52676 N0=8704 N1=93696 kernelpagesize_kB=4
>>
>> The utilization is again almost 100% and the preferred node usage
>> varied a lot between 47-91%.
>>
>> Now with 5.3 + all 4 patches this time:
>> AnonHugePages:    401408 kB
>> 7f8114ab4000 prefer:1 anon=102400 dirty=102400 active=51892 N0=3072 N1=99328 kernelpagesize_kB=4
>> AnonHugePages:    376832 kB
>> 7f37a1404000 prefer:1 anon=102400 dirty=102400 active=55204 N0=23153 N1=79247 kernelpagesize_kB=4
>> AnonHugePages:    372736 kB
>> 7f4abe4af000 prefer:1 anon=102400 dirty=102400 active=52399 N0=23646 N1=78754 kernelpagesize_kB=4
>>
>> The THP utilization varies again and the locality is higher in average
>> 76+%.  Which is even higher than the base page case. I was really

I tried to reproduce your setup locally, and got this for THP case
on 5.4-rc4:

AnonHugePages:    395264 kB
7fdc4a2c0000 prefer:1 anon=102400 dirty=102400 N0=48852 N1=53548 kernelpagesize_kB=4
AnonHugePages:    401408 kB
7f27167e2000 prefer:1 anon=102400 dirty=102400 N0=40095 N1=62305 kernelpagesize_kB=4
AnonHugePages:    378880 kB
7ff693ff9000 prefer:1 anon=102400 dirty=102400 N0=58061 N1=44339 kernelpagesize_kB=4

Somewhat better THP utilization and worse node locality than you.

Then I applied a rebased patch that I proposed before (see below):

AnonHugePages:    407552 kB
7f33fa83a000 prefer:1 anon=102400 dirty=102400 N0=28672 N1=73728 kernelpagesize_kB=4
AnonHugePages:    407552 kB
7faac0aa9000 prefer:1 anon=102400 dirty=102400 N0=48869 N1=53531 kernelpagesize_kB=4
AnonHugePages:    407552 kB
7f9f32c57000 prefer:1 anon=102400 dirty=102400 N0=49664 N1=52736 kernelpagesize_kB=4

The THP utilization is now back at 100% as 5.3 (modulo mis-alignment of
the mem_eater area). This is expected, as the second try that's not limited
to __GFP_THISNODE is also not limited by the newly introduced (in 5.4) heuristics 
that checks COMPACT_SKIPPED. Locality seems similar, can't make any
conclusions with such variation and so few tries.
Could you try confirming that as well? Thanks. But I agree the test is
limited and probably depends on timing wrt kswapd making progress.

----8<----
From 8bd960e4e8e7e99fe13baf0d00b61910b3ae8d23 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 1 Oct 2019 14:20:58 +0200
Subject: [PATCH] mm, thp: tweak reclaim/compaction effort of local-only and
 all-node allocations

THP page faults now attempt a __GFP_THISNODE allocation first, which should
only compact existing free memory, followed by another attempt that can
allocate from any node using reclaim/compaction effort specified by global
defrag setting and madvise.

This patch makes the following changes to the scheme:

- before the patch, the first allocation relies on a check for pageblock order
  and __GFP_IO to prevent excessive reclaim. This however affects also the
  second attempt, which is not limited to single node. Instead of that, reuse
  the existing check for costly order __GFP_NORETRY allocations, and make sure
  the first THP attempt uses __GFP_NORETRY. As a side-effect, all costly order
  __GFP_NORETRY allocations will bail out if compaction needs reclaim, while
  previously they only bailed out when compaction was deferred due to previous
  failures. This should be still acceptable within the __GFP_NORETRY semantics.

- before the patch, the second allocation attempt (on all nodes) was passing
  __GFP_NORETRY. This is redundant as the check for pageblock order (discussed
  above) was stronger. It's also contrary to madvise(MADV_HUGEPAGE) which means
  some effort to allocate THP is requested. After this patch, the second
  attempt doesn't pass __GFP_THISNODE nor __GFP_NORETRY.

To sum up, THP page faults now try the following attempt:

1. local node only THP allocation with no reclaim, just compaction.
2. THP allocation from any node with effort determined by global defrag setting
   and VMA madvise
3. fallback to base pages on any node

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mempolicy.c  | 16 +++++++++-------
 mm/page_alloc.c | 24 +++++-------------------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4ae967bcf954..2c48146f3ee2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2129,18 +2129,20 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		nmask = policy_nodemask(gfp, pol);
 		if (!nmask || node_isset(hpage_node, *nmask)) {
 			mpol_cond_put(pol);
+			/*
+			 * First, try to allocate THP only on local node, but
+			 * don't reclaim unnecessarily, just compact.
+			 */
 			page = __alloc_pages_node(hpage_node,
-						gfp | __GFP_THISNODE, order);
+				gfp | __GFP_THISNODE | __GFP_NORETRY, order);
 
 			/*
-			 * If hugepage allocations are configured to always
-			 * synchronous compact or the vma has been madvised
-			 * to prefer hugepage backing, retry allowing remote
-			 * memory as well.
+			 * If that fails, allow both compaction and reclaim,
+			 * but on all nodes.
 			 */
-			if (!page && (gfp & __GFP_DIRECT_RECLAIM))
+			if (!page)
 				page = __alloc_pages_node(hpage_node,
-						gfp | __GFP_NORETRY, order);
+								gfp, order);
 
 			goto out;
 		}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ecc3dbad606b..36d7d852f7b1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4473,8 +4473,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		if (page)
 			goto got_pg;
 
-		 if (order >= pageblock_order && (gfp_mask & __GFP_IO) &&
-		     !(gfp_mask & __GFP_RETRY_MAYFAIL)) {
+		/*
+		 * Checks for costly allocations with __GFP_NORETRY, which
+		 * includes some THP page fault allocations
+		 */
+		if (costly_order && (gfp_mask & __GFP_NORETRY)) {
 			/*
 			 * If allocating entire pageblock(s) and compaction
 			 * failed because all zones are below low watermarks
@@ -4495,23 +4498,6 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 			if (compact_result == COMPACT_SKIPPED ||
 			    compact_result == COMPACT_DEFERRED)
 				goto nopage;
-		}
-
-		/*
-		 * Checks for costly allocations with __GFP_NORETRY, which
-		 * includes THP page fault allocations
-		 */
-		if (costly_order && (gfp_mask & __GFP_NORETRY)) {
-			/*
-			 * If compaction is deferred for high-order allocations,
-			 * it is because sync compaction recently failed. If
-			 * this is the case and the caller requested a THP
-			 * allocation, we do not want to heavily disrupt the
-			 * system, so we fail the allocation instead of entering
-			 * direct reclaim.
-			 */
-			if (compact_result == COMPACT_DEFERRED)
-				goto nopage;
 
 			/*
 			 * Looks like reclaim/compaction is worth trying, but
-- 
2.23.0

