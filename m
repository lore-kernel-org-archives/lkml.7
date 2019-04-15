Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D1CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9C32087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355341;
	bh=qY7SeKY+Huge9Eq1hAK9oCstFZApOcYzOHXgmCs2CKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rz8tO5bb4qBXqPm9KMtvlEy8cpQyPz3951AVCPkU/V1jMhqY40RjC3k/BlW4gDfX3
	 JUE1cDSTF2v1LLRDduvezELrK6qIDnRPCngdZHypJqcZ+5ZBRFVqyRddEP2ckh3OWw
	 L1Hf+OFycBlqNW88Ck2axZVsHu+u4t8DdKJ14RtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbfDOTJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730598AbfDOTI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:08:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E83E92087C;
        Mon, 15 Apr 2019 19:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355337;
        bh=qY7SeKY+Huge9Eq1hAK9oCstFZApOcYzOHXgmCs2CKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oU9sUTlrCbp8k2hZXMPZOSiRGeYFZRAu36bTndfRH4l1Ed2hn4NMfjnetCKCsxhcY
         a7ZjN8cye1xWx029xryZfxl9dFiGXPgL2eX1bVidspclZ5FLJhftB7pp6vZMYAidOe
         3RjfvHE4rXlp2gkP83fTPDRoHzkojeMlAUkfsSRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.19 082/101] arm64: backtrace: Dont bother trying to unwind the userspace stack
Date:   Mon, 15 Apr 2019 20:59:20 +0200
Message-Id: <20190415183744.750934705@linuxfoundation.org>
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

From: Will Deacon <will.deacon@arm.com>

commit 1e6f5440a6814d28c32d347f338bfef68bc3e69d upstream.

Calling dump_backtrace() with a pt_regs argument corresponding to
userspace doesn't make any sense and our unwinder will simply print
"Call trace:" before unwinding the stack looking for user frames.

Rather than go through this song and dance, just return early if we're
passed a user register state.

Cc: <stable@vger.kernel.org>
Fixes: 1149aad10b1e ("arm64: Add dump_backtrace() in show_regs")
Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/traps.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -101,10 +101,16 @@ static void dump_instr(const char *lvl,
 void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 {
 	struct stackframe frame;
-	int skip;
+	int skip = 0;
 
 	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
 
+	if (regs) {
+		if (user_mode(regs))
+			return;
+		skip = 1;
+	}
+
 	if (!tsk)
 		tsk = current;
 
@@ -125,7 +131,6 @@ void dump_backtrace(struct pt_regs *regs
 	frame.graph = tsk->curr_ret_stack;
 #endif
 
-	skip = !!regs;
 	printk("Call trace:\n");
 	do {
 		/* skip until specified stack frame */
@@ -175,15 +180,13 @@ static int __die(const char *str, int er
 		return ret;
 
 	print_modules();
-	__show_regs(regs);
 	pr_emerg("Process %.*s (pid: %d, stack limit = 0x%p)\n",
 		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk),
 		 end_of_stack(tsk));
+	show_regs(regs);
 
-	if (!user_mode(regs)) {
-		dump_backtrace(regs, tsk);
+	if (!user_mode(regs))
 		dump_instr(KERN_EMERG, regs);
-	}
 
 	return ret;
 }


