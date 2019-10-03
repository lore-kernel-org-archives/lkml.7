Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF4EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D1020865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123175;
	bh=LyoWdA0f7wwBcvyqosMNHJUlyBRTJxT4ByefN/vA58U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=COp1HQ3MxyCThLkvtHbO1aJtY1Ykrd97LBRrQLm1MUnJ1OqzfTRo8WWdnx8/25nae
	 9IJ6shPodvLkzveg5mq7to0/QdY2P7h7ZmiT3x6SpIWffWIq6BW45iEVaVBUrlSKE4
	 nyzALl38ER89eThv52wIsCfvy4hxnUfb5iP1H2PQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390960AbfJCRTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387906AbfJCQTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:19:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC552215EA;
        Thu,  3 Oct 2019 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119585;
        bh=LyoWdA0f7wwBcvyqosMNHJUlyBRTJxT4ByefN/vA58U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DrIbegAGIVQTp5SlZgeSWCP1CTvNhGyKbjNXEyaJda44LbQUd9wUqcEuDertULmHV
         p2RsU11lqiP5bQYiMSkc+VG0WT2joIr4fFS1S1WHjcH8ZTvpxLbFvm85sRFZpsyFGB
         QVTnuv9k17iJoe0mjgFwbyIk1fkDDOgr12eHIjBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 112/211] x86/mm/pti: Handle unaligned address gracefully in pti_clone_pagetable()
Date:   Thu,  3 Oct 2019 17:52:58 +0200
Message-Id: <20191003154513.070177963@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
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
index c1ba376484a5b..622d5968c9795 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -338,13 +338,15 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 
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



