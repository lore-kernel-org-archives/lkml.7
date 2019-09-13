Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFB4C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE9B206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380259;
	bh=FZzabBO5Oz6BzfbFqqZaE47YsPJpQelb9ln172BMCLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wyVBZZXWp8UzyRvFPvYthK+Iu0XsWhJPWVcy7MC8rKU9CZ+9LBZr8eN7MROgk9v+m
	 ANi9ypD13gCth5Z9CZYkWg4slMxDsHGpSgld3NcpmsKzCWuzdkfXKPRflGjxE6WBK8
	 7dAa6DiOUwt9BRe6bu8TfHEDFwdMFjwQpfwYaQbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388848AbfIMNK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388191AbfIMNKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:10:51 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7603520CC7;
        Fri, 13 Sep 2019 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380250;
        bh=FZzabBO5Oz6BzfbFqqZaE47YsPJpQelb9ln172BMCLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y4d1+4JZbEfXi4vavVDJTooL4FzJkOfTH/cTOtoTUnOeljlg/H3Ld1hB16cpG/hQT
         5Ybhc0b2sZirQkVXI9hnYSfwwJHQZs7426b38trFh60t/Owtw+2mn93y1XhHxxA276
         A78m0vcl4oQuEbm3wXoUX+9xneAuw5O1ZmkQ9P6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gustavo Romero <gromero@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 06/21] powerpc/tm: Fix FP/VMX unavailable exceptions inside a transaction
Date:   Fri, 13 Sep 2019 14:06:59 +0100
Message-Id: <20190913130503.671977770@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130501.285837292@linuxfoundation.org>
References: <20190913130501.285837292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Romero <gromero@linux.ibm.com>

commit 8205d5d98ef7f155de211f5e2eb6ca03d95a5a60 upstream.

When we take an FP unavailable exception in a transaction we have to
account for the hardware FP TM checkpointed registers being
incorrect. In this case for this process we know the current and
checkpointed FP registers must be the same (since FP wasn't used
inside the transaction) hence in the thread_struct we copy the current
FP registers to the checkpointed ones.

This copy is done in tm_reclaim_thread(). We use thread->ckpt_regs.msr
to determine if FP was on when in userspace. thread->ckpt_regs.msr
represents the state of the MSR when exiting userspace. This is setup
by check_if_tm_restore_required().

Unfortunatley there is an optimisation in giveup_all() which returns
early if tsk->thread.regs->msr (via local variable `usermsr`) has
FP=VEC=VSX=SPE=0. This optimisation means that
check_if_tm_restore_required() is not called and hence
thread->ckpt_regs.msr is not updated and will contain an old value.

This can happen if due to load_fp=255 we start a userspace process
with MSR FP=1 and then we are context switched out. In this case
thread->ckpt_regs.msr will contain FP=1. If that same process is then
context switched in and load_fp overflows, MSR will have FP=0. If that
process now enters a transaction and does an FP instruction, the FP
unavailable will not update thread->ckpt_regs.msr (the bug) and MSR
FP=1 will be retained in thread->ckpt_regs.msr.  tm_reclaim_thread()
will then not perform the required memcpy and the checkpointed FP regs
in the thread struct will contain the wrong values.

The code path for this happening is:

       Userspace:                      Kernel
                   Start userspace
                    with MSR FP/VEC/VSX/SPE=0 TM=1
                      < -----
       ...
       tbegin
       bne
       fp instruction
                   FP unavailable
                       ---- >
                                        fp_unavailable_tm()
					  tm_reclaim_current()
					    tm_reclaim_thread()
					      giveup_all()
					        return early since FP/VMX/VSX=0
						/* ckpt MSR not updated (Incorrect) */
					      tm_reclaim()
					        /* thread_struct ckpt FP regs contain junk (OK) */
                                              /* Sees ckpt MSR FP=1 (Incorrect) */
					      no memcpy() performed
					        /* thread_struct ckpt FP regs not fixed (Incorrect) */
					  tm_recheckpoint()
					     /* Put junk in hardware checkpoint FP regs */
                                         ....
                      < -----
                   Return to userspace
                     with MSR TM=1 FP=1
                     with junk in the FP TM checkpoint
       TM rollback
       reads FP junk

This is a data integrity problem for the current process as the FP
registers are corrupted. It's also a security problem as the FP
registers from one process may be leaked to another.

This patch moves up check_if_tm_restore_required() in giveup_all() to
ensure thread->ckpt_regs.msr is updated correctly.

A simple testcase to replicate this will be posted to
tools/testing/selftests/powerpc/tm/tm-poison.c

Similarly for VMX.

This fixes CVE-2019-15030.

Fixes: f48e91e87e67 ("powerpc/tm: Fix FP and VMX register corruption")
Cc: stable@vger.kernel.org # 4.12+
Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190904045529.23002-1-gromero@linux.vnet.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/process.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -475,13 +475,14 @@ void giveup_all(struct task_struct *tsk)
 	if (!tsk->thread.regs)
 		return;
 
+	check_if_tm_restore_required(tsk);
+
 	usermsr = tsk->thread.regs->msr;
 
 	if ((usermsr & msr_all_available) == 0)
 		return;
 
 	msr_check_and_set(msr_all_available);
-	check_if_tm_restore_required(tsk);
 
 	WARN_ON((usermsr & MSR_VSX) && !((usermsr & MSR_FP) && (usermsr & MSR_VEC)));
 


