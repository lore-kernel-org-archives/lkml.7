Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1451AC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27BB206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfD0PRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:17:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34386 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727718AbfD0PPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:41 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3D-00014I-SG; Sat, 27 Apr 2019 16:15:39 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004QI-Tb; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.725527461@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 034/202] s390/early: improve machine detection
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Borntraeger <borntraeger@de.ibm.com>

commit 03aa047ef2db4985e444af6ee1c1dd084ad9fb4c upstream.

Right now the early machine detection code check stsi 3.2.2 for "KVM"
and set MACHINE_IS_VM if this is different. As the console detection
uses diagnose 8 if MACHINE_IS_VM returns true this will crash Linux
early for any non z/VM system that sets a different value than KVM.
So instead of assuming z/VM, do not set any of MACHINE_IS_LPAR,
MACHINE_IS_VM, or MACHINE_IS_KVM.

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/kernel/early.c | 4 ++--
 arch/s390/kernel/setup.c | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -232,10 +232,10 @@ static noinline __init void detect_machi
 	if (stsi(vmms, 3, 2, 2) || !vmms->count)
 		return;
 
-	/* Running under KVM? If not we assume z/VM */
+	/* Detect known hypervisors */
 	if (!memcmp(vmms->vm[0].cpi, "\xd2\xe5\xd4", 3))
 		S390_lowcore.machine_flags |= MACHINE_FLAG_KVM;
-	else
+	else if (!memcmp(vmms->vm[0].cpi, "\xa9\x61\xe5\xd4", 4))
 		S390_lowcore.machine_flags |= MACHINE_FLAG_VM;
 }
 
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -831,6 +831,8 @@ void __init setup_arch(char **cmdline_p)
 		pr_info("Linux is running under KVM in 64-bit mode\n");
 	else if (MACHINE_IS_LPAR)
 		pr_info("Linux is running natively in 64-bit mode\n");
+	else
+		pr_info("Linux is running as a guest in 64-bit mode\n");
 #endif /* CONFIG_64BIT */
 
 	/* Have one command line that is parsed and saved in /proc/cmdline */

