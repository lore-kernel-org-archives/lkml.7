Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48548C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2A021883
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="Q3K9Demm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbfIEKgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:36:10 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:57340 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfIEKgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:36:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 8AA2547A11;
        Thu,  5 Sep 2019 12:36:02 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Q3K9Demm;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r6jqe6qZm8uf; Thu,  5 Sep 2019 12:35:52 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1EC3F45577;
        Thu,  5 Sep 2019 12:35:50 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 8655D360184;
        Thu,  5 Sep 2019 12:35:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567679750; bh=sF5pnRh1Bornwr1LEDE7ZQPyi6P6aD1IIefxVqdkCnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3K9DemmI3/xHZebTO2C1r24nQUPkpAM4rTmfzJQI4wualZhcb/hsTtvclulUE7K1
         egQ3kVwV4T8ozRIGk4cA4o+qbAgRhv4CIu5z3sa2byHlWtA5KAj8q+1nyOSxeER/Fy
         NF0JOKa8Y82Jjs5XZQw4Mx8rDj2Cot/VHEefV6rM=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, pv-drivers@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH 1/2] x86: Don't let pgprot_modify() change the page encryption bit
Date:   Thu,  5 Sep 2019 12:35:40 +0200
Message-Id: <20190905103541.4161-2-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190905103541.4161-1-thomas_os@shipmail.org>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

When SEV or SME is enabled and active, vm_get_page_prot() typically
returns with the encryption bit set. This means that users of
pgprot_modify(, vm_get_page_prot()) (mprotect_fixup, do_mmap) typically
unintentionally sets encrypted page protection even on mmap'd coherent
memory where the mmap callback has cleared the bit. Fix this by not
allowing pgprot_modify() to change the encryption bit, similar to
how it's done for PAT bits.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 arch/x86/include/asm/pgtable.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 0bc530c4eb13..8e507169fd90 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -624,12 +624,16 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	return __pmd(val);
 }
 
-/* mprotect needs to preserve PAT bits when updating vm_page_prot */
+/*
+ * mprotect needs to preserve PAT and encryption bits when updating
+ * vm_page_prot
+ */
 #define pgprot_modify pgprot_modify
 static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
 {
-	pgprotval_t preservebits = pgprot_val(oldprot) & _PAGE_CHG_MASK;
-	pgprotval_t addbits = pgprot_val(newprot);
+	pgprotval_t preservebits = pgprot_val(oldprot) &
+		(_PAGE_CHG_MASK | sme_me_mask);
+	pgprotval_t addbits = pgprot_val(newprot) & ~sme_me_mask;
 	return __pgprot(preservebits | addbits);
 }
 
-- 
2.20.1

