Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5DDC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B0820651
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600110;
	bh=ZqQAp2f71kUMzWjXrmUXyEvoOcVtQiz/zU3rz+gLjXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iZDSZdC6tWr1/knWdgDw1pyWib87BuxO5dEp91rBdGZ+bGgVy4IWQb9f3eWwsYvbw
	 Hk7nANd34zXBKAQcr6S6yj+KIk+zwwyDxGd8rOs8KhOT8JRCPnEoMQYuUQXa858epg
	 97CkQy5KShXywy1n1XuANVeNxYJPyHby7EPFBNj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390894AbfGHPfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390729AbfGHPex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:34:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6729E2173E;
        Mon,  8 Jul 2019 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562600092;
        bh=ZqQAp2f71kUMzWjXrmUXyEvoOcVtQiz/zU3rz+gLjXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hd0gRF56gSHJBOb19XGU98/Z7WN7dL4BAGkpKYPv/oxuEn+OBTxxbAHSkHWvzLmxz
         Jo9tL+w+zkKmnykKuMK1Lvpiirmn5L6iyBaFtkY/wLCTZQHK6ptzMG+JxH5k3XXAgG
         Gi3m1ECbCZQqKpNM8HBNIItr+o2l7VvCdowUAGks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 49/96] arm64: tlbflush: Ensure start/end of address range are aligned to stride
Date:   Mon,  8 Jul 2019 17:13:21 +0200
Message-Id: <20190708150529.164511039@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 01d57485fcdb9f9101a10a18e32d5f8b023cab86 ]

Since commit 3d65b6bbc01e ("arm64: tlbi: Set MAX_TLBI_OPS to
PTRS_PER_PTE"), we resort to per-ASID invalidation when attempting to
perform more than PTRS_PER_PTE invalidation instructions in a single
call to __flush_tlb_range(). Whilst this is beneficial, the mmu_gather
code does not ensure that the end address of the range is rounded-up
to the stride when freeing intermediate page tables in pXX_free_tlb(),
which defeats our range checking.

Align the bounds passed into __flush_tlb_range().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Reported-by: Hanjun Guo <guohanjun@huawei.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/tlbflush.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 3a1870228946..dff8f9ea5754 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -195,6 +195,9 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	unsigned long asid = ASID(vma->vm_mm);
 	unsigned long addr;
 
+	start = round_down(start, stride);
+	end = round_up(end, stride);
+
 	if ((end - start) >= (MAX_TLBI_OPS * stride)) {
 		flush_tlb_mm(vma->vm_mm);
 		return;
-- 
2.20.1



