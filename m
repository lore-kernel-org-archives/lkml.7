Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1652CECE596
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAB620867
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382416;
	bh=xqcbefcJOqTr5yezU+WtL17X1hRbLdYNn8J2gsa7Mc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uPyi5Aq+jPVyZcFkM7RVhfl5ZyoHID1/BOnJ/0tg1ilDUsKwfvZCmVnBKwEEWb5dq
	 UHeMB2ZuaktgaunkAiEatuPkm8yMsI+n6fGusojgIKX50TMlkrON3oQk+BGt0ZmIwF
	 CTFdrJnxEHcJuIfHdmwUIrjvlaoongO7AHrSgbWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfJFRTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfJFRTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:19:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AE7B20835;
        Sun,  6 Oct 2019 17:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382384;
        bh=xqcbefcJOqTr5yezU+WtL17X1hRbLdYNn8J2gsa7Mc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18mCn1xRAnbpUqmu58T6ti/EnorGx44njQmZPBMWaYP/DmIygtcLfmobpHUnYsP/R
         KDZbqjVZfCg7Na2/LyM4IpwrNj4VywjV/Fvysl7jP+52lEA78hSgnbV1RxqtP4tUDV
         zPH2wihcBnj9NI7awnf6HwjbIvsslhhVsNgkH9TM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Orion Hodson <oth@google.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 16/36] ARM: 8898/1: mm: Dont treat faults reported from cache maintenance as writes
Date:   Sun,  6 Oct 2019 19:18:58 +0200
Message-Id: <20191006171051.090284415@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171038.266461022@linuxfoundation.org>
References: <20191006171038.266461022@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



