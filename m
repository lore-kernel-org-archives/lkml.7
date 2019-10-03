Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C531C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427D020673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122815;
	bh=R84mSIxpEX1AcPIuhZJU0uwLWQyn3K4b+Mpvg9kxH0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aPk+bkywAZvILJCK3MA6dsisO7hXxU8anSE+aLbhGeLG7ZkFM49N8wvtzm3nQH2Yn
	 3VBnOwtsH0WAacHXYVCeaKV+WnEWcdMwZof73fDaUmhPiOm8y5pk3UQzQ0qDKd8etX
	 ImT3MMTBXQYz975or2BfIqqVJzyKgVKUjDgpVijo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391505AbfJCQ2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389346AbfJCQ2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:28:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67B822133F;
        Thu,  3 Oct 2019 16:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120111;
        bh=R84mSIxpEX1AcPIuhZJU0uwLWQyn3K4b+Mpvg9kxH0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NT6i6wtNm8SCLOgQduDjP8S0Uk7yLmvHyr1eGkSE1y8Kt0L3vdS3rq8b7ctiHE4ZC
         xLfysMGmm7oz9+A4NPFEIu/Ymkr+z01KIHme+jqYa7iUdSDpHYVfLbSRs64EqKimWk
         OLrV/h9DYSt6a5ApRxWtzSaUTm1+10AbZF+dBa/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 101/313] ARM: xscale: fix multi-cpu compilation
Date:   Thu,  3 Oct 2019 17:51:19 +0200
Message-Id: <20191003154542.856795646@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit c7b68049943079550d4e6af0f10aa3aabd64131a ]

Building a combined ARMv4+XScale kernel produces these
and other build failures:

/tmp/copypage-xscale-3aa821.s: Assembler messages:
/tmp/copypage-xscale-3aa821.s:167: Error: selected processor does not support `pld [r7,#0]' in ARM mode
/tmp/copypage-xscale-3aa821.s:168: Error: selected processor does not support `pld [r7,#32]' in ARM mode
/tmp/copypage-xscale-3aa821.s:169: Error: selected processor does not support `pld [r1,#0]' in ARM mode
/tmp/copypage-xscale-3aa821.s:170: Error: selected processor does not support `pld [r1,#32]' in ARM mode
/tmp/copypage-xscale-3aa821.s:171: Error: selected processor does not support `pld [r7,#64]' in ARM mode
/tmp/copypage-xscale-3aa821.s:176: Error: selected processor does not support `ldrd r4,r5,[r7],#8' in ARM mode
/tmp/copypage-xscale-3aa821.s:180: Error: selected processor does not support `strd r4,r5,[r1],#8' in ARM mode

Add an explict .arch armv5 in the inline assembly to allow the ARMv5
specific instructions regardless of the compiler -march= target.

Link: https://lore.kernel.org/r/20190809163334.489360-5-arnd@arndb.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/copypage-xscale.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
index 61d834157bc05..382e1c2855e85 100644
--- a/arch/arm/mm/copypage-xscale.c
+++ b/arch/arm/mm/copypage-xscale.c
@@ -42,6 +42,7 @@ static void mc_copy_user_page(void *from, void *to)
 	 * when prefetching destination as well.  (NP)
 	 */
 	asm volatile ("\
+.arch xscale					\n\
 	pld	[%0, #0]			\n\
 	pld	[%0, #32]			\n\
 	pld	[%1, #0]			\n\
@@ -106,8 +107,9 @@ void
 xscale_mc_clear_user_highpage(struct page *page, unsigned long vaddr)
 {
 	void *ptr, *kaddr = kmap_atomic(page);
-	asm volatile(
-	"mov	r1, %2				\n\
+	asm volatile("\
+.arch xscale					\n\
+	mov	r1, %2				\n\
 	mov	r2, #0				\n\
 	mov	r3, #0				\n\
 1:	mov	ip, %0				\n\
-- 
2.20.1



