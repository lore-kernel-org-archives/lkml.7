Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1F6C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DBA208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="N1XIOHkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfDWQ6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:58:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42422 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfDWQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:58:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so16901465qtc.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gun+KZMg7XOJhr33gKRBOQC9L0sK7Ewjdf+IdhlcL+I=;
        b=N1XIOHkOKoeoxAHUS5gu42PTzgAmQc8qZ4Im4gr7BbZgYmwm6HSdRjD33MMJqo0rXJ
         bYw2CJtqCItfA9j89/9KRIZfgpCgZ4SchQ11CxlSnnDF7UaLiAG2QwB0HAQQ6EAsrw+9
         YBerjLxU+xJxG/2PNDoRISBaBSHb2TNUeMtxE8SEJ1K+j9wkS/i7xf5WlwuCza7DmXMp
         8zH9Ntvi9Z5A4PKVW1pUY/IY0RJ2UaPF5e7PAOCl0H3Qe6R8bQ6W49YkHQ0oHxLL6/SU
         pPp8+c4lMkE9xetJ3PDOf1/+6aNWEFvypmD+7100Ju+/Kjz96PgUr5NCZacwi7+zbEuF
         CQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gun+KZMg7XOJhr33gKRBOQC9L0sK7Ewjdf+IdhlcL+I=;
        b=hz8x3seYuLEN90mtFikK00WDoxxRLUg90tkOSGl21b5x9RT3yGirQ5RYZrPZzyCr6/
         Q5RGN4RSE9x7X5QJzcyCx7XUXWtuCAhZ78R3NSKY0oEo/asVm2+SPGmFyRMf/nILbUEL
         gtkIzraVfnPmGxyFU3XM8/U61tk6QFZqVZTd5FBgDJi3+GYM2KPc44hoIfgubpks84qq
         oZdhFqOSAjuNCO2O8+dDSLog7qThDM7G5ihPTaWoqPkx/DNX2riMIgBRxDe4JlHFUXQT
         ueeC/92BktzQDqBs5IxHa93HjXDiRWU3U8iXeYxTIqWA58gLRrV4IEYIHhc6YMMXJtlK
         ayMA==
X-Gm-Message-State: APjAAAVacG79fkp9jijMNAYcY6DxDtcBn46hlPLLswOQXvjhcTs0ERB7
        +jBYNopd//BMrOFM/VvJC/CYaw==
X-Google-Smtp-Source: APXvYqzEuxPX4PMgh9FEMBFd/YXI4Ee1BZ65WL9rKq1TGpSQAC/VkssfI3XFIS9Y7AtET1Qq0pMFdw==
X-Received: by 2002:ac8:1d02:: with SMTP id d2mr19055064qtl.148.1556038710225;
        Tue, 23 Apr 2019 09:58:30 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z38sm9583713qtz.13.2019.04.23.09.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:58:29 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com
Cc:     catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] x86/mm: fix a crash with kmemleak_scan()
Date:   Tue, 23 Apr 2019 12:58:11 -0400
Message-Id: <20190423165811.36699-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first kmemleak_scan() after boot would trigger a crash below because

kernel_init
  free_initmem
    mem_encrypt_free_decrypted_mem
      free_init_pages

unmapped some memory inside the .bss with DEBUG_PAGEALLOC=y. Since
kmemleak_init() will register the .data/.bss sections (only register
.data..ro_after_init if not within .data) and then kmemleak_scan() will
scan those address and dereference them looking for pointer referencing.
If free_init_pages() free and unmap pages in those sections,
kmemleak_scan() will trigger a crash if referencing one of those
addresses.

BUG: unable to handle kernel paging request at ffffffffbd402000
CPU: 12 PID: 325 Comm: kmemleak Not tainted 5.1.0-rc4+ #4
RIP: 0010:scan_block+0x58/0x160
Call Trace:
 scan_gray_list+0x1d9/0x280
 kmemleak_scan+0x485/0xad0
 kmemleak_scan_thread+0x9f/0xc4
 kthread+0x1d2/0x1f0
 ret_from_fork+0x35/0x40

Since kmemleak_free_part() is tolerant to unknown objects (not tracked by
kmemleak), it is fine to call it from free_init_pages() even if not all
address ranges passed to this function are known to kmemleak.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/mm/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index f905a2371080..8dacdb96899e 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -5,6 +5,7 @@
 #include <linux/memblock.h>
 #include <linux/swapfile.h>
 #include <linux/swapops.h>
+#include <linux/kmemleak.h>
 
 #include <asm/set_memory.h>
 #include <asm/e820/api.h>
@@ -766,6 +767,11 @@ void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 	if (debug_pagealloc_enabled()) {
 		pr_info("debug: unmapping init [mem %#010lx-%#010lx]\n",
 			begin, end - 1);
+		/*
+		 * Inform kmemleak about the hole in the memory since the
+		 * corresponding pages will be unmapped.
+		 */
+		kmemleak_free_part((void *)begin, end - begin);
 		set_memory_np(begin, (end - begin) >> PAGE_SHIFT);
 	} else {
 		/*
-- 
2.20.1 (Apple Git-117)

