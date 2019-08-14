Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B3BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3043214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NbeLsvzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfHNUYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:24:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41029 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbfHNUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:24:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so74765380oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=FWEB5IXfxLQbRwsaJv4PASoOFY+npQTdfta6EzEzKgU=;
        b=NbeLsvzTZ/5uPyXuyWNMwPV8k3h6ZPoD4/z6yigMzzoYE8yAQIcHGOxR9EUoOOGEcf
         FI/95Zs62gZaDFClUDbDoJ0EilpnfhqO/xLT6cVp0jnSkeJrE8lv7rleNw01KG923bEQ
         2gIDx/NR0DXLNDGRVkNqgk6D7QHb6TqpPYdAtV9OmV0NftWmfIFu/XS+0oK2mE5FHlJP
         TblFAJg7x8mQOepGtHPwjojbW9LHDzE1+a/98/vp/SOYbXl6GXP2emcKZyqWRpJf+Ya+
         TG0kVtnE70Ju3jt/SOEgwnTSu/wuY+l7nOAiL2122mPyZcXMUEaKFF+2u+JiPqHFNXH9
         w0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=FWEB5IXfxLQbRwsaJv4PASoOFY+npQTdfta6EzEzKgU=;
        b=qo0C/V9hgqANSWHGX2Milrgy/R/YoESeOkzXXjC3zG3OwOdFoTwj3TRA4BBGcY35Pp
         xMiWHbGPlZ1xxXx8YDctmmRjFk62U+EoN84e7B+sGcRBbePtelGbv9hij53sZ/ovwBgi
         pe91FocbWzshx4IhBGCvC0BcYVegIX4FHshkcQHCEbKaD2Oi8vs0BbEK7O+BpILc9Ewc
         lNOCydKGnVgOcGNzNJ/2JH0PJn8ui3X0fLmWLDzg/oVvqF8n3s6OLNVoWSbTDSD2I8XX
         X7wvv/uAxsDgsxIrKYjFFyGES9Kxap3dVz0F0LLMOft4rTjNtF9dcjcNOhNDVhLB+o+3
         rjpA==
X-Gm-Message-State: APjAAAXLi0qhvTYADcEArVwTYiZSvLTJGYh8Y9a3to+wiBftDudrVAh5
        n29nqSDVdRqB+geHJaGm9O0tJg==
X-Google-Smtp-Source: APXvYqxKIqV46yyI7FJbGdz0Vaq4Oyn79QGiDeiZO1OsmP/cDItUzaSREbzG+k9tnFtc4NY1VBdp3A==
X-Received: by 2002:a02:810:: with SMTP id 16mr1256799jac.121.1565814263417;
        Wed, 14 Aug 2019 13:24:23 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id s4sm1377427iop.25.2019.08.14.13.24.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 13:24:23 -0700 (PDT)
Date:   Wed, 14 Aug 2019 13:24:22 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Vincent Chen <vincent.chen@sifive.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: Correct the initialized flow of FP
 register
In-Reply-To: <1565771033-1831-2-git-send-email-vincent.chen@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1908141316060.18249@viisi.sifive.com>
References: <1565771033-1831-1-git-send-email-vincent.chen@sifive.com> <1565771033-1831-2-git-send-email-vincent.chen@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019, Vincent Chen wrote:

>   The following two reasons cause FP registers are sometimes not
> initialized before starting the user program.
> 1. Currently, the FP context is initialized in flush_thread() function
>    and we expect these initial values to be restored to FP register when
>    doing FP context switch. However, the FP context switch only occurs in
>    switch_to function. Hence, if this process does not be scheduled out
>    and scheduled in before entering the user space, the FP registers
>    have no chance to initialize.
> 2. In flush_thread(), the state of reg->sstatus.FS inherits from the
>    parent. Hence, the state of reg->sstatus.FS may be dirty. If this
>    process is scheduled out during flush_thread() and initializing the
>    FP register, the fstate_save() in switch_to will corrupt the FP context
>    which has been initialized until flush_thread().
> 
>   To solve the 1st case, the initialization of the FP register will be
> completed in start_thread(). It makes sure all FP registers are initialized
> before starting the user program. For the 2nd case, the state of
> reg->sstatus.FS in start_thread will be set to SR_FS_OFF to prevent this
> process from corrupting FP context in doing context save. The FP state is
> set to SR_FS_INITIAL in start_trhead().
> 
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks Vincent.  I fixed a 'checkpatch.pl --strict' issue, added a 
"Fixes:" line and cc'ed stable, and queued the following for v5.3-rc.


- Paul


From: Vincent Chen <vincent.chen@sifive.com>
Date: Wed, 14 Aug 2019 16:23:52 +0800
Subject: [PATCH] riscv: Correct the initialized flow of FP register

  The following two reasons cause FP registers are sometimes not
initialized before starting the user program.
1. Currently, the FP context is initialized in flush_thread() function
   and we expect these initial values to be restored to FP register when
   doing FP context switch. However, the FP context switch only occurs in
   switch_to function. Hence, if this process does not be scheduled out
   and scheduled in before entering the user space, the FP registers
   have no chance to initialize.
2. In flush_thread(), the state of reg->sstatus.FS inherits from the
   parent. Hence, the state of reg->sstatus.FS may be dirty. If this
   process is scheduled out during flush_thread() and initializing the
   FP register, the fstate_save() in switch_to will corrupt the FP context
   which has been initialized until flush_thread().

  To solve the 1st case, the initialization of the FP register will be
completed in start_thread(). It makes sure all FP registers are initialized
before starting the user program. For the 2nd case, the state of
reg->sstatus.FS in start_thread will be set to SR_FS_OFF to prevent this
process from corrupting FP context in doing context save. The FP state is
set to SR_FS_INITIAL in start_trhead().

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Fixes: 7db91e57a0acd ("RISC-V: Task implementation")
Cc: stable@vger.kernel.org
[paul.walmsley@sifive.com: fixed brace alignment issue reported by
 checkpatch]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/include/asm/switch_to.h |  6 ++++++
 arch/riscv/kernel/process.c        | 11 +++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 853b65ef656d..949d9cd91dec 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -19,6 +19,12 @@ static inline void __fstate_clean(struct pt_regs *regs)
 	regs->sstatus |= (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
 }
 
+static inline void fstate_off(struct task_struct *task,
+			      struct pt_regs *regs)
+{
+	regs->sstatus = (regs->sstatus & ~SR_FS) | SR_FS_OFF;
+}
+
 static inline void fstate_save(struct task_struct *task,
 			       struct pt_regs *regs)
 {
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index f23794bd1e90..fb3a082362eb 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -64,8 +64,14 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	unsigned long sp)
 {
 	regs->sstatus = SR_SPIE;
-	if (has_fpu)
+	if (has_fpu) {
 		regs->sstatus |= SR_FS_INITIAL;
+		/*
+		 * Restore the initial value to the FP register
+		 * before starting the user program.
+		 */
+		fstate_restore(current, regs);
+	}
 	regs->sepc = pc;
 	regs->sp = sp;
 	set_fs(USER_DS);
@@ -75,10 +81,11 @@ void flush_thread(void)
 {
 #ifdef CONFIG_FPU
 	/*
-	 * Reset FPU context
+	 * Reset FPU state and context
 	 *	frm: round to nearest, ties to even (IEEE default)
 	 *	fflags: accrued exceptions cleared
 	 */
+	fstate_off(current, task_pt_regs(current));
 	memset(&current->thread.fstate, 0, sizeof(current->thread.fstate));
 #endif
 }
-- 
2.23.0.rc1

