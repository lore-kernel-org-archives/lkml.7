Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE0DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD90B23A77
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="ZaxOt8lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfHTIOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:14:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44115 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfHTIOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:14:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so2353267plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XQA3UCdGC7caS48ij4zC/iNWJe//yYh8xmEXn6HYb5Q=;
        b=ZaxOt8lk22Z21ulmXMLkeo0R/2PTzZDR0R59vKVCfgZDN+uL7ZpYx1PvlCJfYueDro
         0+iBPqErLvoipl5xvSp7vEG5falbWHLpEPg5ypzBjEf8/k1FBngvApv3z67S5WLsZJMt
         mnMgTwgsaNsf9qzaMKnwiJ36s+EIsL+8fLtrDdWbyrexuraTZIp8JMe9ECT4fp0zQbSv
         lfOwLIRUpV7X8afUFwENMwTu2KajbnGZpMxfWW4Fh68lFD4sdthbwcapSbGieEc32Ddc
         n9FJo7AcVmmXhFBst/qWjg54KCZJ8XK61xbCBHNv5qtO0PpQvjDw6gnY5bc0QMok60VT
         i7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQA3UCdGC7caS48ij4zC/iNWJe//yYh8xmEXn6HYb5Q=;
        b=XA9UtXoIR8HXfd8ohQzDutvW18uA8MNsX26PJQrQaGZHCYVVTMgY7a8xOsqiLG+7P4
         t8FE6skWMXoQvzkWWG1yWf7OWsBi88uJfNeUqhAjNtC4auM+P9nW8/FDPJqOe276nEOQ
         htil4xYPleKHaiVTW1dvPdnka30G88UXkegrppantR3iZFhRLvLh3HASY5JxYaZdXlUb
         Pd/zox8DxP6OebllrA8MSOTuvN3K7RyN4Vk1KhDI3EbukJn7OonIBGla7PNJbJDA3cZ5
         +LdHS5NZpD7kai2D0xHVBX/ovJixH9VMNdpVGRULtSq0Z9IOdUxtdzk2ld1RNrzp4b4/
         vlOg==
X-Gm-Message-State: APjAAAVRO14qp5AD/3teMxCoh/Zh3VKBKUjwhk3p+P5zsPn5VEeuGSk2
        YIlNrdcy5tjAITvRp77TOXqN1w==
X-Google-Smtp-Source: APXvYqwKartOprZEYdfxJQodngK2fUrnjvEtKW/9LFLWW5vrWacynvDQZeXWHe7YGCrlHyzifHiUvw==
X-Received: by 2002:a17:902:fe06:: with SMTP id g6mr26976368plj.265.1566288847004;
        Tue, 20 Aug 2019 01:14:07 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.78])
        by smtp.gmail.com with ESMTPSA id b14sm18949265pfo.15.2019.08.20.01.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:14:06 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        stable@vger.kernel.org
Subject: [PATCH v11 2/7] powerpc/mce: Fix MCE handling for huge pages
Date:   Tue, 20 Aug 2019 13:43:47 +0530
Message-Id: <20190820081352.8641-3-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820081352.8641-1-santosh@fossix.org>
References: <20190820081352.8641-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balbir Singh <bsingharora@gmail.com>

The current code would fail on huge pages addresses, since the shift would
be incorrect. Use the correct page shift value returned by
__find_linux_pte() to get the correct physical address. The code is more
generic and can handle both regular and compound pages.

Fixes: ba41e1e1ccb9 ("powerpc/mce: Hookup derror (load/store) UE errors")
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
[arbab@linux.ibm.com: Fixup pseries_do_memory_failure()]
Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
Tested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
Cc: stable@vger.kernel.org # v4.15+
---
 arch/powerpc/kernel/mce_power.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index a814d2dfb5b0..714a98e0927f 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -26,6 +26,7 @@
 unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 {
 	pte_t *ptep;
+	unsigned int shift;
 	unsigned long flags;
 	struct mm_struct *mm;
 
@@ -35,13 +36,18 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 		mm = &init_mm;
 
 	local_irq_save(flags);
-	if (mm == current->mm)
-		ptep = find_current_mm_pte(mm->pgd, addr, NULL, NULL);
-	else
-		ptep = find_init_mm_pte(addr, NULL);
+	ptep = __find_linux_pte(mm->pgd, addr, NULL, &shift);
 	local_irq_restore(flags);
+
 	if (!ptep || pte_special(*ptep))
 		return ULONG_MAX;
+
+	if (shift > PAGE_SHIFT) {
+		unsigned long rpnmask = (1ul << shift) - PAGE_SIZE;
+
+		return pte_pfn(__pte(pte_val(*ptep) | (addr & rpnmask)));
+	}
+
 	return pte_pfn(*ptep);
 }
 
@@ -344,7 +350,7 @@ static const struct mce_derror_table mce_p9_derror_table[] = {
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0, false, 0, 0, 0, 0, 0 } };
 
-static int mce_find_instr_ea_and_pfn(struct pt_regs *regs, uint64_t *addr,
+static int mce_find_instr_ea_and_phys(struct pt_regs *regs, uint64_t *addr,
 					uint64_t *phys_addr)
 {
 	/*
@@ -541,7 +547,8 @@ static int mce_handle_derror(struct pt_regs *regs,
 			 * kernel/exception-64s.h
 			 */
 			if (get_paca()->in_mce < MAX_MCE_DEPTH)
-				mce_find_instr_ea_and_pfn(regs, addr, phys_addr);
+				mce_find_instr_ea_and_phys(regs, addr,
+							   phys_addr);
 		}
 		found = 1;
 	}
-- 
2.21.0

