Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A80C46470
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8C721734
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922545;
	bh=scCfIzNpmx/HUPT7/wV27o0Y/gkLYQtDtefb/hRmiz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sFF8pidRnCh7QOLSJ/n/aozqx++87Ufj3NVexVqViANJDCLItr0sO5kURAAo/kA23
	 HTxKguSpO2A8xhSh/Xo3afbr8lUZT7fv25c9r2RV/gQ95d0y1xxrc/Dp7x3aLH6oSQ
	 sXonu3gbXYCcvuCSJwQcCRDOSToc4ohXlpJPfmOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfEOLDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbfEOLDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:03:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22DDD20644;
        Wed, 15 May 2019 11:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918192;
        bh=scCfIzNpmx/HUPT7/wV27o0Y/gkLYQtDtefb/hRmiz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x+/DS1JTc2vzOpVvhkyB2VDHtrUUJ9ICgzwLUMZdW9HX0PBxEELsddGN2QXTRwFzP
         1GOPhwbg9LuLhsFN4+Ao5aWCQBisKvgwuxqrkNaQQQ0DsqmfptWNSVj7n13ZeikeLV
         KeqeV2I9OgRV7lKaiJbS7KOFQQ20UmtS7skCL8v8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 041/266] powerpc/64: Use barrier_nospec in syscall entry
Date:   Wed, 15 May 2019 12:52:28 +0200
Message-Id: <20190515090723.875913416@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 #include <asm/hw_irq.h>
 #include <asm/context_tracking.h>
 #include <asm/tm.h>
+#include <asm/barrier.h>
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/exception-64s.h>
 #else
@@ -177,6 +178,15 @@ system_call:			/* label this so stack tr
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


