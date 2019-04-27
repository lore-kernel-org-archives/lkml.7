Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF67C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75257206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfD0PXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:23:23 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33624 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727508AbfD0PP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:29 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2z-0000zQ-A0; Sat, 27 Apr 2019 16:15:25 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004YS-FO; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Anton Blanchard" <anton@samba.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.904229853@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 125/202] powerpc/signal: Properly handle return value
 from uprobe_deny_signal()
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

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

commit 46725b17f1c6c815a41429259b3f070c01e71bc1 upstream.

When a uprobe is installed on an instruction that we currently do not
emulate, we copy the instruction into a xol buffer and single step
that instruction. If that instruction generates a fault, we abort the
single stepping before invoking the signal handler. Once the signal
handler is done, the uprobe trap is hit again since the instruction is
retried and the process repeats.

We use uprobe_deny_signal() to detect if the xol instruction triggered
a signal. If so, we clear TIF_SIGPENDING and set TIF_UPROBE so that the
signal is not handled until after the single stepping is aborted. In
this case, uprobe_deny_signal() returns true and get_signal() ends up
returning 0. However, in do_signal(), we are not looking at the return
value, but depending on ksig.sig for further action, all with an
uninitialized ksig that is not touched in this scenario. Fix the same
by initializing ksig.sig to 0.

Fixes: 129b69df9c90 ("powerpc: Use get_signal() signal_setup_done()")
Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -102,7 +102,7 @@ static void check_syscall_restart(struct
 static void do_signal(struct pt_regs *regs)
 {
 	sigset_t *oldset = sigmask_to_save();
-	struct ksignal ksig;
+	struct ksignal ksig = { .sig = 0 };
 	int ret;
 	int is32 = is_32bit_task();
 

