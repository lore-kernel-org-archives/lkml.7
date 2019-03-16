Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1805C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF74C218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goOCBjUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCPVCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 17:02:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43806 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfCPVCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 17:02:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so12991695wre.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 14:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Da+eKdJh0La8tbtW7xAbcurIA1olLExmmkSey1WE7Y4=;
        b=goOCBjUYfmdvX42Aa7VKJJcoyonwLBrR44aj0Asli+ULKh/+WsGoIDRi1cpTU6Ezgz
         RWYOa5NERMRTv3AVGnkJ3PlaNDULqfx0UD2KA25rdbjQFeLRi+YQQyPZ082baWCzliC6
         FjV/vTPahjD3BStaPpMJxdFWAZ0AEVjxmlZMCY14ZetS3o8SyykrPj2zzjy6/M0Ay3jU
         edI+B47AK/f5vkPeJh9fbicL2YZ3qnB2z9mGj5yKcT3KeMSB/t3Doz/V8EuR8056SiP7
         BNbg9Z/rOc0Cv4E9eu8SAMZnCnRKjKBrLQDecyIgwj+gVT1PIbo++dC3ZjWoHj626ghb
         vN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Da+eKdJh0La8tbtW7xAbcurIA1olLExmmkSey1WE7Y4=;
        b=rQ+WB/nEwhkdyxCRfPK2xfxHL9uzZpAKS2TPMupzLxGHxFPQvv9dcCZB+qFKk9rhsB
         k9kDzA513s0Qz4d5cwtsr+SLwm0yPylIDE6GZVdS7YrGIAV4QYvEPDe2d3dR2pVcAe+/
         EYBCpJV0k+7ODe+6ajcqN6TMemB+qlfZWRIeaqhrgUmOF2RjU/prbLEmKA+6zgcVQ4o6
         9Cq+fd5PwRLeQ83+EUf4Xt4OI6mI4mMXyNs4dVI7CH1IfwWq3594Thf7Qv80NcF2FSZy
         0SFOFSljd2FlH4z6P4lewRmw9KdR2+57+aoS8QICgrFkh2E3VIC5AP90ODWS3zPV6/Jb
         qnNw==
X-Gm-Message-State: APjAAAUW5/mVBRtFSJrMcJNjtcCyBAt+a15FkvmjY4W6yEtFoKCN8Xc1
        QkdcvMBAyDgOS5utuUkiIA==
X-Google-Smtp-Source: APXvYqyQaiTHy2FJLqzEq5zJhrdl5emmQiL0nsrr3onSEHrBG/P5Fcns9a+Hcn1+d2GDh+VsGz7zAw==
X-Received: by 2002:a5d:6849:: with SMTP id o9mr2408290wrw.166.1552770162388;
        Sat, 16 Mar 2019 14:02:42 -0700 (PDT)
Received: from avx2 ([46.53.243.195])
        by smtp.gmail.com with ESMTPSA id z14sm6516091wrh.29.2019.03.16.14.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 14:02:41 -0700 (PDT)
Date:   Sun, 17 Mar 2019 00:02:39 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] x86, putuser: copy pasta into 32 and 64-bit versions
Message-ID: <20190316210239.GB21830@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to rewrite 64-bit version to use normal x86_64 calling convention.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/lib/Makefile     |    3 -
 arch/x86/lib/putuser_64.S |  103 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)

--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -21,7 +21,8 @@ clean-files := inat-tables.c
 obj-$(CONFIG_SMP) += msr-smp.o cache-smp.o
 
 lib-y := delay.o misc.o cmdline.o cpu.o
-lib-y += usercopy_$(BITS).o usercopy.o getuser.o putuser.o
+lib-y += usercopy_$(BITS).o usercopy.o getuser.o
+lib-y += putuser_$(BITS).o
 lib-y += memcpy_$(BITS).o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
similarity index 100%
rename from arch/x86/lib/putuser.S
rename to arch/x86/lib/putuser_32.S
new file mode 100644
--- /dev/null
+++ b/arch/x86/lib/putuser_64.S
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * __put_user functions.
+ *
+ * (C) Copyright 2005 Linus Torvalds
+ * (C) Copyright 2005 Andi Kleen
+ * (C) Copyright 2008 Glauber Costa
+ *
+ * These functions have a non-standard call interface
+ * to make them more efficient, especially as they
+ * return an error value in addition to the "real"
+ * return value.
+ */
+#include <linux/linkage.h>
+#include <asm/thread_info.h>
+#include <asm/errno.h>
+#include <asm/asm.h>
+#include <asm/smap.h>
+#include <asm/export.h>
+
+
+/*
+ * __put_user_X
+ *
+ * Inputs:	%eax[:%edx] contains the data
+ *		%ecx contains the address
+ *
+ * Outputs:	%eax is error code (0 or -EFAULT)
+ *
+ * These functions should not modify any other registers,
+ * as they get called from within inline assembly.
+ */
+
+#define ENTER	mov PER_CPU_VAR(current_task), %_ASM_BX
+#define EXIT	ASM_CLAC ;	\
+		ret
+
+.text
+ENTRY(__put_user_1)
+	ENTER
+	cmp TASK_addr_limit(%_ASM_BX),%_ASM_CX
+	jae bad_put_user
+	ASM_STAC
+1:	movb %al,(%_ASM_CX)
+	xor %eax,%eax
+	EXIT
+ENDPROC(__put_user_1)
+EXPORT_SYMBOL(__put_user_1)
+
+ENTRY(__put_user_2)
+	ENTER
+	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
+	sub $1,%_ASM_BX
+	cmp %_ASM_BX,%_ASM_CX
+	jae bad_put_user
+	ASM_STAC
+2:	movw %ax,(%_ASM_CX)
+	xor %eax,%eax
+	EXIT
+ENDPROC(__put_user_2)
+EXPORT_SYMBOL(__put_user_2)
+
+ENTRY(__put_user_4)
+	ENTER
+	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
+	sub $3,%_ASM_BX
+	cmp %_ASM_BX,%_ASM_CX
+	jae bad_put_user
+	ASM_STAC
+3:	movl %eax,(%_ASM_CX)
+	xor %eax,%eax
+	EXIT
+ENDPROC(__put_user_4)
+EXPORT_SYMBOL(__put_user_4)
+
+ENTRY(__put_user_8)
+	ENTER
+	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
+	sub $7,%_ASM_BX
+	cmp %_ASM_BX,%_ASM_CX
+	jae bad_put_user
+	ASM_STAC
+4:	mov %_ASM_AX,(%_ASM_CX)
+#ifdef CONFIG_X86_32
+5:	movl %edx,4(%_ASM_CX)
+#endif
+	xor %eax,%eax
+	EXIT
+ENDPROC(__put_user_8)
+EXPORT_SYMBOL(__put_user_8)
+
+bad_put_user:
+	movl $-EFAULT,%eax
+	EXIT
+END(bad_put_user)
+
+	_ASM_EXTABLE_UA(1b, bad_put_user)
+	_ASM_EXTABLE_UA(2b, bad_put_user)
+	_ASM_EXTABLE_UA(3b, bad_put_user)
+	_ASM_EXTABLE_UA(4b, bad_put_user)
+#ifdef CONFIG_X86_32
+	_ASM_EXTABLE_UA(5b, bad_put_user)
+#endif
