Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF8CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD612077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTjXPUTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfDOQuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:50:02 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46172 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfDOQuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:50:02 -0400
Received: by mail-pf1-f202.google.com with SMTP id y2so12221374pfn.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XvS6R7pFmuEeQ0hWum3umdTl9lp34+wrkR9q3b4KAak=;
        b=LTjXPUTytuXYuUcvPwcJhTYuVEsjeErdsUzAQuB3DZ0xgXk6eLIwkZ16CJHc+/+AiQ
         ctQes55bB9Q88VViTcCAhy0U6B76C2B1XdLOzkuizYUjHAaIMzIOACVgjqfYC+j2jWNe
         634e/3m508mGIf5zmOHClvCr4illkJmrbwNk2QNr/PUgD4yubOF9YElmLUhhVzjlAt+e
         wRW9ut/9skblSOqhyr8PgewwJ9EIzWGhqCn4OmMxUxMK/4Zm1dI3ePLZ0SsY8/deJV2t
         JoSa4I4R7qhsM8wBpgEvsd8Kp7HfxvdRJjhTHR1DpUp492bbHoz2CRBJ1/8aQuH6c1E6
         PeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XvS6R7pFmuEeQ0hWum3umdTl9lp34+wrkR9q3b4KAak=;
        b=YfvsucUj2tb75qX/efj/Zb5lE/WYZQRA0/+6kqr4dtOj1sBZNbr8g5ZZ7RAF7pfUZE
         +Jezf5i0ydIJCAgtPZqW5fRF1ChnRcwzNEGpg4VUBQd83BPf2NkjnyGy91Jbih87nlh8
         bh+k/wAIaWhZGGndDZ8Hv2+9x+hYGBH0TymleKs9f+6emBVRmDXqDnPMphA/8baLWVPd
         bg2Sd3tTt16hFn7VPsvUdNzcDGL42GdOL2RtIhaIe+ZgYoPVIwS7PydBmFZd9z215Ggj
         8bWo9sLKnkB2IJHBoV7+HyBHAK+QcPUmy3NP6NMiSSq4rvwt4pC8/Jbfkj1FjoW3xDUk
         nJtg==
X-Gm-Message-State: APjAAAViEcNZTRzIaAmoPoQCbuXDgAsScGltxqWD+PARE4ZEECZebn+n
        ULe09Ja9oJTe04wESQV6aYqjJ2Ot2nl00ZHJl6k=
X-Google-Smtp-Source: APXvYqz3qmgPgJ4GtcUnwRT0HI1Xh1UhnH4k/JifhVgHFimAYdrDh9KYm25ap2wvFMmVDEmAg/0iqDwO3gnLsk/k/LI=
X-Received: by 2002:aa7:9141:: with SMTP id 1mr1911478pfi.46.1555347001285;
 Mon, 15 Apr 2019 09:50:01 -0700 (PDT)
Date:   Mon, 15 Apr 2019 09:49:56 -0700
Message-Id: <20190415164956.124067-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] x86: fix .bss with -fdata-sections
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With LD_DEAD_CODE_DATA_ELIMINATION, we compile the kernel with
-fdata-sections, which also splits the .bss section. Use the
common BSS_MAIN macro in the linker script to properly merge all
the generated sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index bad8c51fee6e..a5127b2c195f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -362,7 +362,7 @@ SECTIONS
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
 		__bss_start = .;
 		*(.bss..page_aligned)
-		*(.bss)
+		*(BSS_MAIN)
 		BSS_DECRYPTED
 		. = ALIGN(PAGE_SIZE);
 		__bss_stop = .;
-- 
2.21.0.392.gf8f6787159e-goog

