Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E48C4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AF02084D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="TjJrxsl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfILWUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:20:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39761 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfILWTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:19:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id u6so25329731edq.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OHOoE81/vagVdgBIH9CLF85wSTRP1qRZlYCJ09Kjkp4=;
        b=TjJrxsl4zMXNrJFiUwiLu0rXfmuD+c9bLYta25oBAOywi1uIcNZagWhJtH0/xc4JQq
         5tPlC0jgBNcItarWE0JdpGDg0KttyWH7BoiWpfLd9T2xttJtJfLjff5GzrVD0HBOs7s/
         azlms+/f5/MN5FdWxUmiuSCwyzgP12gCZp/Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHOoE81/vagVdgBIH9CLF85wSTRP1qRZlYCJ09Kjkp4=;
        b=GibmSHpci1x1odUCSebcE2fkp0xRwmZz+hRNWaRRu0j9oaUT5fXNiFmGFyyOu/yEKn
         PpQTvHwmL6FXPL935yytWrHilNBMFXqCyMTR/HnPGPDgkd7oI7XNFcCOkgek7OzJAAZo
         7pMXXmB2rU2nKlfGBU88Auw32o5j4mRkHbTnlCFL1YgbNqCVQPVPJb5tTkueMnYHubqj
         C00zvd/VNXelbzdDn03vgG1QYmR0We2br7oi9rA9aW384/G2Ko4yLtoojUr8PrthVe8B
         uUpuXvbZj56hPAa4N4xlB6r1mP4tulUE9iSDJLWT1iDrLSe72qClSEOEDGqB23a71+za
         4qZg==
X-Gm-Message-State: APjAAAUBbb3sQqykmUVUEYE3MKE+JxM6dtj+mvcdnnU9X7tjTTQICXTy
        pxzSZn7iB1wF0C2EZGS1Tohmyg==
X-Google-Smtp-Source: APXvYqwVuv2WZLLpJLpIl8iaifWOV1Pbklez+EdUQAQZTc2XRJa6FHvGGT6cxlfmf5E90tcecg/37g==
X-Received: by 2002:aa7:d607:: with SMTP id c7mr45378150edr.286.1568326784935;
        Thu, 12 Sep 2019 15:19:44 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id 36sm4305228edz.92.2019.09.12.15.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 15:19:44 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 2/6] lib/zstd/mem.h: replace __inline by inline
Date:   Fri, 13 Sep 2019 00:19:23 +0200
Message-Id: <20190912221927.18641-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190912221927.18641-1-linux@rasmusvillemoes.dk>
References: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190912221927.18641-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, compiler_types.h #defines __inline as inline (and further
#defines inline to automatically attach some attributes), so this does
not change functionality. It serves as preparation for removing the
#define of __inline.

While at it, also remove the __attribute__((unused)) - it's already
included in the definition of the inline macro, and "open-coded"
__attribute__(()) should be avoided.

Since commit a95b37e20db9 (kbuild: get <linux/compiler_types.h> out of
<linux/kconfig.h>), compiler_types.h is automatically included by all
kernel C code - i.e., the definition of inline including the unused
attribute is guaranteed to be in effect whenever ZSTD_STATIC is
expanded.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/zstd/mem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/mem.h b/lib/zstd/mem.h
index 3a0f34c8706c..93d7a2c377fe 100644
--- a/lib/zstd/mem.h
+++ b/lib/zstd/mem.h
@@ -27,7 +27,7 @@
 /*-****************************************
 *  Compiler specifics
 ******************************************/
-#define ZSTD_STATIC static __inline __attribute__((unused))
+#define ZSTD_STATIC static inline
 
 /*-**************************************************************
 *  Basic Types
-- 
2.20.1

