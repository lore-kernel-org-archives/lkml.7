Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BADBC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE7A2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbfHZLqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:46:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39614 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731517AbfHZLqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:46:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2DRo-00010U-Tq; Mon, 26 Aug 2019 13:46:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 870D21C0DAE;
        Mon, 26 Aug 2019 13:46:08 +0200 (CEST)
Date:   Mon, 26 Aug 2019 11:46:08 -0000
From:   tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/apic: Fix arch_dynirq_lower_bound() bug for DT
 enabled machines
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, alan@linux.intel.com,
        bp@alien8.de, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar@intel.com, rppt@linux.ibm.com, tony.luck@intel.com,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190821081330.1187-1-rahul.tanwar@linux.intel.com>
References: <20190821081330.1187-1-rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Message-ID: <156681996837.3355.8063649574269386994.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3e5bedc2c258341702ddffbd7688c5e6eb01eafa
Gitweb:        https://git.kernel.org/tip/3e5bedc2c258341702ddffbd7688c5e6eb01eafa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 15:16:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Aug 2019 12:11:23 +02:00

x86/apic: Fix arch_dynirq_lower_bound() bug for DT enabled machines

Rahul Tanwar reported the following bug on DT systems:

> 'ioapic_dynirq_base' contains the virtual IRQ base number. Presently, it is
> updated to the end of hardware IRQ numbers but this is done only when IOAPIC
> configuration type is IOAPIC_DOMAIN_LEGACY or IOAPIC_DOMAIN_STRICT. There is
> a third type IOAPIC_DOMAIN_DYNAMIC which applies when IOAPIC configuration
> comes from devicetree.
>
> See dtb_add_ioapic() in arch/x86/kernel/devicetree.c
>
> In case of IOAPIC_DOMAIN_DYNAMIC (DT/OF based system), 'ioapic_dynirq_base'
> remains to zero initialized value. This means that for OF based systems,
> virtual IRQ base will get set to zero.

Such systems will very likely not even boot.

For DT enabled machines ioapic_dynirq_base is irrelevant and not
updated, so simply map the IRQ base 1:1 instead.

Reported-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Tested-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: alan@linux.intel.com
Cc: bp@alien8.de
Cc: cheol.yong.kim@intel.com
Cc: qi-ming.wu@intel.com
Cc: rahul.tanwar@intel.com
Cc: rppt@linux.ibm.com
Cc: tony.luck@intel.com
Link: http://lkml.kernel.org/r/20190821081330.1187-1-rahul.tanwar@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/apic/io_apic.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index c7bb6c6..d6af97f 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2438,7 +2438,13 @@ unsigned int arch_dynirq_lower_bound(unsigned int from)
 	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
 	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet.
 	 */
-	return ioapic_initialized ? ioapic_dynirq_base : gsi_top;
+	if (!ioapic_initialized)
+		return gsi_top;
+	/*
+	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
+	 * updated. So simply return @from if ioapic_dynirq_base == 0.
+	 */
+	return ioapic_dynirq_base ? : from;
 }
 
 #ifdef CONFIG_X86_32
