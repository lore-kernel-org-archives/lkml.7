Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A5CC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9725A218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL7nJj2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfDWWte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:49:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40414 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbfDWWta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:49:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so14984975ljq.7;
        Tue, 23 Apr 2019 15:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kL5scIjwN0bnNKZh/MvkqfH0S+/rftNhOfsf9udhKXo=;
        b=RL7nJj2AP0HIjtqrrU7fZT1SPPW3Q7aOlP+LazRT5TRh7JlanscVoo3IB8u1my4em0
         3wHtkzlNbjMCiZ/ROm9mg2ShF/y+1S/UdZzCD66KhP5V9aKJ6DyZP+LPJZVrzy7UHTrd
         3qBdEQFqteAoeefh4HtRRW91SMHlshy4Up23Zi891elRwf2sfU6gqFu/NVfFfdBVe0N/
         24olgUFdAofsNaO2cg4ZqeTewGCp/PHoN0eieY0W1CiskXLfi9/zF3pCZO/ieiwxRr+u
         FGD83jHs+iQvA64j3I4QajnwaC/B88ZJqV2XedGoN9TndOARXHGFMe5tN5nBVHwmNaYM
         3Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kL5scIjwN0bnNKZh/MvkqfH0S+/rftNhOfsf9udhKXo=;
        b=n/lc6o+y4wQ5EiE6SaAWhxxUKM4CcTGbhV1GJsYe8TC0V9bZM43ce2+b/QUT2ppEP6
         qoil68389EhgvWMNC8Zste4H7B79+xviqHMZF0VC/0CkMtDLNBXypMoxuTTUY4Of7NiI
         Itdwm/wfmML1z22XWSlwGN9pf3MUKjKh9CAQqAckZ6fB2pbTi0bIIuKt56jS2nBcHMJO
         sCVqG9hmP1lBsIHlJ72yzoI/ti2XtlNJbnhzGkmp96/528Od91GRTvkfvKRgrBJej/fk
         pFlIjE6/6/TaiFX96/bhb7XhfLLhyOcJ497i79oY3NTyVjxQw3B4xAReaTlsj/3+AZUK
         Smww==
X-Gm-Message-State: APjAAAVJvBHtZEN5Qdj3a4KxqOdHbJBFl0gKx7nQJkr8V5w3a2tvXZ6C
        4o94xggEAD8mK8GTn7N09Cg=
X-Google-Smtp-Source: APXvYqyHxLB2YUcQTKUlMkatOsiRjG5aj7qenaEg42Q+Vt1Mc0MuOkVgotaJK5cYFdfXlOG5eCNVTw==
X-Received: by 2002:a2e:93d0:: with SMTP id p16mr14767084ljh.197.1556059768630;
        Tue, 23 Apr 2019 15:49:28 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id w2sm4904722lfa.63.2019.04.23.15.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:49:27 -0700 (PDT)
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
Subject: [PATCH 04/12] mips: Reserve memory for the kernel image resources
Date:   Wed, 24 Apr 2019 01:47:40 +0300
Message-Id: <20190423224748.3765-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423224748.3765-1-fancer.lancer@gmail.com>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved_end variable had been used by the bootmem_init() code
to find a lowest limit of memory available for memmap blob. The original
code just tried to find a free memory space higher than kernel was placed.
This limitation seems justified for the memmap ragion search process, but
I can't see any obvious reason to reserve the unused space below kernel
seeing some platforms place it much higher than standard 1MB. Moreover
the RELOCATION config enables it to be loaded at any memory address.
So lets reserve the memory occupied by the kernel only, leaving the region
below being free for allocations. After doing this we can now discard the
code freeing a space between kernel _text and VMLINUX_LOAD_ADDRESS symbols
since it's going to be free anyway (unless marked as reserved by
platforms).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 185e0e42e009..f71a7d32a687 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -371,7 +371,6 @@ static void __init bootmem_init(void)
 
 static void __init bootmem_init(void)
 {
-	unsigned long reserved_end;
 	phys_addr_t ramstart = PHYS_ADDR_MAX;
 	int i;
 
@@ -382,10 +381,10 @@ static void __init bootmem_init(void)
 	 * will reserve the area used for the initrd.
 	 */
 	init_initrd();
-	reserved_end = (unsigned long) PFN_UP(__pa_symbol(&_end));
 
-	memblock_reserve(PHYS_OFFSET,
-			 (reserved_end << PAGE_SHIFT) - PHYS_OFFSET);
+	/* Reserve memory occupied by kernel. */
+	memblock_reserve(__pa_symbol(&_text),
+			__pa_symbol(&_end) - __pa_symbol(&_text));
 
 	/*
 	 * max_low_pfn is not a number of pages. The number of pages
@@ -501,29 +500,6 @@ static void __init bootmem_init(void)
 		memory_present(0, start, end);
 	}
 
-#ifdef CONFIG_RELOCATABLE
-	/*
-	 * The kernel reserves all memory below its _end symbol as bootmem,
-	 * but the kernel may now be at a much higher address. The memory
-	 * between the original and new locations may be returned to the system.
-	 */
-	if (__pa_symbol(_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
-		unsigned long offset;
-		extern void show_kernel_relocation(const char *level);
-
-		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
-		memblock_free(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
-
-#if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
-		/*
-		 * This information is necessary when debugging the kernel
-		 * But is a security vulnerability otherwise!
-		 */
-		show_kernel_relocation(KERN_INFO);
-#endif
-	}
-#endif
-
 	/*
 	 * Reserve initrd memory if needed.
 	 */
-- 
2.21.0

