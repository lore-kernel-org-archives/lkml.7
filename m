Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3754EC73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13636214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfGOAhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:37:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729015AbfGOAhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 254B73083363;
        Mon, 15 Jul 2019 00:37:33 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17C015D9D2;
        Mon, 15 Jul 2019 00:37:31 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 05/22] x86/entry: Fix thunk function ELF sizes
Date:   Sun, 14 Jul 2019 19:37:00 -0500
Message-Id: <dfe5367f27038785ca3fcc59ba037be42c263385.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 15 Jul 2019 00:37:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings:

  arch/x86/entry/thunk_64.o: warning: objtool: trace_hardirqs_on_thunk() is missing an ELF size annotation
  arch/x86/entry/thunk_64.o: warning: objtool: trace_hardirqs_off_thunk() is missing an ELF size annotation
  arch/x86/entry/thunk_64.o: warning: objtool: lockdep_sys_exit_thunk() is missing an ELF size annotation

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/entry/thunk_64.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index cfdca8b42c70..cc20465b2867 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -12,9 +12,7 @@
 
 	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
 	.macro THUNK name, func, put_ret_addr_in_rdi=0
-	.globl \name
-	.type \name, @function
-\name:
+	ENTRY(\name)
 	pushq %rbp
 	movq %rsp, %rbp
 
@@ -35,6 +33,7 @@
 
 	call \func
 	jmp  .L_restore
+	ENDPROC(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
 
-- 
2.20.1

