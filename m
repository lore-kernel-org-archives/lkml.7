Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84158C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5971520663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfCFTkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:40:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfCFTkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:40:40 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x26JeA451851445
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Mar 2019 11:40:10 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x26Je9p31851442;
        Wed, 6 Mar 2019 11:40:09 -0800
Date:   Wed, 6 Mar 2019 11:40:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-f76a16adc485699f95bb71fce114f97c832fe664@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        mingo@kernel.org, jpoimboe@redhat.com, sedat.dilek@gmail.com,
        dima@golovin.in, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org
Reply-To: ndesaulniers@google.com, linux-kernel@vger.kernel.org,
          jpoimboe@redhat.com, sedat.dilek@gmail.com, mingo@kernel.org,
          hpa@zytor.com, tglx@linutronix.de, dima@golovin.in,
          peterz@infradead.org
In-Reply-To: <d55027ee95fe73e952dcd8be90aebd31b0095c45.1551892041.git.jpoimboe@redhat.com>
References: <d55027ee95fe73e952dcd8be90aebd31b0095c45.1551892041.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/unwind/orc: Fix ORC unwind table alignment
Git-Commit-ID: f76a16adc485699f95bb71fce114f97c832fe664
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f76a16adc485699f95bb71fce114f97c832fe664
Gitweb:     https://git.kernel.org/tip/f76a16adc485699f95bb71fce114f97c832fe664
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 6 Mar 2019 11:07:24 -0600
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Mar 2019 20:36:32 +0100

x86/unwind/orc: Fix ORC unwind table alignment

The .orc_unwind section is a packed array of 6-byte structs.  It's
currently aligned to 6 bytes, which is causing warnings in the LLD
linker.

Six isn't a power of two, so it's not a valid alignment value.  The
actual alignment doesn't matter much because it's an array of packed
structs.  An alignment of two is sufficient.  In reality it always gets
aligned to four bytes because it comes immediately after the
4-byte-aligned .orc_unwind_ip section.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: Dmitry Golovin <dima@golovin.in>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://github.com/ClangBuiltLinux/linux/issues/218
Link: https://lkml.kernel.org/r/d55027ee95fe73e952dcd8be90aebd31b0095c45.1551892041.git.jpoimboe@redhat.com

---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3d7a6a9c2370..f8f6f04c4453 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -733,7 +733,7 @@
 		KEEP(*(.orc_unwind_ip))					\
 		__stop_orc_unwind_ip = .;				\
 	}								\
-	. = ALIGN(6);							\
+	. = ALIGN(2);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
 		__start_orc_unwind = .;					\
 		KEEP(*(.orc_unwind))					\
