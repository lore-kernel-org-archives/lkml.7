Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96422C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741FB2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfEJP21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:28:27 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:60456 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfEJP20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:28:26 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C42CB72CCD0;
        Fri, 10 May 2019 18:28:24 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id B55AE7CCE09; Fri, 10 May 2019 18:28:24 +0300 (MSK)
Date:   Fri, 10 May 2019 18:28:24 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 5/7] powerpc: define syscall_get_error()
Message-ID: <20190510152824.GE28558@altlinux.org>
References: <20190510152640.GA28529@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510152640.GA28529@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_error() is required to be implemented on this
architecture in addition to already implemented syscall_get_nr(),
syscall_get_arguments(), syscall_get_return_value(), and
syscall_get_arch() functions in order to extend the generic
ptrace API with PTRACE_GET_SYSCALL_INFO request.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v11: added Acked-by from https://lore.kernel.org/lkml/87woj3wwmf.fsf@concordia.ellerman.id.au/
    v10: unchanged
    v9: unchanged
    v8: unchanged
    v7: unchanged
    v6: unchanged
    v5: initial revision
    
    This change has been tested with
    tools/testing/selftests/ptrace/get_syscall_info.c and strace,
    so it's correct from PTRACE_GET_SYSCALL_INFO point of view.
    
    This cast doubts on commit v4.3-rc1~86^2~81 that changed
    syscall_set_return_value() in a way that doesn't quite match
    syscall_get_error(), but syscall_set_return_value() is out
    of scope of this series, so I'll just let you know my concerns.
    
    See also https://lore.kernel.org/lkml/874lbbt3k6.fsf@concordia.ellerman.id.au/
    and https://lore.kernel.org/lkml/87woj3wwmf.fsf@concordia.ellerman.id.au/
    for more details on powerpc syscall_set_return_value() confusion.

 arch/powerpc/include/asm/syscall.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index a048fed0722f..bd9663137d57 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -38,6 +38,16 @@ static inline void syscall_rollback(struct task_struct *task,
 	regs->gpr[3] = regs->orig_gpr3;
 }
 
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	/*
+	 * If the system call failed,
+	 * regs->gpr[3] contains a positive ERRORCODE.
+	 */
+	return (regs->ccr & 0x10000000UL) ? -regs->gpr[3] : 0;
+}
+
 static inline long syscall_get_return_value(struct task_struct *task,
 					    struct pt_regs *regs)
 {
-- 
ldv
