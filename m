Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854A3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5646B218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257324;
	bh=FImW029jppW34JOe2Yo9c4JNEgjpmsIaBKwCmCd/t6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g0XakLoTt2yzZ522ozE5tFRx86KoQZ49rZ+bGropHxXk9moHJxWYxcFQZ0jIV5EA5
	 zEKDV9MkNSle+r+jtd9sCQ6Zm8w8nD/jOowhsRA1HyvzXrGOq/74LTbCNwQuz7ZsAs
	 8QqIQVaBGYsQlaQxEp9qYfQCvXWmgmR0IttxgoQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390941AbfCVMWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:32886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390253AbfCVMV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:21:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D95062054F;
        Fri, 22 Mar 2019 12:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257316;
        bh=FImW029jppW34JOe2Yo9c4JNEgjpmsIaBKwCmCd/t6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g070+yPupG51Q6t+IMrFfFKxRC9HoVtRq4Mvkc+gKEB+7KPAkU3mx6dyKDIurBDvB
         DsH3GD+tk7RZ+63zfs7c++VG78KQmsdjZiRsL1+Y3ysBhN/tnS+iIZ1/bJ2kEdRFrx
         bYoPt7nLdbVduPDLiUASP6/khBV2NcDKiIyBAzbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.0 163/238] powerpc: Fix 32-bit KVM-PR lockup and host crash with MacOS guest
Date:   Fri, 22 Mar 2019 12:16:22 +0100
Message-Id: <20190322111307.926543126@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

commit fe1ef6bcdb4fca33434256a802a3ed6aacf0bd2f upstream.

Commit 8792468da5e1 "powerpc: Add the ability to save FPU without
giving it up" unexpectedly removed the MSR_FE0 and MSR_FE1 bits from
the bitmask used to update the MSR of the previous thread in
__giveup_fpu() causing a KVM-PR MacOS guest to lockup and panic the
host kernel.

Leaving FE0/1 enabled means unrelated processes might receive FPEs
when they're not expecting them and crash. In particular if this
happens to init the host will then panic.

eg (transcribed):
  qemu-system-ppc[837]: unhandled signal 8 at 12cc9ce4 nip 12cc9ce4 lr 12cc9ca4 code 0
  systemd[1]: unhandled signal 8 at 202f02e0 nip 202f02e0 lr 001003d4 code 0
  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Reinstate these bits to the MSR bitmask to enable MacOS guests to run
under 32-bit KVM-PR once again without issue.

Fixes: 8792468da5e1 ("powerpc: Add the ability to save FPU without giving it up")
Cc: stable@vger.kernel.org # v4.6+
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/process.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -176,7 +176,7 @@ static void __giveup_fpu(struct task_str
 
 	save_fpu(tsk);
 	msr = tsk->thread.regs->msr;
-	msr &= ~MSR_FP;
+	msr &= ~(MSR_FP|MSR_FE0|MSR_FE1);
 #ifdef CONFIG_VSX
 	if (cpu_has_feature(CPU_FTR_VSX))
 		msr &= ~MSR_VSX;


