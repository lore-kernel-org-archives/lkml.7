Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2E4C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADA8218FC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bM04lvZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfDWWta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:49:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46645 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfDWWt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:49:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id h21so14970102ljk.13;
        Tue, 23 Apr 2019 15:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTU8dE2SxYXM9su1WKXdDX/bmKYoBJJtJQ58Oc3+2AM=;
        b=bM04lvZlR/QIEQrYDfguOHrc2NVRvjS04Zb+CHhgQZ4+MZEqLjigjm7RldS/1KhEi0
         7xinAMJ8nM8zRkYkVGuHEsYUwgu75aLdPfyzL7FQqc9fsUgNh0YjGyXUfg3NeBDHbwO9
         JCHmV/sfaZFAIB+Nvl6BPclex7P0yV4ITLXWVHyXyegN65N7F0u3vHvzzfVzOueGAbEB
         5Ay0BFaKcRedr6yjzA9w/Lnt2BLAD1jmR7B9IFZzC2Ra4QnXyZ+pVJsDY2m04HpFHkbn
         rcZprPGUhuhjE+wmZ3VPWPnukvikhwl1AEwz4de3dWIAEDzagXN08prneD6o5GL9OqLQ
         cSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTU8dE2SxYXM9su1WKXdDX/bmKYoBJJtJQ58Oc3+2AM=;
        b=BGCNZzEd8KDwA4TE2Zl31q4CdZ/FXjVJimvIFuytwWw6fSigmxnltAyp/you7LmyuS
         iRDU/X6WPcEL3KcpnAoX2Rnv/knoB/+BObsyv4S/iopQrqfD2sTSg+qy68jxEsCZBJ32
         JJolZwRaUwWmnc9/14hBJnLNTMxncjtnGD/KQ3Mwo44+TafnWK9h8xAn43c5ixd1CTat
         wcegl3BB9FqHqNjjjGkSh8ie9tBnSmVHmuognXpqnE7FZbiDwByouza9Zv21P+3mAM7G
         x3CZCvJyuFFc7MkxxJYDwhhlBctmFgcfAQZObBPZRfeSJYIkcYeVAVRByAEXRTwX+Eyo
         WiLA==
X-Gm-Message-State: APjAAAXbII5oPm9/DyGjuFzGnwwfjYVKe44/p+JxqSpz5lmfZ0i0jjWp
        qjfip5pD5ZvcMASliJJkbY4=
X-Google-Smtp-Source: APXvYqwRUZSbTDgAkv4wVpcfzgRiCXMR3K44bZnjhDIvSqz1H26dIkLXwHtE6Rjbu6+yTbDZV6X4hg==
X-Received: by 2002:a2e:309:: with SMTP id 9mr16039852ljd.114.1556059765706;
        Tue, 23 Apr 2019 15:49:25 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id w2sm4904722lfa.63.2019.04.23.15.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:49:25 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 02/12] mips: Discard rudiments from bootmem_init
Date:   Wed, 24 Apr 2019 01:47:38 +0300
Message-Id: <20190423224748.3765-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423224748.3765-1-fancer.lancer@gmail.com>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a pointless code left in the bootmem_init() method since
the bootmem allocator removal. First part resides the PFN ranges
calculation loop. The conditional expressions and continue operator
are useless there, since nothing is done after them. Second part is
in RAM ranges installation loop. We can simplify the conditions cascade
a bit without much of the logic redefinition, so to reduce the code
length. In particular the end boundary value can be verified after
the possible reduction to be below max_low_pfn.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 0ee033c44116..53d93a727d1a 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -394,10 +394,7 @@ static void __init bootmem_init(void)
 	min_low_pfn = ~0UL;
 	max_low_pfn = 0;
 
-	/*
-	 * Find the highest page frame number we have available
-	 * and the lowest used RAM address
-	 */
+	/* Find the highest and lowest page frame numbers we have available. */
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long start, end;
 
@@ -427,13 +424,6 @@ static void __init bootmem_init(void)
 			max_low_pfn = end;
 		if (start < min_low_pfn)
 			min_low_pfn = start;
-		if (end <= reserved_end)
-			continue;
-#ifdef CONFIG_BLK_DEV_INITRD
-		/* Skip zones before initrd and initrd itself */
-		if (initrd_end && end <= (unsigned long)PFN_UP(__pa(initrd_end)))
-			continue;
-#endif
 	}
 
 	if (min_low_pfn >= max_low_pfn)
@@ -474,6 +464,7 @@ static void __init bootmem_init(void)
 		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 	}
 
+	/* Install all valid RAM ranges to the memblock memory region */
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long start, end;
 
@@ -481,21 +472,15 @@ static void __init bootmem_init(void)
 		end = PFN_DOWN(boot_mem_map.map[i].addr
 				+ boot_mem_map.map[i].size);
 
-		if (start <= min_low_pfn)
+		if (start < min_low_pfn)
 			start = min_low_pfn;
-		if (start >= end)
-			continue;
-
 #ifndef CONFIG_HIGHMEM
+		/* Ignore highmem regions if highmem is unsupported */
 		if (end > max_low_pfn)
 			end = max_low_pfn;
-
-		/*
-		 * ... finally, is the area going away?
-		 */
+#endif
 		if (end <= start)
 			continue;
-#endif
 
 		memblock_add_node(PFN_PHYS(start), PFN_PHYS(end - start), 0);
 	}
-- 
2.21.0

