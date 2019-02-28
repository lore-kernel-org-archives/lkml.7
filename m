Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEA6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4DF218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MIsLuu95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbfB1CfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:35:19 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38716 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbfB1CfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:35:17 -0500
Received: by mail-qt1-f196.google.com with SMTP id s1so21864847qte.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 18:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yjIoD8uEGLjwoz05d/LFqR2eoJsjuUHWOdyAMv0Rd4Y=;
        b=MIsLuu95LZ/nQkIjs8oqgO+nrZDrGP09lhGBvpILxiDBv075A86LdH3KefPA77Lbft
         W+D0dvkG6tY0YqK+toC+Y9F3rg4mocacw1kpqFcaLac9tQXAoXEUjCWNG/GcNP4wUgfH
         IcedeDYwmE6jtS3okm5jB7uJBrQ26oSO4XQqjeKN7CHgC8ZsmW8r18r3uvuCG3PoEgS1
         xVQH/cNfKqPUSJdQZKSL/t0V4fl4Hr9RM4NTAA7UAu8qQTAXkkll7D8mp+gR91F/TzKN
         wEgTygGMdtwinvU3RLd5yCWkX4876BZWskW3VlohxmWc9coOWzXSz4yLKoHUtmyLCkCq
         gqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yjIoD8uEGLjwoz05d/LFqR2eoJsjuUHWOdyAMv0Rd4Y=;
        b=bee4eWie13di+fwSfeYwCir0vW2AwXnPn9ta2y89SU0r7GpyC5zswxT4fF2F1SC881
         A/l1qe0Elp04NjGQmbOoaCtLZ8fzbRGGz2MaidnSAy8rpRvk3AEvV4uYBcGln3qbGakn
         sYF0yz2FKV5z08+0jA1nPhBWMcFL4qYtKYFUxkYwUAqCYMo7WLMoNY/LOaQNuLehvvAu
         up4bwhhmdTM9f9Z4D4qMkFr8ziSUaFauQh7KmRe0ihqnPmPpOr++IEycOiQ1Lsrbjj1B
         AwF67LFXdCs3TQ6ITKa0zD4840j4QSQv35nyOcLQKA4iQje5XK0K+JvlGy4Uqi2hQhx3
         QDEg==
X-Gm-Message-State: AHQUAua+KEXwGdO6+eCIU8gOMYfPKwnvXfY38gnbIzaj/SUwoOJJYOj7
        Y6WkuaecVJZCO11WqNmqkWplPQ==
X-Google-Smtp-Source: APXvYqyzdAPC7rFIDGKtvUajimBBDviMi4BApuwltgX5Rn4/ua0nLWNWPzJjWgHD0jCFmTtqkjJ//Q==
X-Received: by 2002:ac8:fb0:: with SMTP id b45mr4529312qtk.146.1551321316271;
        Wed, 27 Feb 2019 18:35:16 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s19sm11703228qth.80.2019.02.27.18.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 18:35:15 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc: fix "sz" set but not used
Date:   Wed, 27 Feb 2019 21:35:05 -0500
Message-Id: <20190228023505.80092-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/powerpc/mm/hugetlbpage-hash64.c: In function '__hash_page_huge':
arch/powerpc/mm/hugetlbpage-hash64.c:29:28: warning: variable 'sz' set
but not used [-Wunused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/mm/hugetlbpage-hash64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 2e6a8f9345d3..f6b09edc5e6e 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -26,7 +26,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	real_pte_t rpte;
 	unsigned long vpn;
 	unsigned long old_pte, new_pte;
-	unsigned long rflags, pa, sz;
+	unsigned long rflags, pa;
 	long slot, offset;
 
 	BUG_ON(shift != mmu_psize_defs[mmu_psize].shift);
@@ -73,7 +73,6 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		offset = PTRS_PER_PMD;
 	rpte = __real_pte(__pte(old_pte), ptep, offset);
 
-	sz = ((1UL) << shift);
 	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
 		/* No CPU has hugepages but lacks no execute, so we
 		 * don't need to worry about that case */
-- 
2.17.2 (Apple Git-113)

