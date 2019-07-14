Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1292DC742D2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D894020896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563117798;
	bh=vKxZjK6XQ4xFvpdZPzxOyvZtQo9jmMou4Hq4FfVgY1Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IaXKoSx7vLNl9leT/q6KRxQ9079zxxkrAIBUCN9RKFFqW5MhZObyvAuVDGvm8qq6o
	 boPZXnpXajB/TNQfJ1K3HBTe5ELAJw4tHsm5RBy64oqPHbjpdiJqab4bBwu2meGZ/G
	 rWAG5v+PcT/m1cj2YPYZsLD3F7o/ZPj00yjORSQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfGNPXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfGNPXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:23:17 -0400
Received: from localhost (d192-24-91-215.try.wideopenwest.com [24.192.215.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20557205F4;
        Sun, 14 Jul 2019 15:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563117796;
        bh=vKxZjK6XQ4xFvpdZPzxOyvZtQo9jmMou4Hq4FfVgY1Y=;
        h=From:To:Cc:Subject:Date:From;
        b=0Cu3LLMyoHyzBiqSyU1BUzfK5WiotNftdNq4m8I3eGu/DDa2y4+56JasrHSWg1s1p
         FUb9RmJnvG6gb6kPD20EDQZyqMPdCglHJQ8VQ0bS+V8r/fsi4Iyi1GYY8eVEUFpEf1
         wpWx5n7QetKx9NbrtUttYx1W2TUMHDX6Pe2JRc6o=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH] x86/apic: Initialize TPR to block interrupts 16-31
Date:   Sun, 14 Jul 2019 08:23:14 -0700
Message-Id: <dc04a9f8b234d7b0956a8d2560b8945bcd9c4bf7.1563117760.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The APIC, per spec, is fundamentally confused and thinks that
interrupt vectors 16-31 are valid.  This makes no sense -- the CPU
reserves vectors 0-31 for exceptions (faults, traps, etc).
Obviously, no device should actually produce an interrupt with
vector 16-31, but we can improve robustness by setting the APIC TPR
class to 1, which will prevent delivery of an interrupt with a
vector below 32.

Note: this is *not* intended as a security measure against attackers
who control malicious hardware.  Any PCI or similar hardware that
can be controlled by an attacker MUST be behind a functional IOMMU
that remaps interrupts.  The purpose of this patch is to reduce the
chance that a certain class of device malfunctions crashes the
kernel in hard-to-debug ways.

Cc: Nadav Amit <namit@vmware.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Feng Tang <feng.tang@intel.com>
Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/apic/apic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 177aa8ef2afa..ff31322f8839 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1531,11 +1531,14 @@ static void setup_local_APIC(void)
 #endif
 
 	/*
-	 * Set Task Priority to 'accept all'. We never change this
-	 * later on.
+	 * Set Task Priority to 'accept all except vectors 0-31'.  An APIC
+	 * vector in the 16-31 range could be delivered if TPR == 0, but we
+	 * would think it's an exception and terrible things will happen.  We
+	 * never change this later on.
 	 */
 	value = apic_read(APIC_TASKPRI);
 	value &= ~APIC_TPRI_MASK;
+	value |= 0x10;
 	apic_write(APIC_TASKPRI, value);
 
 	apic_pending_intr_clear();
-- 
2.21.0

