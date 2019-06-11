Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55160C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D4520657
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404965AbfFKJiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:38:25 -0400
Received: from foss.arm.com ([217.140.110.172]:56312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404137AbfFKJiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:38:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 200D0346;
        Tue, 11 Jun 2019 02:38:23 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 80E7F3F73C;
        Tue, 11 Jun 2019 02:38:21 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        marc.zyngier@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, james.morse@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        liwei391@huawei.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v4 1/8] arm64: Do not enable IRQs for ct_user_exit
Date:   Tue, 11 Jun 2019 10:38:06 +0100
Message-Id: <1560245893-46998-2-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560245893-46998-1-git-send-email-julien.thierry@arm.com>
References: <1560245893-46998-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For el0_dbg and el0_error, DAIF bits get explicitly cleared before
calling ct_user_exit.

When context tracking is disabled, DAIF gets set (almost) immediately
after. When context tracking is enabled, among the first things done
is disabling IRQs.

What is actually needed is:
- PSR.D = 0 so the system can be debugged (should be already the case)
- PSR.A = 0 so async error can be handled during context tracking

Do not clear PSR.I in those two locations.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Cc:Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index cd0c7af..89ab6bd 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -870,7 +870,7 @@ el0_dbg:
 	mov	x1, x25
 	mov	x2, sp
 	bl	do_debug_exception
-	enable_daif
+	enable_da_f
 	ct_user_exit
 	b	ret_to_user
 el0_inv:
@@ -922,7 +922,7 @@ el0_error_naked:
 	enable_dbg
 	mov	x0, sp
 	bl	do_serror
-	enable_daif
+	enable_da_f
 	ct_user_exit
 	b	ret_to_user
 ENDPROC(el0_error)
--
1.9.1
