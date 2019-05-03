Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C56C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AFD2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfECWbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 18:31:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfECWbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 18:31:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9338081F0C;
        Fri,  3 May 2019 22:31:47 +0000 (UTC)
Received: from ultra.random (ovpn-122-217.rdu2.redhat.com [10.10.122.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46E4160BFB;
        Fri,  3 May 2019 22:31:47 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] reapply: relax __GFP_THISNODE for MADV_HUGEPAGE mappings
Date:   Fri,  3 May 2019 18:31:44 -0400
Message-Id: <20190503223146.2312-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 03 May 2019 22:31:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The fixes for what was originally reported as "pathological THP
behavior" we rightfully reverted to be sure not to introduced
regressions at end of a merge window after a severe regression report
from the kernel bot. We can safely re-apply them now that we had time
to analyze the problem.

The mm process worked fine, because the good fixes were eventually
committed upstream without excessive delay.

The regression reported by the kernel bot however forced us to revert
the good fixes to be sure not to introduce regressions and to give us
the time to analyze the issue further. The silver lining is that this
extra time allowed to think more at this issue and also plan for a
future direction to improve things further in terms of THP NUMA
locality.

Thank you,
Andrea

Andrea Arcangeli (2):
  Revert "Revert "mm, thp: consolidate THP gfp handling into
    alloc_hugepage_direct_gfpmask""
  Revert "mm, thp: restore node-local hugepage allocations"

 include/linux/gfp.h       | 12 +++------
 include/linux/mempolicy.h |  2 ++
 mm/huge_memory.c          | 51 ++++++++++++++++++++++++---------------
 mm/mempolicy.c            | 34 +++-----------------------
 mm/shmem.c                |  2 +-
 5 files changed, 42 insertions(+), 59 deletions(-)

