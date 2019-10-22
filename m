Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF027CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C599A20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389281AbfJVQNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:13:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:59776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732197AbfJVQNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:13:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8CAAB385;
        Tue, 22 Oct 2019 16:13:20 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] MIPS: arc: remove unused stuff
Date:   Tue, 22 Oct 2019 18:13:13 +0200
Message-Id: <20191022161315.4194-3-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191022161315.4194-1-tbogendoerfer@suse.de>
References: <20191022161315.4194-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused _prom_envp and prom_argc macro.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/fw/arc/init.c         | 3 +--
 arch/mips/include/asm/sgialib.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/fw/arc/init.c b/arch/mips/fw/arc/init.c
index 4ac6466a8872..c713292462aa 100644
--- a/arch/mips/fw/arc/init.c
+++ b/arch/mips/fw/arc/init.c
@@ -19,7 +19,7 @@
 /* Master romvec interface. */
 struct linux_romvec *romvec;
 int prom_argc;
-LONG *_prom_argv, *_prom_envp;
+LONG *_prom_argv;
 
 #if defined(CONFIG_64BIT) && defined(CONFIG_FW_ARC32)
 /* stack for calling 32bit ARC prom */
@@ -34,7 +34,6 @@ void __init prom_init(void)
 
 	prom_argc = fw_arg0;
 	_prom_argv = (LONG *) fw_arg1;
-	_prom_envp = (LONG *) fw_arg2;
 
 	if (pb->magic != 0x53435241) {
 		printk(KERN_CRIT "Aieee, bad prom vector magic %08lx\n",
diff --git a/arch/mips/include/asm/sgialib.h b/arch/mips/include/asm/sgialib.h
index 21d17eb25ed8..40ab4ef0b1dc 100644
--- a/arch/mips/include/asm/sgialib.h
+++ b/arch/mips/include/asm/sgialib.h
@@ -17,12 +17,11 @@
 extern struct linux_romvec *romvec;
 extern int prom_argc;
 
-extern LONG *_prom_argv, *_prom_envp;
+extern LONG *_prom_argv;
 
 /* A 32-bit ARC PROM pass arguments and environment as 32-bit pointer.
    These macros take care of sign extension.  */
 #define prom_argv(index) ((char *) (long) _prom_argv[(index)])
-#define prom_argc(index) ((char *) (long) _prom_argc[(index)])
 
 extern int prom_flags;
 
-- 
2.16.4

