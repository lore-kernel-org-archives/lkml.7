Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83421C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A41E2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556808138;
	bh=zl3f1U1qdc5+UGyWIUNpw3Pep+eDR0yy7kgp5H5+0Yw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dQuIUoXYTwdvQLwLnRmpIRnnPvFiB8TH+Ma17IuVNQ2ABaA133xgib5uXif4ythal
	 dehWid40QhiSyFTxnisJCOV5lFlCMuYSqM/eqEkXKfR8KWGAVVNWVobM99ygK1hCfF
	 c+E6X13XkXU6WCxfw/fMHG4NCE5YxNvzEAevlUDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEBOmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBOmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:42:16 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC50B20656;
        Thu,  2 May 2019 14:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556808135;
        bh=zl3f1U1qdc5+UGyWIUNpw3Pep+eDR0yy7kgp5H5+0Yw=;
        h=From:To:Cc:Subject:Date:From;
        b=l2xBFaFKiw471yvWye0sbMhxsqCsbECno6mwYPuqzPLooiFDPkn8wW2T1p2Hcwly6
         q9eFuB67kier9E6fCp4kctoQ3/YKD8iZhhEtLYTADJ/e3VsHO4IfxjhU8ZjbszQVtB
         nOOaP1qG7q3J0ygghSMeHpsbBOcxEbEFxqha4ZLo=
From:   Andy Lutomirski <luto@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rik van Riel <riel@surriel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] x86/fpu: Remove the _GPL from the kernel_fpu_begin/end() export
Date:   Thu,  2 May 2019 07:42:14 -0700
Message-Id: <761345df6285930339aced868ebf8ec459091383.1556807897.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FPU is not a super-Linuxy internal detail, so remove the _GPL
from its export.  Without something like this patch, it's impossible
for even highly license-respecting non-GPL modules to use the FPU,
which seems silly to me.  After all, the FPU is a CPU feature, not
really a kernel feature at all.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:: Borislav Petkov <bp@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: stable@vger.kernel.org
Fixes: 12209993e98c ("x86/fpu: Don't export __kernel_fpu_{begin,end}()")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---

This fixes a genuine annoyance for ZFS on Linux.  Regardless of what
one may think about the people who distribute ZFS on Linux
*binaries*, as far as I know, the source and the users who build it
themselves are entirely respectful of everyone's license.  I have no
problem with EXPORT_SYMBOL_GPL() in general, but let's please avoid
using it for things that aren't fundamentally Linux internals.

 arch/x86/kernel/fpu/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 2e5003fef51a..8de5687a470d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -127,14 +127,14 @@ void kernel_fpu_begin(void)
 	preempt_disable();
 	__kernel_fpu_begin();
 }
-EXPORT_SYMBOL_GPL(kernel_fpu_begin);
+EXPORT_SYMBOL(kernel_fpu_begin);
 
 void kernel_fpu_end(void)
 {
 	__kernel_fpu_end();
 	preempt_enable();
 }
-EXPORT_SYMBOL_GPL(kernel_fpu_end);
+EXPORT_SYMBOL(kernel_fpu_end);
 
 /*
  * Save the FPU state (mark it for reload if necessary):
-- 
2.21.0

