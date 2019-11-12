Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928FCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741992084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKLKuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:50:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33275 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfKLKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:50:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUTkI-0008AW-S1; Tue, 12 Nov 2019 11:50:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7B8141C0084;
        Tue, 12 Nov 2019 11:50:02 +0100 (CET)
Date:   Tue, 12 Nov 2019 10:50:02 -0000
From:   "tip-bot2 for Andrea Parri" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/hyperv] x86/hyperv: Allow guests to enable InvariantTSC
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191003155200.22022-1-parri.andrea@gmail.com>
References: <20191003155200.22022-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Message-ID: <157355580216.29376.5207364580446998985.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/hyperv branch of tip:

Commit-ID:     dce7cd62754b5d4a6e401b8b0769ec94cf971041
Gitweb:        https://git.kernel.org/tip/dce7cd62754b5d4a6e401b8b0769ec94cf971041
Author:        Andrea Parri <parri.andrea@gmail.com>
AuthorDate:    Thu, 03 Oct 2019 17:52:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Nov 2019 11:44:21 +01:00

x86/hyperv: Allow guests to enable InvariantTSC

If the hardware supports TSC scaling, Hyper-V will set bit 15 of the
HV_PARTITION_PRIVILEGE_MASK in guest VMs with a compatible Hyper-V
configuration version.  Bit 15 corresponds to the
AccessTscInvariantControls privilege.  If this privilege bit is set,
guests can access the HvSyntheticInvariantTscControl MSR: guests can
set bit 0 of this synthetic MSR to enable the InvariantTSC feature.
After setting the synthetic MSR, CPUID will enumerate support for
InvariantTSC.

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lkml.kernel.org/r/20191003155200.22022-1-parri.andrea@gmail.com

---
 arch/x86/include/asm/hyperv-tlfs.h | 5 +++++
 arch/x86/kernel/cpu/mshyperv.c     | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 7a27056..887b1d6 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -86,6 +86,8 @@
 #define HV_X64_ACCESS_FREQUENCY_MSRS		BIT(11)
 /* AccessReenlightenmentControls privilege */
 #define HV_X64_ACCESS_REENLIGHTENMENT		BIT(13)
+/* AccessTscInvariantControls privilege */
+#define HV_X64_ACCESS_TSC_INVARIANT		BIT(15)
 
 /*
  * Feature identification: indicates which flags were specified at partition
@@ -270,6 +272,9 @@
 #define HV_X64_MSR_TSC_EMULATION_CONTROL	0x40000107
 #define HV_X64_MSR_TSC_EMULATION_STATUS		0x40000108
 
+/* TSC invariant control */
+#define HV_X64_MSR_TSC_INVARIANT_CONTROL	0x40000118
+
 /*
  * Declare the MSR used to setup pages used to communicate with the hypervisor.
  */
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 062f772..6f7c822 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -285,7 +285,12 @@ static void __init ms_hyperv_init_platform(void)
 	machine_ops.shutdown = hv_machine_shutdown;
 	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
 #endif
-	mark_tsc_unstable("running on Hyper-V");
+	if (ms_hyperv.features & HV_X64_ACCESS_TSC_INVARIANT) {
+		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
+		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	} else {
+		mark_tsc_unstable("running on Hyper-V");
+	}
 
 	/*
 	 * Generation 2 instances don't support reading the NMI status from
