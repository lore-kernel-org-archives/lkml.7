Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8838C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 22:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A682720708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 22:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKTWsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 17:48:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59095 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKTWsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 17:48:53 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXYmC-0000H4-Gu; Wed, 20 Nov 2019 23:48:44 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BEF351C1A27;
        Wed, 20 Nov 2019 23:48:43 +0100 (CET)
Date:   Wed, 20 Nov 2019 22:48:43 -0000
From:   "tip-bot2 for Alexander Duyck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/ioperm: Fix use of deprecated config option
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>, "x86-ml" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191120222426.3060.18462.stgit@localhost.localdomain>
References: <20191120222426.3060.18462.stgit@localhost.localdomain>
MIME-Version: 1.0
Message-ID: <157429012364.21853.105281990076926777.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/iopl branch of tip:

Commit-ID:     e3cb0c7102f04c83bf1a7cb1d052e92749310b46
Gitweb:        https://git.kernel.org/tip/e3cb0c7102f04c83bf1a7cb1d052e92749310b46
Author:        Alexander Duyck <alexander.h.duyck@linux.intel.com>
AuthorDate:    Wed, 20 Nov 2019 14:25:53 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Nov 2019 23:40:05 +01:00

x86/ioperm: Fix use of deprecated config option

The commit

  111e7b15cf10 ("x86/ioperm: Extend IOPL config to control ioperm() as well")

replaced X86_IOPL_EMULATION with X86_IOPL_IOPERM. However it appears
that there was at least one spot missed as tss_update_io_bitmap() still
had a reference to it contained in the code.

The result of this is that it exposed a NULL pointer dereference as seen
below with a linux-next next-20191120 kernel:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP PTI
  CPU: 5 PID: 1542 Comm: ovs-vswitchd Tainted: G        W 5.4.0-rc8-next-20191120 #125
  RIP: 0010:tss_update_io_bitmap+0x4e/0x180
  Code: 10 31 c0 65 48 03 1d 69 54 5d 6d 65 48 8b 04 25 40 8c 01 00 48 8b 10 \
	  f7 c2 00 00 40 00 0f 84 8c 00 00 00 4c 8b a0 c0 22 00 00 <49> 8b 04 \
	  24 48 39 43 68 74 2e 8b 53 70 41 39 54 24 0c 48 8d 7b 78
  RSP: 0018:ffffb8888a0ebf08 EFLAGS: 00010006
  RAX: ffff8a429811a680 RBX: ffff8a4c3f946000 RCX: 0000000000000011
  RDX: 0000000000400080 RSI: 0000000000400080 RDI: 0000000000000000
  RBP: ffffb8888a0ebf30 R08: 00007ffffb5d7ce0 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  FS:  00007f68a9635c40(0000) GS:ffff8a4c3f940000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 000000103572a001 CR4: 00000000001606e0
  Call Trace:
   ? syscall_slow_exit_work+0x39/0xdb
   do_syscall_64+0x1a5/0x200
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  RIP: 0033:0x7f68a7aff797

Fixes: 111e7b15cf10 ("x86/ioperm: Extend IOPL config to control ioperm() as well")
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191120222426.3060.18462.stgit@localhost.localdomain
---
 arch/x86/kernel/process.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 7964d7d..bd2a11c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -382,8 +382,7 @@ void tss_update_io_bitmap(void)
 	if (test_thread_flag(TIF_IO_BITMAP)) {
 		struct thread_struct *t = &current->thread;
 
-		if (IS_ENABLED(CONFIG_X86_IOPL_EMULATION) &&
-		    t->iopl_emul == 3) {
+		if (IS_ENABLED(CONFIG_X86_IOPL_IOPERM) && t->iopl_emul == 3) {
 			*base = IO_BITMAP_OFFSET_VALID_ALL;
 		} else {
 			struct io_bitmap *iobm = t->io_bitmap;
