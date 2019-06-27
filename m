Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E928C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3B621897
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561610722;
	bh=It8qNuorDHkN++30w/QRv2Qr7Cixz/gz1T4PqMIF4Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p3Ia3oL6gXyXt5kZEyL5Ej4bMOEESvNXfMGuS6FsVoJCP4iucEm43jQswRm90mhJH
	 UKP4aSO7NHQCEc0jc/syerf80QOyPh3aCLRYdyB8rYj0t7h3lfHdDV2OW3ljFPobB4
	 EpHOBdoSj4zbt4ffDUIR5bU2Ahu94ebCgM13+p7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfF0EpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 00:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfF0EpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 00:45:17 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99DA021871;
        Thu, 27 Jun 2019 04:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561610716;
        bh=It8qNuorDHkN++30w/QRv2Qr7Cixz/gz1T4PqMIF4Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/S1g6tA36w5ZCGiw3DETjmxkhfWf0/8H4PK/ziyQkxVJCNMsRDQT/INUuLD/N/j/
         vsRGwWDvAJ+aHq51RKzHWxsT6vVnXdZN9qZqIwHHw4E9mLLZa/tYI1tfURMEeUQ+P9
         4OnNX7VYmYUw6ad95mECRjcB0g4vGLkbOjg+122c=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 7/8] x86/vsyscall: Add __ro_after_init to global variables
Date:   Wed, 26 Jun 2019 21:45:08 -0700
Message-Id: <a386925835e49d319e70c4d7404b1f6c3c2e3702.1561610354.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561610354.git.luto@kernel.org>
References: <cover.1561610354.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vDSO is only configurable by command-line options, so make its
global variables __ro_after_init.  This seems highly unlikely to
ever stop an exploit, but I think it's nice anyway.

Cc: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 9c58ab807aeb..07003f3f1bfc 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -42,7 +42,7 @@
 #define CREATE_TRACE_POINTS
 #include "vsyscall_trace.h"
 
-static enum { EMULATE, XONLY, NONE } vsyscall_mode =
+static enum { EMULATE, XONLY, NONE } vsyscall_mode __ro_after_init =
 #ifdef CONFIG_LEGACY_VSYSCALL_NONE
 	NONE;
 #elif defined(CONFIG_LEGACY_VSYSCALL_XONLY)
@@ -305,7 +305,7 @@ static const char *gate_vma_name(struct vm_area_struct *vma)
 static const struct vm_operations_struct gate_vma_ops = {
 	.name = gate_vma_name,
 };
-static struct vm_area_struct gate_vma = {
+static struct vm_area_struct gate_vma __ro_after_init = {
 	.vm_start	= VSYSCALL_ADDR,
 	.vm_end		= VSYSCALL_ADDR + PAGE_SIZE,
 	.vm_page_prot	= PAGE_READONLY_EXEC,
-- 
2.21.0

