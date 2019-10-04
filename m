Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B7AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 04:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B1D215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 04:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbfJDEX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 00:23:58 -0400
Received: from foss.arm.com ([217.140.110.172]:34814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387709AbfJDEX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 00:23:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB6CC15A1;
        Thu,  3 Oct 2019 21:23:57 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.5])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D5AF33F739;
        Thu,  3 Oct 2019 21:23:54 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Poison initmem while freeing with free_reserved_area()
Date:   Fri,  4 Oct 2019 09:53:58 +0530
Message-Id: <1570163038-32067-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform implementation for free_initmem() should poison the memory while
freeing it up. Hence pass across POISON_FREE_INITMEM while calling into
free_reserved_area(). The same is being followed in the generic fallback
for free_initmem() and some other platforms overriding it.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 45c00a54909c..ea7d38011e83 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -571,7 +571,7 @@ void free_initmem(void)
 {
 	free_reserved_area(lm_alias(__init_begin),
 			   lm_alias(__init_end),
-			   0, "unused kernel");
+			   POISON_FREE_INITMEM, "unused kernel");
 	/*
 	 * Unmap the __init region but leave the VM area in place. This
 	 * prevents the region from being reused for kernel modules, which
-- 
2.20.1

