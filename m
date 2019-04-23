Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751B2C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390FA218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHY48LhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfDWWtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:49:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46696 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfDWWtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:49:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id k18so12985303lfj.13;
        Tue, 23 Apr 2019 15:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HJRvj8BujR+p5SOja4FAemkZIFG1n37I1t4IGxaN5rI=;
        b=VHY48LhM8TNgdZneoiW3y8NkrZcdRSFuXgtVdkM2iPWLaxjrMRw4rE96YnsFQ07M4J
         AWYVCKEDNcEFOXjLZ2j7PtdunmbuhnwdaIXS9tdwv5rWB3iL0mXJMm481chlaFJ+QLmG
         x9wyok20vv7GlzltLfYRx4BhrZXJcjE0SI5nuvVJHENzkQ8D2VNZfQaH7RbrTEF7/JVR
         L6qlMVv5rcKbyVck7ddB6unYKfdZz02Zl6ujqiC35edvcsESnuXql+zbAAe2RNee1Iu8
         Z7wBsMUcxy6d6IwRwvjc/0KXt/LrphI3gSBGOpG++jjcdnWbQ9Vxzsh89tJ3kW71MoYX
         mQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HJRvj8BujR+p5SOja4FAemkZIFG1n37I1t4IGxaN5rI=;
        b=R3oWy11YLH80dvMmwF5HcrdEpe+rp4qmuC6gp22lnIdnjUHtYN1QqATBeA6z5qzcsh
         GTuOH/H4nfxzffmK4DJ2vDu4/ZFD3Mq5+9BjHdWPHXoqwrWvGS/xYu1Fi9ENDLqKCqpC
         nOPqQd9XEagVXdKTkbl6wZ/ZmrAKnaophyNSjuWrMxE5cbat0Tmtc2pLxoIwJ98nNKBk
         TVBkJtToOXck/6Q49UrJDXjAOa1ekfR83rcCe22Vty2LVVo4w642eiiUt990e7h1z9Ny
         dM1FRkIlblt8/fvK3uM6PO8JnsORnk4reuFI8KT6l+bVr0s1Ua1HY1rRzXClcRJqxO5A
         jy1g==
X-Gm-Message-State: APjAAAUP7CGvQyL8bGNxcNCWQMj3nm/fgsxfJIhnDfOQvMAR9IOXkA8C
        XqfoxQdKJtlKPIX0R0Yhr/A=
X-Google-Smtp-Source: APXvYqzBPfY2roDZJC/cvUS8pRWGCB3Y6qBzQOGp021YLe4yOcN5c+tUwToi5RT5Wjzp3e+XNVEaTA==
X-Received: by 2002:a19:7014:: with SMTP id h20mr15944340lfc.158.1556059772953;
        Tue, 23 Apr 2019 15:49:32 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id w2sm4904722lfa.63.2019.04.23.15.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:49:32 -0700 (PDT)
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
Subject: [PATCH 07/12] mips: Add reserve-nomap memory type support
Date:   Wed, 24 Apr 2019 01:47:43 +0300
Message-Id: <20190423224748.3765-8-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423224748.3765-1-fancer.lancer@gmail.com>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It might be necessary to prevent the virtual mapping creation for a
requested memory region. For instance there is a "no-map" property
indicating exactly this feature. In this case we need to not only
reserve the specified region by pretending it doesn't exist in the
memory space, but completely remove the range from system just by
removing it from memblock. The same way it's done in default
early_init_dt_reserve_memory_arch() method.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/include/asm/bootinfo.h | 1 +
 arch/mips/kernel/prom.c          | 4 +++-
 arch/mips/kernel/setup.c         | 8 ++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index a301a8f4bc66..235bc2f52113 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -92,6 +92,7 @@ extern unsigned long mips_machtype;
 #define BOOT_MEM_ROM_DATA	2
 #define BOOT_MEM_RESERVED	3
 #define BOOT_MEM_INIT_RAM	4
+#define BOOT_MEM_NOMAP		5
 
 /*
  * A memory map that's built upon what was determined
diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 93b8e0b4332f..437a174e3ef9 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -47,7 +47,9 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
 					phys_addr_t size, bool nomap)
 {
-	add_memory_region(base, size, BOOT_MEM_RESERVED);
+	add_memory_region(base, size,
+			  nomap ? BOOT_MEM_NOMAP : BOOT_MEM_RESERVED);
+
 	return 0;
 }
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 3a5140943f54..2a1b2e7a1bc9 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -178,6 +178,7 @@ static bool __init __maybe_unused memory_region_available(phys_addr_t start,
 				in_ram = true;
 			break;
 		case BOOT_MEM_RESERVED:
+		case BOOT_MEM_NOMAP:
 			if ((start >= start_ && start < end_) ||
 			    (start < start_ && start + size >= start_))
 				free = false;
@@ -213,6 +214,9 @@ static void __init print_memory_map(void)
 		case BOOT_MEM_RESERVED:
 			printk(KERN_CONT "(reserved)\n");
 			break;
+		case BOOT_MEM_NOMAP:
+			printk(KERN_CONT "(nomap)\n");
+			break;
 		default:
 			printk(KERN_CONT "type %lu\n", boot_mem_map.map[i].type);
 			break;
@@ -487,6 +491,9 @@ static void __init bootmem_init(void)
 		switch (boot_mem_map.map[i].type) {
 		case BOOT_MEM_RAM:
 			break;
+		case BOOT_MEM_NOMAP: /* Discard the range from the system. */
+			memblock_remove(PFN_PHYS(start), PFN_PHYS(end - start));
+			continue;
 		default: /* Reserve the rest of the memory types at boot time */
 			memblock_reserve(PFN_PHYS(start), PFN_PHYS(end - start));
 			break;
@@ -861,6 +868,7 @@ static void __init resource_init(void)
 			res->flags |= IORESOURCE_SYSRAM;
 			break;
 		case BOOT_MEM_RESERVED:
+		case BOOT_MEM_NOMAP:
 		default:
 			res->name = "reserved";
 		}
-- 
2.21.0

