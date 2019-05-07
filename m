Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19764C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF481205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208750;
	bh=XxO6TjRIcp5X5OiMe4gAGo/n1EizSuDR1wlTAcNzDT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sgty0rdAVXrryjV1K6Q72548S4OGY2Kp9KGzYWGA8aH02cayJyqsEOxZZaJYfXPmS
	 kTi4aidK7dbwK4XMf3OEFy31Bwg61Ud2BwC8hNJOn2mQWHxPLRw3uLH990UoI24lOl
	 IIDIckeYGZv9di/OKzxTKnOKR7WE/85pD8SOWJlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfEGF7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:59:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfEGFg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:36:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24D7620B7C;
        Tue,  7 May 2019 05:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207415;
        bh=XxO6TjRIcp5X5OiMe4gAGo/n1EizSuDR1wlTAcNzDT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQuIYJIE3sl3rQBRvlowqbrI+1FmBxAEa14nGeXURY+f3/3hE1Nv9hWbHAsvZH1H2
         DCDUe+ODYxF+aUUfJuy/Ltwqe8izOa1CjUsKHs6LMBWjP/Zz+hB4g111LZB+z7V+U9
         lg0jUN5JqyxgOQ0XvsYL8cp0F701Rrv+5/8qqO4k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 30/81] x86/build/lto: Fix truncated .bss with -fdata-sections
Date:   Tue,  7 May 2019 01:35:01 -0400
Message-Id: <20190507053554.30848-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053554.30848-1-sashal@kernel.org>
References: <20190507053554.30848-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit 6a03469a1edc94da52b65478f1e00837add869a3 ]

With CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y, we compile the kernel with
-fdata-sections, which also splits the .bss section.

The new section, with a new .bss.* name, which pattern gets missed by the
main x86 linker script which only expects the '.bss' name. This results
in the discarding of the second part and a too small, truncated .bss
section and an unhappy, non-working kernel.

Use the common BSS_MAIN macro in the linker script to properly capture
and merge all the generated BSS sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190415164956.124067-1-samitolvanen@google.com
[ Extended the changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index c63bab98780c..85e6d5620188 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -372,7 +372,7 @@ SECTIONS
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
 		__bss_start = .;
 		*(.bss..page_aligned)
-		*(.bss)
+		*(BSS_MAIN)
 		BSS_DECRYPTED
 		. = ALIGN(PAGE_SIZE);
 		__bss_stop = .;
-- 
2.20.1

