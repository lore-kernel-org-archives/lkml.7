Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148742192B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255733;
	bh=iaP6tjL41Gr6eJ6zro4soELsdReZ6RHWXJno1skuRXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x+Pe6W6J2p7eEWRQE0qyL4jhfmlebggeHv61P22aoc8202LISVlD7qALkPWubRcHg
	 DPyBdlnjPw0OsOdLBVtgtr975jVBSuDg7urT3HlTO5C1JjsCRCIjQGDbHI9vfpIzfs
	 oEsK/6HZ0XDauXuhbTYUev8lx7SHOBVPiiGqqohs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbfCVLzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733312AbfCVLz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:55:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A0A62082C;
        Fri, 22 Mar 2019 11:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255728;
        bh=iaP6tjL41Gr6eJ6zro4soELsdReZ6RHWXJno1skuRXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q5KL9uo6OejQyqeb11fmb/FWpJ7RzWHhMSEJvIQuv8dvqgXzVFUI5O0QmTO19FPlf
         PcyJaT0qX1ZmCVSePD4BwYZEmn7V159lEgOXY++0YXNuTBiWIyp0DzugX0d96j73gU
         GMBkXIIxToaZHmHYwmg13PdNcCMzyiZxsT0L8P5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4.14 162/183] x86/unwind/orc: Fix ORC unwind table alignment
Date:   Fri, 22 Mar 2019 12:16:30 +0100
Message-Id: <20190322111253.637843202@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -696,7 +696,7 @@
 		KEEP(*(.orc_unwind_ip))					\
 		VMLINUX_SYMBOL(__stop_orc_unwind_ip) = .;		\
 	}								\
-	. = ALIGN(6);							\
+	. = ALIGN(2);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
 		VMLINUX_SYMBOL(__start_orc_unwind) = .;			\
 		KEEP(*(.orc_unwind))					\


