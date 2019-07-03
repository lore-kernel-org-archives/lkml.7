Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DE2C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6050C21874
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562120482;
	bh=EKd5QM7O37RJeJVsOGu4y8h/7Si1oO7SID6TIXdkLDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D2RBQc05fueWX+PNj82IXwq4t+k6ks02Cur7M5wcjWl5F7E7jvhFokOA4AgsR15wK
	 jjNXEcUD6QthZiJoTqpexarIIo5ZaBMZzhu7BQD+ho0R5GEz96JPcj1mYp4kcqEogF
	 5BoLyervReimvPeLXBJTa7b0Owsrg6vSlk5sr28M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfGCCQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbfGCCP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:15:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8EC121880;
        Wed,  3 Jul 2019 02:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562120158;
        bh=EKd5QM7O37RJeJVsOGu4y8h/7Si1oO7SID6TIXdkLDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBV/rjfUuJ7GdMzrBci/IVd0hFCb+OHJAHRN4vvqtLGFQd+Th7ogsBGuXo5pE5dvQ
         JRyK5ASmHDZPPppSavSMvNlOh+6Pcf2LSrVmNH1tDpC5CxZeLQPRBKXwSqdpQZ3+/X
         i8cIX79TqVRlnyTXU5sfIszLwg/Tg85r5ta6A92g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Sasha Levin <sashal@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.1 29/39] x86/boot/64: Add missing fixup_pointer() for next_early_pgt access
Date:   Tue,  2 Jul 2019 22:15:04 -0400
Message-Id: <20190703021514.17727-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703021514.17727-1-sashal@kernel.org>
References: <20190703021514.17727-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill@shutemov.name>

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
index 7df5bce4e1be..29ffa495bd1c 100644
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

