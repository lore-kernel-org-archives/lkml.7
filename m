Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A800C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 02:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648F221872
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 02:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390361AbfGTCdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 22:33:31 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:40001 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbfGTCdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 22:33:31 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hofBR-0001QZ-Ku from George_Davis@mentor.com ; Fri, 19 Jul 2019 19:33:13 -0700
Received: from localhost (147.34.91.1) by svr-orw-mbx-01.mgc.mentorg.com
 (147.34.90.201) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 19 Jul
 2019 19:33:11 -0700
From:   "George G. Davis" <george_davis@mentor.com>
To:     Russell King <linux@armlinux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        "George G. Davis" <george_davis@mentor.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: Fix null die() string for unhandled data and prefetch abort cases
Date:   Fri, 19 Jul 2019 22:32:55 -0400
Message-ID: <1563589976-19004-1-git-send-email-george_davis@mentor.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an unhandled data or prefetch abort occurs, the die() string
is empty resulting in backtrace messages similar to the following:

	Internal error: : 1 [#1] PREEMPT SMP ARM

Replace the null string with the name of the abort handler in order
to provide more meaningful hints as to the cause of the fault.

Signed-off-by: George G. Davis <george_davis@mentor.com>
---
 arch/arm/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 0048eadd0681..dddea0a21220 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -557,7 +557,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		inf->name, fsr, addr);
 	show_pte(current->mm, addr);
 
-	arm_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
+	arm_notify_die(inf->name, regs, inf->sig, inf->code, (void __user *)addr,
 		       fsr, 0);
 }
 
@@ -585,7 +585,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
 		inf->name, ifsr, addr);
 
-	arm_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
+	arm_notify_die(inf->name, regs, inf->sig, inf->code, (void __user *)addr,
 		       ifsr, 0);
 }
 
-- 
2.7.4

