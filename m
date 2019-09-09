Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC602C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B529B2196E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7Y9ASEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbfIIDdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 23:33:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39621 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733222AbfIIDdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:33:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id j16so11227479ljg.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 20:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sP3G2taks07JVJjYmcizqiN6Piw+vO0AmnF6NGNG57Y=;
        b=Q7Y9ASEgdlE1BzyD/aFBl+4+vZ8213IHtDuRGgHumulm16aQ2cSUD2/WZYVSV/xdbu
         X85Rcf6ekeLdErCj64l1aZ2QyaZM6/byjFRUX9a6EwVp23vwi+aCQ6z11ttGx6Vbp4Wg
         hRL/Q4aRr4LYYZ5iykr/xGbTRGdPFS5pjsi1mZB4mi6xF5MT5FuPhDeNj8xAXdJvl2gZ
         oxSRgfRUnYnR4RsT1c6O3I5ZXv3soxAmPmGMpnpHcPXWKQqPEUyzLYViVhsEXBwurnGs
         cpIQq5u5YCfkVPyRi4dVhVDaD/NjIWhpPPu2l9tSh8AzHYpmeKHQW4p+2hlLRJbkTqqm
         bEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sP3G2taks07JVJjYmcizqiN6Piw+vO0AmnF6NGNG57Y=;
        b=p1rqxULgIpDuhoxtHNrxUBZmBnCawr0s1+wZ3QZbpu1o6ZMOr6ZuilR2a1oypnX3Q/
         5XfVHZqYZnIbCaD1p2qtJBuJX03jtA1pff0KBDmvgS7r8n+m+ricEdPDPmVtoHQKbDmo
         tJkSqgGhAPjr6hEIn/T55vUaT413V/thX7vYvUC8OGFTQNP8Dx24vZKXrImLxx+y726y
         O9YCw21IRZAWVWeBMt/92PvVgWvnvs3JMdl/WSIaW+7i7yeX3NVKIyuO/uCgxeSYEzPc
         GAajEVG6Wan+5Xug9aSd6s7Tn/ixs230F3Iq8cjoV+IC6/F5qvxQXFKilqrFJvnfLqRc
         Zm3g==
X-Gm-Message-State: APjAAAVtl+EKeREFCjEwLfs8cZxe7jWoab7neB/21V1DpomVjkTxbSFF
        MxoLcqr0JSUs3mbcDin6q5g=
X-Google-Smtp-Source: APXvYqzF/aYZad0cwPAmeAVQ6b9F18Fz3nWgXR4xXVc7W7OTH0PM18U7UEws1Om9fL+N2HXAALVSlQ==
X-Received: by 2002:a2e:5418:: with SMTP id i24mr14230917ljb.126.1567999989944;
        Sun, 08 Sep 2019 20:33:09 -0700 (PDT)
Received: from localhost.localdomain (128-73-37-85.broadband.corbina.ru. [128.73.37.85])
        by smtp.gmail.com with ESMTPSA id f22sm2783605lfk.56.2019.09.08.20.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 20:33:09 -0700 (PDT)
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
Date:   Sun,  8 Sep 2019 20:30:15 -0700
Message-Id: <20190909033021.11600-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909033021.11600-1-yury.norov@gmail.com>
References: <20190909033021.11600-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New function works like strchrnul() with a length limited strings.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/string.h |  1 +
 lib/string.c           | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 3cf684db4bc6b..cf8f47efeb051 100644
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
index cd7a10c192109..75b10363e61f0 100644
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

