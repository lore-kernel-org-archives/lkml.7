Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB0BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1232920717
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402303;
	bh=HS84tFKpKufgsJQxZKLcluRkNCzY3Fs/Uh0TZmuPb40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oBvGqDZVhLtctrF3vPGsO550W7NFLolpsWuWk6KChTVw200YauF4HeSa/jGxXi9N4
	 leTEEd0sp601mquRg9O2HPCtNVnl791IWr7/FIUIo7+8MdBglOccbAG8Wyu3zGnVQm
	 j2DKAz/8RZYV1l9stPNXdUOnj2uEt1j407pfcjng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfKVF6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:58:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729608AbfKVF6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:58:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B60A42082F;
        Fri, 22 Nov 2019 05:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402284;
        bh=HS84tFKpKufgsJQxZKLcluRkNCzY3Fs/Uh0TZmuPb40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uJ5IV6XTZ7s/mdvNif6ciiEp/Da/AOXyOCPjLp3+vYg9IWLPQtniywNaxWD4VeAQm
         gm9bvktMvrDj5DI6Wu78XTFtjULybU1Lss5XoNGJqy7q1eshgMR06vFJuW6yoFalxa
         qzjtt6TjeddviQKhrxwr5E8X9MD6aROy9BDDpkVM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 123/127] ACPI / APEI: Switch estatus pool to use vmalloc memory
Date:   Fri, 22 Nov 2019 00:55:40 -0500
Message-Id: <20191122055544.3299-121-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

[ Upstream commit 0ac234be1a9497498e57d958f4251f5257b116b4 ]

The ghes code is careful to parse and round firmware's advertised
memory requirements for CPER records, up to a maximum of 64K.
However when ghes_estatus_pool_expand() does its work, it splits
the requested size into PAGE_SIZE granules.

This means if firmware generates 5K of CPER records, and correctly
describes this in the table, __process_error() will silently fail as it
is unable to allocate more than PAGE_SIZE.

Switch the estatus pool to vmalloc() memory. On x86 vmalloc() memory
may fault and be fixed up by vmalloc_fault(). To prevent this call
vmalloc_sync_all() before an NMI handler could discover the memory.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/ghes.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9c31c7cd5cb5e..cd6fae6ad4c2a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -170,40 +170,40 @@ static int ghes_estatus_pool_init(void)
 	return 0;
 }
 
-static void ghes_estatus_pool_free_chunk_page(struct gen_pool *pool,
+static void ghes_estatus_pool_free_chunk(struct gen_pool *pool,
 					      struct gen_pool_chunk *chunk,
 					      void *data)
 {
-	free_page(chunk->start_addr);
+	vfree((void *)chunk->start_addr);
 }
 
 static void ghes_estatus_pool_exit(void)
 {
 	gen_pool_for_each_chunk(ghes_estatus_pool,
-				ghes_estatus_pool_free_chunk_page, NULL);
+				ghes_estatus_pool_free_chunk, NULL);
 	gen_pool_destroy(ghes_estatus_pool);
 }
 
 static int ghes_estatus_pool_expand(unsigned long len)
 {
-	unsigned long i, pages, size, addr;
-	int ret;
+	unsigned long size, addr;
 
 	ghes_estatus_pool_size_request += PAGE_ALIGN(len);
 	size = gen_pool_size(ghes_estatus_pool);
 	if (size >= ghes_estatus_pool_size_request)
 		return 0;
-	pages = (ghes_estatus_pool_size_request - size) / PAGE_SIZE;
-	for (i = 0; i < pages; i++) {
-		addr = __get_free_page(GFP_KERNEL);
-		if (!addr)
-			return -ENOMEM;
-		ret = gen_pool_add(ghes_estatus_pool, addr, PAGE_SIZE, -1);
-		if (ret)
-			return ret;
-	}
 
-	return 0;
+	addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
+	if (!addr)
+		return -ENOMEM;
+
+	/*
+	 * New allocation must be visible in all pgd before it can be found by
+	 * an NMI allocating from the pool.
+	 */
+	vmalloc_sync_all();
+
+	return gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
 }
 
 static int map_gen_v2(struct ghes *ghes)
-- 
2.20.1

