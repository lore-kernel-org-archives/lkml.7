Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA0AC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE07206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt1p4DdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfFEOtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:49:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42363 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbfFEOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:49:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so11260033pgd.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n/tZofbBogKZ5HTBUbSV6rWcxAAFfPOtXDpX6liTabU=;
        b=Xt1p4DdYpo2iTbRqldHe1m4pbYWezS+2NvUE8s9WGrvQ32mQm/SvJ95a+v5FCwvhdU
         uqsVALe56+yi0vvM5IqsD2+B0U3wt3mi4jPtG98X84/K4ZoJscczxTB2FTr2kalU7QK8
         QSodgzdiM1cHC8jLZ18alaSGJ3nAp3XoBqOFU5A8CEy3WV2rlKZx9RxnQOHgpV4zo4oJ
         CppFN9hDpmIhW3P0WfQKj5WDkYmLQKU1W+qF8L5Vjn33pvdVB8asrbfEEzdHdBvTGSPo
         N6+kKFpe8QK6I1vGkt9zZfHzCU4hbgxOeDyHQC0m4Z1/n87MhLnjpbJkVj+rPlVtc+pG
         tveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n/tZofbBogKZ5HTBUbSV6rWcxAAFfPOtXDpX6liTabU=;
        b=mVB+dtGjkympwjOLPDIP+Toqlz093CYFRms72Yc+WQpNLJnO4Z7bzNpi9uVyFrN9Dd
         /o2wa8P3Fox7bIZCev/epQmRF5Rb2RZ3wbUFKQh0bkkbAXGEVMRlctH/xTpXEm8KJQi5
         GqCAcUhHkz6GhYrxrNWbH8l5Gmao0Tn5n6P5GqJv//Odoy90cw/ezdeA+/Y0c3M+6OS8
         OIWW8Pz+5Ut0asO2n0nbJEmWc0P+u7Q4g4iyBpgV+o1a6tJnH0+3JLUybVMTB8DDyEvz
         0qnxJVKVtkxw0pooPNJnrTVjfUHlnvgcELGaQ42GXjV9CaNTiCoquPZd1ELZbugkYS5h
         8law==
X-Gm-Message-State: APjAAAUCGL2z6HyjAXa9GVNqgPKZbG7eyHN6GQ0vNBmwTxduUGdRUIBu
        K81rM84no6ep91xmgDj3VTo=
X-Google-Smtp-Source: APXvYqyBbhev4RKfSBMh3SGEtpfz2O+6DtVwVokbLlv0pD8pFHlxodfBt6wDsYpKmza793o7PvgMMA==
X-Received: by 2002:a62:2643:: with SMTP id m64mr45312432pfm.46.1559746159262;
        Wed, 05 Jun 2019 07:49:19 -0700 (PDT)
Received: from bobo.local0.net ([203.220.89.252])
        by smtp.gmail.com with ESMTPSA id m19sm13375840pff.153.2019.06.05.07.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 07:49:17 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] mm/large system hash: use vmalloc for size > MAX_ORDER when !hashdist
Date:   Thu,  6 Jun 2019 00:48:13 +1000
Message-Id: <20190605144814.29319-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel currently clamps large system hashes to MAX_ORDER when
hashdist is not set, which is rather arbitrary.

vmalloc space is limited on 32-bit machines, but this shouldn't
result in much more used because of small physical memory limiting
system hash sizes.

Include "vmalloc" or "linear" in the kernel log message.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

This is a better solution than the previous one for the case of !NUMA
systems running on CONFIG_NUMA kernels, we can clear the default
hashdist early and have everything allocated out of the linear map.

The hugepage vmap series I will post later, but it's quite
independent from this improvement.

 mm/page_alloc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d66bc8abe0af..15f46be7d210 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7966,6 +7966,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 	unsigned long log2qty, size;
 	void *table = NULL;
 	gfp_t gfp_flags;
+	bool virt;
 
 	/* allow the kernel cmdline to have a say */
 	if (!numentries) {
@@ -8022,6 +8023,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 
 	gfp_flags = (flags & HASH_ZERO) ? GFP_ATOMIC | __GFP_ZERO : GFP_ATOMIC;
 	do {
+		virt = false;
 		size = bucketsize << log2qty;
 		if (flags & HASH_EARLY) {
 			if (flags & HASH_ZERO)
@@ -8029,26 +8031,26 @@ void *__init alloc_large_system_hash(const char *tablename,
 			else
 				table = memblock_alloc_raw(size,
 							   SMP_CACHE_BYTES);
-		} else if (hashdist) {
+		} else if (get_order(size) >= MAX_ORDER || hashdist) {
 			table = __vmalloc(size, gfp_flags, PAGE_KERNEL);
+			virt = true;
 		} else {
 			/*
 			 * If bucketsize is not a power-of-two, we may free
 			 * some pages at the end of hash table which
 			 * alloc_pages_exact() automatically does
 			 */
-			if (get_order(size) < MAX_ORDER) {
-				table = alloc_pages_exact(size, gfp_flags);
-				kmemleak_alloc(table, size, 1, gfp_flags);
-			}
+			table = alloc_pages_exact(size, gfp_flags);
+			kmemleak_alloc(table, size, 1, gfp_flags);
 		}
 	} while (!table && size > PAGE_SIZE && --log2qty);
 
 	if (!table)
 		panic("Failed to allocate %s hash table\n", tablename);
 
-	pr_info("%s hash table entries: %ld (order: %d, %lu bytes)\n",
-		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size);
+	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
+		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
+		virt ? "vmalloc" : "linear");
 
 	if (_hash_shift)
 		*_hash_shift = log2qty;
-- 
2.20.1

