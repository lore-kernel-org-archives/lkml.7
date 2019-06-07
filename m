Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C81C468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD39420B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfFGLgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:36:44 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:44394 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbfFGLgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:36:44 -0400
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id Mnci200093XaVaC06nciXJ; Fri, 07 Jun 2019 13:36:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZDAo-0004G6-2j; Fri, 07 Jun 2019 13:36:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZDAo-0003xk-1G; Fri, 07 Jun 2019 13:36:42 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] MIPS: ftrace: Reword prepare_ftrace_return() comment block
Date:   Fri,  7 Jun 2019 13:36:40 +0200
Message-Id: <20190607113640.15191-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the comment block for prepare_ftrace_return().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/mips/kernel/ftrace.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 4b5e1f2bfbcea85f..2625232bfe526a84 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -333,20 +333,21 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 		return;
 
 	/*
-	 * "parent_ra_addr" is the stack address saved the return address of
-	 * the caller of _mcount.
+	 * "parent_ra_addr" is the stack address where the return address of
+	 * the caller of _mcount is saved.
 	 *
-	 * if the gcc < 4.5, a leaf function does not save the return address
-	 * in the stack address, so, we "emulate" one in _mcount's stack space,
-	 * and hijack it directly, but for a non-leaf function, it save the
-	 * return address to the its own stack space, we can not hijack it
-	 * directly, but need to find the real stack address,
-	 * ftrace_get_parent_addr() does it!
+	 * If gcc < 4.5, a leaf function does not save the return address
+	 * in the stack address, so we "emulate" one in _mcount's stack space,
+	 * and hijack it directly.
+	 * For a non-leaf function, it does save the return address to its own
+	 * stack space, so we can not hijack it directly, but need to find the
+	 * real stack address, which is done by ftrace_get_parent_addr().
 	 *
-	 * if gcc>= 4.5, with the new -mmcount-ra-address option, for a
+	 * If gcc >= 4.5, with the new -mmcount-ra-address option, for a
 	 * non-leaf function, the location of the return address will be saved
-	 * to $12 for us, and for a leaf function, only put a zero into $12. we
-	 * do it in ftrace_graph_caller of mcount.S.
+	 * to $12 for us.
+	 * For a leaf function, it just puts a zero into $12, so we handle
+	 * it in ftrace_graph_caller() of mcount.S.
 	 */
 
 	/* old_parent_ra = *parent_ra_addr; */
-- 
2.17.1

