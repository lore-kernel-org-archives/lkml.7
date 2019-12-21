Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEAFC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 15:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFA721927
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 15:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rI/yCLRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfLUPSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 10:18:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39591 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfLUPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 10:18:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id q10so6875291pfs.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 07:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IalKy0cIDykcqIOovYMNggMAbyERadJBeyOCwn69dUI=;
        b=rI/yCLRW1ThOuyKlWa7kZYOiWbm1zu6K68+an8IKhVLuNvGgnWfpgFnH4UDCGl3fYg
         icPykowvK+rzcD5torv5jOkqTGxAvzA4IXkGKQcFBrP8RZ8VTPoxcBzZ7CmaVbOHF0hx
         eqP3eLTp8TXwnYRDu23M7ytsmL5TXh12UbNjrSQaIb/4Ok3UBNjtTgAn5LSn00MNM6e+
         VITjl3Er4YJM2hzPi9jay6JF58oel4H7eUHbxvPnE/ZKTNA9g8jiSZjVJSl+mqYHjQXC
         7l6i6Al18JcyPrEIDjGmWCgLyBkLAD6uO+Wehnm2dspIL4AKMDDGg0KlIPec8WjrUK6F
         n6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IalKy0cIDykcqIOovYMNggMAbyERadJBeyOCwn69dUI=;
        b=uASjPRi+NSg0a9bpBYGM2KzLaeKELZ/c/eK/8yxU6+7Mdmka3e4U3m1YEtMJlhBfRE
         mNvbAK+1zfiWYBay03aOJQMXJLA6ybLG4pHSpbhh26L7uVZ2awXmzzgZY+cw6K8aQ9os
         GMkCKi2DRWDcyRt/67WR8xCDuSAeR1sozYSLSIEtBwggknxjRCe7fPV3CKhNxoO7NmDb
         U9oPytNOmM71N8arf3ha4h88pjnOgIboJK/4D67WQV68dtlJFhCaMJ6qBVHSNqs72tb0
         /QurqQFibISEinfCQ4K67PS/8nkxM0kSdiijXE9/CwaNUvC6KifLBeK6pCU7vFaXF/DE
         4uyQ==
X-Gm-Message-State: APjAAAXNlMb3L0upk1+VQIjKBDNxpnq3VqWd5zwFIY+P1Ijqh587YFsc
        o3fpU9Fqn/AHrEkElOu29ISRP4Kb7LU=
X-Google-Smtp-Source: APXvYqzi7KYQSFIMqIKtWX1kLd2Lss+xS9iXkKxZBPunH9NrdSEXUw8xIlSuTMKau2Z9DHwCqLsItw==
X-Received: by 2002:a63:181:: with SMTP id 123mr20844550pgb.36.1576941532049;
        Sat, 21 Dec 2019 07:18:52 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9200:4e0::36e9])
        by smtp.gmail.com with ESMTPSA id t187sm17233646pfd.21.2019.12.21.07.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 07:18:51 -0800 (PST)
From:   Khem Raj <raj.khem@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] x86/boot/compressed/64: Define __force_order only when CONFIG_RANDOMIZE_BASE is unset
Date:   Sat, 21 Dec 2019 07:18:13 -0800
Message-Id: <20191221151813.1573450-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kaslr_64.c also defines the same variable, however when both files are
included into final link, linker complains about multiple definition of
`__force_order' which is coming from kaslr_64.o and pgtable_64.o, its
possible that kaslr_64.o is disabled via CONFIG_RANDOMIZE_BASE config
option, therefore define it conditionally only when
CONFIG_RANDOMIZE_BASE is not set

Since arch/x86/boot/compressed/Makefile overrides global CFLAGS it loses
-fno-common option which would have caught this

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/boot/compressed/pgtable_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index c8862696a47b..077d19268b0b 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -12,7 +12,9 @@
  * It is not referenced from the code, but GCC < 5 with -fPIE would fail
  * due to an undefined symbol. Define it to make these ancient GCCs work.
  */
+#ifndef CONFIG_RANDOMIZE_BASE
 unsigned long __force_order;
+#endif
 
 #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
 #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
-- 
2.24.1

