Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D42C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93BA222C5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497273;
	bh=ruQE4AZSfn+uFm1Jnz+1l3fCPEtKaaORfqJq7BvjEco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=op3Wj7F65ydtoHdtb1DcxZbKYwRLyrnaU11i0wDoAP3bE3a7LHBdg8csfxgTkW/Xq
	 2ZJ3Vi49zhcQIxGssOLRNjCo6LO6kk1rUFL8XqCxXwhA3+uTnaQ5DHmySd1uFlAR/V
	 PPJ53REimA5Ms2FByIeThqdFlLIEDSFJK712FSbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfKKSec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:34:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbfKKSea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:34:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E60A21655;
        Mon, 11 Nov 2019 18:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497269;
        bh=ruQE4AZSfn+uFm1Jnz+1l3fCPEtKaaORfqJq7BvjEco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OGN2+CGyS4M4OjOqLrNAJ4rURZRJPFWhhcq6GscRKgzXB4IwJvuC+Cdt1z31xGmQs
         7qpjalSgA7g/5TOHUMO8pWawkwShz97UwSBTX1P7MJqpeMx2nPqVvgwAAqSSzaChCT
         V0PgJKogznaaiJgBVqNiY2r6VYQlYLPPawqp7/hw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 62/65] x86/apic/32: Avoid bogus LDR warnings
Date:   Mon, 11 Nov 2019 19:29:02 +0100
Message-Id: <20191111181356.216949292@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181331.917659011@linuxfoundation.org>
References: <20191111181331.917659011@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Beulich <jbeulich@suse.com>

[ Upstream commit fe6f85ca121e9c74e7490fe66b0c5aae38e332c3 ]

The removal of the LDR initialization in the bigsmp_32 APIC code unearthed
a problem in setup_local_APIC().

The code checks unconditionally for a mismatch of the logical APIC id by
comparing the early APIC id which was initialized in get_smp_config() with
the actual LDR value in the APIC.

Due to the removal of the bogus LDR initialization the check now can
trigger on bigsmp_32 APIC systems emitting a warning for every booting
CPU. This is of course a false positive because the APIC is not using
logical destination mode.

Restrict the check and the possibly resulting fixup to systems which are
actually using the APIC in logical destination mode.

[ tglx: Massaged changelog and added Cc stable ]

Fixes: bae3a8d3308 ("x86/apic: Do not initialize LDR and DFR for bigsmp")
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/666d8f91-b5a8-1afd-7add-821e72a35f03@suse.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/apic/apic.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index ad2a220a4a7f7..722a76b88bcc0 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1341,9 +1341,6 @@ void setup_local_APIC(void)
 {
 	int cpu = smp_processor_id();
 	unsigned int value;
-#ifdef CONFIG_X86_32
-	int logical_apicid, ldr_apicid;
-#endif
 
 
 	if (disable_apic) {
@@ -1384,16 +1381,21 @@ void setup_local_APIC(void)
 	apic->init_apic_ldr();
 
 #ifdef CONFIG_X86_32
-	/*
-	 * APIC LDR is initialized.  If logical_apicid mapping was
-	 * initialized during get_smp_config(), make sure it matches the
-	 * actual value.
-	 */
-	logical_apicid = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
-	ldr_apicid = GET_APIC_LOGICAL_ID(apic_read(APIC_LDR));
-	WARN_ON(logical_apicid != BAD_APICID && logical_apicid != ldr_apicid);
-	/* always use the value from LDR */
-	early_per_cpu(x86_cpu_to_logical_apicid, cpu) = ldr_apicid;
+	if (apic->dest_logical) {
+		int logical_apicid, ldr_apicid;
+
+		/*
+		 * APIC LDR is initialized.  If logical_apicid mapping was
+		 * initialized during get_smp_config(), make sure it matches
+		 * the actual value.
+		 */
+		logical_apicid = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
+		ldr_apicid = GET_APIC_LOGICAL_ID(apic_read(APIC_LDR));
+		if (logical_apicid != BAD_APICID)
+			WARN_ON(logical_apicid != ldr_apicid);
+		/* Always use the value from LDR. */
+		early_per_cpu(x86_cpu_to_logical_apicid, cpu) = ldr_apicid;
+	}
 #endif
 
 	/*
-- 
2.20.1



