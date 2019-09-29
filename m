Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B153C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFE121925
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569778628;
	bh=xqcbefcJOqTr5yezU+WtL17X1hRbLdYNn8J2gsa7Mc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PUhoNd+Z6xr4FZA4Z76+ZD1uq5gl1K26g+35gkUwwJ+PfcpVUZc6t+xhP8OjXB/ua
	 koKaTJlykicjJwVSXH8Kb/xSVdMNAGQBaYfbrclzHjuOkWnSzp3ibrbmUTW1ZaqUAV
	 CRgvyxRYmsn+SMsxvOhTWi5W33M0suXTZmBC4g7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbfI2RhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730965AbfI2RhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:37:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 215DA21928;
        Sun, 29 Sep 2019 17:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569778623;
        bh=xqcbefcJOqTr5yezU+WtL17X1hRbLdYNn8J2gsa7Mc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NKSlRjXsPMvsFJjIi5XTX3XZcm7zvFkp71CP6yKXPddEwfUK0Nh4GjP5+XPOwDIlB
         QLJfbYggVjXv3XvoNyxgmy4Cwo0MpJfuFxVHME30RNl3zioQhU33gzJ4xOnIuUR5Th
         xCAgnbJPDjRQa4Ct1OQWVW6ajfMmEbbSWXtqz59E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Orion Hodson <oth@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 3/9] ARM: 8898/1: mm: Don't treat faults reported from cache maintenance as writes
Date:   Sun, 29 Sep 2019 13:36:48 -0400
Message-Id: <20190929173655.10178-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190929173655.10178-1-sashal@kernel.org>
References: <20190929173655.10178-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

[ Upstream commit 834020366da9ab3fb87d1eb9a3160eb22dbed63a ]

Translation faults arising from cache maintenance instructions are
rather unhelpfully reported with an FSR value where the WnR field is set
to 1, indicating that the faulting access was a write. Since cache
maintenance instructions on 32-bit ARM do not require any particular
permissions, this can cause our private 'cacheflush' system call to fail
spuriously if a translation fault is generated due to page aging when
targetting a read-only VMA.

In this situation, we will return -EFAULT to userspace, although this is
unfortunately suppressed by the popular '__builtin___clear_cache()'
intrinsic provided by GCC, which returns void.

Although it's tempting to write this off as a userspace issue, we can
actually do a little bit better on CPUs that support LPAE, even if the
short-descriptor format is in use. On these CPUs, cache maintenance
faults additionally set the CM field in the FSR, which we can use to
suppress the write permission checks in the page fault handler and
succeed in performing cache maintenance to read-only areas even in the
presence of a translation fault.

Reported-by: Orion Hodson <oth@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/fault.c | 4 ++--
 arch/arm/mm/fault.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 0d20cd5940171..702a5542b11a8 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -211,7 +211,7 @@ static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
 {
 	unsigned int mask = VM_READ | VM_WRITE | VM_EXEC;
 
-	if (fsr & FSR_WRITE)
+	if ((fsr & FSR_WRITE) && !(fsr & FSR_CM))
 		mask = VM_WRITE;
 	if (fsr & FSR_LNX_PF)
 		mask = VM_EXEC;
@@ -281,7 +281,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
-	if (fsr & FSR_WRITE)
+	if ((fsr & FSR_WRITE) && !(fsr & FSR_CM))
 		flags |= FAULT_FLAG_WRITE;
 
 	/*
diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index 78830657cab3a..b014e57248044 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -5,6 +5,7 @@
  * Fault status register encodings.  We steal bit 31 for our own purposes.
  */
 #define FSR_LNX_PF		(1 << 31)
+#define FSR_CM			(1 << 13)
 #define FSR_WRITE		(1 << 11)
 #define FSR_FS4			(1 << 10)
 #define FSR_FS3_0		(15)
-- 
2.20.1

