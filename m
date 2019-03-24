Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E68EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00C1222DD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfCXOOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 10:14:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43610 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfCXOOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 10:14:00 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h83ss-0001ym-B1; Sun, 24 Mar 2019 15:13:58 +0100
Date:   Sun, 24 Mar 2019 14:12:21 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core updates for 5.1
Message-ID: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

Two small fixes:

 - Move the large objtool_file struct off the stack so objtool works in
   setups with a tight stack limit.

 - Make a few variables static in the watchdog core code.

Thanks,

	tglx

------------------>
Josh Poimboeuf (1):
      objtool: Move objtool_file struct off the stack

Valdis Kletnieks (1):
      watchdog/core: Make variables static


 kernel/watchdog.c     | 4 ++--
 tools/objtool/check.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8fbfda94a67b..403c9bd90413 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -42,9 +42,9 @@ int __read_mostly watchdog_user_enabled = 1;
 int __read_mostly nmi_watchdog_user_enabled = NMI_WATCHDOG_DEFAULT;
 int __read_mostly soft_watchdog_user_enabled = 1;
 int __read_mostly watchdog_thresh = 10;
-int __read_mostly nmi_watchdog_available;
+static int __read_mostly nmi_watchdog_available;
 
-struct cpumask watchdog_allowed_mask __read_mostly;
+static struct cpumask watchdog_allowed_mask __read_mostly;
 
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0414a0d52262..5dde107083c6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2184,9 +2184,10 @@ static void cleanup(struct objtool_file *file)
 	elf_close(file->elf);
 }
 
+static struct objtool_file file;
+
 int check(const char *_objname, bool orc)
 {
-	struct objtool_file file;
 	int ret, warnings = 0;
 
 	objname = _objname;

