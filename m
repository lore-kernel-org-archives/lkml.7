Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4865DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6A9205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414124;
	bh=3njfcR6Vu3BkGaHB6lX+WLTJPmhSQI4izfkmdTrye/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VOKWq0Qpp62WGDnzKK6plqhuYNt4okHQJ/N7XgCKAN7HK2W0AJlvSj88GWY4vX6lo
	 YjkNOk/Ha02JoihuypYxQhqw3M6U0FnGUki+zzAcr+RhPv9tEl8GCwVkvPOKZ2E8eY
	 TueXRQwWCmjtVMJKn5qdHGT+rErMS9kP/oEWwf3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfCLSIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfCLRMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:14 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 277242171F;
        Tue, 12 Mar 2019 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410733;
        bh=3njfcR6Vu3BkGaHB6lX+WLTJPmhSQI4izfkmdTrye/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQg46hePsRBdBF2xahFvEjk1EctxYa6OvkBXh7iaPzTdg2AjrIwDm9UXWekmPOOli
         umAMfg/UaxNBw0zDvdGTwjvdHAQWqekkDUzQ6u9fjvhWejoICX+ovORy8mXsC6P9RA
         p9z7mosDi0EjxAVcxUWQglHul3BgTNejFEsnrrMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Huang <wei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        bp@alien8.de, hpa@zytor.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 054/171] x86/boot/compressed/64: Set EFER.LME=1 in 32-bit trampoline before returning to long mode
Date:   Tue, 12 Mar 2019 10:07:14 -0700
Message-Id: <20190312170352.778671364@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b677dfae5aa197afc5191755a76a8727ffca538a ]

In some old AMD KVM implementation, guest's EFER.LME bit is cleared by KVM
when the hypervsior detects that the guest sets CR0.PG to 0. This causes
the guest OS to reboot when it tries to return from 32-bit trampoline code
because the CPU is in incorrect state: CR4.PAE=1, CR0.PG=1, CS.L=1, but
EFER.LME=0.  As a precaution, set EFER.LME=1 as part of long mode
activation procedure. This extra step won't cause any harm when Linux is
booted on a bare-metal machine.

Signed-off-by: Wei Huang <wei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20190104054411.12489-1-wei@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 8 ++++++++
 arch/x86/boot/compressed/pgtable.h | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 64037895b085..f105ae8651c9 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -600,6 +600,14 @@ ENTRY(trampoline_32bit_src)
 	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%ecx), %eax
 	movl	%eax, %cr3
 3:
+	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
+	pushl	%ecx
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	btsl	$_EFER_LME, %eax
+	wrmsr
+	popl	%ecx
+
 	/* Enable PAE and LA57 (if required) paging modes */
 	movl	$X86_CR4_PAE, %eax
 	cmpl	$0, %edx
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index 91f75638f6e6..6ff7e81b5628 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -6,7 +6,7 @@
 #define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
 
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
-#define TRAMPOLINE_32BIT_CODE_SIZE	0x60
+#define TRAMPOLINE_32BIT_CODE_SIZE	0x70
 
 #define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
 
-- 
2.19.1



