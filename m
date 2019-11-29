Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C62C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869EA2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfK2LXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:23:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48624 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfK2LXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:23:54 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaeND-0004K9-PG; Fri, 29 Nov 2019 12:23:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5BB6C1C211A;
        Fri, 29 Nov 2019 12:23:43 +0100 (CET)
Date:   Fri, 29 Nov 2019 11:23:43 -0000
From:   "tip-bot2 for Kai-Heng Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] x86/intel: Disable HPET on Intel Ice Lake platforms
Cc:     "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        feng.tang@intel.com, harry.pan@intel.com, hpa@zytor.com,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191129062303.18982-2-kai.heng.feng@canonical.com>
References: <20191129062303.18982-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Message-ID: <157502662320.21853.1194845015436593183.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     e0748539e3d594dd26f0d27a270f14720b22a406
Gitweb:        https://git.kernel.org/tip/e0748539e3d594dd26f0d27a270f14720b22a406
Author:        Kai-Heng Feng <kai.heng.feng@canonical.com>
AuthorDate:    Fri, 29 Nov 2019 14:23:03 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 29 Nov 2019 12:17:58 +01:00

x86/intel: Disable HPET on Intel Ice Lake platforms

Like CFL and CFL-H, ICL SoC has skewed HPET timer once it hits PC10.
So let's disable HPET on ICL.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: feng.tang@intel.com
Cc: harry.pan@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20191129062303.18982-2-kai.heng.feng@canonical.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/early-quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 606711f..2f9ec14 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -714,6 +714,8 @@ static struct chipset early_qrk[] __initdata = {
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_INTEL, 0x3ec4,
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
+	{ PCI_VENDOR_ID_INTEL, 0x8a12,
+		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
 	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, 0, apple_airport_reset},
 	{}
