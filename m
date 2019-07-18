Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5031C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FFE2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563420252;
	bh=jGxMWdulzhR058UfyBeS225ZVsG+oHSXokkhjiMLPDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=azIo9EAM0BqvrTezA55WiYVygS2bxWTpi7txsV2bDcdbt5q+Mrgt3nvYIa7ww8xEO
	 lR9TAxv5yftBIG9o+ijtbipK+0dqERSOQ71JmWgi66//DcSucYHa+J2eaXiUyTCXLP
	 DYfOpnPjJPs4WcylemJ3XbRlgPA2vyBMKr2Ec08o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390411AbfGRDHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390356AbfGRDHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:07:13 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93BE9205F4;
        Thu, 18 Jul 2019 03:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419233;
        bh=jGxMWdulzhR058UfyBeS225ZVsG+oHSXokkhjiMLPDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJyGDDAvCnlJyzOE2U+/nAA6OsZIfUM/sSW5nhurmdhEL5kaf7JJoKIKPKVc+smGV
         k8O+B5aWqVW4bQpwnnJs7F3Tmh0Snekw6eNdo49u/90903VoCWXQ50kPXenfbNCMFr
         UMIzx6olFPsa24Z9YBcEMy72dOR5Z01d5CPnXaro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 23/47] x86/boot/64: Add missing fixup_pointer() for next_early_pgt access
Date:   Thu, 18 Jul 2019 12:01:37 +0900
Message-Id: <20190718030050.669792804@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030045.780672747@linuxfoundation.org>
References: <20190718030045.780672747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c1887159eb48ba40e775584cfb2a443962cf1a05 ]

__startup_64() uses fixup_pointer() to access global variables in a
position-independent fashion. Access to next_early_pgt was wrapped into the
helper, but one instance in the 5-level paging branch was missed.

GCC generates a R_X86_64_PC32 PC-relative relocation for the access which
doesn't trigger the issue, but Clang emmits a R_X86_64_32S which leads to
an invalid memory access and system reboot.

Fixes: 187e91fe5e91 ("x86/boot/64/clang: Use fixup_pointer() to access 'next_early_pgt'")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Potapenko <glider@google.com>
Link: https://lkml.kernel.org/r/20190620112422.29264-1-kirill.shutemov@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/head64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index cc5b519dc687..250cfa85b633 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -184,7 +184,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
 
 	if (la57) {
-		p4d = fixup_pointer(early_dynamic_pgts[next_early_pgt++], physaddr);
+		p4d = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++],
+				    physaddr);
 
 		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
 		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
-- 
2.20.1



