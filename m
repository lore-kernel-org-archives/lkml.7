Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2D5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F0A207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4smDkxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfCJKwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 06:52:02 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:34371 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfCJKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 06:52:02 -0400
Received: by mail-wm1-f41.google.com with SMTP id o10so11837487wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WOJxUyJgT5a4Gpwu3LaePhE9cITUNvZ4THprSE4VHKE=;
        b=m4smDkxxUdgxBN5vC1e4FGrfoQFFl4JBzjV3bwSzoFdgMpzF0Uc2YwLrchod7GOP5z
         vJ+QqDM0Ucoc8e2eJMMKhji2B1WnqFVHtOUQqofmR2RWuYS1gDcFlljRkr22GTmncqAd
         JGEeOIFG8rImOTJpuEq1vW7IlngNinO5Od7i6pFSgBVFV0mgokt0wYteNMFJ3VT+UfTU
         45fF8QwPRBQ3lpMrr8slbF4O32O/ABXfYjm0MfacVvUHwyJPlO+TJ5f72gjn5wkbaIFD
         b1JFTL1BOQhk/XmtFw5+hml1x/zOvrbd7pG8O3BkTnlaIEW7UjeS+idwo4gwazpVBe/J
         EVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WOJxUyJgT5a4Gpwu3LaePhE9cITUNvZ4THprSE4VHKE=;
        b=H/x+Nyr9wNUVQupsuHfg0nfV5S/FhWjetux9IWK8Xp6pVzbB3Y5qPhjrI/62H37tdF
         zOnHNmSPLS7jnLFQJ9UcBf3Brdiga3AN/x8lHGSsnrfB5wJSuITIRlxdHXYoZ0HHpO2E
         ermALc+k4fTT4mIVY8vKIHZ10HqtJA4CJ5cELCgHqKKvAVr+aFf1f63agZ2T15D7575X
         Plg2QkfiQg4XzkdCIw9UMC3VoY+ElAOCU4gcQUuteleS2K+WoL3QLxCutdGUmzcjSBOA
         Q9X9CzZECDx/FaoaesVEQ/Vsqkq6NTTkT+D4S/2rDaukqsLzQVWL6JMUqUbo6ENLD1Tv
         3bVQ==
X-Gm-Message-State: APjAAAUkm+wR439/L8FkhIzkH2nhhBDi3Z72Qb7jQy4JoOdg+/oeaugJ
        h5ku6zuhnr7QwWfmh18OqbDTS+s=
X-Google-Smtp-Source: APXvYqwWpNA6spbygdlIDUmTSc9flWs+iia/93hCLcD21q/74imSHYpCuEaOWKqNNf2/H3m6Ql+bqg==
X-Received: by 2002:a7b:cb48:: with SMTP id v8mr13709433wmj.138.1552215119661;
        Sun, 10 Mar 2019 03:51:59 -0700 (PDT)
Received: from avx2 ([46.53.246.68])
        by smtp.gmail.com with ESMTPSA id g81sm15307567wmf.7.2019.03.10.03.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 03:51:59 -0700 (PDT)
Date:   Sun, 10 Mar 2019 13:51:57 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk
Subject: [PATCH] static_assert: move before people start using it
Message-ID: <20190310105157.GA15039@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace places static_assert() macro at <assert.h>

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/assert.h          |   19 +++++++++++++++++++
 include/linux/build_bug.h |   19 -------------------
 include/linux/fs.h        |    2 +-
 lib/vsprintf.c            |    1 +
 4 files changed, 21 insertions(+), 20 deletions(-)

new file mode 100644
--- /dev/null
+++ b/include/assert.h
@@ -0,0 +1,19 @@
+#pragma once
+/**
+ * static_assert - check integer constant expression at build time
+ *
+ * static_assert() is a wrapper for the C11 _Static_assert, with a
+ * little macro magic to make the message optional (defaulting to the
+ * stringification of the tested expression).
+ *
+ * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
+ * scope, but requires the expression to be an integer constant
+ * expression (i.e., it is not enough that __builtin_constant_p() is
+ * true for expr).
+ *
+ * Also note that BUILD_BUG_ON() fails the build if the condition is
+ * true, while static_assert() fails the build if the expression is
+ * false.
+ */
+#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
+#define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -58,23 +58,4 @@
  */
 #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
 
-/**
- * static_assert - check integer constant expression at build time
- *
- * static_assert() is a wrapper for the C11 _Static_assert, with a
- * little macro magic to make the message optional (defaulting to the
- * stringification of the tested expression).
- *
- * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
- * scope, but requires the expression to be an integer constant
- * expression (i.e., it is not enough that __builtin_constant_p() is
- * true for expr).
- *
- * Also note that BUILD_BUG_ON() fails the build if the condition is
- * true, while static_assert() fails the build if the expression is
- * false.
- */
-#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
-#define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
-
 #endif	/* _LINUX_BUILD_BUG_H */
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_FS_H
 #define _LINUX_FS_H
-
+#include <assert.h>
 #include <linux/linkage.h>
 #include <linux/wait_bit.h>
 #include <linux/kdev_t.h>
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -16,6 +16,7 @@
  * - scnprintf and vscnprintf
  */
 
+#include <assert.h>
 #include <stdarg.h>
 #include <linux/build_bug.h>
 #include <linux/clk.h>
