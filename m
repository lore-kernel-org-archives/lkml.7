Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CB3C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E83E21874
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127461;
	bh=iODa59ZhbrOXINmDY45BZp+laDP9p7j34D9T+9UIi3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vkJzNEnIu+7VUqLR5G4avJk3S2vv9T1+uAFPs0MemGFR8lqXD+6TscxM62hcosH8Q
	 6UyeJctaUi+Ex4E2wsN6r0sy+0QFPdVOQFJMb5csUG0IBMsOj+QPT6GBkiByKrlufu
	 z9X/Uw7DwKbxJNIbQIY84tTkQ5AMzC6wzJDaflgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfHFVhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729433AbfHFVhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:37:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33D4521874;
        Tue,  6 Aug 2019 21:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127457;
        bh=iODa59ZhbrOXINmDY45BZp+laDP9p7j34D9T+9UIi3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ut8Du7jadfEuVA2EiPugos2UaFJ9tt7Te7Gg+9+lmN1kUXuA2bBU27vJ8Sw6fdxJX
         /jrzkeflyVrqv4W4q5xEA/qo3FUWNs40p2UB0nxByRhF31G0KSXMLR4IuMdx7dkMso
         V5w8d0NoWXv4MHeLspT5oJiznTepnTJcSa3gNtgQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Will Deacon <will@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 12/17] arm64/mm: fix variable 'pud' set but not used
Date:   Tue,  6 Aug 2019 17:37:09 -0400
Message-Id: <20190806213715.20487-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213715.20487-1-sashal@kernel.org>
References: <20190806213715.20487-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

[ Upstream commit 7d4e2dcf311d3b98421d1f119efe5964cafa32fc ]

GCC throws a warning,

arch/arm64/mm/mmu.c: In function 'pud_free_pmd_page':
arch/arm64/mm/mmu.c:1033:8: warning: variable 'pud' set but not used
[-Wunused-but-set-variable]
  pud_t pud;
        ^~~

because pud_table() is a macro and compiled away. Fix it by making it a
static inline function and for pud_sect() as well.

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 73e3718356b05..edb2c359480db 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -387,8 +387,8 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				 PMD_TYPE_SECT)
 
 #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
-#define pud_sect(pud)		(0)
-#define pud_table(pud)		(1)
+static inline bool pud_sect(pud_t pud) { return false; }
+static inline bool pud_table(pud_t pud) { return true; }
 #else
 #define pud_sect(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
 				 PUD_TYPE_SECT)
-- 
2.20.1

