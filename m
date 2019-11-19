Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51083C43141
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294A22230E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574155613;
	bh=6pJAHvS/vr09/agJP71ir2SyOeCxfUSjUCG+MgWwCzA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qAQX0OmCVKy2jdgHwcrWiKfwRYCqRe5AonOaLpbXaCmZxRxirgv8k6QIfFS88ytao
	 RIUn93TxYytteeunkXosHAluYLWdYgDpGhQ+LGVJwyqFzhjUKGmu5guI7NKSIoTn+b
	 2YuNw2x5J+DkcCYNQILf3i+oD/WIoVVHoTJYiGyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfKSJ0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:26:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39195 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfKSJ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:26:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id t26so2626062wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 01:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+2OHFpC0q55v8InPSssCQHOt0deRDCWxkFPtuptQPU=;
        b=Xo9k8qxwJ8CemHuMuK5jKw02L9dHGRWwbE01ns3jLPKrYSennEoz1DuC/OiLrDD/On
         Vyjaxqag0CEjttU0pXqTRRCxVtGLJeyurWMAvinB0D5PH1Petu3VI8NCz6u/KanqwTc+
         J5hI7wqZUlpVAJTwErKz7jNhF7uzmW6l0BQiumtJdmsgwPXtg7a76dXXc3S0SwHzm3rX
         pEfma9eg2TxNMFCh7aTIuYxuTRoabrSr3sv4+hLg4M2280ObC738Xbi+eqcE1JGGtZi0
         b8j+dwfF4QlSx/pPzIs6bOOqpc9/KXz7Pvx9PiaLiqlZjENzG3Ui4m6l8L+ixluYi2Cl
         XxeA==
X-Gm-Message-State: APjAAAUOe+NIMXvpP55xP/WmzRV61qbXmk5daD9n+xVWOWw+XNM8l9Ni
        HOA5A+geQYP95DNCWM50j68=
X-Google-Smtp-Source: APXvYqy1wQcmGCsaSRfc1zaf+MRHK4ds374WMhyJbp+jps3aovj80g9aPVmycHMKppG3CGpTvkm36Q==
X-Received: by 2002:a7b:cbd9:: with SMTP id n25mr4583498wmi.64.1574155609894;
        Tue, 19 Nov 2019 01:26:49 -0800 (PST)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id c15sm26392622wrx.78.2019.11.19.01.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 01:26:48 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Oscar Salvador <OSalvador@suse.com>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm, sparse: do not waste pre allocated memmap space
Date:   Tue, 19 Nov 2019 10:26:42 +0100
Message-Id: <20191119092642.31799-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Vincent has noticed [1] that there is something unusual with the memmap
allocations going on on his platform
: I noticed this because on my ARM64 platform, with 1 GiB of memory the
: first [and only] section is allocated from the zeroing path while with
: 2 GiB of memory the first 1 GiB section is allocated from the
: non-zeroing path.

The underlying problem is that although sparse_buffer_init allocates enough
memory for all sections on the node sparse_buffer_alloc is not able to
consume them due to mismatch in the expected allocation alignement.
While sparse_buffer_init preallocation uses the PAGE_SIZE alignment the
real memmap has to be aligned to section_map_size() this results in a
wasted initial chunk of the preallocated memmap and unnecessary fallback
allocation for a section.

While we are at it also change __populate_section_memmap to align to the
requested size because at least VMEMMAP has constrains to have memmap
properly aligned.

[1] http://lkml.kernel.org/r/20191030131122.8256-1-vincent.whitchurch@axis.com
Reported-and-debugged-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Fixes: 35fd1eb1e821 ("mm/sparse: abstract sparse buffer allocations")
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/sparse.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index f6891c1992b1..079f3e3c4cab 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -458,8 +458,7 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
 	if (map)
 		return map;
 
-	map = memblock_alloc_try_nid(size,
-					  PAGE_SIZE, addr,
+	map = memblock_alloc_try_nid(size, size, addr,
 					  MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	if (!map)
 		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%pa\n",
@@ -482,8 +481,13 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 {
 	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
 	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
+	/*
+	 * Pre-allocated buffer is mainly used by __populate_section_memmap
+	 * and we want it to be properly aligned to the section size - this is
+	 * especially the case for VMEMMAP which maps memmap to PMDs
+	 */
 	sparsemap_buf =
-		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
+		memblock_alloc_try_nid_raw(size, section_map_size(),
 						addr,
 						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	sparsemap_buf_end = sparsemap_buf + size;
-- 
2.20.1

