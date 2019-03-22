Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B8DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFB721916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254435;
	bh=i721EGfZ24JAuqsMgTQq07xjBicZ5WGeImgDtPnpZo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iXgjhAhQ1DJ76pKfLRRbClR4vI26B166KPewEPQXwGo7NhYk7EYbSvzaNTmXfDAwK
	 dE1umB8rdxfcuj0WKcGYj+VoCSuCGgTG8vs8S4LFK0NOfk3A2XzuESasCmxa870tOX
	 LFpXZ46ZKTpa++6mKCrdJU8nuzshUSi1w7jLxbuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfCVLdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbfCVLdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:33:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6247721916;
        Fri, 22 Mar 2019 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254427;
        bh=i721EGfZ24JAuqsMgTQq07xjBicZ5WGeImgDtPnpZo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6erh5zVo8MFC9Wj1SQjOHaiMAdkpGatJMEUT9EGIZpz0fAfdjyGvEArmxschGEsK
         A1Rocp0/ep2hUSbBAp6xfVGPx6Sy4MeUUCh13brouglgnO6B4sLHzPfLrLF/8ZEura
         5e39AJQPWUDNvCS5Zd/QNnn5ttHXaXara9FAPWzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 117/230] Revert "x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls"
Date:   Fri, 22 Mar 2019 12:14:15 +0100
Message-Id: <20190322111244.855972199@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

This reverts commit 7212e37cbdf99f48e4a6c689a42f4bda1ae69001.

Hedi Berriche <hedi.berriche@hpe.com> notes:

> In 4.4-stable efi_runtime_lock as defined in drivers/firmware/efi/runtime-wrappers.c
> is a spinlock (given it predates commit dce48e351c0d) and commit
>
>         f331e766c4be x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls
>
> which 7212e37cbdf9 is a backport of, needs it to be a semaphore.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/uv/bios.h          |    8 +-------
 arch/x86/platform/uv/bios_uv.c          |   23 ++---------------------
 drivers/firmware/efi/runtime-wrappers.c |    7 -------
 3 files changed, 3 insertions(+), 35 deletions(-)

--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -48,8 +48,7 @@ enum {
 	BIOS_STATUS_SUCCESS		=  0,
 	BIOS_STATUS_UNIMPLEMENTED	= -ENOSYS,
 	BIOS_STATUS_EINVAL		= -EINVAL,
-	BIOS_STATUS_UNAVAIL		= -EBUSY,
-	BIOS_STATUS_ABORT		= -EINTR,
+	BIOS_STATUS_UNAVAIL		= -EBUSY
 };
 
 /*
@@ -112,9 +111,4 @@ extern long system_serial_number;
 
 extern struct kobject *sgi_uv_kobj;	/* /sys/firmware/sgi_uv */
 
-/*
- * EFI runtime lock; cf. firmware/efi/runtime-wrappers.c for details
- */
-extern struct semaphore __efi_uv_runtime_lock;
-
 #endif /* _ASM_X86_UV_BIOS_H */
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -28,8 +28,7 @@
 
 static struct uv_systab uv_systab;
 
-static s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
-			u64 a4, u64 a5)
+s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
 {
 	struct uv_systab *tab = &uv_systab;
 	s64 ret;
@@ -44,19 +43,6 @@ static s64 __uv_bios_call(enum uv_bios_c
 			a1, a2, a3, a4, a5);
 	return ret;
 }
-
-s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
-{
-	s64 ret;
-
-	if (down_interruptible(&__efi_uv_runtime_lock))
-		return BIOS_STATUS_ABORT;
-
-	ret = __uv_bios_call(which, a1, a2, a3, a4, a5);
-	up(&__efi_uv_runtime_lock);
-
-	return ret;
-}
 EXPORT_SYMBOL_GPL(uv_bios_call);
 
 s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
@@ -65,15 +51,10 @@ s64 uv_bios_call_irqsave(enum uv_bios_cm
 	unsigned long bios_flags;
 	s64 ret;
 
-	if (down_interruptible(&__efi_uv_runtime_lock))
-		return BIOS_STATUS_ABORT;
-
 	local_irq_save(bios_flags);
-	ret = __uv_bios_call(which, a1, a2, a3, a4, a5);
+	ret = uv_bios_call(which, a1, a2, a3, a4, a5);
 	local_irq_restore(bios_flags);
 
-	up(&__efi_uv_runtime_lock);
-
 	return ret;
 }
 
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -88,13 +88,6 @@ static DEFINE_SPINLOCK(efi_runtime_lock)
  */
 
 /*
- * Expose the EFI runtime lock to the UV platform
- */
-#ifdef CONFIG_X86_UV
-extern struct semaphore __efi_uv_runtime_lock __alias(efi_runtime_lock);
-#endif
-
-/*
  * As per commit ef68c8f87ed1 ("x86: Serialize EFI time accesses on rtc_lock"),
  * the EFI specification requires that callers of the time related runtime
  * functions serialize with other CMOS accesses in the kernel, as the EFI time


