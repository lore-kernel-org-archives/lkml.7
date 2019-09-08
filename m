Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FD1C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 07:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76846214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 07:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfIHHHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 03:07:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50009 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfIHHHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 03:07:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6rI3-0006V7-JY; Sun, 08 Sep 2019 09:07:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ED03A1C072D;
        Sun,  8 Sep 2019 09:07:14 +0200 (CEST)
Date:   Sun, 08 Sep 2019 07:07:14 -0000
From:   "tip-bot2 for Jan Stancek" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/timer: Force PIT initialization when !X86_FEATURE_ARAT
Cc:     Jan Stancek <jstancek@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156792643484.24167.388160525662287317.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     afa8b475c1aec185a8e106c48b3832e0b88bc2de
Gitweb:        https://git.kernel.org/tip/afa8b475c1aec185a8e106c48b3832e0b88bc2de
Author:        Jan Stancek <jstancek@redhat.com>
AuthorDate:    Sun, 08 Sep 2019 00:50:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 08 Sep 2019 09:01:15 +02:00

x86/timer: Force PIT initialization when !X86_FEATURE_ARAT

KVM guests with commit c8c4076723da ("x86/timer: Skip PIT initialization on
modern chipsets") applied to guest kernel have been observed to have
unusually higher CPU usage with symptoms of increase in vm exits for HLT
and MSW_WRITE (MSR_IA32_TSCDEADLINE).

This is caused by older QEMUs lacking support for X86_FEATURE_ARAT.  lapic
clock retains CLOCK_EVT_FEAT_C3STOP and nohz stays inactive.  There's no
usable broadcast device either.

Do the PIT initialization if guest CPU lacks X86_FEATURE_ARAT.  On real
hardware it shouldn't matter as ARAT and DEADLINE come together.

Fixes: c8c4076723da ("x86/timer: Skip PIT initialization on modern chipsets")
Signed-off-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/apic/apic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index dba2828..f91b3ff 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -834,6 +834,10 @@ bool __init apic_needs_pit(void)
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return true;
 
+	/* Virt guests may lack ARAT, but still have DEADLINE */
+	if (!boot_cpu_has(X86_FEATURE_ARAT))
+		return true;
+
 	/* Deadline timer is based on TSC so no further PIT action required */
 	if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
 		return false;
