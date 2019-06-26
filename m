Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E0CC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCF320659
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfFZIgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:36:08 -0400
Received: from foss.arm.com ([217.140.110.172]:56352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZIgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:36:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2AEE2B;
        Wed, 26 Jun 2019 01:36:07 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.40.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 78D5E3F246;
        Wed, 26 Jun 2019 01:36:05 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steve Capper <steve.capper@arm.com>
Subject: [PATCH] arm64/mm: Drop [PTE|PMD]_TYPE_FAULT
Date:   Wed, 26 Jun 2019 14:06:10 +0530
Message-Id: <1561538170-26594-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was added part of the original commit which added MMU definitions.

commit 4f04d8f00545 ("arm64: MMU definitions").

These symbols never got used as confirmed from a git log search.

git log -p arch/arm64/ | grep PTE_TYPE_FAULT
git log -p arch/arm64/ | grep PMD_TYPE_FAULT

These probably meant to identify non present entries which can now be
achieved with PMD_SECT_VALID or PTE_VALID bits. Hence just drop these
unused symbols which are not required anymore.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 974f0114ef1b..529e83f8e607 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -126,7 +126,6 @@
  * Level 2 descriptor (PMD).
  */
 #define PMD_TYPE_MASK		(_AT(pmdval_t, 3) << 0)
-#define PMD_TYPE_FAULT		(_AT(pmdval_t, 0) << 0)
 #define PMD_TYPE_TABLE		(_AT(pmdval_t, 3) << 0)
 #define PMD_TYPE_SECT		(_AT(pmdval_t, 1) << 0)
 #define PMD_TABLE_BIT		(_AT(pmdval_t, 1) << 1)
@@ -155,7 +154,6 @@
  */
 #define PTE_VALID		(_AT(pteval_t, 1) << 0)
 #define PTE_TYPE_MASK		(_AT(pteval_t, 3) << 0)
-#define PTE_TYPE_FAULT		(_AT(pteval_t, 0) << 0)
 #define PTE_TYPE_PAGE		(_AT(pteval_t, 3) << 0)
 #define PTE_TABLE_BIT		(_AT(pteval_t, 1) << 1)
 #define PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
-- 
2.20.1

