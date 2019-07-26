Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F5FC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584C922CE5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149437;
	bh=fpt9gHlgHFABDDyRXQzXw1gk5uU8yrS8EcsUFXPNdQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BDTKELjLc1alDYnMPsXTS376F9H7YhoLZADhBTDau1KOxKTfOQ46PLMh1TU5EiLeD
	 Z+XO5w6DUEyAWrChIaizaqVGFdMkpZ4JMlux5sShCfrwI4vp18VW7CJ67EwXTSIaK6
	 s1oA4MuPp+n2xs205+1lPoZw04QdYAwZcBx7+lrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfGZN5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfGZNlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:41:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F62322BE8;
        Fri, 26 Jul 2019 13:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148476;
        bh=fpt9gHlgHFABDDyRXQzXw1gk5uU8yrS8EcsUFXPNdQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tIiCtH4cmSCpAD4ZuU/N4Ddlz1h4I5XYuQBkjZNXToag3d6ogjYl/FuPZoPxVgUeV
         tG7D3tH66+uRHcMH0UxqwBm5pbpO7mZCgsRizUKVVyprCW6aF9yDeNiV2J/m/kdFFd
         cMwngPQUuE4rnAbZ1ieLPjBY3pu1A5JWIpqQmzSE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Will Deacon <will.deacon@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 59/85] mm/ioremap: check virtual address alignment while creating huge mappings
Date:   Fri, 26 Jul 2019 09:39:09 -0400
Message-Id: <20190726133936.11177-59-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anshuman Khandual <anshuman.khandual@arm.com>

[ Upstream commit 6b95ab4218bfa59bc315105127ffe03aef3b5742 ]

Virtual address alignment is essential in ensuring correct clearing for
all intermediate level pgtable entries and freeing associated pgtable
pages.  An unaligned address can end up randomly freeing pgtable page
that potentially still contains valid mappings.  Hence also check it's
alignment along with existing phys_addr check.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Chintan Pandya <cpandya@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/ioremap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/ioremap.c b/lib/ioremap.c
index 063213685563..a95161d9c883 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -86,6 +86,9 @@ static int ioremap_try_huge_pmd(pmd_t *pmd, unsigned long addr,
 	if ((end - addr) != PMD_SIZE)
 		return 0;
 
+	if (!IS_ALIGNED(addr, PMD_SIZE))
+		return 0;
+
 	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
 		return 0;
 
@@ -126,6 +129,9 @@ static int ioremap_try_huge_pud(pud_t *pud, unsigned long addr,
 	if ((end - addr) != PUD_SIZE)
 		return 0;
 
+	if (!IS_ALIGNED(addr, PUD_SIZE))
+		return 0;
+
 	if (!IS_ALIGNED(phys_addr, PUD_SIZE))
 		return 0;
 
@@ -166,6 +172,9 @@ static int ioremap_try_huge_p4d(p4d_t *p4d, unsigned long addr,
 	if ((end - addr) != P4D_SIZE)
 		return 0;
 
+	if (!IS_ALIGNED(addr, P4D_SIZE))
+		return 0;
+
 	if (!IS_ALIGNED(phys_addr, P4D_SIZE))
 		return 0;
 
-- 
2.20.1

