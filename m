Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFCDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B9B2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzT8/LLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfH1W4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:56:22 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41238 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfH1W4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:56:19 -0400
Received: by mail-pf1-f201.google.com with SMTP id 191so861795pfz.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b7ld9YNlx/ctaSkEdtcO3fpX7aUy1ofd0MxWpfkF/rA=;
        b=JzT8/LLbQFND6yOdtjnjndUw5dZEXCmhAV49vnQicQImhLm9v6qzCBihCNlmrsXKTl
         jKpxIU6rwju1F8GAvgLl1poxw1iypySHcqwITYHfFdUetBFnQRy2MYw8B4Fx8DZva/43
         lI575oWycij5nbg78kD4esr4cV4ET13QvfrjpDIDnzzw+1tMt7relayQpEUDZSxiswjX
         dJdU0sBvXksVr/8/4uioOoYAHsSOYQKNTnYrlSKsq5NIqH0bFJBkrBCK3sF/VWxnDDRb
         pf05BA3w+S5mdkYjgJ7+v+z5ce9kp5i80DlZxB2Q3DhYgUwvhgc9vAZXNGlUFnsnHxWz
         MOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b7ld9YNlx/ctaSkEdtcO3fpX7aUy1ofd0MxWpfkF/rA=;
        b=LKC2X0Ii+6or/U6sB1njrkOCCXIxtT9s26mWvlYUDVTQiIDWFtz9DYGd/JnLMzygIF
         3HvVyK2aN+JZNLpsamjXONpQKmFWOxo6JGNp/UmU9nuCWbzarV0egZvkdjTeqHi7a1zi
         S3mukk9cI0mZGS+ilYFcMZ0ud07M5avfPIos2WtIty9xqGlDbvkmagW6dReqOYIk5WBw
         fij4yNUPNIl35FgxOVZxZAiugfMr5MMXvpYB9fPC1kss27uxeBvv+N3UYem8Hhpf0FYP
         zojdn545Eq3IHEKKEQXw23no8bv/J6IXHRGTpnsDhQNua52WTW1feCFeIT47ArmNhfGK
         lrCw==
X-Gm-Message-State: APjAAAXmQODTaKBMee85H4tBv0jLQuMLLLCtgCxqBWt74pEJgM5GKn3/
        bh0RzyAasHi8k7afDdfcGVkqlyMAJLLak5Rx6DY=
X-Google-Smtp-Source: APXvYqx6pEqROs2HZkrQhulF4T9Tz/HeHr6yqL4s9fnbc6XdE+si85r0zcogoTYioslJn8BPV7HOIR5p5+RmsOjEOG8=
X-Received: by 2002:a63:6686:: with SMTP id a128mr5422005pgc.361.1567032978096;
 Wed, 28 Aug 2019 15:56:18 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:55:29 -0700
In-Reply-To: <20190828225535.49592-1-ndesaulniers@google.com>
Message-Id: <20190828225535.49592-9-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 08/14] sparc: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

Instead, we should:
1. Prefer __section(.section_name_no_quotes).
2. Only use __attribute__((__section__(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
Link: https://github.com/ClangBuiltLinux/linux/issues/619
Acked-by: David S. Miller <davem@davemloft.net>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/sparc/include/asm/cache.h | 2 +-
 arch/sparc/kernel/btext.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/cache.h b/arch/sparc/include/asm/cache.h
index dcfd58118c11..9a9effdd01e2 100644
--- a/arch/sparc/include/asm/cache.h
+++ b/arch/sparc/include/asm/cache.h
@@ -21,6 +21,6 @@
 
 #define SMP_CACHE_BYTES (1 << SMP_CACHE_BYTES_SHIFT)
 
-#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+#define __read_mostly __section(.data..read_mostly)
 
 #endif /* !(_SPARC_CACHE_H) */
diff --git a/arch/sparc/kernel/btext.c b/arch/sparc/kernel/btext.c
index 5869773f3dc4..b2eff8f8f27b 100644
--- a/arch/sparc/kernel/btext.c
+++ b/arch/sparc/kernel/btext.c
@@ -24,7 +24,7 @@ static void draw_byte_32(unsigned char *bits, unsigned int *base, int rb);
 static void draw_byte_16(unsigned char *bits, unsigned int *base, int rb);
 static void draw_byte_8(unsigned char *bits, unsigned int *base, int rb);
 
-#define __force_data __attribute__((__section__(".data")))
+#define __force_data __section(.data)
 
 static int g_loc_X __force_data;
 static int g_loc_Y __force_data;
-- 
2.23.0.187.g17f5b7556c-goog

