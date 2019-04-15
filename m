Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B410CC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83879218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355578;
	bh=Jzj6Vje+UQ+k+tTLbwJjWim6C9H5Cuhi9WrSuC+FPBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K1xdBzjo6RNI/e34BHjQLwc0XHKuXk7fUIyJV8bx6mT+6+xcZgFjQD189fvCfF5KG
	 hmJKGmB0xfebdFHYO4bHfljUbbUsDGKDkcGh2GvisExjoz37aDxkLPxUV1SzmKeC9l
	 K2RmDKX6s+XORvEqKYbB2JJvMWC+X0y0P1D40Wck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbfDOTM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731444AbfDOTMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:12:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FE5F2073F;
        Mon, 15 Apr 2019 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355570;
        bh=Jzj6Vje+UQ+k+tTLbwJjWim6C9H5Cuhi9WrSuC+FPBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+yR0i8p4KpZhHw1ZCVGdDCuIvVPjRXdQwuAoaMBepHOT4Slu8KwzPWvfp4I4w9gW
         VlF1P2CCQ2k6XAFWhEsfGsaNf+wgqGC30od94fFvg+2YWhhRfdJqT/0/bUUmBPvwL7
         qE5XBAi6sPWP/dlgHk/ip70m5Jhy1Fl3Wl5cu7mo=
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
Subject: [PATCH 5.0 077/117] riscv: Fix syscall_get_arguments() and syscall_set_arguments()
Date:   Mon, 15 Apr 2019 21:00:47 +0200
Message-Id: <20190415183748.852374631@linuxfoundation.org>
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
@@ -79,10 +79,11 @@ static inline void syscall_get_arguments
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
@@ -94,10 +95,11 @@ static inline void syscall_set_arguments
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
 
 static inline int syscall_get_arch(void)


