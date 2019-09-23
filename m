Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2408AC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0072B21655
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439977AbfIWOgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:36:47 -0400
Received: from foss.arm.com ([217.140.110.172]:43430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393578AbfIWOgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:36:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 256B515A2;
        Mon, 23 Sep 2019 07:36:43 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8597D3F59C;
        Mon, 23 Sep 2019 07:36:42 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guo Ren <guoren@kernel.org>
Subject: [PATCH v2 3/9] csky: entry: Remove unneeded need_resched() loop
Date:   Mon, 23 Sep 2019 15:36:14 +0100
Message-Id: <20190923143620.29334-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190923143620.29334-1-valentin.schneider@arm.com>
References: <20190923143620.29334-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the enabling and disabling of IRQs within preempt_schedule_irq()
is contained in a need_resched() loop, we don't need the outer arch
code loop.

Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/csky/kernel/entry.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index a7e84ccccbd8..679afbcc2001 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -292,11 +292,7 @@ ENTRY(csky_irq)
 	ldw	r8, (r9, TINFO_FLAGS)
 	btsti	r8, TIF_NEED_RESCHED
 	bf	2f
-1:
 	jbsr	preempt_schedule_irq	/* irq en/disable is done inside */
-	ldw	r7, (r9, TINFO_FLAGS)	/* get new tasks TI_FLAGS */
-	btsti	r7, TIF_NEED_RESCHED
-	bt	1b			/* go again */
 #endif
 2:
 	jmpi	ret_from_exception
-- 
2.22.0

