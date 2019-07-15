Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C66CC742D2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A099214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfGOAhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:37:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbfGOAhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5CD843688B;
        Mon, 15 Jul 2019 00:37:34 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 501475D9D2;
        Mon, 15 Jul 2019 00:37:33 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 06/22] x86/head/64: Annotate start_cpu0() as non-callable
Date:   Sun, 14 Jul 2019 19:37:01 -0500
Message-Id: <b6568e859d8af1d2b5c9efed40cfb45f0b3ebb90.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 15 Jul 2019 00:37:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After an objtool improvement, it complains about the fact that
start_cpu0() jumps to code which has an LRET instruction.

  arch/x86/kernel/head_64.o: warning: objtool: .head.text+0xe4: unsupported instruction in callable function

Technically, start_cpu0() is callable, but it acts nothing like a
callable function.  Prevent objtool from treating it like one by
removing its ELF function annotation.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/head_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index bcd206c8ac90..66b4a7757397 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -253,10 +253,10 @@ END(secondary_startup_64)
  * start_secondary() via .Ljump_to_C_code.
  */
 ENTRY(start_cpu0)
-	movq	initial_stack(%rip), %rsp
 	UNWIND_HINT_EMPTY
+	movq	initial_stack(%rip), %rsp
 	jmp	.Ljump_to_C_code
-ENDPROC(start_cpu0)
+END(start_cpu0)
 #endif
 
 	/* Both SMP bootup and ACPI suspend change these variables */
-- 
2.20.1

