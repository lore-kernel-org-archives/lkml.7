Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A41C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92722173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfC1MkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:40:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57161 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfC1MkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:40:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2SCdIvB3318890
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Mar 2019 05:39:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2SCdIqB3318887;
        Thu, 28 Mar 2019 05:39:18 -0700
Date:   Thu, 28 Mar 2019 05:39:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-bebd024e4815b1a170fcd21ead9c2222b23ce9e6@git.kernel.org>
Cc:     michael.h.kelley@microsoft.com, jkosina@suse.cz,
        linux-kernel@vger.kernel.org, luto@kernel.org, riel@surriel.com,
        kys@microsoft.com, mingo@kernel.org, mojha@codeaurora.org,
        Tianyu.Lan@microsoft.com, peterz@infradead.org, hpa@zytor.com,
        jpoimboe@redhat.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, bp@alien8.de,
        konrad.wilk@oracle.com, gregkh@linuxfoundation.org
Reply-To: mingo@kernel.org, mojha@codeaurora.org,
          michael.h.kelley@microsoft.com, linux-kernel@vger.kernel.org,
          jkosina@suse.cz, luto@kernel.org, riel@surriel.com,
          kys@microsoft.com, konrad.wilk@oracle.com,
          gregkh@linuxfoundation.org, peterz@infradead.org,
          Tianyu.Lan@microsoft.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, hpa@zytor.com, jpoimboe@redhat.com,
          bp@alien8.de
In-Reply-To: <20190326163811.598166056@linutronix.de>
References: <20190326163811.598166056@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/urgent] x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=y
Git-Commit-ID: bebd024e4815b1a170fcd21ead9c2222b23ce9e6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bebd024e4815b1a170fcd21ead9c2222b23ce9e6
Gitweb:     https://git.kernel.org/tip/bebd024e4815b1a170fcd21ead9c2222b23ce9e6
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Tue, 26 Mar 2019 17:36:06 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 28 Mar 2019 13:34:58 +0100

x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=y

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
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Konrad Wilk <konrad.wilk@oracle.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Rik van Riel <riel@surriel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Micheal Kelley <michael.h.kelley@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190326163811.598166056@linutronix.de

---
 arch/x86/Kconfig | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1f9b3cf437c..5ad92419be19 100644
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
