Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEF3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD512075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715067;
	bh=UNeV/CEiqTpGckZzIp25/uCRYplK5p5pIYBYfUU7yIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cPBuZIDkzA+Sy0huf8NfnKYClWB0HK1n4NoCKRc9K1XunPc1Xzuj78gdnXNrQow2R
	 NGe54te7uzNf3X1NDBfoEAV77QbtGHcknNEXo/oNQflQrvmBZV26eofXF/XhbfZK+7
	 ajVnHQK5dlgAHyhN/lNBMLq6eEVw9oCpk9dLaEa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbfC0TbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbfC0SDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:03:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA8E92177E;
        Wed, 27 Mar 2019 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709803;
        bh=UNeV/CEiqTpGckZzIp25/uCRYplK5p5pIYBYfUU7yIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yEf938IDBtskcjfTktcRTEC9eFAhYAXHorTLb8XNZGzEpvBD7i5jzUHnTf/5gNsXn
         VdEsSX7sn+13JF7VO67XhtiyfjUKcy+vCpz0m9QOIUDQFbeqbniIQvQv0mNzVSJMmt
         0+lhv4P0Vdjd+mBg4tAkF4b7zxhVQP71VHYMdgQ4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.0 045/262] kasan: fix kasan_check_read/write definitions
Date:   Wed, 27 Mar 2019 13:58:20 -0400
Message-Id: <20190327180158.10245-45-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit bcf6f55a0d05eedd8ebb6ecc60ae3f93205ad833 ]

Building little-endian allmodconfig kernels on arm64 started failing
with the generated atomic.h implementation, since we now try to call
kasan helpers from the EFI stub:

  aarch64-linux-gnu-ld: drivers/firmware/efi/libstub/arm-stub.stub.o: in function `atomic_set':
  include/generated/atomic-instrumented.h:44: undefined reference to `__efistub_kasan_check_write'

I suspect that we get similar problems in other files that explicitly
disable KASAN for some reason but call atomic_t based helper functions.

We can fix this by checking the predefined __SANITIZE_ADDRESS__ macro
that the compiler sets instead of checking CONFIG_KASAN, but this in
turn requires a small hack in mm/kasan/common.c so we do see the extern
declaration there instead of the inline function.

Link: http://lkml.kernel.org/r/20181211133453.2835077-1-arnd@arndb.de
Fixes: b1864b828644 ("locking/atomics: build atomic headers as required")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kasan-checks.h | 2 +-
 mm/kasan/common.c            | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
index d314150658a4..a61dc075e2ce 100644
--- a/include/linux/kasan-checks.h
+++ b/include/linux/kasan-checks.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_KASAN_CHECKS_H
 #define _LINUX_KASAN_CHECKS_H
 
-#ifdef CONFIG_KASAN
+#if defined(__SANITIZE_ADDRESS__) || defined(__KASAN_INTERNAL)
 void kasan_check_read(const volatile void *p, unsigned int size);
 void kasan_check_write(const volatile void *p, unsigned int size);
 #else
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 09b534fbba17..80bbe62b16cd 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -14,6 +14,8 @@
  *
  */
 
+#define __KASAN_INTERNAL
+
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-- 
2.19.1

