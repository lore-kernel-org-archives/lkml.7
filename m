Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F21C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C0921A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178500;
	bh=E+8DDLBbjMszKWIYzvh2j4yfRBKcj4KQ5wwXpznjhCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UR2UEbYDKLYlctatW0j8hhJQSUsgrElpiIoJk3rIzL9hVNMU3HC3dRBa1TfuizKQj
	 MrSQqpBKoY7c0SsD0MzWWStAaOGx2sP9IoQr1irIJGI9d4prqvXAwX4lrKyI+dXXBa
	 uU+46/aYpVBSZzO2WXGj6S9qsC73q7xFb1flvHYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436459AbfIVSy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404530AbfIVSyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:54:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FC6921D6C;
        Sun, 22 Sep 2019 18:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178484;
        bh=E+8DDLBbjMszKWIYzvh2j4yfRBKcj4KQ5wwXpznjhCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tqY0Z4fGPlRmxG2IzsCg/7AwGeAE58wGyEaqhRFBduH1M1xfjMdKu9WWPLeMC3aIG
         zWc5VZl096FOQ3MOm7AoIerG5f1yV3Z93XHI9herejHf14KUvURjlGc8bPrMGc/ic4
         dtWShxk2ZT3nxf9iQVe+5jb6oq8qeXibvonL0WLU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 020/128] x86/apic: Soft disable APIC before initializing it
Date:   Sun, 22 Sep 2019 14:52:30 -0400
Message-Id: <20190922185418.2158-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185418.2158-1-sashal@kernel.org>
References: <20190922185418.2158-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 2640da4cccf5cc613bf26f0998b9e340f4b5f69c ]

If the APIC was already enabled on entry of setup_local_APIC() then
disabling it soft via the SPIV register makes a lot of sense.

That masks all LVT entries and brings it into a well defined state.

Otherwise previously enabled LVTs which are not touched in the setup
function stay unmasked and might surprise the just booting kernel.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105219.068290579@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/apic/apic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 9bfbe1fa0339c..dfdd1caf0d55d 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1538,6 +1538,14 @@ static void setup_local_APIC(void)
 		return;
 	}
 
+	/*
+	 * If this comes from kexec/kcrash the APIC might be enabled in
+	 * SPIV. Soft disable it before doing further initialization.
+	 */
+	value = apic_read(APIC_SPIV);
+	value &= ~APIC_SPIV_APIC_ENABLED;
+	apic_write(APIC_SPIV, value);
+
 #ifdef CONFIG_X86_32
 	/* Pound the ESR really hard over the head with a big hammer - mbligh */
 	if (lapic_is_integrated() && apic->disable_esr) {
-- 
2.20.1

