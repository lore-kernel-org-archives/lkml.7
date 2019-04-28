Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2382C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD78205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vetf1E5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfD1D3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 23:29:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38400 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfD1D3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 23:29:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id f36so3414804plb.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 20:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t0fbPBc8WL/45aaOebc5T9OubIEUSHJaCFoFZIq2imw=;
        b=Vetf1E5Jemf5j3XxsXjHL59pOCEy1qCn1xcw4FKwuKNsbyIGMtIVQQD+IQq+cVdHtl
         QJvxKY6RWVf2xElLg0f3HvwkXoeY7B2SQPiT1Uxuwxz2Dyt5/bqiwFIUjihHTOG/E6Zr
         haWcK1L3HRLDED4eeh3pGjrWbIU+QkRhmO33YXxL/PdW83eNTSQ1RY6vaeV4om7b/jYj
         pHf4on5kMSDlluROKFnBHc9KIhHwRpbQLQ9xxDNrIDo9XfnHfOKuhXN5bLIPi9b2qvP3
         87ySdcscBmgOedWkPw8t06736nH/3ui6GqMWYbWpVReSk1ne/en8GGaxNm5uwkLj0+1J
         xF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t0fbPBc8WL/45aaOebc5T9OubIEUSHJaCFoFZIq2imw=;
        b=WDwzvoeAVa1jkl2/SeK+cSVkSx10fIfCyX6GGP8ytNug+iFJOIqGqUetfTLkx7O0oF
         /+iiMmrzoaY5lRqH1vurmdD+mnQRqlyI9djWCu9OSQkqXM6gayu6WOnVNgK2iFuVnIvt
         bYW0C1WGPbFSlwuQWov+CMZhfNUYgrAGjTasKhJ9c9cGaZSvcIvJE1iCFM437Zrpoxgf
         N92zp+Wpu67GUYZqsZci3KgXFe2bQiEk2u3SjLPBWbaKANK6wP/tP/X4f8/gDrs6nHb7
         Bp1EGX/f7Z0V/9hfHuv6NKJWdL9faOJ7DFY10ua8beSDqhwtuue5ET3GeTt/hd3vgHVR
         Rs2g==
X-Gm-Message-State: APjAAAWmeFFjOZzhElVd1NMvZ7UHhnX73imUHc+nxIzK3zCraZ2osJ6l
        euj8EP3iI6sQ3fu7XLr5nsE=
X-Google-Smtp-Source: APXvYqyASYuLtn3qCp5Kx0NraY38EXzHP+NOSYUTMBqSRtYUayC1U+hdFc9+PcFU2AexY9KuYSP5tg==
X-Received: by 2002:a17:902:43a4:: with SMTP id j33mr55223245pld.307.1556422184450;
        Sat, 27 Apr 2019 20:29:44 -0700 (PDT)
Received: from localhost ([2601:640:6:3484:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id d187sm32989201pgc.43.2019.04.27.20.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 20:29:43 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 1/6] lib/string: add strnchrnul()
Date:   Sat, 27 Apr 2019 20:29:31 -0700
Message-Id: <20190428032936.1317-2-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190428032936.1317-1-ynorov@marvell.com>
References: <20190428032936.1317-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New function works like strchrnul() with a length limited strings.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 include/linux/string.h |  3 +++
 lib/string.c           | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 4deb11f7976b..69e8df51b630 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -62,6 +62,9 @@ extern char * strchr(const char *,int);
 #ifndef __HAVE_ARCH_STRCHRNUL
 extern char * strchrnul(const char *,int);
 #endif
+#ifndef __HAVE_ARCH_STRNCHRNUL
+extern char * strnchrnul(const char *, int, int);
+#endif
 #ifndef __HAVE_ARCH_STRNCHR
 extern char * strnchr(const char *, size_t, int);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 6016eb3ac73d..dd99e6ac517a 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -429,6 +429,26 @@ char *strchrnul(const char *s, int c)
 EXPORT_SYMBOL(strchrnul);
 #endif
 
+#ifndef __HAVE_ARCH_STRNCHRNUL
+/**
+ * strnchrnul - Find and return a character in a length limited string,
+ * or end of string
+ * @s: The string to be searched
+ * @count: The number of characters to be searched
+ * @c: The character to search for
+ *
+ * Returns pointer to first occurrence of 'c' in s. If c is not found,
+ * then return a pointer to the null byte at the end of s.
+ */
+char *strnchrnul(const char *s, int count, int c)
+{
+	while (count-- && *s && *s != (char)c)
+		s++;
+	return (char *)s;
+}
+EXPORT_SYMBOL(strnchrnul);
+#endif
+
 #ifndef __HAVE_ARCH_STRRCHR
 /**
  * strrchr - Find the last occurrence of a character in a string
-- 
2.17.1

