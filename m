Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA4FC04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589D521537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfENOEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:04:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:47286 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfENOC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:02:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 07:02:58 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2019 07:02:58 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [RFC PATCH v3 09/21] x86/nmi: Add a NMI_WATCHDOG NMI handler category
Date:   Tue, 14 May 2019 07:02:02 -0700
Message-Id: <1557842534-4266-10-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a NMI_WATCHDOG as a new category of NMI handler. This new category
is to be used with the HPET-based hardlockup detector. This detector
does not have a direct way of checking if the HPET timer is the source of
the NMI. Instead it indirectly estimate it using the time-stamp counter.

Therefore, we may have false-positives in case another NMI occurs within
the estimated time window. For this reason, we want the handler of the
detector to be called after all the NMI_LOCAL handlers. A simple way
of achieving this with a new NMI handler category.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/nmi.h |  1 +
 arch/x86/kernel/nmi.c      | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 75ded1d13d98..75aa98313cde 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -29,6 +29,7 @@ enum {
 	NMI_UNKNOWN,
 	NMI_SERR,
 	NMI_IO_CHECK,
+	NMI_WATCHDOG,
 	NMI_MAX
 };
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 3755d0310026..a43213f0ab26 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -62,6 +62,10 @@ static struct nmi_desc nmi_desc[NMI_MAX] =
 		.lock = __RAW_SPIN_LOCK_UNLOCKED(&nmi_desc[3].lock),
 		.head = LIST_HEAD_INIT(nmi_desc[3].head),
 	},
+	{
+		.lock = __RAW_SPIN_LOCK_UNLOCKED(&nmi_desc[4].lock),
+		.head = LIST_HEAD_INIT(nmi_desc[4].head),
+	},
 
 };
 
@@ -172,6 +176,8 @@ int __register_nmi_handler(unsigned int type, struct nmiaction *action)
 	 */
 	WARN_ON_ONCE(type == NMI_SERR && !list_empty(&desc->head));
 	WARN_ON_ONCE(type == NMI_IO_CHECK && !list_empty(&desc->head));
+	WARN_ON_ONCE(type == NMI_WATCHDOG && !list_empty(&desc->head));
+
 
 	/*
 	 * some handlers need to be executed first otherwise a fake
@@ -382,6 +388,10 @@ static void default_do_nmi(struct pt_regs *regs)
 	}
 	raw_spin_unlock(&nmi_reason_lock);
 
+	handled = nmi_handle(NMI_WATCHDOG, regs);
+	if (handled == NMI_HANDLED)
+		return;
+
 	/*
 	 * Only one NMI can be latched at a time.  To handle
 	 * this we may process multiple nmi handlers at once to
-- 
2.17.1

