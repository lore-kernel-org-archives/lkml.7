Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E8BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5141B21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256505;
	bh=VkJ6ltrC+LlyGGzRFGYZjr81llUHqSdHfSQ//9U8JZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wkk/4MFI4CX/F6oNL5BVbufEMBy7Q701q4frAYbR6APRHKhLnT//olMzzRZcfzvF0
	 9rdi7kY17z0FUtwBQfKcaL00RuRxRHDuJPQZmKF8ISWn9Fltop8Mj5tTpdmYzXy6Jv
	 C8E0c6Xn8Af14leofXfGwP/dFN0KYrziVV5/L85s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389160AbfCVMIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388902AbfCVMIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:08:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E94D521916;
        Fri, 22 Mar 2019 12:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256502;
        bh=VkJ6ltrC+LlyGGzRFGYZjr81llUHqSdHfSQ//9U8JZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yDbSzWsOY3LrPXDxmjWYuG8tXGb3AW4+PDbhK/56e/GGDvM18a4bIoWfWZk0Xgs6J
         3Gkxuwjt+z0Yo1TeeFQm3iJBoA2Kfr0c50GutIQvMH7R4hIW1n+O1ZzzTAbq9yXITU
         UKRrvCBMBBobP5PDi9DP7N+RDHE1slsKnPl0te4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 230/280] powerpc/traps: Fix the message printed when stack overflows
Date:   Fri, 22 Mar 2019 12:16:23 +0100
Message-Id: <20190322111337.008318680@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 9bf3d3c4e4fd82c7174f4856df372ab2a71005b9 upstream.

Today's message is useless:

  [   42.253267] Kernel stack overflow in process (ptrval), r1=c65500b0

This patch fixes it:

  [   66.905235] Kernel stack overflow in process sh[356], r1=c65560b0

Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
[mpe: Use task_pid_nr()]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/traps.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1545,8 +1545,8 @@ bail:
 
 void StackOverflow(struct pt_regs *regs)
 {
-	printk(KERN_CRIT "Kernel stack overflow in process %p, r1=%lx\n",
-	       current, regs->gpr[1]);
+	pr_crit("Kernel stack overflow in process %s[%d], r1=%lx\n",
+		current->comm, task_pid_nr(current), regs->gpr[1]);
 	debugger(regs);
 	show_regs(regs);
 	panic("kernel stack overflow");


