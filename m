Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDF9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B18F21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127604;
	bh=rR/BmRYRECyJ327Oa3CGilUVKTTBkBLxMkfazYCRJsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kTUx6miGEotQCeV9NpybZm0ccbRbABknPqtKfMD9wNKg2ZRUfOir4WvdCCiGNjX8j
	 X+PVMioduzyGQf7+uH7ekuxLzKfaRMvYJPBn65laFoe0Tvq2Pbrp8gMeMur5J2p84K
	 2G8jynU8mAwZcGFYLl7v6fe7Gb24S+zk6Fj7WV1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404039AbfDXRkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392217AbfDXRhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:37:36 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CFFA21905;
        Wed, 24 Apr 2019 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127455;
        bh=rR/BmRYRECyJ327Oa3CGilUVKTTBkBLxMkfazYCRJsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQC6O3kW36V3OiqT3QM9wXHF6E6HEhgttHlBXosqQbaVHh/QOR4GUSLzMk37DdjC7
         v0zE0PwQyQJIzEHbRr7YRnmacxz6W6m+/3rGraYgahN0KWUuoVc0WRiMzBr2cqExdF
         h5zx5H8jZizlzdbhRhhK8jyyCAHMN1qBBofUJwgw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 5.0 098/115] x86/speculation: Prevent deadlock on ssb_state::lock
Date:   Wed, 24 Apr 2019 19:10:34 +0200
Message-Id: <20190424170930.519816869@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit 2f5fb19341883bb6e37da351bc3700489d8506a7 upstream.

Mikhail reported a lockdep splat related to the AMD specific ssb_state
lock:

  CPU0                       CPU1
  lock(&st->lock);
                             local_irq_disable();
                             lock(&(&sighand->siglock)->rlock);
                             lock(&st->lock);
  <Interrupt>
     lock(&(&sighand->siglock)->rlock);

  *** DEADLOCK ***

The connection between sighand->siglock and st->lock comes through seccomp,
which takes st->lock while holding sighand->siglock.

Make sure interrupts are disabled when __speculation_ctrl_update() is
invoked via prctl() -> speculation_ctrl_update(). Add a lockdep assert to
catch future offenders.

Fixes: 1f50ddb4f418 ("x86/speculation: Handle HT correctly on AMD")
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Thomas Lendacky <thomas.lendacky@amd.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1904141948200.4917@nanos.tec.linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/process.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -414,6 +414,8 @@ static __always_inline void __speculatio
 	u64 msr = x86_spec_ctrl_base;
 	bool updmsr = false;
 
+	lockdep_assert_irqs_disabled();
+
 	/*
 	 * If TIF_SSBD is different, select the proper mitigation
 	 * method. Note that if SSBD mitigation is disabled or permanentely
@@ -465,10 +467,12 @@ static unsigned long speculation_ctrl_up
 
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


