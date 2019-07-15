Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48386C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1352B205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563203436;
	bh=MSj5LcMDuO+4WZpzB8HaBhx7NFuDTADdEnuNPU/Oyf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aIFcvjGep1aesA2jVMkZ7rUrY8xbhEbsGrbDjZl6LIczvGXji68udRCWGY2QXN67h
	 IyEP6YLEx0xL4PLXc+kzMIamjxcsWX3StKENyLRd/YX1P33BI+OtZjWMSkZVNqNaN6
	 1e7ZV2o/RrJKQP9wDnpdIlMRXRk5LZOHJii3ZaC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbfGOPKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732337AbfGONzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:55:17 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 691222067C;
        Mon, 15 Jul 2019 13:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198916;
        bh=MSj5LcMDuO+4WZpzB8HaBhx7NFuDTADdEnuNPU/Oyf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVd3ltjcXqOA6GlU/mZWjGl0KiE43bjwA8lwEsVmV7231uRVQQcueUDYyK0MQ3VZv
         WFlZl24dORV96EbLFVeDcMy2Kr0KntYYu9U7b+I3E+zL72ynXLQ1lmjSqB+gOpE9Jr
         ekoO8cyvDV6l24j0aqfLj8V09xX9gLNmWKqEE0kA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 140/249] arm64: Do not enable IRQs for ct_user_exit
Date:   Mon, 15 Jul 2019 09:45:05 -0400
Message-Id: <20190715134655.4076-140-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

[ Upstream commit 9034f6251572a4744597c51dea5ab73a55f2b938 ]

For el0_dbg and el0_error, DAIF bits get explicitly cleared before
calling ct_user_exit.

When context tracking is disabled, DAIF gets set (almost) immediately
after. When context tracking is enabled, among the first things done
is disabling IRQs.

What is actually needed is:
- PSR.D = 0 so the system can be debugged (should be already the case)
- PSR.A = 0 so async error can be handled during context tracking

Do not clear PSR.I in those two locations.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 2df8d0a1d980..dbe467686332 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -859,7 +859,7 @@ el0_dbg:
 	mov	x1, x25
 	mov	x2, sp
 	bl	do_debug_exception
-	enable_daif
+	enable_da_f
 	ct_user_exit
 	b	ret_to_user
 el0_inv:
@@ -911,7 +911,7 @@ el0_error_naked:
 	enable_dbg
 	mov	x0, sp
 	bl	do_serror
-	enable_daif
+	enable_da_f
 	ct_user_exit
 	b	ret_to_user
 ENDPROC(el0_error)
-- 
2.20.1

