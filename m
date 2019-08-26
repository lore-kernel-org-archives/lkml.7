Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A0DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED96E21872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbfHZKPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:15:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbfHZKPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:15:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88ACA883C2;
        Mon, 26 Aug 2019 10:15:50 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com [10.18.17.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAFED60920;
        Mon, 26 Aug 2019 10:15:49 +0000 (UTC)
From:   Bandan Das <bsd@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] x86/apic: Do not initialize LDR and DFR for bigsmp
Date:   Mon, 26 Aug 2019 06:15:12 -0400
Message-Id: <20190826101513.5080-2-bsd@redhat.com>
In-Reply-To: <20190826101513.5080-1-bsd@redhat.com>
References: <20190826101513.5080-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 26 Aug 2019 10:15:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Legacy apic init uses bigsmp for > 8 smp systems.
In these cases, PhysFlat will invariably be used and there
is no point in initializing apic LDR and DFR. Furthermore,
calculate_ldr() helper function was incorrectly setting multiple
bits in the LDR.

This was discovered with a 32 bit KVM guest loading the kdump kernel.
Owing to the multiple bits being incorrectly set in the LDR, KVM hit a
buggy "if" condition in the kvm lapic implementation that creates the
logical destination map for vcpus - it ends up overwriting and
existing valid entry and as a result, apic calibration hangs in the
guest during kdump initialization.

Note that this change isn't intended to workaround the kvm lapic bug;
bigsmp should correctly stay away from initializing LDR.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Bandan Das <bsd@redhat.com>
---
 arch/x86/kernel/apic/bigsmp_32.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index afee386ff711..caedd8d60d36 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -38,32 +38,12 @@ static int bigsmp_early_logical_apicid(int cpu)
 	return early_per_cpu(x86_cpu_to_apicid, cpu);
 }
 
-static inline unsigned long calculate_ldr(int cpu)
-{
-	unsigned long val, id;
-
-	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
-	id = per_cpu(x86_bios_cpu_apicid, cpu);
-	val |= SET_APIC_LOGICAL_ID(id);
-
-	return val;
-}
-
 /*
- * Set up the logical destination ID.
- *
- * Intel recommends to set DFR, LDR and TPR before enabling
- * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
- * document number 292116).  So here it goes...
+ * bigsmp enables physical destination mode
+ * and doesn't use LDR and DFR
  */
 static void bigsmp_init_apic_ldr(void)
 {
-	unsigned long val;
-	int cpu = smp_processor_id();
-
-	apic_write(APIC_DFR, APIC_DFR_FLAT);
-	val = calculate_ldr(cpu);
-	apic_write(APIC_LDR, val);
 }
 
 static void bigsmp_setup_apic_routing(void)
-- 
2.20.1

