Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E2EECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818CE2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfJARni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:43:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56054 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfJARni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:43:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iFMBE-0000rD-WA; Tue, 01 Oct 2019 19:43:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 820C91C03AB;
        Tue,  1 Oct 2019 19:43:20 +0200 (CEST)
Date:   Tue, 01 Oct 2019 17:43:20 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Issue the revision updated
 message only on the BSP
Cc:     Borislav Petkov <bp@suse.de>, Ashok Raj <ashok.raj@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, Mihai Carabas <mihai.carabas@oracle.com>,
        patrick.colp@oracle.com, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190824085341.GC16813@zn.tnic>
References: <20190824085341.GC16813@zn.tnic>
MIME-Version: 1.0
Message-ID: <156995180039.9978.4399431172812014164.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     811ae8ba6dca6b91a3ceccf9d40b98818cc4f400
Gitweb:        https://git.kernel.org/tip/811ae8ba6dca6b91a3ceccf9d40b98818cc4f400
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sat, 24 Aug 2019 10:01:53 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Oct 2019 16:06:35 +02:00

x86/microcode/intel: Issue the revision updated message only on the BSP

... in order to not pollute dmesg with a line for each updated microcode
engine.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jon Grimm <Jon.Grimm@amd.com>
Cc: kanth.ghatraju@oracle.com
Cc: konrad.wilk@oracle.com
Cc: Mihai Carabas <mihai.carabas@oracle.com>
Cc: patrick.colp@oracle.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190824085341.GC16813@zn.tnic
---
 arch/x86/kernel/cpu/microcode/intel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index ce799cf..6a99535 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -791,6 +791,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
+	bool bsp = c->cpu_index == boot_cpu_data.cpu_index;
 	struct microcode_intel *mc;
 	enum ucode_state ret;
 	static int prev_rev;
@@ -836,7 +837,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		return UCODE_ERROR;
 	}
 
-	if (rev != prev_rev) {
+	if (bsp && rev != prev_rev) {
 		pr_info("updated to revision 0x%x, date = %04x-%02x-%02x\n",
 			rev,
 			mc->hdr.date & 0xffff,
@@ -852,7 +853,7 @@ out:
 	c->microcode	 = rev;
 
 	/* Update boot_cpu_data's revision too, if we're on the BSP: */
-	if (c->cpu_index == boot_cpu_data.cpu_index)
+	if (bsp)
 		boot_cpu_data.microcode = rev;
 
 	return ret;
