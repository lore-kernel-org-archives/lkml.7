Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CFCC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 04:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FD421473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 04:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="G3Fo5cx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDIEFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 00:05:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36079 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfDIEFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 00:05:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so9850929qtn.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 21:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zppCZKF0rZ1NnZ9xjCb0DzXkMNKc+Uy/xubAcaV6Yvg=;
        b=G3Fo5cx9ldlWA5w+d1uPLa3zpDz9GhiSAi/g+Z4o5/z49iXUZ9faeJOMerXVzu323D
         FciNy8z6KdgSwOQqfPkaohJyJuV3UjU4kLNuTKbGsAO0E7XDBgUZQgxsA8iIerL9FPaQ
         C+AMQMSO9ChMD4F8wh1UMy1Jx8N7O4PI7Rwdh8kQPpJzA2tDhfUktIIGf1DyH0oO7dMi
         2OLTYpyBBQ6oZpN7bA7gAhrsphzkcGoD5BphsPUQBspV83iuB+pGHcDzYj1gsk39gP0n
         5ZNE3ZOdHYm4USxBv/uxXeAtLj9fKxrnbmD7Z85vXC/ZBtfzyZwEDNvJuiYsIWv8Lopo
         CqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zppCZKF0rZ1NnZ9xjCb0DzXkMNKc+Uy/xubAcaV6Yvg=;
        b=jwqIjrIAstIgbtEQtXLHaoDFHAcmCPU3kNl6pagc0pV+Bn5bb7cnSmNnBKN+B9dlvZ
         Upf39UTO2+X7pYg5HbatPlSf6D1wbItCr756DA3i5eO2yXpGOwL4q9/DTANwTk8kaUvz
         Iqz9qRYL0roU4hzzgKIwnn6YJ5nX8XqV3TZhysYJxclT5ZG7KI83glIFWvqHxCMw/5Aa
         bQ6r5DN0Z0XuurX8m9guuFeDIqYHlFO2H0k/9l6GA/AEZf332ShGU8hXzkRlRHzvFH7c
         jAk/oN2i7hauqJ8ZEak0VQcJMUyt3LxiKLd6Bsu+19/l1xwp2ih1FBRMym3/8AIr4IeM
         5qlA==
X-Gm-Message-State: APjAAAX8wXM8ki869ZvNBSct7D4yQfx6wlzI2N0rtkvTsoNBziQ6kjhJ
        Kagr2btpY+uR9kSquEGFP/ZWvkwQ6oc=
X-Google-Smtp-Source: APXvYqztEyrw/6TQw4d2NvoTwYv/KENDm4gcbaiM10st7rQdiAPOJEToI9IhM3Ss87WvjmV4GEq7OQ==
X-Received: by 2002:a0c:969d:: with SMTP id a29mr27331190qvd.56.1554782741353;
        Mon, 08 Apr 2019 21:05:41 -0700 (PDT)
Received: from ovpn-120-238.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k140sm17052187qke.9.2019.04.08.21.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 21:05:40 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     catalin.marinas@arm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] x86/mm/mem_encrypt: fix a crash with kmemleak_scan
Date:   Tue,  9 Apr 2019 00:05:02 -0400
Message-Id: <20190409040502.55361-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first kmemleak_scan() after boot would trigger a crash below because

kernel_init
  free_initmem
    mem_encrypt_free_decrypted_mem
      free_init_pages

unmapped some memory inside the .bss.

BUG: unable to handle kernel paging request at ffffffffbd402000
CPU: 12 PID: 325 Comm: kmemleak Not tainted 5.1.0-rc4+ #4
RIP: 0010:scan_block+0x58/0x160
Call Trace:
 scan_gray_list+0x1d9/0x280
 kmemleak_scan+0x485/0xad0
 kmemleak_scan_thread+0x9f/0xc4
 kthread+0x1d2/0x1f0
 ret_from_fork+0x35/0x40

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/mm/mem_encrypt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 385afa2b9e17..614ab156024f 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -18,6 +18,7 @@
 #include <linux/dma-direct.h>
 #include <linux/swiotlb.h>
 #include <linux/mem_encrypt.h>
+#include <linux/kmemleak.h>
 
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
@@ -369,6 +370,11 @@ void __init mem_encrypt_free_decrypted_mem(void)
 		}
 	}
 
+	/*
+	 * Inform kmemleak about the hole in the .bss section since the
+	 * corresponding pages will be unmapped with DEBUG_PAGEALLOC=y.
+	 */
+	kmemleak_free_part((void *)vaddr, vaddr_end - vaddr);
 	free_init_pages("unused decrypted", vaddr, vaddr_end);
 }
 
-- 
2.17.2 (Apple Git-113)

