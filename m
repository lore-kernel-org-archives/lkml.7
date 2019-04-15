Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58969C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FF52075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355746;
	bh=OmzfE5MV0cNVsHTEUvFX1PTykvy8XfXmEV8QH4JX4jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y78p2cjlMnxHKymwLR4v9HHXBePB1+26iIZtvzPv/RqBFC8nk5/GhIKrwoOZEHAQy
	 mWBkWsDIbATIGmPsfy3A19Nn3es+tPE53Vth+oPSpZMspYSZgHONDWMIhduUHjDhrT
	 phfvJ4022qEafVej/in77kijUXBzSWzGt2CF+FeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbfDOTPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731081AbfDOTNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1806F2075B;
        Mon, 15 Apr 2019 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355632;
        bh=OmzfE5MV0cNVsHTEUvFX1PTykvy8XfXmEV8QH4JX4jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1DhLK5XdymPHZc+llxKrFBXOhGZp7UO3PZhHONPlMyjRLvGh6Wrq8QjCVoWl5DpDs
         DVZWr19eCHQF9k4PMKoeGlAoha9CfizpWe6+fxCDSSOfdAxs78gUOe5mk7sXoTDnCw
         g8PUMRqEwyYlCF8+WtwCexpOVS/r5UcYC7XBlUw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 5.0 094/117] arm64: backtrace: Dont bother trying to unwind the userspace stack
Date:   Mon, 15 Apr 2019 21:01:04 +0200
Message-Id: <20190415183749.624977100@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
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
@@ -102,10 +102,16 @@ static void dump_instr(const char *lvl,
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
 
@@ -126,7 +132,6 @@ void dump_backtrace(struct pt_regs *regs
 	frame.graph = 0;
 #endif
 
-	skip = !!regs;
 	printk("Call trace:\n");
 	do {
 		/* skip until specified stack frame */
@@ -176,15 +181,13 @@ static int __die(const char *str, int er
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


