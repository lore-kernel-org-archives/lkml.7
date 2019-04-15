Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A91DC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C41A2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354247;
	bh=JbHRqqDdLox7A+1SqlhWZjj+LVtvxmrPPwy2w5Ps0vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=or+u+3BdXo61MuTXho19M6a2o8mAaOqaptx3Aa4eCX/PfcKY4dMULgTQCuOO5Ig/A
	 6YoNCMr4yk8sLg7EMppPCdmebE7MPYZV6ew6eD9+8fWGZi6ZlrY4gf6bCCYl0Q/WgF
	 qVR5iD6kRL3H/98HcuB2NC6EYfv3SPZ2NZJBlW9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfDOSq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728569AbfDOSqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:46:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11A522073F;
        Mon, 15 Apr 2019 18:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353979;
        bh=JbHRqqDdLox7A+1SqlhWZjj+LVtvxmrPPwy2w5Ps0vI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lIq61BsMt4+R+Bzetw4/IzjRsc34UWL2991IX6bDtfo1IF+nLK0geXnfEPk7793Lm
         GdwsYhqImMYI9hfeNRt+anaBJlv8CcumsFMiemu6O1UOEPLVxYM5l4RfrMt4aL5geX
         aBgo2V/R74zBnfcoenr7axWhd8oVNhOMkhQBsfrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 26/76] powerpc/fsl: Sanitize the syscall table for NXP PowerPC 32 bit platforms
Date:   Mon, 15 Apr 2019 20:43:50 +0200
Message-Id: <20190415183714.606590273@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit c28218d4abbf4f2035495334d8bfcba64bda4787 upstream.

Used barrier_nospec to sanitize the syscall table.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/entry_32.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 370645687cc7..bdd88f9d7926 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -34,6 +34,7 @@
 #include <asm/ftrace.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/barrier.h>
 
 /*
  * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
@@ -347,6 +348,15 @@ syscall_dotrace_cont:
 	ori	r10,r10,sys_call_table@l
 	slwi	r0,r0,2
 	bge-	66f
+
+	barrier_nospec_asm
+	/*
+	 * Prevent the load of the handler below (based on the user-passed
+	 * system call number) being speculatively executed until the test
+	 * against NR_syscalls and branch to .66f above has
+	 * committed.
+	 */
+
 	lwzx	r10,r10,r0	/* Fetch system call handler [ptr] */
 	mtlr	r10
 	addi	r9,r1,STACK_FRAME_OVERHEAD
-- 
2.19.1



