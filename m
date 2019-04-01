Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CC3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D6020830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140373;
	bh=QlinmCr1rDs33ojeH/oVCrGs4lWcvwW4ykcVfd/ILDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cpYfHdhoiT1nawr1OkQT5UoHVmjvjQIcO69lit5vvsZQG9LvoOlZ5ldMJ/qQDYbbl
	 drayux4c08aGqcN+WQJe2ggy/10ENkWcmMKl/uGJEQNGOjPYaZwz6gKH3EcejsMBA6
	 iJ4CbLO5GXlbWs8f+lPr/cW+rdiZbEsrXXyYhKIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbfDARjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:39:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388089AbfDARja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:39:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B14EF20857;
        Mon,  1 Apr 2019 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140369;
        bh=QlinmCr1rDs33ojeH/oVCrGs4lWcvwW4ykcVfd/ILDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okDFAmihEJ//IYprAIOYeOgDXS3D0yP8TfeA5Gcr8GTVUrEii5CJXS3udXMHMUQ4n
         bJLPpawqSBVzF/jrjVG2VhwJQ7DlMnvCk57QIWr2unWT0RSHUHLFokEmaD5EyJh1bC
         n+Zgw0Wfs20hcvElk4m3pE2/LxW8Jhdg3khBamjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>,
        Matt Wagantall <mattw@codeaurora.org>,
        Syed Rameez Mustafa <rameezmustafa@codeaurora.org>,
        Osvaldo Banuelos <osvaldob@codeaurora.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 15/50] staging: ashmem: Avoid deadlock with mmap/shrink
Date:   Mon,  1 Apr 2019 19:02:58 +0200
Message-Id: <20190401170042.880174233@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 18e77054de741ef3ed2a2489bc9bf82a318b2d5e ]

Both ashmem_mmap and ashmem_shrink take the ashmem_lock. It may
be possible for ashmem_mmap to invoke ashmem_shrink:

-000|mutex_lock(lock = 0x0)
-001|ashmem_shrink(?, sc = 0x0) <--- try to take ashmem_mutex again
-002|shrink_slab(shrink = 0xDA5F1CC0, nr_pages_scanned = 0, lru_pages
-002|=
-002|124)
-003|try_to_free_pages(zonelist = 0x0, ?, ?, ?)
-004|__alloc_pages_nodemask(gfp_mask = 21200, order = 1, zonelist =
-004|0xC11D0940,
-005|new_slab(s = 0xE4841E80, ?, node = -1)
-006|__slab_alloc.isra.43.constprop.50(s = 0xE4841E80, gfpflags =
-006|2148925462, ad
-007|kmem_cache_alloc(s = 0xE4841E80, gfpflags = 208)
-008|shmem_alloc_inode(?)
-009|alloc_inode(sb = 0xE480E800)
-010|new_inode_pseudo(?)
-011|new_inode(?)
-012|shmem_get_inode(sb = 0xE480E800, dir = 0x0, ?, dev = 0, flags =
-012|187)
-013|shmem_file_setup(?, ?, flags = 187)
-014|ashmem_mmap(?, vma = 0xC5D64210) <---- Acquire ashmem_mutex
-015|mmap_region(file = 0xDF8E2C00, addr = 1772974080, len = 233472,
-015|flags = 57,
-016|sys_mmap_pgoff(addr = 0, len = 230400, prot = 3, flags = 1, fd =
-016|157, pgoff
-017|ret_fast_syscall(asm)
-->|exception
-018|NUR:0x40097508(asm)
---|end of frame

Avoid this deadlock by using mutex_trylock in ashmem_shrink; if the mutex
is already held, do not attempt to shrink.

Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Android Kernel Team <kernel-team@android.com>
Reported-by: Matt Wagantall <mattw@codeaurora.org>
Reported-by: Syed Rameez Mustafa <rameezmustafa@codeaurora.org>
Reported-by: Osvaldo Banuelos <osvaldob@codeaurora.org>
Reported-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
[jstultz: Minor commit message tweaks]
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/android/ashmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 22ddd4ce9dd6..5105fe5e6533 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -447,7 +447,9 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	if (!(sc->gfp_mask & __GFP_FS))
 		return SHRINK_STOP;
 
-	mutex_lock(&ashmem_mutex);
+	if (!mutex_trylock(&ashmem_mutex))
+		return -1;
+
 	list_for_each_entry_safe(range, next, &ashmem_lru_list, lru) {
 		loff_t start = range->pgstart * PAGE_SIZE;
 		loff_t end = (range->pgend + 1) * PAGE_SIZE;
-- 
2.19.1



