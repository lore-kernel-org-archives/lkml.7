Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF0BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B3E20656
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2TOTmIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfKZOqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:46:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37551 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKZOqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:46:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id g7so2086075wrw.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z4d670MtFAZBRVHDDr7y0hwhh3jdjrRCwzJNRcQEIpE=;
        b=b2TOTmIssjHAdfu33yethPu4DPKpr4YhsGK0jiWYpI4rByPGN6vKrELD6l/eWkO5Pj
         JwsxE59R4krfQTwhLW/J2sVsJvp0r616lQcwOq/fprrfZMYtnFFUpWcLQdCEX/ehF8wO
         VULG/somi6ZYO+lGfnZgzyHswOwE1dgdrO67woKr/PF/4CXPGntHp6PDq+Ao0yoeDW43
         Q/UvWkHMNQ2A9sLohyiUJZTaFjfA7V1NyMYDRy0O209j42zNyjU9icdjwiD8ShXQJUZ+
         ss9v9JtpHF6BP598vF/Oe/BxVVBihnbjK33XmDbS9QQp/F/ZgepjPbrv1MB2nCvpSVZy
         UONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z4d670MtFAZBRVHDDr7y0hwhh3jdjrRCwzJNRcQEIpE=;
        b=B4Bv9eLG81iyirk5zHV4/+WfmH7EPSB6oBZFTH5k+buErmkzZQtF6lAs2cwcFIR8Q6
         TSPHJBJd94NYeGtkSIz55rXq2UjzcrfR8zgDSnNKyPhpXgvZRm6b9Yihl3hnnTPkFF0K
         KM7HFSCJu2e7uK+wV3RHWkLRBNeCSm35e2uDmphVBw3yAVY3xbInZ3yXL0T2JyyxOJAI
         9Qc0YHm2ZB5BjeZsGEmxdzT0WznsM8NyWEAxorWOLX3vfkRZNbcxSLiSYcSXr2bpe1cE
         5GWdB3J/ZQom8FQC1bBcAwRkmtS56aQ6BG8c2rjnBrx9ZtFQLJl5pD4dy86OH/11MtN+
         GqjQ==
X-Gm-Message-State: APjAAAU27YEriN0yZFLQ3pkz7zy5uG4BLvg54Sc3iRIviWKqqGW5a0uX
        CZdJfO8ThZKSCMndAxlWVlM8x3THDfk=
X-Google-Smtp-Source: APXvYqz7zA8LG92MJSyDd2eRIISQ4Qcp/e84JCJxgZqxCKET9zDZXwoc5lrMqJeg6GKWYIPxTIWQKw==
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr14314290wrx.87.1574779604252;
        Tue, 26 Nov 2019 06:46:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:a58:8166:7500:6c1e:69e9:a832:6384])
        by smtp.gmail.com with ESMTPSA id s82sm3325380wms.28.2019.11.26.06.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 06:46:43 -0800 (PST)
From:   Ilie Halip <ilie.halip@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>, Andy <luto@kernel.org>,
        Ilie Halip <ilie.halip@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v3] x86/boot: discard .eh_frame sections
Date:   Tue, 26 Nov 2019 16:45:44 +0200
Message-Id: <20191126144545.19354-1-ilie.halip@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118175223.GM6363@zn.tnic>
References: <20191118175223.GM6363@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using GCC as compiler and LLVM's lld as linker, linking
setup.elf fails:
      LD      arch/x86/boot/setup.elf
    ld.lld: error: init sections too big!

This happens because GCC generates .eh_frame sections for most
of the files in that directory, then ld.lld places the merged
section before __end_init, triggering an assert in the linker
script.

Fix this by discarding the .eh_frame sections, as suggested by
Boris. The kernel proper linker script discards them too.

Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
Link: https://lore.kernel.org/lkml/20191118175223.GM6363@zn.tnic/
Link: https://github.com/ClangBuiltLinux/linux/issues/760
Suggested-by: Borislav Petkov <bp@alien8.de>
---

Changes in V3:
 * discard .eh_frame instead of placing it after .rodata

Changes in V2:
 * removed wildcard for input sections (.eh_frame* -> .eh_frame)

 arch/x86/boot/setup.ld | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 0149e41d42c2..3da1c37c6dd5 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -51,7 +51,10 @@ SECTIONS
 	. = ALIGN(16);
 	_end = .;
 
-	/DISCARD/ : { *(.note*) }
+	/DISCARD/	: {
+		*(.eh_frame)
+		*(.note*)
+	}
 
 	/*
 	 * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
-- 
2.17.1

