Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2E1C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C2720707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403436;
	bh=sShHE3n8YsD5IgFRZKyWm5uJF1u9IVVzTomfAgpuE2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KMl7B1lAEDcaQGRbMI7EHtC2obFB8TYRe9pmZCD9ybKr1QTErJnqRcET7Y5oM8rXi
	 Z4qQGznEBERHcRNeZqou2YM/Swr/ZWa3dTFdrRD1i0L7cBjoilN2VaL8e+bbsJsieu
	 DtnNlbDyMUEaRdiH3KF2AKFtwBVss5+wryE9aaw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfKVGRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:17:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729409AbfKVGNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:13:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA4272071C;
        Fri, 22 Nov 2019 06:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403215;
        bh=sShHE3n8YsD5IgFRZKyWm5uJF1u9IVVzTomfAgpuE2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDuA0++11dqclVpYi7OPTEEQodajcR5sUZW+4BIGRFMPwNa/xagz1pvjVtrf+N4ud
         f60ZTn9nBuFfG0gIcN+2ZBtD/UDFNjVJPQBm6o2ZMtVZBLRHch7GfryL4Gkgd9+7dc
         /aP7W8cYSPMKFm9bFZx2qv8QbnHNjBUj4BxaPKcE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 30/68] powerpc/book3s/32: fix number of bats in p/v_block_mapped()
Date:   Fri, 22 Nov 2019 01:12:23 -0500
Message-Id: <20191122061301.4947-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit e93ba1b7eb5b188c749052df7af1c90821c5f320 ]

This patch fixes the loop in p_block_mapped() and v_block_mapped()
to scan the entire bat_addrs[] array.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/ppc_mmu_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 6b2f3e457171a..ae0f157d201c6 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -52,7 +52,7 @@ struct batrange {		/* stores address ranges mapped by BATs */
 phys_addr_t v_mapped_by_bats(unsigned long va)
 {
 	int b;
-	for (b = 0; b < 4; ++b)
+	for (b = 0; b < ARRAY_SIZE(bat_addrs); ++b)
 		if (va >= bat_addrs[b].start && va < bat_addrs[b].limit)
 			return bat_addrs[b].phys + (va - bat_addrs[b].start);
 	return 0;
@@ -64,7 +64,7 @@ phys_addr_t v_mapped_by_bats(unsigned long va)
 unsigned long p_mapped_by_bats(phys_addr_t pa)
 {
 	int b;
-	for (b = 0; b < 4; ++b)
+	for (b = 0; b < ARRAY_SIZE(bat_addrs); ++b)
 		if (pa >= bat_addrs[b].phys
 	    	    && pa < (bat_addrs[b].limit-bat_addrs[b].start)
 		              +bat_addrs[b].phys)
-- 
2.20.1

