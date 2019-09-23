Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77450C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFC7214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440021AbfIWOg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:36:58 -0400
Received: from foss.arm.com ([217.140.110.172]:43468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439984AbfIWOgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:36:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F04E1576;
        Mon, 23 Sep 2019 07:36:49 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 39C663F59C;
        Mon, 23 Sep 2019 07:36:48 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Chris Zankel <chris@zankel.net>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH v2 9/9] xtensa: entry: Remove unneeded need_resched() loop
Date:   Mon, 23 Sep 2019 15:36:20 +0100
Message-Id: <20190923143620.29334-10-valentin.schneider@arm.com>
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

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 9e3676879168..2ca209e71565 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -529,7 +529,7 @@ common_exception_return:
 	l32i	a4, a2, TI_PRE_COUNT
 	bnez	a4, 4f
 	call4	preempt_schedule_irq
-	j	1b
+	j	4f
 #endif
 
 #if XTENSA_FAKE_NMI
-- 
2.22.0

