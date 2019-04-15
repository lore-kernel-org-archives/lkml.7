Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4504BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C59218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353908;
	bh=lbZ61vHLb9s/CkdEAJj/+ehwlNE4J/HwEJkBiVfG6SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v3U0cQHromyc8bpLI+kbNrLQ3ipLrdAT2ogVSfKQ6eYLjLyrQ79i9CXmgKqxNhjvj
	 E+51JPuf/Zr854y4ONpCl7dp8RlY9Pc0gZZVaI1KmgZ1RMj4z/QwLX1Q5V6RwFBWjB
	 nBUiXCGetoziBt8gbnc1N9ZDo4Q7EyK9CT+/4I5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfDOSpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbfDOSpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:45:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CFD02073F;
        Mon, 15 Apr 2019 18:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353904;
        bh=lbZ61vHLb9s/CkdEAJj/+ehwlNE4J/HwEJkBiVfG6SY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0mEjzvnaHQssZKjdd/N1KN52fA3PY1Ltoa5di0freEppSSJXLpw1RDf2xB6cviYd/
         WgYR6n3WoSJJlh5BhBwhGf2TyHtresmRslpBlfl4BlQO89hJ9HNGEhqdM5SNCUhHjs
         DdQsD0jLoRthUI7WVu0IZQWNJRZLix8KAjDqAYoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 05/76] powerpc/tm: Limit TM code inside PPC_TRANSACTIONAL_MEM
Date:   Mon, 15 Apr 2019 20:43:29 +0200
Message-Id: <20190415183708.770484882@linuxfoundation.org>
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

[ Upstream commit 897bc3df8c5aebb54c32d831f917592e873d0559 ]

Commit e1c3743e1a20 ("powerpc/tm: Set MSR[TS] just prior to recheckpoint")
moved a code block around and this block uses a 'msr' variable outside of
the CONFIG_PPC_TRANSACTIONAL_MEM, however the 'msr' variable is declared
inside a CONFIG_PPC_TRANSACTIONAL_MEM block, causing a possible error when
CONFIG_PPC_TRANSACTION_MEM is not defined.

	error: 'msr' undeclared (first use in this function)

This is not causing a compilation error in the mainline kernel, because
'msr' is being used as an argument of MSR_TM_ACTIVE(), which is defined as
the following when CONFIG_PPC_TRANSACTIONAL_MEM is *not* set:

	#define MSR_TM_ACTIVE(x) 0

This patch just fixes this issue avoiding the 'msr' variable usage outside
the CONFIG_PPC_TRANSACTIONAL_MEM block, avoiding trusting in the
MSR_TM_ACTIVE() definition.

Cc: stable@vger.kernel.org
Reported-by: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Fixes: e1c3743e1a20 ("powerpc/tm: Set MSR[TS] just prior to recheckpoint")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/signal_64.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index d929afab7b24..bdf2f7b995bb 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -746,12 +746,25 @@ int sys_rt_sigreturn(unsigned long r3, unsigned long r4, unsigned long r5,
 		if (restore_tm_sigcontexts(current, &uc->uc_mcontext,
 					   &uc_transact->uc_mcontext))
 			goto badframe;
-	}
-	else
-	/* Fall through, for non-TM restore */
+	} else
 #endif
-	if (restore_sigcontext(current, NULL, 1, &uc->uc_mcontext))
-		goto badframe;
+	{
+		/*
+		 * Fall through, for non-TM restore
+		 *
+		 * Unset MSR[TS] on the thread regs since MSR from user
+		 * context does not have MSR active, and recheckpoint was
+		 * not called since restore_tm_sigcontexts() was not called
+		 * also.
+		 *
+		 * If not unsetting it, the code can RFID to userspace with
+		 * MSR[TS] set, but without CPU in the proper state,
+		 * causing a TM bad thing.
+		 */
+		current->thread.regs->msr &= ~MSR_TS_MASK;
+		if (restore_sigcontext(current, NULL, 1, &uc->uc_mcontext))
+			goto badframe;
+	}
 
 	if (restore_altstack(&uc->uc_stack))
 		goto badframe;
-- 
2.19.1



