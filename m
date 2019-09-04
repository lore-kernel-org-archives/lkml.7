Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF29C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2085206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620631;
	bh=KrPtQpgU7KtViUDDEEXsHPNbJbqCycwcitUbwT9Qoy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CzmvhCLAEJK03Hl1d88+Z+6fN3aOr2iAbMT6V+TZSHEHAcRtejReyJDNGx7kVHnxH
	 S73IqFI7x8eGrPAhfS+y98cIoP5OCG1uK6sN6IqkB59BHHbYeU6gspRspmEzRdQ6gS
	 IvyZvrnZ9/YWi2y+CGIIAKShO07dYcJdJsNcAvNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390096AbfIDSKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389398AbfIDSK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:10:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CE2F22CEA;
        Wed,  4 Sep 2019 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620628;
        bh=KrPtQpgU7KtViUDDEEXsHPNbJbqCycwcitUbwT9Qoy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNsg+xPI8DnbsydnLs29l+dysrhB+hqzpwQdwe9mymDFI135V4Q886Qvarc0xbllR
         BMnGwbUce7Z8FEL9Lm0JfgUrj2yUN5qdr5/7GLO3hX5ZqalkssvnP7ggzJU8QONcNk
         VcmxjDc4J476VGvxj2bbHfj8dGWmSilv6jOrVoyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Schwab <schwab@suse.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 035/143] riscv: fix flush_tlb_range() end address for flush_tlb_page()
Date:   Wed,  4 Sep 2019 19:52:58 +0200
Message-Id: <20190904175315.422903595@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit eb93685847a9055283d05951c1b205e737f38533 ]

The RISC-V kernel implementation of flush_tlb_page() when CONFIG_SMP
is set is wrong.  It passes zero to flush_tlb_range() as the final
address to flush, but it should be at least 'addr'.

Some other Linux architecture ports use the beginning address to
flush, plus PAGE_SIZE, as the final address to flush.  This might
flush slightly more than what's needed, but it seems unlikely that
being more clever would improve anything.  So let's just take that
implementation for now.

While here, convert the macro into a static inline function, primarily
to avoid unintentional multiple evaluations of 'addr'.

This second version of the patch fixes a coding style issue found by
Christoph Hellwig <hch@lst.de>.

Reported-by: Andreas Schwab <schwab@suse.de>
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/tlbflush.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 687dd19735a7e..4d9bbe8438bf6 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -53,10 +53,17 @@ static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
 }
 
 #define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
-#define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, 0)
+
 #define flush_tlb_range(vma, start, end) \
 	remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) - (start))
-#define flush_tlb_mm(mm) \
+
+static inline void flush_tlb_page(struct vm_area_struct *vma,
+				  unsigned long addr)
+{
+	flush_tlb_range(vma, addr, addr + PAGE_SIZE);
+}
+
+#define flush_tlb_mm(mm)				\
 	remote_sfence_vma(mm_cpumask(mm), 0, -1)
 
 #endif /* CONFIG_SMP */
-- 
2.20.1



