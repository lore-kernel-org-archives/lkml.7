Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91156FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E5821D7F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239275;
	bh=qLaqX/z0adtFJJvxmrhsMd/vQ3e+34HWLa887NEigz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hdrw3JPvs5pqjQ81yz1FMC8rVcE5dLImBQXvnjbfFrZV4ueY70EKJY9IN+hRerl6i
	 owDnsxQQmtFFiRotcN0hUN/cXMoAn0ZQx17ijD+Y27ZgkORoOtyTYbUUZqNEsgjNwK
	 M3m3k1Dlky0U/CRqXtwSBXUARpNOx8PTflGh5AYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbfKHSyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:54:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732959AbfKHSy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:54:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1662218AE;
        Fri,  8 Nov 2019 18:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239269;
        bh=qLaqX/z0adtFJJvxmrhsMd/vQ3e+34HWLa887NEigz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OamCFJoR59zpi67rS3vhqH8FlkOMuhjBVJbeXfb5aAuZLfqxfZ+VoewCXjhn3mk+4
         8wr0QfN8ifV4PeXMzaZN7KXBN/vSyvyo2tfhOnyj4pU4+6zxtXczGbGSuDtoaJjVl6
         ELJPEJJ0cqQqHaIGMOR3yZ8D/a79JXvGiPfahdd0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk, Ard Biesheuvel" 
        <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 4.4 57/75] ARM: spectre-v1: use get_user() for __get_user()
Date:   Fri,  8 Nov 2019 19:50:14 +0100
Message-Id: <20191108174759.489192959@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174708.135680837@linuxfoundation.org>
References: <20191108174708.135680837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit b1cd0a14806321721aae45f5446ed83a3647c914 upstream.

Fixing __get_user() for spectre variant 1 is not sane: we would have to
add address space bounds checking in order to validate that the location
should be accessed, and then zero the address if found to be invalid.

Since __get_user() is supposed to avoid the bounds check, and this is
exactly what get_user() does, there's no point having two different
implementations that are doing the same thing.  So, when the Spectre
workarounds are required, make __get_user() an alias of get_user().

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/uaccess.h |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -288,6 +288,16 @@ static inline void set_fs(mm_segment_t f
 #define user_addr_max() \
 	(segment_eq(get_fs(), KERNEL_DS) ? ~0UL : get_fs())
 
+#ifdef CONFIG_CPU_SPECTRE
+/*
+ * When mitigating Spectre variant 1, it is not worth fixing the non-
+ * verifying accessors, because we need to add verification of the
+ * address space there.  Force these to use the standard get_user()
+ * version instead.
+ */
+#define __get_user(x, ptr) get_user(x, ptr)
+#else
+
 /*
  * The "__xxx" versions of the user access functions do not verify the
  * address space - it must have been done previously with a separate
@@ -304,12 +314,6 @@ static inline void set_fs(mm_segment_t f
 	__gu_err;							\
 })
 
-#define __get_user_error(x, ptr, err)					\
-({									\
-	__get_user_err((x), (ptr), err);				\
-	(void) 0;							\
-})
-
 #define __get_user_err(x, ptr, err)					\
 do {									\
 	unsigned long __gu_addr = (unsigned long)(ptr);			\
@@ -369,6 +373,7 @@ do {									\
 
 #define __get_user_asm_word(x, addr, err)			\
 	__get_user_asm(x, addr, err, ldr)
+#endif
 
 
 #define __put_user_switch(x, ptr, __err, __fn)				\


