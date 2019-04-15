Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D31FC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334B42087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355105;
	bh=mF2BBxg4kqXaj9f2hI7ltrvsQ2w8gbMjYgy+7a7ZDXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GlU1tkxac//CfplPnudoEQuV6PLQHCJl+h4m/KUPZYFyT94lgsNcBM9Y5WODeAWwh
	 I091iBKhDqUOTEXGaH05DFtOr843dhySs3nKRB5GXKbsxkwObsI/s+aWTKGUhzRFGS
	 gfQPHGQP5MK2CorKMLwxrcxKHhJJ5LpMDfy1pF0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfDOTFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729640AbfDOTFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:05:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24357218A1;
        Mon, 15 Apr 2019 19:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355100;
        bh=mF2BBxg4kqXaj9f2hI7ltrvsQ2w8gbMjYgy+7a7ZDXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7DcZdj3PjWL4T2yXwjh+2Rwo1ntPaI3c1g3w+I5KOEckgcYLAZyKi/LBBYs+kSY/
         iwTekA+vOlO0Hl8HJXEIanJsqinyO38T/LBmqtcUgE8wxt2iQO8VDSHYlMhr5AUbbl
         SVEVjSraVMc08p8IzoInyxWSnWf6WEbcGbnJ4s2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 003/101] powerpc/tm: Limit TM code inside PPC_TRANSACTIONAL_MEM
Date:   Mon, 15 Apr 2019 20:58:01 +0200
Message-Id: <20190415183740.520791587@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 897bc3df8c5aebb54c32d831f917592e873d0559 upstream.

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
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/signal_64.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index bbd1c73243d7..14b0f5b6a373 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -755,12 +755,25 @@ SYSCALL_DEFINE0(rt_sigreturn)
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



