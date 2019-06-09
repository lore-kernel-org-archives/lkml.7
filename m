Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B94BC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8FE208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099641;
	bh=orFbGQNmIg/UlgOMEjrkVkWSq42RPN7hoa0UHDkDI8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ih81CTHp4krpQLDuDS4Lho/5pBa65V57tHUxikCIIA4liJPuPRMAadZ6Uznra0/bg
	 sgGwZzsV9NB5mtW9LCPHD9GWQHz0s3zTdO0Oj0Aw2WHqR050yY6VAOeeWsG0FyqMeS
	 kEwitssF7m64CigSFDziHjp5dFQSjiwNtPX8Xn7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbfFIRAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387885AbfFIRAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:00:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5857520833;
        Sun,  9 Jun 2019 17:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099636;
        bh=orFbGQNmIg/UlgOMEjrkVkWSq42RPN7hoa0UHDkDI8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uZIrZ1JCPXqj6/RcZG7TlQuh6SChwP/imS+5fw/CwstuW3IGgPrL7wimLwNgg3LPk
         x180w3Pn159leTf0Rw4eHJ86+XQ6oLt47M1QQrM4EQkYgLSaKoTl3XmZa29Ywp+jwB
         qjDEnFKCHmpsOs8saoi0UgKTmWkmB/Rbt0p3jAAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH 4.4 111/241] x86/build: Move _etext to actual end of .text
Date:   Sun,  9 Jun 2019 18:40:53 +0200
Message-Id: <20190609164150.998565143@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 392bef709659abea614abfe53cf228e7a59876a4 ]

When building x86 with Clang LTO and CFI, CFI jump regions are
automatically added to the end of the .text section late in linking. As a
result, the _etext position was being labelled before the appended jump
regions, causing confusion about where the boundaries of the executable
region actually are in the running kernel, and broke at least the fault
injection code. This moves the _etext mark to outside (and immediately
after) the .text area, as it already the case on other architectures
(e.g. arm64, arm).

Reported-and-tested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190423183827.GA4012@beast
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 17e1e60b6b400..68dd72248919b 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -110,11 +110,11 @@ SECTIONS
 		*(.text.__x86.indirect_thunk)
 		__indirect_thunk_end = .;
 #endif
-
-		/* End of text section */
-		_etext = .;
 	} :text = 0x9090
 
+	/* End of text section */
+	_etext = .;
+
 	NOTES :text :note
 
 	EXCEPTION_TABLE(16) :text = 0x9090
-- 
2.20.1



