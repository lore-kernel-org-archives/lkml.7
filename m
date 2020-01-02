Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B26CC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27E421655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbYGDZ2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgABEbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:31:19 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36466 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgABEbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:31:13 -0500
Received: by mail-qk1-f195.google.com with SMTP id a203so30980396qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 20:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nfaGL95TSLRjcQiyh+M/l9sx3mjoZwVjo6SVlE9q9g=;
        b=bbYGDZ2OO5TkZc92tmgGGxF8AI+AcCFZhtMMZcTgkmPiDwajj0VBrxEwYCkP9umzrl
         4liUBxcpK6mBy7wEMvU8jqPgijwTVUtLX7UHOZk/fvSKZP9pUDXWvUO7OLBAGB8fJ5KX
         PbUYYp3ZUgXEGwGOhpQBmwIn6uGPLSKfDIdeBwyNL6QcbiGt7dw7GXwHOxv6WL4RzNa0
         3n5qSRPe28gBmtkpvBkuVhb9x+m5oL7dIIh0UYdgpOTxwpQzSkPyvUOgPv0hvZ+IaydF
         YHtJlDNaJ56ju2wgMHtxpNreAYEZsVgz/SRway2zrTNZv5pPOvpcDYwWx5sardIrShPZ
         GBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nfaGL95TSLRjcQiyh+M/l9sx3mjoZwVjo6SVlE9q9g=;
        b=COGj1qRVbd7mChva5FpgWom1LJBcL6YFKmAbYlNOdEAwcNe8nY2Gj2+ehGxUaBiYsu
         ua4ybmptCzxVLDcqIqG+AgsnYUZwJgx+zB0/biOweE7tXjFuWg/F7aaspe0wa2C4xCf+
         gxqTNNrSc1khneYbZmd7ASLbGsxhhzRx0CxuHXKCytlMSi16Cxe3aicw5GiILidZ/DHC
         uYCQGvG/O8ypytArsDNWOxZGSbtf7yC7n6xf3RCPfWsbNA5XEThVB4I+DOVMiiAgeCLu
         jTO6P1KRyPi4DTVWODDYUrrnoIeoaraxSKfW1aRbTM9sATRxr5LCXaY72kldBRdkdr7N
         FhHQ==
X-Gm-Message-State: APjAAAX33OESJctzEhy2I2wmZcKe4m9wXFNZeTaRDdFUoFu3r465M3zc
        Arh6hxcQ/ckvX7Pof9zsQlo=
X-Google-Smtp-Source: APXvYqxeKoEPY6pna6RGzne+nlhUOD16tgrnkRa+/X+oxHXNVofKJdgKx4uef299yFz9669tGaUAJg==
X-Received: by 2002:a37:a54b:: with SMTP id o72mr64747916qke.313.1577939472692;
        Wed, 01 Jan 2020 20:31:12 -0800 (PST)
Received: from yury-thinkpad.dhcp.amer.jpmchase.net ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id 16sm14876857qkj.77.2020.01.01.20.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 20:31:12 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
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
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 1/7] lib/string: add strnchrnul()
Date:   Wed,  1 Jan 2020 20:30:25 -0800
Message-Id: <20200102043031.30357-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200102043031.30357-1-yury.norov@gmail.com>
References: <20200102043031.30357-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Yury Norov <yury.norov@gmail.com>

New function works like strchrnul() with a length limited strings.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/string.h |  1 +
 lib/string.c           | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 6b0e950701d02..3b8e8b12dd37c 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -107,6 +107,7 @@ extern char * strchr(const char *,int);
 #ifndef __HAVE_ARCH_STRCHRNUL
 extern char * strchrnul(const char *,int);
 #endif
+extern char * strnchrnul(const char *, size_t, int);
 #ifndef __HAVE_ARCH_STRNCHR
 extern char * strnchr(const char *, size_t, int);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 08ec58cc673b5..f607b967d9785 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -434,6 +434,23 @@ char *strchrnul(const char *s, int c)
 EXPORT_SYMBOL(strchrnul);
 #endif
 
+/**
+ * strnchrnul - Find and return a character in a length limited string,
+ * or end of string
+ * @s: The string to be searched
+ * @count: The number of characters to be searched
+ * @c: The character to search for
+ *
+ * Returns pointer to the first occurrence of 'c' in s. If c is not found,
+ * then return a pointer to the last character of the string.
+ */
+char *strnchrnul(const char *s, size_t count, int c)
+{
+	while (count-- && *s && *s != (char)c)
+		s++;
+	return (char *)s;
+}
+
 #ifndef __HAVE_ARCH_STRRCHR
 /**
  * strrchr - Find the last occurrence of a character in a string
-- 
2.20.1

