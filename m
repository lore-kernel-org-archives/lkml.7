Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C3BC48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E77A205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mKbcgRcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbfFXPt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:49:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35028 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfFXPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:49:27 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so608368ioo.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/CTIq1HdIxzxdpehMHCyy5IUFBPpAMudQ6zK1OgHCE8=;
        b=mKbcgRcwaHfrmZlxeA0cp7rLPXj7KAz0taPq2RCAEY9dTbYu+m7Bqlcnjx0x2wxzO1
         hQFRn2R0epb3WFRFm9pBlFnV7SDgroUwVwrH7t2MiJY5+rPplaQ1I+cyIt+jiMpnEl0b
         hpn+m+KDi++MTk8bCIhDdWp7IpwKwoJtC4kw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/CTIq1HdIxzxdpehMHCyy5IUFBPpAMudQ6zK1OgHCE8=;
        b=N/5HSbkkO8TYpdHqt8rj1qD7nmb55JG2TC1+6yVmmZcelSQLrqK8W19VKHk61sobH7
         w1x9JA9lxfvKyVqUkzKbE34bCfYwFjb4cpEuVNfSOPI9q+XaVazFQorbcPWmZGX3KLOx
         g3g6J5U44cM17W0S6X8uOQnR7GEf9Zy4DWBmIocP2RsMoCVWoHauTKt/Olxi+7iynt7X
         LQhEhnySui4aXwhW461RqVIdcQu5zep0hbH9y/wJkLA6cfLCA+E0Y7lAF3zhIIFq/Hjp
         wr/PRiLJ6rBTsbUbSjAf93+fvYp4+qpWrAwymV5pkG/0MW+w70MGOfFQNJIA5mxLb1M7
         86qw==
X-Gm-Message-State: APjAAAVAY9T4oZs7NZSGGK1EqSoGfUaMjsxSUw7OrFwnzATmnN5VgoH+
        fDlGnWvevMkd8DRdcd1b5uQgkw==
X-Google-Smtp-Source: APXvYqyj2BYPx36CSXPCjdMUcwuByrZDPIhDJZ4u3mAYSUH4vCpEfQWiZiLMm6TnQhUkJpCR8ANa1Q==
X-Received: by 2002:a6b:6f0e:: with SMTP id k14mr3667985ioc.257.1561391367034;
        Mon, 24 Jun 2019 08:49:27 -0700 (PDT)
Received: from ddavenport4.bld.corp.google.com ([2620:15c:183:0:92f:a80a:519d:f777])
        by smtp.gmail.com with ESMTPSA id y20sm9740693ion.77.2019.06.24.08.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jun 2019 08:49:26 -0700 (PDT)
From:   Drew Davenport <ddavenport@chromium.org>
To:     akpm@linux-foundation.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        Drew Davenport <ddavenport@chromium.org>,
        stable@vger.kernel.org
Subject: [PATCH] bug: Fix "cut here" for WARN_ON for __WARN_TAINT architectures
Date:   Mon, 24 Jun 2019 09:48:31 -0600
Message-Id: <20190624154831.163888-1-ddavenport@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For architectures using __WARN_TAINT, the WARN_ON macro did not
print out the "cut here" string. The other WARN_XXX macros would
print "cut here" inside __warn_printk, which is not called for
WARN_ON since it doesn't have a message to print.

Fixes: a7bed27af194 ("bug: fix "cut here" location for __WARN_TAINT architectures")
Cc: stable@vger.kernel.org

Signed-off-by: Drew Davenport <ddavenport@chromium.org>
---
 include/asm-generic/bug.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index c21ff2712803..79feb1a3081b 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -94,8 +94,10 @@ extern void warn_slowpath_null(const char *file, const int line);
 	warn_slowpath_fmt_taint(__FILE__, __LINE__, taint, arg)
 #else
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
-#define __WARN()		__WARN_TAINT(TAINT_WARN)
-#define __WARN_printf(arg...)	do { __warn_printk(arg); __WARN(); } while (0)
+#define __WARN() do { \
+	printk(KERN_WARNING CUT_HERE); __WARN_TAINT(TAINT_WARN); \
+} while (0)
+#define __WARN_printf(arg...)	__WARN_printf_taint(TAINT_WARN, arg)
 #define __WARN_printf_taint(taint, arg...)				\
 	do { __warn_printk(arg); __WARN_TAINT(taint); } while (0)
 #endif
-- 
2.20.1

