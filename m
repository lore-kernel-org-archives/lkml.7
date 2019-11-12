Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FA5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A1C214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfKLXv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:51:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57320 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726978AbfKLXuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:50:35 -0500
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iUfvd-0008I6-He; Tue, 12 Nov 2019 23:50:33 +0000
Received: from ben by deadeye with local (Exim 4.93-RC1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iUfvc-00056y-Iz; Tue, 12 Nov 2019 23:50:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Neelima Krishnan" <neelima.krishnan@intel.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Borislav Petkov" <bp@suse.de>
Date:   Tue, 12 Nov 2019 23:48:05 +0000
Message-ID: <lsq.1573602477.205490276@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 08/25] kvm/x86: Export MDS_NO=0 to guests when TSX is
 enabled
In-Reply-To: <lsq.1573602477.548403712@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.77-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit e1d38b63acd843cfdd4222bf19a26700fd5c699e upstream.

Export the IA32_ARCH_CAPABILITIES MSR bit MDS_NO=0 to guests on TSX
Async Abort(TAA) affected hosts that have TSX enabled and updated
microcode. This is required so that the guests don't complain,

  "Vulnerable: Clear CPU buffers attempted, no microcode"

when the host has the updated microcode to clear CPU buffers.

Microcode update also adds support for MSR_IA32_TSX_CTRL which is
enumerated by the ARCH_CAP_TSX_CTRL bit in IA32_ARCH_CAPABILITIES MSR.
Guests can't do this check themselves when the ARCH_CAP_TSX_CTRL bit is
not exported to the guests.

In this case export MDS_NO=0 to the guests. When guests have
CPUID.MD_CLEAR=1, they deploy MDS mitigation which also mitigates TAA.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/x86.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -924,6 +924,25 @@ u64 kvm_get_arch_capabilities(void)
 	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		data |= ARCH_CAP_MDS_NO;
 
+	/*
+	 * On TAA affected systems, export MDS_NO=0 when:
+	 *	- TSX is enabled on the host, i.e. X86_FEATURE_RTM=1.
+	 *	- Updated microcode is present. This is detected by
+	 *	  the presence of ARCH_CAP_TSX_CTRL_MSR and ensures
+	 *	  that VERW clears CPU buffers.
+	 *
+	 * When MDS_NO=0 is exported, guests deploy clear CPU buffer
+	 * mitigation and don't complain:
+	 *
+	 *	"Vulnerable: Clear CPU buffers attempted, no microcode"
+	 *
+	 * If TSX is disabled on the system, guests are also mitigated against
+	 * TAA and clear CPU buffer mitigation is not required for guests.
+	 */
+	if (boot_cpu_has_bug(X86_BUG_TAA) && boot_cpu_has(X86_FEATURE_RTM) &&
+	    (data & ARCH_CAP_TSX_CTRL_MSR))
+		data &= ~ARCH_CAP_MDS_NO;
+
 	return data;
 }
 

