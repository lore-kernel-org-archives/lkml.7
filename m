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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED759C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B7120693
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2IZunxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfFEOtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:49:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44669 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfFEOtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:49:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id c5so9771644pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uokpXhUGAbY6p5XmmfFzDRpYAOfHcWN+Kl+0vKMAotA=;
        b=J2IZunxCvI+d08sLrBzSc3RRPxO2OwlM39JK3Wfz7NHVngOBAtWqR8LmRGyHdMML4H
         xJ2memtPxZu00hLPKDBQq3Kxz797fYuSHyz5MjFeuGvOGgdFli2RaOk5+fCl8K4RUByH
         zTyfexL/KNSXqkjKSBxsg1gZsKpQTyVhwUrXQjXGO4pG0TSYNyDeCjnb/skVPGUmy0mf
         ILTmQLnxJ+gq9qzMJv6iRgnIiHoZZNuXwF0++xu1MmCaYxdA47zGacG7Tnhqr/6kHJ0Y
         8L7tgd4Zfm/GQ1ySDh3QfXdINL81pLmMoedb74dlImuilFm4D8it+aDUxKka7xcx2ezR
         kYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uokpXhUGAbY6p5XmmfFzDRpYAOfHcWN+Kl+0vKMAotA=;
        b=cYIzhwBBSxztFk7nHJzrMVNlL+Fon0CzB4rm87sDRbd+klRS++5hillGHgLq5iHxXB
         c0C19Y8LtOiXhZJTOxo0ve9R2287NYNTEIJIBnLucd23HGCNPCObLX5LxGYCiOpNQ23c
         194QApCiFY2lIVfUyHWKGMlPAhNmrH1kxRFdHN8qJVxr39nKOn7r3ZkNUnOR+9GnYncv
         wxffYY05+owJIcCjbnJToR380Zzls7YiA0y3IEOYJaDpyaFIsUagVt8w/psxs0zxGXpB
         4eKp5tSwGdLhEhIfQBDMdRgniGB1Ud0Zdpu1+sl7yYKLBpisGOQahcsrWyuP2iz13rcs
         oAFg==
X-Gm-Message-State: APjAAAU76J1/d/EHIzCuLw3tlIzM6C/rllEbg6wik68KJnGwezttWvRG
        Bly2BDUHtMw0RIPj6ey2l4w=
X-Google-Smtp-Source: APXvYqzclwzYKdfqEnZ6+MDN2VJ6wxc2CPFyVlmBhB2yRZPhVC1P4kxcpKFPMHk9z1/c/77J1YvRaQ==
X-Received: by 2002:a17:902:e306:: with SMTP id cg6mr15878349plb.341.1559746162576;
        Wed, 05 Jun 2019 07:49:22 -0700 (PDT)
Received: from bobo.local0.net ([203.220.89.252])
        by smtp.gmail.com with ESMTPSA id m19sm13375840pff.153.2019.06.05.07.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 07:49:22 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] mm/large system hash: clear hashdist when only one node with memory is booted
Date:   Thu,  6 Jun 2019 00:48:14 +1000
Message-Id: <20190605144814.29319-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605144814.29319-1-npiggin@gmail.com>
References: <20190605144814.29319-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_NUMA on 64-bit CPUs currently enables hashdist unconditionally
even when booting on single node machines. This causes the large system
hashes to be allocated with vmalloc, and mapped with small pages.

This change clears hashdist if only one node has come up with memory.

This results in the important large inode and dentry hashes using
memblock allocations. All others are within 4MB size up to about 128GB
of RAM, which allows them to be allocated from the linear map on most
non-NUMA images.

Other big hashes like futex and TCP should eventually be moved over to
the same style of allocation as those vfs caches that use HASH_EARLY if
!hashdist, so they don't exceed MAX_ORDER on very large non-NUMA images.

This brings dTLB misses for linux kernel tree `git diff` from ~45,000 to
~8,000 on a Kaby Lake KVM guest with 8MB dentry hash and mitigations=off
(performance is in the noise, under 1% difference, page tables are
likely to be well cached for this workload).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/page_alloc.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 15f46be7d210..cd944f48be9a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7519,10 +7519,28 @@ static int page_alloc_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
+#ifdef CONFIG_NUMA
+int hashdist = HASHDIST_DEFAULT;
+
+static int __init set_hashdist(char *str)
+{
+	if (!str)
+		return 0;
+	hashdist = simple_strtoul(str, &str, 0);
+	return 1;
+}
+__setup("hashdist=", set_hashdist);
+#endif
+
 void __init page_alloc_init(void)
 {
 	int ret;
 
+#ifdef CONFIG_NUMA
+	if (num_node_state(N_MEMORY) == 1)
+		hashdist = 0;
+#endif
+
 	ret = cpuhp_setup_state_nocalls(CPUHP_PAGE_ALLOC_DEAD,
 					"mm/page_alloc:dead", NULL,
 					page_alloc_cpu_dead);
@@ -7907,19 +7925,6 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
-#ifdef CONFIG_NUMA
-int hashdist = HASHDIST_DEFAULT;
-
-static int __init set_hashdist(char *str)
-{
-	if (!str)
-		return 0;
-	hashdist = simple_strtoul(str, &str, 0);
-	return 1;
-}
-__setup("hashdist=", set_hashdist);
-#endif
-
 #ifndef __HAVE_ARCH_RESERVED_KERNEL_PAGES
 /*
  * Returns the number of pages that arch has reserved but
-- 
2.20.1

