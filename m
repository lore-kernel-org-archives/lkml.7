Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C60C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E384F21883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="HrL2rwQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbfHHMsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:48:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44664 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732665AbfHHMsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:48:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4647TQ0kk0z9v092;
        Thu,  8 Aug 2019 14:48:26 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=HrL2rwQa; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 00jIBSq5nYKe; Thu,  8 Aug 2019 14:48:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4647TP6PC3z9v091;
        Thu,  8 Aug 2019 14:48:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565268505; bh=LkuvloXq0B1GPQ4se8YQMng+MHe39MOzCdt0xc5QcVQ=;
        h=From:Subject:To:Cc:Date:From;
        b=HrL2rwQaGJA9+MienkOeSMPmHAvp/4esoC/0OsD82dwCsmU655Ev2Eurb4kPCCEiC
         7MJgFy3wa8w7AIUXaBEXvHOb1XkhQiPc93H4bgvIVIOOlwhpaC+EWLyGvmulFGhIaa
         j9YmrpM2+euV7o1oca8D7RwP5pVj0tkWlQLK3g7w=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4EE128B870;
        Thu,  8 Aug 2019 14:48:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RX28SLrlltZi; Thu,  8 Aug 2019 14:48:27 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 12F868B85B;
        Thu,  8 Aug 2019 14:48:27 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AFE6B69623; Thu,  8 Aug 2019 12:48:26 +0000 (UTC)
Message-Id: <bef479514f4c08329fa649f67735df8918bc0976.1565268248.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/64e: drop stale call to smp_processor_id() which
 hangs SMP startup
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  8 Aug 2019 12:48:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Santa commit ebb9d30a6a74 ("powerpc/mm: any thread in one core can be
the first to setup TLB1") removed the need to know the cpu_id in
early_init_this_mmu(), but the call to smp_processor_id() which was
marked __maybe_used remained.

Since commit ed1cd6deb013 ("powerpc: Activate
CONFIG_THREAD_INFO_IN_TASK") thread_info cannot be reached before mmu
is properly set up.

Drop this stale call to smp_processor_id() which make SMP hang
when CONFIG_PREEMPT is set.

Reported-by: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Fixes: ebb9d30a6a74 ("powerpc/mm: any thread in one core can be the first to setup TLB1")
Link: https://github.com/linuxppc/issues/issues/264
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: stable@vger.kernel.org
---
 arch/powerpc/mm/nohash/tlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index d4acf6fa0596..bf60983a58c7 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -630,7 +630,6 @@ static void early_init_this_mmu(void)
 #ifdef CONFIG_PPC_FSL_BOOK3E
 	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		unsigned int num_cams;
-		int __maybe_unused cpu = smp_processor_id();
 		bool map = true;
 
 		/* use a quarter of the TLBCAM for bolted linear map */
-- 
2.13.3

