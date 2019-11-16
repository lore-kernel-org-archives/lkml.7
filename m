Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD21CC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951D121823
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920629;
	bh=MdXxU8oNnNxUNykFVPJPxOfa36YJHrJlrvzu5GMEQSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aBEVeM7SG6q9TjGDvmWheCfhgP/GGIIpi7IQ3s6W1ll6U+PErG4pPwXBjl/QBz7kf
	 OUTctBrurUoM7/8qVWhpHWn8yejfjdSTQovIrsBiKlC8Xb9Oxijkt0EPmokeoFaKxQ
	 Y5oQyAsXoil24zSp+gwui+kYkK+UlnCGLEqQv0Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbfKPQK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:10:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730223AbfKPPs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:48:56 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6583120729;
        Sat, 16 Nov 2019 15:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919335;
        bh=MdXxU8oNnNxUNykFVPJPxOfa36YJHrJlrvzu5GMEQSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NucvSvLM16+7ngiVuF/tnsj4keI8e5+XH+IpXnmZKfFh/K0JGs07Wcr8/zH/dzeh+
         zD6b+QpI/2DjnNLO5gRNZneeyvfbjw+obpVqF5Am57pp335c81SFufSebjiYD8wQQV
         X5FacWpuxFi4rjNYHkeXYHBzsEAcdlj/ef6j6uao=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Felipe Rechia <felipe.rechia@datacom.com.br>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 076/150] powerpc/process: Fix flush_all_to_thread for SPE
Date:   Sat, 16 Nov 2019 10:46:14 -0500
Message-Id: <20191116154729.9573-76-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Rechia <felipe.rechia@datacom.com.br>

[ Upstream commit e901378578c62202594cba0f6c076f3df365ec91 ]

Fix a bug introduced by the creation of flush_all_to_thread() for
processors that have SPE (Signal Processing Engine) and use it to
compute floating-point operations.

>From userspace perspective, the problem was seen in attempts of
computing floating-point operations which should generate exceptions.
For example:

  fork();
  float x = 0.0 / 0.0;
  isnan(x);           // forked process returns False (should be True)

The operation above also should always cause the SPEFSCR FINV bit to
be set. However, the SPE floating-point exceptions were turned off
after a fork().

Kernel versions prior to the bug used flush_spe_to_thread(), which
first saves SPEFSCR register values in tsk->thread and then calls
giveup_spe(tsk).

After commit 579e633e764e, the save_all() function was called first
to giveup_spe(), and then the SPEFSCR register values were saved in
tsk->thread. This would save the SPEFSCR register values after
disabling SPE for that thread, causing the bug described above.

Fixes 579e633e764e ("powerpc: create flush_all_to_thread()")
Signed-off-by: Felipe Rechia <felipe.rechia@datacom.com.br>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/process.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 5e5da2073fdff..ba0d4f9a99bac 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -567,12 +567,11 @@ void flush_all_to_thread(struct task_struct *tsk)
 	if (tsk->thread.regs) {
 		preempt_disable();
 		BUG_ON(tsk != current);
-		save_all(tsk);
-
 #ifdef CONFIG_SPE
 		if (tsk->thread.regs->msr & MSR_SPE)
 			tsk->thread.spefscr = mfspr(SPRN_SPEFSCR);
 #endif
+		save_all(tsk);
 
 		preempt_enable();
 	}
-- 
2.20.1

