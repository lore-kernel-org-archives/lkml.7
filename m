Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FD0C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1792C2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127141;
	bh=KvnMzeYMC+DEtYdigmfzkFAkCX2JLyp/utJM9teUTG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W6+It+jSpXvnkBvSd0t/QKo2M7J+D8DCIFq8McSv/w2bLbTCgWAyuSi6NeiaIhsYG
	 tKgnxV+Lzw/v0r3JNbZcesEaedHx+Ou+Uvoj2LkMNwb0+iaxZamsiivZixUTKjSpy6
	 +OpVVvRWkiQ4uxS5m6jo6OiMXnEAGGZwhlWYLrug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391322AbfDXRcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391309AbfDXRcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:32:18 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BCF921906;
        Wed, 24 Apr 2019 17:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127137;
        bh=KvnMzeYMC+DEtYdigmfzkFAkCX2JLyp/utJM9teUTG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UnFInW8FkQxGS2+/5EAd9GW0fHnqExH701TkatrZ2Ulv1cZxlPWQbKsjoxXzLVTBh
         zYYux3Y/6clJsX6OBNsMJTRtzpzkB81unXkVUMw+G/gLzepc7vL+vVPYRi7XyrstF8
         N4gzUWjdPzL61PA2aMd035MQN8mL1ln4txZjoC7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 4.19 75/96] x86/speculation: Prevent deadlock on ssb_state::lock
Date:   Wed, 24 Apr 2019 19:10:20 +0200
Message-Id: <20190424170924.815623557@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
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
@@ -411,6 +411,8 @@ static __always_inline void __speculatio
 	u64 msr = x86_spec_ctrl_base;
 	bool updmsr = false;
 
+	lockdep_assert_irqs_disabled();
+
 	/*
 	 * If TIF_SSBD is different, select the proper mitigation
 	 * method. Note that if SSBD mitigation is disabled or permanentely
@@ -462,10 +464,12 @@ static unsigned long speculation_ctrl_up
 
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


