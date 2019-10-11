Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3913CC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137D621920
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UICOc5TK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfJKAMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:12:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41426 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfJKAMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:12:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id t3so4693912pga.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C4qrRt1wPf/MBbE+aHUnjpKB3JMiaG6wbnmkvfoIFU0=;
        b=UICOc5TKza9BTCIUokRpRXRixWvfiu//j+nLFORdk7UGk/JwyzBWx+ycolyJCZr/Zj
         USYjJEh9S6rYvbkeSR5dqh4t0wO42rK96mEpNN2uDcZMnixq8tbOTsEogIYGcWgVfWSY
         D4i8QsjQVcM0qjRwO2F5cvKbTZ8BLcWZFx7T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C4qrRt1wPf/MBbE+aHUnjpKB3JMiaG6wbnmkvfoIFU0=;
        b=gPKcQUvPkb58TM+ybuab3sUI3PlOb4E2W/CjuLrvBi/5JilHMFxTdeawKaeNn3uCa2
         f4fXtDZVClBerWMoXfeOHdAZ6WMZ/0b/AJ9D9uLSJNRVsoAKKxwg3qXSA4Vd4rphcThI
         Pc/wSU8QjYnTbLrf/zR8fSfq5f91YGvbJr58dUkmOMWkZIPG83dnHvYvy7q+VkCLVZb5
         Y8Nv6djV3YPTDSYaGaP0bOC4TkYEQinArfyQOjKqc/jKsrxGmu97oH3G4ElaeHoQyHnI
         fSdEX70zUyXo9OwdTl4ya4k6EGTn9ld8arQ8Dlgf3cWmysLMtgqbgv9/tIOKrv2pp1d/
         YX2w==
X-Gm-Message-State: APjAAAXt7eGjr+ciffFgj6D0EsnNdQFFnP6yNK0R/3gLmLoKwRQPauwh
        2gD1YxXbHse7R0G5FgZWXjoBUg==
X-Google-Smtp-Source: APXvYqwliD8aT2m8D5BS3pRkZKxejc1RX6nlHmvajkiWktD94kckhfSBhz7/A5hJ2lTUaMfRy1yv0g==
X-Received: by 2002:a62:e206:: with SMTP id a6mr13749471pfi.245.1570752773224;
        Thu, 10 Oct 2019 17:12:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w2sm7937638pfn.57.2019.10.10.17.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:12:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/29] alpha: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 10 Oct 2019 17:05:57 -0700
Message-Id: <20191011000609.29728-18-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the EXCEPTION_TABLE is read-only, collapse it into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/alpha/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/vmlinux.lds.S b/arch/alpha/kernel/vmlinux.lds.S
index edc45f45523b..bc6f727278fd 100644
--- a/arch/alpha/kernel/vmlinux.lds.S
+++ b/arch/alpha/kernel/vmlinux.lds.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #define EMITS_PT_NOTE
+#define RO_EXCEPTION_TABLE_ALIGN	16
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
@@ -35,7 +36,6 @@ SECTIONS
 	_etext = .;	/* End of text section */
 
 	RO_DATA(4096)
-	EXCEPTION_TABLE(16)
 
 	/* Will be freed after init */
 	__init_begin = ALIGN(PAGE_SIZE);
-- 
2.17.1

