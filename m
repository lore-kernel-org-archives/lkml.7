Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462A7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A5420685
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257443;
	bh=DQUDU/wicvfblSmKO3y8YDpRo/lM3C0d0nuKwJLqwio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2LZe0Zy9zmlW7l5ogABvKa375c0bARqAbEyflFn6fLjyMh6lLObp0uHZCZZtXyngL
	 mWbICqEYvIOATiSfNfmVLOQjXO0zodv2/wIYo2Wg2FNAWGTi8zKGCNbHIfTdnWBR7G
	 Fp12Q//LxCwsGmAohw9JsIDr5ZzgPaQgkg10y77g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391222AbfCVMYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391190AbfCVMX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:23:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ACE02054F;
        Fri, 22 Mar 2019 12:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257439;
        bh=DQUDU/wicvfblSmKO3y8YDpRo/lM3C0d0nuKwJLqwio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAiaZxjPy4D9EjCyMOPEyF5VGEAmiVkoNBxA1+81g/xD6FepPTR1pnrWW0K5dVbKL
         cmnlM4bnCqn+Viriz34vv0IiDidXuP3bd9buyx8AkPx/Uh8MQJIWoCW1FYFBh7ft2z
         +84Cwn8s9V9yPMMjkkPAco0bEzAFZbunl70VfbK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.0 199/238] x86/unwind/orc: Fix ORC unwind table alignment
Date:   Fri, 22 Mar 2019 12:16:58 +0100
Message-Id: <20190322111309.936738551@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit f76a16adc485699f95bb71fce114f97c832fe664 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/asm-generic/vmlinux.lds.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


