Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32101C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7A6206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139314;
	bh=3fWez6qKtU3ATj0dro3LRfBjMBRTT+8s25leg0SMixE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eSHuHj2l0xDk1eQ3LMBpZ0LaIfzwkePFhYFCDAVypJyJBfOc6qnlfRnI4FOQ914mY
	 mjNMMqrjL8XNFyT8A6vd9uT0Qd3w/NyL/egjIVQtwqsMrVPZ0A7pRTESL1AuJywtwS
	 Ie3Es2s5IBexE8ReKNP+E32HEEZhPI5GZy+SPZ2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbfDARVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731876AbfDARVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:21:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 258C9206C0;
        Mon,  1 Apr 2019 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139310;
        bh=3fWez6qKtU3ATj0dro3LRfBjMBRTT+8s25leg0SMixE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2Ckg+Xqk1x0DgOEHjiSVpZ5n/vnoDu1S0n5OJI39ISOm/NHhFWnO7LnPVP5fi8qG
         Rkyafj+Vah9dxtQa+ElVLTF4JgKd8+jvVdYcpNDxrMWz8rGD+2/Bb4p/A7IzC6MgXB
         Yra+7U/wr5V5CrYs+WSnHKy3ToLyoe92X4oO+gJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 037/107] powerpc/fsl: Sanitize the syscall table for NXP PowerPC 32 bit platforms
Date:   Mon,  1 Apr 2019 19:01:52 +0200
Message-Id: <20190401170049.016361454@linuxfoundation.org>
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

From: Diana Craciun <diana.craciun@nxp.com>

commit c28218d4abbf4f2035495334d8bfcba64bda4787 upstream.

Used barrier_nospec to sanitize the syscall table.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/entry_32.S |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -33,6 +33,7 @@
 #include <asm/unistd.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/barrier.h>
 
 /*
  * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
@@ -358,6 +359,15 @@ syscall_dotrace_cont:
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


