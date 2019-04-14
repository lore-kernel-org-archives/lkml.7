Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0259C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 17:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA67420850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 17:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfDNRvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 13:51:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43718 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfDNRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 13:51:09 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFjHW-0005tt-Ni; Sun, 14 Apr 2019 19:51:06 +0200
Date:   Sun, 14 Apr 2019 19:51:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        thomas.lendacky@amd.com
Subject: Re: [5.0.0 rc3 BUG] possible irq lock inversion dependency
 detected
In-Reply-To: <CABXGCsMcS+H9jxEotmM3u8F28zhPobvT3+Hd_iWstFQN744v6Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904141948200.4917@nanos.tec.linutronix.de>
References: <CABXGCsM8gjvh8x9QyzbrbnSb-NmWpmmEUJnFiFv5MaPkcG=Ubg@mail.gmail.com> <CABXGCsMcS+H9jxEotmM3u8F28zhPobvT3+Hd_iWstFQN744v6Q@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 14 Apr 2019, Mikhail Gavrilov wrote:

> This bug is still present in 5.1 rc4
> Why no one answered me?

Because mails fall through the cracks occasionally.

Does the patch below cure your problem?

Thanks,

	tglx

8<------------------
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -426,6 +426,8 @@ static __always_inline void __speculatio
 	u64 msr = x86_spec_ctrl_base;
 	bool updmsr = false;
 
+	lockdep_assert_irqs_disabled();
+
 	/*
 	 * If TIF_SSBD is different, select the proper mitigation
 	 * method. Note that if SSBD mitigation is disabled or permanentely
@@ -477,10 +479,12 @@ static unsigned long speculation_ctrl_up
 
 void speculation_ctrl_update(unsigned long tif)
 {
+	unsigned long flags;
+
 	/* Forced update. Make sure all relevant TIF flags are different */
-	preempt_disable();
+	local_irq_save(flags);
 	__speculation_ctrl_update(~tif, tif);
-	preempt_enable();
+	local_irq_restore(flags);
 }
 
 /* Called from seccomp/prctl update */
