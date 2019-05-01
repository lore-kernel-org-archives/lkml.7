Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C387C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B22C2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5Qq9XVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfEABGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 21:06:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35641 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfEABGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 21:06:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so7935015pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 18:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PGH2UEgTOqUK+tdvn6V0iW1ke3I98pXm3Hch6j04sck=;
        b=c5Qq9XVDtPzxgmbbLNKFMCyYBaNC4kw3VqCUYJSBmiLafYDitn/97K3bBiZWDPdiT0
         Vxl2F6dgdx5TsBu9mMUFSVhKlzgVYE18BB0HT8ETgA7cu5Y86+K+a1PVH+201COHUalU
         cMspiXe8WmlZpppIZVIh6GsczLVWNBRQfXt0Iac3w331kHLLm4msKvNuCfkF0DWfV6st
         vlSdhNehg8saCnD8rwcDW2F4bwIUT/ck2EPUPbMVoi9cClh2jLJ2o27FyUZROqkuV7wU
         kimWMrQE7tUN5OpgwT04a1So5cgWC5FK5rMTMJFsm/bF6c+e2iUh1nvmOz9s5lWO4ek4
         eCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PGH2UEgTOqUK+tdvn6V0iW1ke3I98pXm3Hch6j04sck=;
        b=rynS+r4CgASDG4ozH7XdW/bjZfqes/T5zsf6NOXQyuySmbUi7dXMT5zlGuEO3/bbbp
         E3XgO2+XLEB1b3AqI7aNU+8BahexKZu3EaKfM4NHf9fQaGXXtg2fieHHzuiC+1Siyot0
         JU2iTsHIVCjeNA+2Ti7jVkvzDCRSR3npURfoCGrhHTN0UeHjKygQX43E/FfmM9JR/1t2
         80YXBTZUtdcEDiclzIoeOshxbszmVnWbAfJdxrDo2+MUMKb0QvmOYzKyz+Mbq7OsSSau
         UdxAtnH7sFcmNhQiw7J4f28G9FzhfwFh51YyuUyZFrzuES15go+UbmFsc+JUOQSnwUn1
         0LuA==
X-Gm-Message-State: APjAAAUmcnQUZ+OU0Jj3G0/9w6h5x2BK3J5OGnuaPvaN6AItXy2lEnLg
        XVKSQTkm4d+GQMch0ldeuUo=
X-Google-Smtp-Source: APXvYqwoD3pyezEvQ5umMmSMiVtvzjhNUOpoVesEmkkZXOOz5Y9WKIG3bCPbuC22JlNSMwXp5ZfXqw==
X-Received: by 2002:aa7:8453:: with SMTP id r19mr75217872pfn.44.1556672803710;
        Tue, 30 Apr 2019 18:06:43 -0700 (PDT)
Received: from localhost ([2601:640:7:332f:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id j6sm47299092pfe.107.2019.04.30.18.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 18:06:42 -0700 (PDT)
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
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 1/7] lib/string: add strnchrnul()
Date:   Tue, 30 Apr 2019 18:06:30 -0700
Message-Id: <20190501010636.30595-2-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501010636.30595-1-ynorov@marvell.com>
References: <20190501010636.30595-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New function works like strchrnul() with a length limited strings.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 include/linux/string.h |  1 +
 lib/string.c           | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 4deb11f7976b..ae934d6c50bf 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -62,6 +62,7 @@ extern char * strchr(const char *,int);
 #ifndef __HAVE_ARCH_STRCHRNUL
 extern char * strchrnul(const char *,int);
 #endif
+extern char * strnchrnul(const char *, size_t, int);
 #ifndef __HAVE_ARCH_STRNCHR
 extern char * strnchr(const char *, size_t, int);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 6016eb3ac73d..eee521ad1f40 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -429,6 +429,23 @@ char *strchrnul(const char *s, int c)
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
2.17.1

