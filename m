Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9F0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A2820661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfCFRIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:08:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbfCFRIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:08:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3257C309175F;
        Wed,  6 Mar 2019 17:08:47 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFD2B18E39;
        Wed,  6 Mar 2019 17:08:45 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH] x86/unwind/orc: Fix ORC unwind table alignment
Date:   Wed,  6 Mar 2019 11:07:24 -0600
Message-Id: <d55027ee95fe73e952dcd8be90aebd31b0095c45.1551892041.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 06 Mar 2019 17:08:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .orc_unwind section is a packed array of 6-byte structs.  It's
currently aligned to 6 bytes, which is causing warnings in the LLD
linker.

Six isn't a power of two, so it's not a valid alignment value.  The
actual alignment doesn't matter much because it's an array of packed
structs.  An alignment of two is sufficient.  In reality it always gets
aligned to four bytes because it comes immediately after the
4-byte-aligned .orc_unwind_ip section.

Link: https://github.com/ClangBuiltLinux/linux/issues/218
Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: Dmitry Golovin <dima@golovin.in>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
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
-- 
2.17.2

