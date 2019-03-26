Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE87C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAB920863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581916;
	bh=tEPTFH14pQM5GL8qMFkugEi9XfjTGrs5r/LpIHO+8Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W4Hu3lNOr4DMtUwWvFBusJeTjZDUQoasY8dvjO7ldJxoyAqwfRoFlUMLaXm5KTqK9
	 aEVX0LhHHY2qmHyM39tvZ0swv+s0Ij2N5jTX3yGtXS8hFTIQ/060GGUlGiibCRt2rZ
	 kxqKPAazM2r2zMsav40EJhU/XAKdOKt1xupEyl2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfCZGby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731215AbfCZGbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:31:52 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 396F220863;
        Tue, 26 Mar 2019 06:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581911;
        bh=tEPTFH14pQM5GL8qMFkugEi9XfjTGrs5r/LpIHO+8Xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6yP3+d6TSRtTcGQGQUDMS0pPECtfYvAk6oE4zMJVYbZsYckoNXuH31nRTs+trJYI
         r31+hUZHgXaH4aNdPV+OrzZUp4Isf4DB6lHj9TgLAbSlk1i/+tKJboXplJUtJ3qGU/
         02ewrysADeF3PpErNFP89IdbyLWoygYbkIQRlQSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiao Zhou <qiaozhou@asrmicro.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 22/30] arm64: traps: disable irq in die()
Date:   Tue, 26 Mar 2019 15:30:01 +0900
Message-Id: <20190326042608.316746710@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiao Zhou <qiaozhou@asrmicro.com>

commit 6f44a0bacb79a03972c83759711832b382b1b8ac upstream.

In current die(), the irq is disabled for __die() handle, not
including the possible panic() handling. Since the log in __die()
can take several hundreds ms, new irq might come and interrupt
current die().

If the process calling die() holds some critical resource, and some
other process scheduled later also needs it, then it would deadlock.
The first panic will not be executed.

So here disable irq for the whole flow of die().

Signed-off-by: Qiao Zhou <qiaozhou@asrmicro.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/traps.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -266,10 +266,12 @@ void die(const char *str, struct pt_regs
 {
 	struct thread_info *thread = current_thread_info();
 	int ret;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&die_lock, flags);
 
 	oops_enter();
 
-	raw_spin_lock_irq(&die_lock);
 	console_verbose();
 	bust_spinlocks(1);
 	ret = __die(str, err, thread, regs);
@@ -279,13 +281,15 @@ void die(const char *str, struct pt_regs
 
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-	raw_spin_unlock_irq(&die_lock);
 	oops_exit();
 
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 	if (panic_on_oops)
 		panic("Fatal exception");
+
+	raw_spin_unlock_irqrestore(&die_lock, flags);
+
 	if (ret != NOTIFY_STOP)
 		do_exit(SIGSEGV);
 }


