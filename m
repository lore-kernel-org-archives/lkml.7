Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37707C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F5B205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370320;
	bh=QdAIqRtdBfpxX6mDe/c/UCu3ModpzT5aE2JphyKTeF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Obigk0s+oZb9hJD+W/HavuToHBT6inOyYL0LRzRixxNxPMIlvBVrrf7rmvW/+kDpa
	 OdhH9ADqEKSXSejiRP8nROsB7rEE/h3FJUiMBzBLAy3FBDff2GYaVZ27GNR3XthOwU
	 69XeHq/EPEZvraKJDJom5/HVNQsyP1Pce3ot3E0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbfDDJb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728723AbfDDJJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:09:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 708ED20652;
        Thu,  4 Apr 2019 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368948;
        bh=QdAIqRtdBfpxX6mDe/c/UCu3ModpzT5aE2JphyKTeF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koZ+5HtGfYQa/1jb9a18iqDDMNLqCBtx/EoNcFQ/lLNn7H0xYwKetSU389JpvU/LU
         Qclxu+gaFoIzX86GjYagaJNa6sKqgQWhTOpYFfFAE+I5+aiimVy3qEClKh/QnNlc07
         QdSCIq9/eqCbWyVfiupjJzpGRONPr9Mop3yXiSUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 5.0 041/246] kasan: fix kasan_check_read/write definitions
Date:   Thu,  4 Apr 2019 10:45:41 +0200
Message-Id: <20190404084620.474868772@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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



