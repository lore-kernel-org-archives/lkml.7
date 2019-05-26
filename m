Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E296C28CBF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 10:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD5E20863
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 10:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="JgYNuUv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfEZK11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 06:27:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43722 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfEZK11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 06:27:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id w33so18459960edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+oB2jDYFfiPbDeKt5OpxAstfWpdkA4qca9bIIMmsGE=;
        b=JgYNuUv018IPyJcRHgDtebanYdWMdoX7TqTb7KeEsIsMOxpJixhxGi6+cpO3GL29gJ
         we5uzd16MxfMbYjX3M4Wou3EISRCbu9zIFwFdtLO/dIbtOYyq1OxoqHh3Ckp1Z6U0np7
         E0axT2YppNMrxQONXAl62AQcpz4+MMSI4GeeTIfW0Mb6YhtGKSu+i5LY5zNu1qE3ytZU
         qG6FqdvDGg02Gmo5a6XamzkCXXesNYL490NeuCrg2YaxXdr1W7HynekZ/8ntlckHz9W5
         1hs8csuAesg6hDeMA6m33DATPVEs2yKhuxgqdO+gzw4xUIb8hE/5HKk7XpnVB6r6qFn4
         LwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+oB2jDYFfiPbDeKt5OpxAstfWpdkA4qca9bIIMmsGE=;
        b=YMud8Is24/JK8+tKhrabFy4Lcg5PdzuT/KdXQm+IWeYpjQPMjiCTY3WDXEvLEX8D2M
         YMRP/zdIVy1Nm7V576TXRP7Q9jO/aTCF4GDBcKNwITk/cKrIY4XY8/txF8MKpy1T8NNE
         SYxvkpZ3CAwbUzt/ogwQ5II0OaGYbeXiej68QypAW6CGWXnBQiASDFQvDHQvgRQ1ij2i
         +VLqrjwW9xAMHtfabWyS9qMNN5Y6m7hFiOHudMGhGa6O+jGo1Cf73Rm/O9ISKJDbXrhB
         bTMZZn6mPLc5avK3v5oDTyBtP9pBiOyYn78SC/y5nfVju3YPwlH343MZIcbZP4k7KZLj
         yExQ==
X-Gm-Message-State: APjAAAWWNo2h2j3rQ0mKBrtzNezF93mct504LBga42biksRmUjRlaPs8
        RntVvbU2oHErF/p8qGQqvFFD+g==
X-Google-Smtp-Source: APXvYqzLXD8k61g6xw/zjaPYfAsykZOtCqoXw4qSKk1VEtXwNkDzo/wxCo9Fz/U+2I9xaaEINIv1bw==
X-Received: by 2002:a17:906:1fcb:: with SMTP id e11mr83640788ejt.221.1558866445409;
        Sun, 26 May 2019 03:27:25 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bf7d3.dynamic.kabel-deutschland.de. [95.91.247.211])
        by smtp.gmail.com with ESMTPSA id l43sm2314100eda.70.2019.05.26.03.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 03:27:24 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com
Cc:     fweimer@redhat.com, oleg@redhat.com, arnd@arndb.de,
        dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org
Subject: [PATCH 2/2] arch: wire-up clone6() syscall on x86
Date:   Sun, 26 May 2019 12:26:12 +0200
Message-Id: <20190526102612.6970-2-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526102612.6970-1-christian@brauner.io>
References: <20190526102612.6970-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the clone6() call on x86.

This patch only wires up clone6() on x86. Some of the arches look like they
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
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 include/uapi/asm-generic/unistd.h      | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ad968b7bac72..dffcd57990b3 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
 432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
+436	i386	clone6			sys_clone6			__ia32_sys_clone6
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e6204a..73bf4cc099a2 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+436	common	clone6			__x64_sys_clone6/ptregs
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a87904daf103..500bdb4c5e36 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -844,9 +844,11 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_clone6 436
+__SYSCALL(__NR_clone6, sys_clone6)
 
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 437
 
 /*
  * 32 bit systems traditionally used different
-- 
2.21.0

