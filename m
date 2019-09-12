Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F52CC4CEC8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB309214DE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="VlWJzeFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfILWTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:19:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39764 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfILWTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:19:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id u6so25329752edq.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/Zs3M8U4xSGbreIPfz9YMDfpqs2smNfuk85ROC+apU=;
        b=VlWJzeFUMiBdShxxsRCMtQDi2X3BEYTsY+qF61Ym60/yomCJcq1ZK2npVmras1QC+O
         rZQw0OxEbN+rLICZpxnRxVeZf//HiYpNhHxqzS44MG+aK+swfNz2beu3YF1/DkjTQdJg
         mU8QEr32VZCpC0nOqS5XO7+hrmZQXMY2/Au3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/Zs3M8U4xSGbreIPfz9YMDfpqs2smNfuk85ROC+apU=;
        b=oS5KJvkJa48vcUR27cKXGUx0r4KShaBZiEkOAY+ZGsQyf7guNWaTrNgOn9pP22AJAT
         4Zren/NJmnMgFqB6Q0fF9L55gTZOCeXK71iqn/UXg95wi93UScCo2a0HinKzXkMmtBlx
         xnHelUoYlj5kWp0UPXo429XvsfYic1l0a0dNRs5/ohmAjme/sLhnp/osKZFY0Pk0bej1
         Hkvjgcm88RdykSgu43Nhf+4G2ZGGMIkk5YIJA0j6gNizwXlzk2MdWyWIYUmrgX7bvrhT
         JIFcjPRs9Pyi+unO8qUWHvE3M38F/OrNkU3+0fqwjZAElRYqn4jNGmFhCu349y/lO1c7
         UlfA==
X-Gm-Message-State: APjAAAXTlP6YtD7PUfdoEp0SEh0tBaFD/Div9RSw0GzVSm0Ia4bjBdgu
        nhSYv9kCdsknoukOCi1hhIH0ww==
X-Google-Smtp-Source: APXvYqyBmONlyJbpuPSE9kXi+uyAdtb5Ms1e+b/ehTsS11FCAJYi0pEjNI0GNEc5MXDbWAQAt2oZBw==
X-Received: by 2002:a05:6402:17aa:: with SMTP id j10mr44115355edy.222.1568326785970;
        Thu, 12 Sep 2019 15:19:45 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id 36sm4305228edz.92.2019.09.12.15.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 15:19:45 -0700 (PDT)
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
Subject: [PATCH v3 3/6] compiler_types.h: don't #define __inline
Date:   Fri, 13 Sep 2019 00:19:24 +0200
Message-Id: <20190912221927.18641-4-linux@rasmusvillemoes.dk>
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

The spellings __inline and __inline__ should be reserved for uses
where one really wants to refer to the inline keyword, regardless of
whether or not the spelling "inline" has been #defined to something
else. Due to use of __inline__ in uapi headers, we can't easily get
rid of the definition of __inline__. However, almost all users of
__inline has been converted to inline, so we can get rid of that
#define.

The exception is include/acpi/platform/acintel.h. However, that header
is only included when using the intel compiler (does anybody actually
build the kernel with that?), and the ACPI_INLINE macro is only used
in the definition of utterly trivial stub functions, where I doubt a
small change of semantics (lack of __gnu_inline) changes anything.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/compiler_types.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 599c27b56c29..ee49be6d6088 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -150,8 +150,17 @@ struct ftrace_likely_data {
 	__maybe_unused notrace
 #endif
 
+/*
+ * gcc provides both __inline__ and __inline as alternate spellings of
+ * the inline keyword, though the latter is undocumented. New kernel
+ * code should only use the inline spelling, but some existing code
+ * uses __inline__. Since we #define inline above, to ensure
+ * __inline__ has the same semantics, we need this #define.
+ *
+ * However, the spelling __inline is strictly reserved for referring
+ * to the bare keyword.
+ */
 #define __inline__ inline
-#define __inline   inline
 
 /*
  * Rather then using noinline to prevent stack consumption, use
-- 
2.20.1

