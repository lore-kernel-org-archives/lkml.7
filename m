Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C85C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560AD23C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="cxf6FGCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfE2PXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:23:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38324 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2PXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:23:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so2089667wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sEU/6jo/VWdUWlOyGNZQKsa0Hbh5Kew23C4AwHcHeOY=;
        b=cxf6FGCWzQXEk7cUsYBGphB6EHup1dBk3Ti5WgycwzrZ4P2SvoS1IFsZhZalAfXbeb
         DTmGlc6SreSP3V68maP1P2GHr4vl3fiR68a7LYtsGu99ifzbTtENj5V4f87/3TSUh0zH
         BjQ3s+0X9oYoMpo/iElk2U7WXBueVT4LAGy2LUil3ygMCFwvm7vA8Ug+ezui0l313mlZ
         CeTSqvkBuGMeLXo9QwhmUh3hVJdkN/XQ4lwQ2xhxg8kYlXWzFRsyTjgIpwAvB9ZfkIO7
         +TokJsJiTVObhuUShGqw4ehFOq0Z80X1iuMzgydyJIGClxFNn8bllXXo8UNsrH7IrcRa
         Lb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEU/6jo/VWdUWlOyGNZQKsa0Hbh5Kew23C4AwHcHeOY=;
        b=LyljJiaz4+mEvSiUs23biJWocXV648HDJ6C8ZkNNLNhH4G7QPcHT4Mdz7zjB6Q0uwe
         DD9JmS0o+pQQoc2B0PuNAaS7oJPk3cFrNhtCWEbfG9gdOfgUtFM/CX9UYkFMuT1AH0hg
         SPBbSp5lQdwr8tn9BZlePfDTkfPJ5ck1TpBTviHNzm4OaVkvFH6fJ3WpwwL/DV1F1MD8
         ik2SCwQN33ayDJgUUkz0gY5ICeIFpn6O/lGDRqzmzWErZoiBgyv56eWwFuQCPBCkSZ8p
         79h7PO0ssC+i/IwxA08q5WpWJ/ALwY4i56tGF8HjftfYOh8nSKqwsavo1BmNF98tgPyK
         X69Q==
X-Gm-Message-State: APjAAAVyN1e2QLuPORKV2hBuiQNsztk1dP7g35Zi/2GXgSoB6xMzGjcM
        HnTds1d8r7Rpmds8DyerBnj98g==
X-Google-Smtp-Source: APXvYqxqllal3eetCSSRngpIJj59zjpZSbbwaoTCO52UECzlz0mHSLjA0ealsaerNmAcnYfH9/PH3A==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr3797515wrn.159.1559143394433;
        Wed, 29 May 2019 08:23:14 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id x68sm7874865wmf.13.2019.05.29.08.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 08:23:13 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com
Cc:     fweimer@redhat.com, oleg@redhat.com, arnd@arndb.de,
        dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org
Subject: [PATCH v1 2/2] arch: wire-up clone3() syscall on x86
Date:   Wed, 29 May 2019 17:22:37 +0200
Message-Id: <20190529152237.10719-2-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529152237.10719-1-christian@brauner.io>
References: <20190529152237.10719-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the clone3() call on x86.

This patch only wires up clone3() on x86. Some of the arches look like they
need special assembly massaging and it is probably smarter if the
appropriate arch maintainers would do the actual wiring.

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Adrian Reber <adrian@lisas.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: x86@kernel.org
---
v1: unchanged
---
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 include/uapi/asm-generic/unistd.h      | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ad968b7bac72..80e26211feff 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
 432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
+436	i386	clone3			sys_clone3			__ia32_sys_clone3
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e6204a..7968f0b5b5e8 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+436	common	clone3			__x64_sys_clone3/ptregs
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a87904daf103..45bc87687c47 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -844,9 +844,11 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_clone3 436
+__SYSCALL(__NR_clone3, sys_clone3)
 
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 437
 
 /*
  * 32 bit systems traditionally used different
-- 
2.21.0

