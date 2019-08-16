Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40C2C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 23:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0405205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 23:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MyGaKK5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfHPX40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 19:56:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41246 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfHPX40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 19:56:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so3684627pgg.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 16:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y8big8JDLH0cEg2DUrcwlEE8MRigFGZIox3mPts2jbg=;
        b=MyGaKK5jNHd7VGf51BbEu2FRdNHg21E0zLOMXYc+0pvYVVzAbfUYrsmde4BVran2C/
         DO4aOZtcjC0SUD9tO091Sru888qwg9o1SH8OJGuz2hMosUSzuFzQ2J2vqMKu4boM/f/6
         USV+9xfiSw7yc8EuVZjsQ7su0oRSRd+kPTJqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y8big8JDLH0cEg2DUrcwlEE8MRigFGZIox3mPts2jbg=;
        b=rlIwvE9sKq2/sG6foHdkQ/ctCF9fobzchvRjnZyKAPAjkOxkYV/owg4JEekeOCiQu+
         mCeXjeC6Nhch8TD+mEiB5lflUnQZRtq8GUHDG+i/fPYb19Ieco1CjThnrMKBpTHdoq5W
         chGqYLq9zrIJHDIpT1/goA8foVFwY/2OIXfrfYyDWhu5DNwmWjsq9eCgMy6PQSUhNmPc
         i6JJLZFHjbd4CUlwGRIkBedYT2gQqt0wIxOxGGUCS0oLsDrrrmU2kuiaBzCWlVC7YH4d
         cS1yRttOMmTsBJDhGlqM0r/E3vDvTpkoCtQHP5RW7FdnBV7ZO6z83gFyDywj5RyZhozU
         YCkg==
X-Gm-Message-State: APjAAAXjsYNMMtptQG4AyODNvqcJTA/t+JPC+gY24hTb7CGZ1wcy7Qyu
        c9+tbO8HTNm7QR4BkkqR2O9GEQ==
X-Google-Smtp-Source: APXvYqzDbruWxDYAwt7gO2SKRvNKd/Nuis0oDEUcTVI4kflJ8LcBSvOGH41xY7QSvGOThxHbTQ5XIA==
X-Received: by 2002:a63:cb4f:: with SMTP id m15mr9806586pgi.100.1565999785380;
        Fri, 16 Aug 2019 16:56:25 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z68sm5753464pgz.88.2019.08.16.16.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 16:56:24 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/hexdump: Make print_hex_dump_bytes() a nop on !DEBUG builds
Date:   Fri, 16 Aug 2019 16:56:24 -0700
Message-Id: <20190816235624.115280-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a bunch of debug prints from a user of print_hex_dump_bytes()
in my kernel logs, but I don't have CONFIG_DYNAMIC_DEBUG enabled nor do
I have DEBUG defined in my build. The problem is that
print_hex_dump_bytes() calls a wrapper function in lib/hexdump.c  that
calls print_hex_dump() with KERN_DEBUG level. There are three cases to
consider here

  1. CONFIG_DYNAMIC_DEBUG=y  --> call dynamic_hex_dum()
  2. CONFIG_DYNAMIC_DEBUG=n && DEBUG --> call print_hex_dump()
  3. CONFIG_DYNAMIC_DEBUG=n && !DEBUG --> stub it out

Right now, that last case isn't detected and we still call
print_hex_dump() from the stub wrapper.

Let's make print_hex_dump_bytes() only call print_hex_dump_debug() so
that it works properly in all cases.

Case #1, print_hex_dump_debug() calls dynamic_hex_dump() and we get same
behavior. Case #2, print_hex_dump_debug() calls print_hex_dump() with
KERN_DEBUG and we get the same behavior. Case #3, print_hex_dump_debug()
is a nop, changing behavior to what we want, i.e. print nothing.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/printk.h | 22 +++++++++++++++-------
 lib/hexdump.c          | 21 ---------------------
 2 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cefd374c47b1..c09d67edda3a 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -488,13 +488,6 @@ extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
 extern void print_hex_dump(const char *level, const char *prefix_str,
 			   int prefix_type, int rowsize, int groupsize,
 			   const void *buf, size_t len, bool ascii);
-#if defined(CONFIG_DYNAMIC_DEBUG)
-#define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
-	dynamic_hex_dump(prefix_str, prefix_type, 16, 1, buf, len, true)
-#else
-extern void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
-				 const void *buf, size_t len);
-#endif /* defined(CONFIG_DYNAMIC_DEBUG) */
 #else
 static inline void print_hex_dump(const char *level, const char *prefix_str,
 				  int prefix_type, int rowsize, int groupsize,
@@ -526,4 +519,19 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
 }
 #endif
 
+/**
+ * print_hex_dump_bytes - shorthand form of print_hex_dump() with default params
+ * @prefix_str: string to prefix each line with;
+ *  caller supplies trailing spaces for alignment if desired
+ * @prefix_type: controls whether prefix of an offset, address, or none
+ *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
+ * @buf: data blob to dump
+ * @len: number of bytes in the @buf
+ *
+ * Calls print_hex_dump(), with log level of KERN_DEBUG,
+ * rowsize of 16, groupsize of 1, and ASCII output included.
+ */
+#define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
+	print_hex_dump_debug(prefix_str, prefix_type, 16, 1, buf, len, true)
+
 #endif
diff --git a/lib/hexdump.c b/lib/hexdump.c
index b1d55b669ae2..147133f8eb2f 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -270,25 +270,4 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 }
 EXPORT_SYMBOL(print_hex_dump);
 
-#if !defined(CONFIG_DYNAMIC_DEBUG)
-/**
- * print_hex_dump_bytes - shorthand form of print_hex_dump() with default params
- * @prefix_str: string to prefix each line with;
- *  caller supplies trailing spaces for alignment if desired
- * @prefix_type: controls whether prefix of an offset, address, or none
- *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
- * @buf: data blob to dump
- * @len: number of bytes in the @buf
- *
- * Calls print_hex_dump(), with log level of KERN_DEBUG,
- * rowsize of 16, groupsize of 1, and ASCII output included.
- */
-void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
-			  const void *buf, size_t len)
-{
-	print_hex_dump(KERN_DEBUG, prefix_str, prefix_type, 16, 1,
-		       buf, len, true);
-}
-EXPORT_SYMBOL(print_hex_dump_bytes);
-#endif /* !defined(CONFIG_DYNAMIC_DEBUG) */
 #endif /* defined(CONFIG_PRINTK) */
-- 
Sent by a computer through tubes

