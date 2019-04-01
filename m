Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1333C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29A820856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139853;
	bh=4EpMchv+8Adtq0UQRmOyI/xx8HFGdMtkEteoehtrBjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fLMzBNa+5rVs0XK4u+kFXIg/fG3jAejPwOsnzU1Ijp6fWbB8ei1XsvLV8VjMgduFc
	 h5PPOGXfwHFNNuuLHfPscw95KtQddlnD3hVLLY+QG07sYKdN/5AknZjW/7XLhyjn7k
	 ABrMdg0YoXLCEiy02ZzokGhLuxpPUIrABGX3jW8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732948AbfDARaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732760AbfDARaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D10520880;
        Mon,  1 Apr 2019 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139845;
        bh=4EpMchv+8Adtq0UQRmOyI/xx8HFGdMtkEteoehtrBjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xLrsgemZA/Q+mPr/5WNyVzJSkpENMdsbG25cQQNY/rKeyJ7UHvrH4pQoAGmqbSRTh
         VwXtcBqt6xWHCXGi9pSaR9rhOFHXO2hUqsztzRG304PE8bt/+sjvXAgheqhmhwdoLt
         2S8bowa+W+XUbssZEf2sbGTGnNmrVNoSESuZFfqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiao Zhou <qiaozhou@asrmicro.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 031/131] arm64: traps: disable irq in die()
Date:   Mon,  1 Apr 2019 19:01:41 +0200
Message-Id: <20190401170054.686711639@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -239,10 +239,12 @@ void die(const char *str, struct pt_regs
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
@@ -252,13 +254,15 @@ void die(const char *str, struct pt_regs
 
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


