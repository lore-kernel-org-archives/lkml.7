Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B042CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846C320409
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403916;
	bh=QFLf3HJ6du181U9CDpuGFKVocaY+72lw3PwSNKydJss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TKJk1FYYMOA7aK3eHrqHL0YR8wowyBSvbBBFx4lwoorwBiPbu0ziyKn4OoOxPPe58
	 tDfWXdLZVyFSf2kyVeBDiVzHOEQUo47mmREH50jOTcW9p3LZqyUouWccoduAuBjr9y
	 P0olTVXhDP0e9QaoZS6beZCLX/rGB6Np7MaTngas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfKVGZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbfKVFvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:51:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 043EA2068F;
        Fri, 22 Nov 2019 05:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401870;
        bh=QFLf3HJ6du181U9CDpuGFKVocaY+72lw3PwSNKydJss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aIw6FRMDGRXtkvBAlYz3cSEHM5r45Ph00IKgZHt6/MqSCF1GLkX/p/EUYCymaQIRS
         tG8FzIuvof3WD0q4Up7yYih7WtGR9a8XDaB3g6yHQi8yCqb/pX3TEIWwgov34daXIg
         j3wNo2L0XpQJZovI8G5Z5R/LbjV716KOqTRaY6/A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 106/219] powerpc/book3s/32: fix number of bats in p/v_block_mapped()
Date:   Fri, 22 Nov 2019 00:47:18 -0500
Message-Id: <20191122054911.1750-99-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
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
index bea6c544e38f9..06783270a1242 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -52,7 +52,7 @@ struct batrange {		/* stores address ranges mapped by BATs */
 phys_addr_t v_block_mapped(unsigned long va)
 {
 	int b;
-	for (b = 0; b < 4; ++b)
+	for (b = 0; b < ARRAY_SIZE(bat_addrs); ++b)
 		if (va >= bat_addrs[b].start && va < bat_addrs[b].limit)
 			return bat_addrs[b].phys + (va - bat_addrs[b].start);
 	return 0;
@@ -64,7 +64,7 @@ phys_addr_t v_block_mapped(unsigned long va)
 unsigned long p_block_mapped(phys_addr_t pa)
 {
 	int b;
-	for (b = 0; b < 4; ++b)
+	for (b = 0; b < ARRAY_SIZE(bat_addrs); ++b)
 		if (pa >= bat_addrs[b].phys
 	    	    && pa < (bat_addrs[b].limit-bat_addrs[b].start)
 		              +bat_addrs[b].phys)
-- 
2.20.1

