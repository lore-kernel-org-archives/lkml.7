Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A220C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6042064B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781517;
	bh=WqoT9R7AMcKrZqWQ5NRho4R7EQhp6LMuSpwpr0HGsDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SBeqcQ/clTrdvQgZBFL9VZbo1I02ruhevgJRlb8R00QW8BdLnQE/DBE2nqwM8tiwk
	 tVVsXd2LiqE6fto0rRlcB7tVuAhhWWnCKFRfbMz/1NLevqE8qs0AMb4YvFRhsxMn2L
	 7jJqDm4juS6AUyRvEdaSj9w9NyQbH61mRGzIogNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfLSSvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:51:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729989AbfLSSvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:51:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3414620674;
        Thu, 19 Dec 2019 18:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781510;
        bh=WqoT9R7AMcKrZqWQ5NRho4R7EQhp6LMuSpwpr0HGsDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vYR9Ci29l8pFIKJb2vPYiC1NTYX22MCFHwghYS8RQlnQ/ScAC2SlMYX2V+Y8bOe9f
         lsD/NhC0kHyqYkYYVh+97QlAi/nQRc2BrGuL3kEKCOaGePbXuOXjJHv9ApyU/SpQR5
         0BaitWhN3SsLNA6EAjS7AlLtxX8oqtMboLRTmrjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 15/47] Revert "arm64: preempt: Fix big-endian when checking preempt count in assembly"
Date:   Thu, 19 Dec 2019 19:34:29 +0100
Message-Id: <20191219182913.664954881@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219182857.659088743@linuxfoundation.org>
References: <20191219182857.659088743@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 64694b276d74c653051637caa4bfa5e8c27b30ad which is
commit 7faa313f05cad184e8b17750f0cbe5216ac6debb upstream.

Turns out one of the pre-requsite patches wasn't in 4.19.y, so this
patch didn't make sense.  So let's revert it.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Reported-by: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h |    8 +++++---
 arch/arm64/kernel/entry.S          |    6 ++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -683,9 +683,11 @@ USER(\label, ic	ivau, \tmp2)			// invali
 	.macro		if_will_cond_yield_neon
 #ifdef CONFIG_PREEMPT
 	get_thread_info	x0
-	ldr		x0, [x0, #TSK_TI_PREEMPT]
-	sub		x0, x0, #PREEMPT_DISABLE_OFFSET
-	cbz		x0, .Lyield_\@
+	ldr		w1, [x0, #TSK_TI_PREEMPT]
+	ldr		x0, [x0, #TSK_TI_FLAGS]
+	cmp		w1, #PREEMPT_DISABLE_OFFSET
+	csel		x0, x0, xzr, eq
+	tbnz		x0, #TIF_NEED_RESCHED, .Lyield_\@	// needs rescheduling?
 	/* fall through to endif_yield_neon */
 	.subsection	1
 .Lyield_\@ :
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -622,8 +622,10 @@ el1_irq:
 	irq_handler
 
 #ifdef CONFIG_PREEMPT
-	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
-	cbnz	x24, 1f				// preempt count != 0
+	ldr	w24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
+	cbnz	w24, 1f				// preempt count != 0
+	ldr	x0, [tsk, #TSK_TI_FLAGS]	// get flags
+	tbz	x0, #TIF_NEED_RESCHED, 1f	// needs rescheduling?
 	bl	el1_preempt
 1:
 #endif


