Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BE2C3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3E422CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="or+awGJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfIDTy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 15:54:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46093 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730376AbfIDTyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:54:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so6114862pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=B3LdhXMejYHV96KWaOzQTiZ+Z/f85k5LioNA2CuFGwA=;
        b=or+awGJWRmLily/ifY9QIoKC+CGZd1JKGA2tLCtcVC/VmH4wwudR9egRn8R/ycC2MU
         QkEVmujb1Mk/MjJsZ531+o2qQ7k16VC23z6324ylW7RJXfjvi0O5g2i8K9SXerUQbgNO
         Q6NSmTB/AoABUH0mdkvgh56M3vvjfBldKCTDhb6r8Ry9sSh/SoJW+jWVTaFD3s8cE7fe
         ohOxMT9Cth1jYnIPeErV+9BC+nAc3qlv9HzDPUcw3x/Wwi54C0UG/xZGaIFTFZBuEquM
         B3NRWQjdcMOUp7g/Fb0s6sxmlmLcFoSw/s92qJLDjewgM3DS2Ds0XUVoYF5VnX0+1+IS
         cONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=B3LdhXMejYHV96KWaOzQTiZ+Z/f85k5LioNA2CuFGwA=;
        b=SUg/UyzsprHZ75fQiGPJ2OX5/iUuMHE1kHqQnEWfzkEU1ucQMV8AGF29cELH4musNC
         C6Fro5FRXVNmBtm15hwPHfkXTQFOjqgWD8BYOVwq6++crDcWq1r4c4DNBN6857/BlU2B
         ytw+kg4vNRJt+oN1+eMpslDADeyK8r/zodOHXGFQXkkWmfuxvSQ9fxyDQQ21y4Ln0WDb
         wu8gTyP3uOGfXInS77STQgSbYS/80FO91CrfcIq31bygEQMCTCeKw2ZtzYmzhAAtOPpI
         UqhCBy+gCXqpdYRwHwfGzKLD8T2BzOPczT1RkUdLkMsPt0cBLqai43nwLehVcxGWlmIu
         RxeQ==
X-Gm-Message-State: APjAAAVlnyzXFk4Vc+NYe2tnVMh0gbrKSwbFufyQSf3yhF0tf3dVa5oL
        UOhxu7AlX0zJEKrs8v+dpu0M2A==
X-Google-Smtp-Source: APXvYqx0L17qVqLK8UqgdtItnyAIhFPkS2AAz/mdKmDOlHp8/ioytZJL1xi4U489pRG9xu/gDl/18A==
X-Received: by 2002:a62:cd45:: with SMTP id o66mr49017925pfg.112.1567626864234;
        Wed, 04 Sep 2019 12:54:24 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c2sm3173938pjs.13.2019.09.04.12.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:54:23 -0700 (PDT)
Date:   Wed, 4 Sep 2019 12:54:22 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [rfc 3/4] mm, page_alloc: avoid expensive reclaim when compaction
 may not succeed
Message-ID: <alpine.DEB.2.21.1909041253390.94813@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory compaction has a couple significant drawbacks as the allocation
order increases, specifically:

 - isolate_freepages() is responsible for finding free pages to use as
   migration targets and is implemented as a linear scan of memory
   starting at the end of a zone,

 - failing order-0 watermark checks in memory compaction does not account
   for how far below the watermarks the zone actually is: to enable
   migration, there must be *some* free memory available.  Per the above,
   watermarks are not always suffficient if isolate_freepages() cannot
   find the free memory but it could require hundreds of MBs of reclaim to
   even reach this threshold (read: potentially very expensive reclaim with
   no indication compaction can be successful), and

 - if compaction at this order has failed recently so that it does not even
   run as a result of deferred compaction, looping through reclaim can often
   be pointless.

For hugepage allocations, these are quite substantial drawbacks because
these are very high order allocations (order-9 on x86) and falling back to
doing reclaim can potentially be *very* expensive without any indication
that compaction would even be successful.

Reclaim itself is unlikely to free entire pageblocks and certainly no
reliance should be put on it to do so in isolation (recall lumpy reclaim).
This means we should avoid reclaim and simply fail hugepage allocation if
compaction is deferred.

It is also not helpful to thrash a zone by doing excessive reclaim if
compaction may not be able to access that memory.  If order-0 watermarks
fail and the allocation order is sufficiently large, it is likely better
to fail the allocation rather than thrashing the zone.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/page_alloc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4458,6 +4458,28 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		if (page)
 			goto got_pg;
 
+		 if (order >= pageblock_order && (gfp_mask & __GFP_IO)) {
+			/*
+			 * If allocating entire pageblock(s) and compaction
+			 * failed because all zones are below low watermarks
+			 * or is prohibited because it recently failed at this
+			 * order, fail immediately.
+			 *
+			 * Reclaim is
+			 *  - potentially very expensive because zones are far
+			 *    below their low watermarks or this is part of very
+			 *    bursty high order allocations,
+			 *  - not guaranteed to help because isolate_freepages()
+			 *    may not iterate over freed pages as part of its
+			 *    linear scan, and
+			 *  - unlikely to make entire pageblocks free on its
+			 *    own.
+			 */
+			if (compact_result == COMPACT_SKIPPED ||
+			    compact_result == COMPACT_DEFERRED)
+				goto nopage;
+		}
+
 		/*
 		 * Checks for costly allocations with __GFP_NORETRY, which
 		 * includes THP page fault allocations
