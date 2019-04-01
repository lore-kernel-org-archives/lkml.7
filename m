Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C8AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB699206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139279;
	bh=U6VH4tJMwBji+xr3jucaKUTaZ+jXNLtFA0JAelIZNQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dbrCFgwSEb+lGVi1Klh4T+h5zM3vVjP0cqykem9LW+dWDBoQ5mtub7/bCOI/q2bHn
	 MUkgsz7Mb0av9Cdb8bRoREwocESZih93ULCAji1kg/uVqGJvxjCAQuAytPlSysh74z
	 x5k68sTEm7EiNzLOenF28DjhcG/Y5Y/WgRI7lqm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbfDARVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731546AbfDARVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:21:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3BA4206DD;
        Mon,  1 Apr 2019 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139276;
        bh=U6VH4tJMwBji+xr3jucaKUTaZ+jXNLtFA0JAelIZNQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Za5Ha7hA5d4VIg+rvTXMzgIGhhdYDmGxHAJHmbFHTY30XnUb3PAMvHcUUwdeMUTdp
         LzrHzlalbB6sTJabFn+WoLQ9iIh9vARzkiIMzdB5KwEhUCZcVQFwM7hq9WkP3nLdPS
         pZZteEdhEVWbh7gJeYqmEcphlJjOYUrq1pu6Q4DA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 028/107] powerpc/64: Use barrier_nospec in syscall entry
Date:   Mon,  1 Apr 2019 19:01:43 +0200
Message-Id: <20190401170048.326257686@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 51973a815c6b46d7b23b68d6af371ad1c9d503ca upstream.

Our syscall entry is done in assembly so patch in an explicit
barrier_nospec.

Based on a patch by Michal Suchanek.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/entry_64.S |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -36,6 +36,7 @@
 #include <asm/context_tracking.h>
 #include <asm/tm.h>
 #include <asm/ppc-opcode.h>
+#include <asm/barrier.h>
 #include <asm/export.h>
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/exception-64s.h>
@@ -179,6 +180,15 @@ system_call:			/* label this so stack tr
 	clrldi	r8,r8,32
 15:
 	slwi	r0,r0,4
+
+	barrier_nospec_asm
+	/*
+	 * Prevent the load of the handler below (based on the user-passed
+	 * system call number) being speculatively executed until the test
+	 * against NR_syscalls and branch to .Lsyscall_enosys above has
+	 * committed.
+	 */
+
 	ldx	r12,r11,r0	/* Fetch system call handler [ptr] */
 	mtctr   r12
 	bctrl			/* Call handler */


