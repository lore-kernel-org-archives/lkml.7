Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF1DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDF42077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950880;
	bh=H9rYx0czH4fQK/q1YmaxFub10EO4OctXx4sO0TWZeB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a/CYA6For5tl84cawwba68z2PWeqDK7abllomD2HgW4CXHtDYetvBEtZGZ1iRPcdX
	 3SCXmcugJHU07WFGuzJFimHaYUfUqSxMTgHJ71lsGQQF1RZCx8UO103v6bP0fDGY+P
	 gWhmr/WoYCsYE5+R7O4MF8bLqk5iktp1brL9Ws7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfLJEH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:07:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfLJEHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:07:51 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4164224656;
        Tue, 10 Dec 2019 04:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950870;
        bh=H9rYx0czH4fQK/q1YmaxFub10EO4OctXx4sO0TWZeB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XxBnAZhLKbD1s5lgC5Zev7uTqsm6TYubaVAbWLr0Tji4MWYJ6Qfipv2Twx9aC75hP
         EeRLgXENaTYHS+tDE638QObWBt/IQnNkvCk1S19fd3KFmH6B9WUqaUBd6iMA6Th2Jb
         RHRSxW4QYSK28htMHsVtbnrvarO0cpk0yNitELDY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/12] powerpc: Remove comment about read_barrier_depends()
Date:   Mon,  9 Dec 2019 20:07:40 -0800
Message-Id: <20191210040741.2943-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040714.GA2715@paulmck-ThinkPad-P72>
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

'read_barrier_depends()' doesn't exist anymore so stop talking about it.

Signed-off-by: Will Deacon <will@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/powerpc/include/asm/barrier.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index fbe8df4..123adce 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -18,8 +18,6 @@
  * mb() prevents loads and stores being reordered across this point.
  * rmb() prevents loads being reordered across this point.
  * wmb() prevents stores being reordered across this point.
- * read_barrier_depends() prevents data-dependent loads being reordered
- *	across this point (nop on PPC).
  *
  * *mb() variants without smp_ prefix must order all types of memory
  * operations with one another. sync is the only instruction sufficient
-- 
2.9.5

