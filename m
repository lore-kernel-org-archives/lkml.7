Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B26C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524CF20862
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482671;
	bh=c92/BLyGFwnUnlC9RHs4LORE2AeBCegKXnWlVU3xO4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mBQgu3ccV6SMzauMMCaRXrNfbbG2oyHxI5CKiY5SuSWXMx09+eF/SsNSSJHFyDvdX
	 1WiXynObtrgyciwc+ROdt4+lpc2mY915GxiS2eIfBZbrudgEQ7CNxrA1m4nL5FMNrE
	 azK6syD3wN38XmNGBKfegQfvZ5bZXlIU95tARN58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfLDSEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:04:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbfLDSER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:04:17 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F068B20675;
        Wed,  4 Dec 2019 18:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482656;
        bh=c92/BLyGFwnUnlC9RHs4LORE2AeBCegKXnWlVU3xO4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGS8P3/8uaAjYsNfV8cY60gcL+FWw0hjUC7WwSNUctjAtdNZPsYlIy+k9tukEXsH+
         6cr4P0ffc0l76fkc9FwHg839Um1hGJ9hZ37eeO2CNThfIqWc3LkAHkdx41Mhvadjtr
         oXrp8QY5Uqk7eyyxaGHLOCFFHhPD1e0C4J/+zr8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 082/209] powerpc/book3s/32: fix number of bats in p/v_block_mapped()
Date:   Wed,  4 Dec 2019 18:54:54 +0100
Message-Id: <20191204175327.188907859@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 2a049fb8523d5..96c52271e9c2d 100644
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



