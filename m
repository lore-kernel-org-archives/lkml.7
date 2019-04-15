Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2912C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8B62073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353957;
	bh=n4inz8fgTcSK7q+sPQjPtVdlfG1PqBQbmbjq/62cAfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n4w8mDmEJv/8LOompvgijdxNNbZdAPhDOKr5geKzTKrTldwSrfXbPvzyTwUjgTacJ
	 sjdAIPK9822O4UaDz4B5Hs/PXnmiub5LD8UChrzZBKgWzimeskNK17N2M+bpNQ42q+
	 1RWMKrgcN+xMjGsqfgvPbROCxvJ1qUhIU2fW+gxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfDOSp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbfDOSpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:45:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A308B2073F;
        Mon, 15 Apr 2019 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353953;
        bh=n4inz8fgTcSK7q+sPQjPtVdlfG1PqBQbmbjq/62cAfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xGa3V8N9VghJvZtRGY6//0a/jqpyXHNL+5VK7u/CwiJPNNhAjEe2clY1nvaxabiwW
         9gOzFi02VwGV8TbuRcJxjs6SxvDxiIJ28i+EzzlG+y/kwlciWD3DCFbwGWY+bUKNEo
         4cPhlp59RKNGYrHnV4pfE0nMag+TaYV3f7CYC2KQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 17/76] powerpc/64: Use barrier_nospec in syscall entry
Date:   Mon, 15 Apr 2019 20:43:41 +0200
Message-Id: <20190415183712.229837735@linuxfoundation.org>
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

commit 51973a815c6b46d7b23b68d6af371ad1c9d503ca upstream.

Our syscall entry is done in assembly so patch in an explicit
barrier_nospec.

Based on a patch by Michal Suchanek.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/entry_64.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index e24ae0fa80ed..11e390662384 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -38,6 +38,7 @@
 #include <asm/context_tracking.h>
 #include <asm/tm.h>
 #include <asm/ppc-opcode.h>
+#include <asm/barrier.h>
 #include <asm/export.h>
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/exception-64s.h>
@@ -180,6 +181,15 @@ system_call:			/* label this so stack traces look sane */
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
-- 
2.19.1



