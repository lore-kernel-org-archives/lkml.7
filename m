Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3D0C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBB32072E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574401935;
	bh=/PKAD3AkTjyL9c8QHOk65inIyuVXFHetGmXfEQaBdZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xH1fmMYsANQM8QGPELPkD/BOpHsilrz3EIe1WOH+ggeYkKhtnC+VKg3Ck7cZxBeen
	 hInv+j9Lp8vNZ5ofjG6hKMHWZbMaaDs4JuG1PneG4CHQ9sXa2Cc7G1rrPvxg8dF4lh
	 inazAypmraMf+c5ZN5y3f4oad8xxvx3Sj3id2Djc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfKVFwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:52:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbfKVFwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:52:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20BE20721;
        Fri, 22 Nov 2019 05:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401929;
        bh=/PKAD3AkTjyL9c8QHOk65inIyuVXFHetGmXfEQaBdZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eh4Y/MZnnh2MimFV3TlPe+Cup/L4JvqYCsNhjbQFOiCZ6IF8yz2QJbb2b/c2RNlw2
         71t/OLKxnxH7rbvw9bdGMelERLssJZWDBsOdBTrz5YGahi+HLrlwFI9SMc4710H33X
         Ef5NLgtwiDrIukvxtYBkZlZYS5h6YUdm6WmPYlk8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wentao Wang <witallwang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.19 156/219] mm/page_alloc.c: deduplicate __memblock_free_early() and memblock_free()
Date:   Fri, 22 Nov 2019 00:48:08 -0500
Message-Id: <20191122054911.1750-149-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wentao Wang <witallwang@gmail.com>

[ Upstream commit d31cfe7bff9109476da92c245b56083e9b48d60a ]

Link: http://lkml.kernel.org/r/C8ECE1B7A767434691FEEFA3A01765D72AFB8E78@MX203CL03.corp.emc.com
Signed-off-by: Wentao Wang <witallwang@gmail.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memblock.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 237944479d25a..bb4e32c6b19e9 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1537,12 +1537,7 @@ void * __init memblock_virt_alloc_try_nid(
  */
 void __init __memblock_free_early(phys_addr_t base, phys_addr_t size)
 {
-	phys_addr_t end = base + size - 1;
-
-	memblock_dbg("%s: [%pa-%pa] %pF\n",
-		     __func__, &base, &end, (void *)_RET_IP_);
-	kmemleak_free_part_phys(base, size);
-	memblock_remove_range(&memblock.reserved, base, size);
+	memblock_free(base, size);
 }
 
 /**
-- 
2.20.1

