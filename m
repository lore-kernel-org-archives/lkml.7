Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57581C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBA322CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ef/XNIoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfH1Rg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:36:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43695 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfH1Rgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:36:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so91941pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=93yuXrsoDJcxfGXtFKyOpMG4hjEuFRY7JcoZkRO/7KU=;
        b=ef/XNIoNJ8FNf/2UnZbvjPJFb8vqeFEtJZZiDWxVd0dEO6hxV7LL75+7/Iq8aGzpzF
         iVg4v8/Ta29xut1+Ke/E3ivGKILuYoiqx8ehk5RClbXXnKRntl6kt8DoHEWsooVI/UG1
         Mw6C1HP/T5nI64PfzV2LE0znr18jvo0nu1TnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=93yuXrsoDJcxfGXtFKyOpMG4hjEuFRY7JcoZkRO/7KU=;
        b=H4T+v96XSsIL9kWI0dyirn35Jg7Gku3tNlfM9Ndli3hCt81VR7gDq5cBsmq2g8W7nO
         GjreqtOnzhLha5taCeIP2WGd0br8FitBXIUjpezl2MW/p7761NC0KwJwDtZydxnZZsQ+
         /n5wLAp++GVtKw+fjYUT7KevKGvzwOEpDjzrrNlCShoXM92F0wqO3BfDJNwUiJcasui+
         jfX0y4HveuhKxWz2eiZFJe1pvy+xWJS6wd+boSwtHDR8vSuashtFVm3V2O59FmYkVjLX
         gat55njzGP83/81XiwX634iGWNB9dB+bRVy+SqRxnMEArQQ0TQifHe2oYaMwG/74Y+uS
         6how==
X-Gm-Message-State: APjAAAWZKhzaIiM51Nh8Nx8izjwNAcOvZdRErfZLcAnRC+WUkK2zcc6R
        rY0ONzHine5zljdPGuJPanOErA==
X-Google-Smtp-Source: APXvYqxFk5KhDDxCy5Ewx4tfQUPIRn0OhctMJTT0EyfySELBd8Ch/wU/0zGOElx+WEND0stqqdNuhQ==
X-Received: by 2002:a17:90a:380a:: with SMTP id w10mr5337257pjb.138.1567013814445;
        Wed, 28 Aug 2019 10:36:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g2sm3692290pfm.32.2019.08.28.10.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:36:51 -0700 (PDT)
Date:   Sun, 25 Aug 2019 16:12:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] uaccess: Add missing __must_check attributes
Message-ID: <201908251609.ADAD5CAAC1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usercopy implementation comments describe that callers of the
copy_*_user() family of functions must always have their return values
checked. This can be enforced at compile time with __must_check, so add
it where needed.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/thread_info.h |  2 +-
 include/linux/uaccess.h     | 21 +++++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 8d8821b3689a..659a4400517b 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -134,7 +134,7 @@ static inline void copy_overflow(int size, unsigned long count)
 	WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
 }
 
-static __always_inline bool
+static __always_inline __must_check bool
 check_copy_size(const void *addr, size_t bytes, bool is_source)
 {
 	int sz = __compiletime_object_size(addr);
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 34a038563d97..70bbdc38dc37 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -55,7 +55,7 @@
  * as usual) and both source and destination can trigger faults.
  */
 
-static __always_inline unsigned long
+static __always_inline __must_check unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
 	kasan_check_write(to, n);
@@ -63,7 +63,7 @@ __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 	return raw_copy_from_user(to, from, n);
 }
 
-static __always_inline unsigned long
+static __always_inline __must_check unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	might_fault();
@@ -85,7 +85,7 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
  * The caller should also make sure he pins the user space address
  * so that we don't result in page fault and sleep.
  */
-static __always_inline unsigned long
+static __always_inline __must_check unsigned long
 __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
 {
 	kasan_check_read(from, n);
@@ -93,7 +93,7 @@ __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
 	return raw_copy_to_user(to, from, n);
 }
 
-static __always_inline unsigned long
+static __always_inline __must_check unsigned long
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
@@ -103,7 +103,7 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
 }
 
 #ifdef INLINE_COPY_FROM_USER
-static inline unsigned long
+static inline __must_check unsigned long
 _copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	unsigned long res = n;
@@ -117,12 +117,12 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
 	return res;
 }
 #else
-extern unsigned long
+extern __must_check unsigned long
 _copy_from_user(void *, const void __user *, unsigned long);
 #endif
 
 #ifdef INLINE_COPY_TO_USER
-static inline unsigned long
+static inline __must_check unsigned long
 _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
@@ -133,7 +133,7 @@ _copy_to_user(void __user *to, const void *from, unsigned long n)
 	return n;
 }
 #else
-extern unsigned long
+extern __must_check unsigned long
 _copy_to_user(void __user *, const void *, unsigned long);
 #endif
 
@@ -222,8 +222,9 @@ static inline bool pagefault_disabled(void)
 
 #ifndef ARCH_HAS_NOCACHE_UACCESS
 
-static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
-				const void __user *from, unsigned long n)
+static inline __must_check unsigned long
+__copy_from_user_inatomic_nocache(void *to, const void __user *from,
+				  unsigned long n)
 {
 	return __copy_from_user_inatomic(to, from, n);
 }
-- 
2.17.1


-- 
Kees Cook
