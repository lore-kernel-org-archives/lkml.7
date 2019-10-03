Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBCDC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDD12086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120404;
	bh=YdtB9ERDjqPMpLb1hhSKMnEGtL5LAfOBUuAxVN22O04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t7okMOOsQJ7Dfb5MNYe2wTbG1Rxn3ZI/fTwLVekMJSpYWsQpyedwwCZISFyPSS4FS
	 Z8mi6kdTvKhVbyllEZK7FXAVSG3YAlm2NrUFhoLAbpPtUWjyN8bQ0vbND0rpT4HJM4
	 /hSDQmbSJ0DF6wdE9yp+CuExk01bpKH4gQFpR/8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404065AbfJCQdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404124AbfJCQdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:33:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42A89215EA;
        Thu,  3 Oct 2019 16:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120397;
        bh=YdtB9ERDjqPMpLb1hhSKMnEGtL5LAfOBUuAxVN22O04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=00wKocBBWNasNksPFmij14hafSI7lurfI5WALS/DKyy4noYBFn8Djx/cytniRSynM
         JjkYrvV62P/TEvj1KdWhrfJYG2UhsRUaAU5AEjCIcAgKgMfISG+Xg8/5Kv5+/5iywP
         EENE6VyPsOh4nThdJcqQ+m98ZaeN7KRDdMkyiv2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 159/313] x86/mm/pti: Handle unaligned address gracefully in pti_clone_pagetable()
Date:   Thu,  3 Oct 2019 17:52:17 +0200
Message-Id: <20191003154548.602201222@linuxfoundation.org>
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

From: Song Liu <songliubraving@fb.com>

[ Upstream commit 825d0b73cd7526b0bb186798583fae810091cbac ]

pti_clone_pmds() assumes that the supplied address is either:

 - properly PUD/PMD aligned
or
 - the address is actually mapped which means that independently
   of the mapping level (PUD/PMD/PTE) the next higher mapping
   exists.

If that's not the case the unaligned address can be incremented by PUD or
PMD size incorrectly. All callers supply mapped and/or aligned addresses,
but for the sake of robustness it's better to handle that case properly and
to emit a warning.

[ tglx: Rewrote changelog and added WARN_ON_ONCE() ]

Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1908282352470.1938@nanos.tec.linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/pti.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index ba22b50f4eca2..7f2140414440d 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -330,13 +330,15 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 
 		pud = pud_offset(p4d, addr);
 		if (pud_none(*pud)) {
-			addr += PUD_SIZE;
+			WARN_ON_ONCE(addr & ~PUD_MASK);
+			addr = round_up(addr + 1, PUD_SIZE);
 			continue;
 		}
 
 		pmd = pmd_offset(pud, addr);
 		if (pmd_none(*pmd)) {
-			addr += PMD_SIZE;
+			WARN_ON_ONCE(addr & ~PMD_MASK);
+			addr = round_up(addr + 1, PMD_SIZE);
 			continue;
 		}
 
-- 
2.20.1



