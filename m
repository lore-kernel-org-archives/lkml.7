Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFC2C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330C2212F5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfD0PP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33346 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727426AbfD0PPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:25 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2w-00014L-5T; Sat, 27 Apr 2019 16:15:22 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004b6-L6; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Michael Matz" <matz@suse.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Borislav Petkov" <bp@suse.de>, x86@kernel.org,
        "Derek Robson" <robsonde@gmail.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.647550654@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 154/202] x86/a.out: Clear the dump structure initially
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

From: Borislav Petkov <bp@suse.de>

commit 10970e1b4be9c74fce8ab6e3c34a7d718f063f2c upstream.

dump_thread32() in aout_core_dump() does not clear the user32 structure
allocated on the stack as the first thing on function entry.

As a result, the dump.u_comm, dump.u_ar0 and dump.signal which get
assigned before the clearing, get overwritten.

Rename that function to fill_dump() to make it clear what it does and
call it first thing.

This was caught while staring at a patch by Derek Robson
<robsonde@gmail.com>.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Derek Robson <robsonde@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Matz <matz@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190202005512.3144-1-robsonde@gmail.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/ia32/ia32_aout.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -50,7 +50,7 @@ static unsigned long get_dr(int n)
 /*
  * fill in the user structure for a core dump..
  */
-static void dump_thread32(struct pt_regs *regs, struct user32 *dump)
+static void fill_dump(struct pt_regs *regs, struct user32 *dump)
 {
 	u32 fs, gs;
 	memset(dump, 0, sizeof(*dump));
@@ -156,10 +156,12 @@ static int aout_core_dump(struct coredum
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 	has_dumped = 1;
+
+	fill_dump(cprm->regs, &dump);
+
 	strncpy(dump.u_comm, current->comm, sizeof(current->comm));
 	dump.u_ar0 = offsetof(struct user32, regs);
 	dump.signal = cprm->siginfo->si_signo;
-	dump_thread32(cprm->regs, &dump);
 
 	/*
 	 * If the size of the dump file exceeds the rlimit, then see

