Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61A8C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4276218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355263;
	bh=NSit78T3Vqt1LsLyM32f+ZxYp6oa2w0kebm1Ee3VE4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vYoo7TWP/oeLKohdFEdeH0lARkUhwQbSYbWo8yyVnOb4kMH7tJMugMrR9MPBBsan4
	 7OYeCpBot2jARfNdHpZ3orb9tiyt887KLc2sp1KL9uBc/kgp9/b8QYAzYJBjQC0GY/
	 Od9Cfivsp2KlK2ecEMAQ1VvqQDu2RybFIXJJVlQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfDOTHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbfDOTHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:07:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B77A7218D3;
        Mon, 15 Apr 2019 19:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355258;
        bh=NSit78T3Vqt1LsLyM32f+ZxYp6oa2w0kebm1Ee3VE4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwKHungADuyCoba5gn6lGjxdg1miHCO6Fy+Zx/kplS9A2UYi9KElR8ngMlX7cxfnk
         mThX+TwsekFYlGSGfVwF9hdv+BLoM1PkP4kTAjdTpt4x28XgJaT8jGyhUiB4KOHcCl
         3wjoaRt2ZravW1uzgejBSFI2d+S/+cyzKIosi/wE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 070/101] riscv: Fix syscall_get_arguments() and syscall_set_arguments()
Date:   Mon, 15 Apr 2019 20:59:08 +0200
Message-Id: <20190415183744.172230767@linuxfoundation.org>
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

From: Dmitry V. Levin <ldv@altlinux.org>

commit 10a16997db3d99fc02c026cf2c6e6c670acafab0 upstream.

RISC-V syscall arguments are located in orig_a0,a1..a5 fields
of struct pt_regs.

Due to an off-by-one bug and a bug in pointer arithmetic
syscall_get_arguments() was reading s3..s7 fields instead of a1..a5.
Likewise, syscall_set_arguments() was writing s3..s7 fields
instead of a1..a5.

Link: http://lkml.kernel.org/r/20190329171221.GA32456@altlinux.org

Fixes: e2c0cdfba7f69 ("RISC-V: User-facing API")
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Cc: stable@vger.kernel.org # v4.15+
Acked-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/riscv/include/asm/syscall.h |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -78,10 +78,11 @@ static inline void syscall_get_arguments
 	if (i == 0) {
 		args[0] = regs->orig_a0;
 		args++;
-		i++;
 		n--;
+	} else {
+		i--;
 	}
-	memcpy(args, &regs->a1 + i * sizeof(regs->a1), n * sizeof(args[0]));
+	memcpy(args, &regs->a1 + i, n * sizeof(args[0]));
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
@@ -93,10 +94,11 @@ static inline void syscall_set_arguments
         if (i == 0) {
                 regs->orig_a0 = args[0];
                 args++;
-                i++;
                 n--;
-        }
-	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
+	} else {
+		i--;
+	}
+	memcpy(&regs->a1 + i, args, n * sizeof(regs->a1));
 }
 
 #endif	/* _ASM_RISCV_SYSCALL_H */


