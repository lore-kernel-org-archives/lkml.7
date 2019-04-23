Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C121C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697BB218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8OafW3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfDWWuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:50:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45988 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWWta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:49:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so14964746ljd.12;
        Tue, 23 Apr 2019 15:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nf5p2Hszyn7zksK8vUlbN9/At8QF1xygcv19ymXYW3s=;
        b=t8OafW3s67dc/e2f5ea3EKPsRNwVMA+tSDMPuKeRJfh+A7l7j3BT+LhzhKkcgV9Djy
         YQ75W3UTwjty7OcwReU8rwTZlkmf3YzYQpGlLorRFGY+/j7bXViz3vX3cetkHN4Iz2Qw
         TqM4NitL9g1h5fz8ZcQh3mT0GGosgBZX2kvNxkfxcoP4ioMBqpuiCcw1sZhrBx/DDzyA
         KexhVilA/my06BDZM6oeb+oZ72yMNVj3PiSdwODG9QZl+dzQb9grqg3qjGgzlvGHBuQI
         EW9Tq2juRtaSST6bZXW7cQWxAzSjuuVMnUBrMc6awP+8fptOxjvIXEGKGdMbdN3XHDgc
         RZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nf5p2Hszyn7zksK8vUlbN9/At8QF1xygcv19ymXYW3s=;
        b=thtozZOTsocJ0iKrUppW984pipSwDZYs3QOVR6be6w4GHTqYjcC5hAj9ncfYaYL2+U
         /P5/xmQxYW/wtXM7Ujs6MZqeqzI1YgRS9O0kXMrxXm+P62bIyuLbf7ceDUPa3tVSJPlT
         SVUPB2qMZJpJQZ3m8i06fKS3TGGiT+xBUO3oS9RqiVvKH1UXW7sDFpKmlS58UMsFlkPN
         yOuxXvV+W/Xo/13kysSicbPpqtcbu00u6yuV2nnP97Ey+6MxbwLsbLrrkm04Uoy/bRUp
         le1OaQMBXhyhzccu0u1KZMdrYr7iHqn1Q+gVgKVLnfjAm92Hn7NDEWIva2PFUFasRDiE
         tgJA==
X-Gm-Message-State: APjAAAUULnGdlrAnChhult5Bf81ada12LQuTQyYDIYiiUkMr8Zc7jqr2
        dVJDXJXrz1pcedf3N/OKOqc=
X-Google-Smtp-Source: APXvYqx3NfW75naO0rRCrxSVqpPFHGqC3Y3W2/GsE/V2uKHOBfmNUOiAcTk9Si95omHfgqBDlsCJsw==
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr1224671ljj.63.1556059767142;
        Tue, 23 Apr 2019 15:49:27 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id w2sm4904722lfa.63.2019.04.23.15.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:49:26 -0700 (PDT)
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
Subject: [PATCH 03/12] mips: Combine memblock init and memory reservation loops
Date:   Wed, 24 Apr 2019 01:47:39 +0300
Message-Id: <20190423224748.3765-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423224748.3765-1-fancer.lancer@gmail.com>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before bootmem was completely removed from the kernel, the last loop
in the bootmem_init() had been used to reserve the correspondingly
marked regions, initialize sparsemem sections and to free the low memory
pages, which then would be used for early memory allocations. After the
bootmem removing patchset had been merged the loop was left to do the first
two things only. But it didn't do them quite well.

First of all it leaves the BOOT_MEM_INIT_RAM memory types unreserved,
which is definitely bug (although it isn't noticeable due to being used
by the kernel region only, which is fully marked as reserved). Secondly
the reservation is supposed to be done for any memory including the
high one. (I couldn't figure out why the highmem was ignored in the first
place, since platforms and dts' may declare any memory region for
reservation) Thirdly the reserved_end variable had been used here to not
accidentally free memory occupied by kernel. Since we already reserved the
corresponding region higher in this method there is no need in using the
variable here anymore. Fourthly the sparsemem should be aware of all the
memory types in the system including the ROM_DATA even if it is going to
be reserved for the whole system uptime. Finally after all these notes are
fixed the loop of memory reservation can be freely merged into the memory
installation loop as it's done in this patch.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 48 ++++++----------------------------------
 1 file changed, 7 insertions(+), 41 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 53d93a727d1a..185e0e42e009 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -483,55 +483,21 @@ static void __init bootmem_init(void)
 			continue;
 
 		memblock_add_node(PFN_PHYS(start), PFN_PHYS(end - start), 0);
-	}
-
-	/*
-	 * Register fully available low RAM pages with the bootmem allocator.
-	 */
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		unsigned long start, end, size;
-
-		start = PFN_UP(boot_mem_map.map[i].addr);
-		end   = PFN_DOWN(boot_mem_map.map[i].addr
-				    + boot_mem_map.map[i].size);
 
-		/*
-		 * Reserve usable memory.
-		 */
+		/* Reserve any memory except the ordinary RAM ranges. */
 		switch (boot_mem_map.map[i].type) {
 		case BOOT_MEM_RAM:
 			break;
-		case BOOT_MEM_INIT_RAM:
-			memory_present(0, start, end);
-			continue;
-		default:
-			/* Not usable memory */
-			if (start > min_low_pfn && end < max_low_pfn)
-				memblock_reserve(boot_mem_map.map[i].addr,
-						boot_mem_map.map[i].size);
-
-			continue;
+		default: /* Reserve the rest of the memory types at boot time */
+			memblock_reserve(PFN_PHYS(start), PFN_PHYS(end - start));
+			break;
 		}
 
 		/*
-		 * We are rounding up the start address of usable memory
-		 * and at the end of the usable range downwards.
-		 */
-		if (start >= max_low_pfn)
-			continue;
-		if (start < reserved_end)
-			start = reserved_end;
-		if (end > max_low_pfn)
-			end = max_low_pfn;
-
-		/*
-		 * ... finally, is the area going away?
+		 * In any case the added to the memblock memory regions
+		 * (highmem/lowmem, available/reserved, etc) are considered
+		 * as present, so inform sparsemem about them.
 		 */
-		if (end <= start)
-			continue;
-		size = end - start;
-
-		/* Register lowmem ranges */
 		memory_present(0, start, end);
 	}
 
-- 
2.21.0

