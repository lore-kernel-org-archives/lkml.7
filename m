Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A69ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09A72089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394380AbfJQQRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:17:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53733 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730526AbfJQQRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:17:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iL8SN-0002xh-RE; Thu, 17 Oct 2019 18:16:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5EB891C009F;
        Thu, 17 Oct 2019 18:16:55 +0200 (CEST)
Date:   Thu, 17 Oct 2019 16:16:55 -0000
From:   "tip-bot2 for Scott Wood" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/Kconfig: Enforce limit of 512 CPUs with MAXSMP and
 no CPUMASK_OFFSTACK
Cc:     Scott Wood <swood@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191012070054.28657-1-swood@redhat.com>
References: <20191012070054.28657-1-swood@redhat.com>
MIME-Version: 1.0
Message-ID: <157132901520.29376.161729676075623652.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     1edae1ae62589f28d00da186465a003e2a7f9c6c
Gitweb:        https://git.kernel.org/tip/1edae1ae62589f28d00da186465a003e2a7f9c6c
Author:        Scott Wood <swood@redhat.com>
AuthorDate:    Sat, 12 Oct 2019 02:00:54 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 17 Oct 2019 18:04:51 +02:00

x86/Kconfig: Enforce limit of 512 CPUs with MAXSMP and no CPUMASK_OFFSTACK

The help text of NR_CPUS says that the maximum number of CPUs supported
without CPUMASK_OFFSTACK is 512. However, NR_CPUS_RANGE_END allows this
limit to be bypassed by MAXSMP even if CPUMASK_OFFSTACK is not set.

This scenario can currently only happen in the RT tree, since it has
"select CPUMASK_OFFSTACK if !PREEMPT_RT_FULL" in MAXSMP. However,
even if we ignore the RT tree, checking for MAXSMP in addition to
CPUMASK_OFFSTACK is redundant.

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191012070054.28657-1-swood@redhat.com
---
 arch/x86/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 91c22ee..896f840 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1000,8 +1000,8 @@ config NR_CPUS_RANGE_END
 config NR_CPUS_RANGE_END
 	int
 	depends on X86_64
-	default 8192 if  SMP && ( MAXSMP ||  CPUMASK_OFFSTACK)
-	default  512 if  SMP && (!MAXSMP && !CPUMASK_OFFSTACK)
+	default 8192 if  SMP && CPUMASK_OFFSTACK
+	default  512 if  SMP && !CPUMASK_OFFSTACK
 	default    1 if !SMP
 
 config NR_CPUS_DEFAULT
