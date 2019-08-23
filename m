Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4280DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6512339D
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lpANlXsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395177AbfHWOWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:22:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39502 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390442AbfHWOWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:22:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id 125so8302049qkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=moc3IlfprhHeTI7XClejHHobNYyvuFk0GwG2m6SxEgM=;
        b=lpANlXshmursICRsWV0tnI38Skc6/orrezhIGeTS4nRN00OxTi99Sz8HjQ0EWLe+MY
         YtQMhGKV7nUE4SsfKnktFnYEhEfbaGTJfD2w6cKRb25vauMpv71IYVSBU0HKW3+62Xdm
         7JfGsdFndSws9htjzAUugyt3CoP/Rl1EwQPKh1WiKHszNV23Ng6CZ5EEMaAMhRS0Zb8O
         kUV86nyiz+/KTQ4zGI3ED8rxws3+BcJtJleR+Esr38eTC5CLUd+yiDIyIdnwnim174zS
         5Qfh1EHNCWQ0+EYUMgm1J4BeFxZoQpma2on18wU9nSSfh/eZGBG0Eaz7zHAi5ni4kX4q
         A8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=moc3IlfprhHeTI7XClejHHobNYyvuFk0GwG2m6SxEgM=;
        b=rPLKToHuB33lpnATIO0IutOLtVgZa2Vp/aEKROzBRNqgKWQUBqBVutzz6lDb7XLUdK
         fHFKdK4CvMnL4dA8h3r+WUp169USUH/DnbywWz8ZiHsB/7yx8tKb0oz4O/Z1EFzf+4EK
         U7XmTfVkATXrsnpwM+StlTDpmWNnzE2z3A293vBp948NKA9zwE2O1f7vICSO6VaMd348
         oCevoF+ombkYW6crm6kQDlI2S5EohsG93CJPIIlBphxCrFnlx1RlwOIoi2XFKO0dr8b3
         qFXoQ/goODW0tf8UsHl5uKNrJSA3oMYgAs/Wzr/rCdO1/odiI/Q0bfAHkvZYze0ycK3S
         ivIg==
X-Gm-Message-State: APjAAAV56BuZYrgjLHgJA8USfsg0mCyzKLqRl9ttQgvTuLZKQO7vfYt2
        zr8OH2aepqdqWy/LJ//MdcVDEF6eVzE=
X-Google-Smtp-Source: APXvYqwSZ9XK9JhQ9qs2SXwccpU9qjSKONX9JS1AIawZ30G9AP70CqBgOPkqdDhUTyorHQc2nuLUDA==
X-Received: by 2002:a37:a483:: with SMTP id n125mr4410088qke.329.1566570135325;
        Fri, 23 Aug 2019 07:22:15 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m129sm1377605qkf.86.2019.08.23.07.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 07:22:14 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/mm/radix: remove useless kernel messages
Date:   Fri, 23 Aug 2019 10:22:00 -0400
Message-Id: <1566570120-16529-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting a POWER9 PowerNV system generates a few messages below with
"____ptrval____" due to the pointers printed without a specifier
extension (i.e unadorned %p) are hashed to prevent leaking information
about the kernel memory layout.

radix-mmu: Initializing Radix MMU
radix-mmu: Partition table (____ptrval____)
radix-mmu: Mapped 0x0000000000000000-0x0000000040000000 with 1.00 GiB
pages (exec)
radix-mmu: Mapped 0x0000000040000000-0x0000002000000000 with 1.00 GiB
pages
radix-mmu: Mapped 0x0000200000000000-0x0000202000000000 with 1.00 GiB
pages
radix-mmu: Process table (____ptrval____) and radix root for kernel:
(____ptrval____)

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index b4ca9e95e678..b6692ee9411d 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -386,7 +386,6 @@ static void __init radix_init_pgtable(void)
 	 * physical address here.
 	 */
 	register_process_table(__pa(process_tb), 0, PRTB_SIZE_SHIFT - 12);
-	pr_info("Process table %p and radix root for kernel: %p\n", process_tb, init_mm.pgd);
 	asm volatile("ptesync" : : : "memory");
 	asm volatile(PPC_TLBIE_5(%0,%1,2,1,1) : :
 		     "r" (TLBIEL_INVAL_SET_LPID), "r" (0));
@@ -420,7 +419,6 @@ static void __init radix_init_partition_table(void)
 	mmu_partition_table_set_entry(0, dw0, 0);
 
 	pr_info("Initializing Radix MMU\n");
-	pr_info("Partition table %p\n", partition_tb);
 }
 
 void __init radix_init_native(void)
-- 
1.8.3.1

