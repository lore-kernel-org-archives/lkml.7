Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B514CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6442075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbfCZQkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:40:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48825 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731489AbfCZQj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:39:59 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8p7D-0001bO-Rr; Tue, 26 Mar 2019 17:39:56 +0100
Message-Id: <20190326163811.598166056@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 26 Mar 2019 17:36:06 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>, Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Micheal Kelley <michael.h.kelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: [patch 2/2] x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=y
References: <20190326163604.348882514@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMT disable 'nosmt' command line argument is not working properly when
CONFIG_HOTPLUG_CPU is disabled. The teardown of the sibling CPUs which are
required to be brought up due to the MCE issues, cannot work. The CPUs are
then kept in a half dead state.

As the 'nosmt' functionality has become popular due to the speculative
hardware vulnerabilities, the half torn down state is not a proper solution
to the problem.

Enforce CONFIG_HOTPLUG_CPU=y when SMP is enabled so the full operation is
possible.

Reported-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Konrad Wilk <konrad.wilk@oracle.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Rik van Riel <riel@surriel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Micheal Kelley <michael.h.kelley@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: stable@vger.kernel.org
---
 arch/x86/Kconfig |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2217,14 +2217,8 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 	   If unsure, leave at the default value.
 
 config HOTPLUG_CPU
-	bool "Support for hot-pluggable CPUs"
+	def_bool y
 	depends on SMP
-	---help---
-	  Say Y here to allow turning CPUs off and on. CPUs can be
-	  controlled through /sys/devices/system/cpu.
-	  ( Note: power management support will enable this option
-	    automatically on SMP systems. )
-	  Say N if you want to disable CPU hotplug.
 
 config BOOTPARAM_HOTPLUG_CPU0
 	bool "Set default setting of cpu0_hotpluggable"


