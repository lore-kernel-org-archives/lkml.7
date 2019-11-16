Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6F3C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E34721479
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921360;
	bh=8f4xeZaKgSHe+bwCZXSCAB6UIQWCoTjScHY3Svna+w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GXIPfFDvQQrI1glvHR9U3zZTI9eBThKKanIb1Un6Iy3GleTDqEByphKeNzs6wnOIt
	 LI743i4gb3iBHv5TsVTF95W39A1rS1wkJjQh/5LM96KVuadXXxs77xT22Q0s8qyWdu
	 ha3tQu3Kv7qS6+UGpgxNsTOt5iciBdBt0Mdjo0Rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfKPPnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:43:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbfKPPnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:43:11 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 293A52073B;
        Sat, 16 Nov 2019 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918991;
        bh=8f4xeZaKgSHe+bwCZXSCAB6UIQWCoTjScHY3Svna+w4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0p53hj7RihkzfSPlxDhBgu4d/kOZNwysM1t+zbh6+rMg/mdP1qiNzioSQHbHEXpR5
         nz5YofMo5REbY7wEnqeNHkv+eEqo7k0Q80Qlk3Btj07tYV25MRtmxE4jL1cfxeiSGZ
         5ZOFTmFlQvhRlKg7LfxI3u1OPGvercL76bzv2GUY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 095/237] powerpc/64s/radix: Fix radix__flush_tlb_collapsed_pmd double flushing pmd
Date:   Sat, 16 Nov 2019 10:38:50 -0500
Message-Id: <20191116154113.7417-95-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit dd76ff5af35350fd6d5bb5b069e73b6017f66893 ]

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/tlb-radix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 62be0e5732b70..02bc3ae8522f4 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -1071,7 +1071,6 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 			goto local;
 		}
 		_tlbie_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize, true);
-		goto local;
 	} else {
 local:
 		_tlbiel_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize, true);
-- 
2.20.1

