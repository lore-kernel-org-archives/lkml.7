Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4CDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 02:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6872148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 02:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfCXC3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 22:29:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38146 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfCXC3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 22:29:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id e80so5180241ote.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 19:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eYHMHvfk1i1VZt1I+33kwKGsGJOWrp3Ur5mjx/9Dq0g=;
        b=BhRTlu3wod3kO/LOWZisBHA8F7Bi1TIRxdfcdOw72IW8Mxtsw0scdU5eGMl4af7T2o
         SG79D/fghmPkf06ZRFNpEi9LDezk04xuEbFDoE75R++CQtVDi7Pl44uMI3rPeaxl4cpk
         jJ2Of7+fQN0K03aldcgAROMoaz4/MXIMgPRdA6O0dXttWmu8+aR9gENXB1olL1hx+zHL
         gLxjBy0h5FtW5kLOg9GYqr8Drfsa2hZZySu9zUNpatBqJW0XDq7iITiiCRp3dXQBIHhI
         UemGoGZoI7GKdOe9YxMUp/gq4cmBkTgdFIxhEyPhXRWPed+N5+YxWXW0xYg02TWk5mOe
         h5qg==
X-Gm-Message-State: APjAAAVaqw9OnqwJpFGHPw8bOTkeAylOs2ElLzzNexgiHDk00kDTthWO
        a1Bf9IyopcZoi0MrB8AcuKo=
X-Google-Smtp-Source: APXvYqw7jmx2tIC8gqel9Fs7pNtCg+gcN2P4LI2ePF/oVJlfKtdCdIKTzvc8tRAXWKUYOedPYYEN+A==
X-Received: by 2002:a9d:7ac7:: with SMTP id m7mr13197905otn.179.1553394251435;
        Sat, 23 Mar 2019 19:24:11 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id 92sm4872410oti.60.2019.03.23.19.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Mar 2019 19:24:10 -0700 (PDT)
Date:   Sat, 23 Mar 2019 19:24:06 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RFCv2] string: Use faster alternatives when constant arguments are
 used
Message-ID: <20190324022406.GA18988@sultan-box.localdomain>
References: <20190324014445.28688-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324014445.28688-1-sultan@kerneltoast.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I messed up the return value for strcat in the first patch. Here's a fixed
version, ready for some scathing reviews.

From: Sultan Alsawaf <sultan@kerneltoast.com>

When strcpy, strcat, and strcmp are used with a literal string, they can
be optimized to memcpy or memcmp calls. These alternatives are faster
since knowing the length of a string argument beforehand allows
traversal through the string word at a time without being concerned
about looking for the terminating zero character. In some cases, the
replaced calls to memcpy or memcmp can even be optimized out completely
for a significant speed up.

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 include/linux/string.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b875f..59c301c0e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -476,4 +476,34 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
 	return strncmp(str, prefix, len) == 0 ? len : 0;
 }
 
+/*
+ * Replace some common string helpers with faster alternatives when one of the
+ * arguments is a constant (i.e., literal string). This uses strlen instead of
+ * sizeof for calculating the string length in order to silence compiler
+ * warnings that may arise due to what the compiler thinks is incorrect sizeof
+ * usage. The strlen calls on constants are folded into scalar values at compile
+ * time, so performance is not reduced by using strlen.
+ */
+#define strcpy(dest, src)							\
+	__builtin_choose_expr(__builtin_constant_p(src),			\
+		memcpy((dest), (src), strlen(src) + 1),				\
+		(strcpy)((dest), (src)))
+
+#define strcat(dest, src)							\
+	__builtin_choose_expr(__builtin_constant_p(src),			\
+		({								\
+			memcpy(strchr((dest), '\0'), (src), strlen(src) + 1);	\
+			(dest);							\
+		}),								\
+		(strcat)((dest), (src)))
+
+#define strcmp(dest, src)							\
+	__builtin_choose_expr(__builtin_constant_p(dest),			\
+		__builtin_choose_expr(__builtin_constant_p(src),		\
+			(strcmp)((dest), (src)),				\
+			memcmp((dest), (src), strlen(dest) + 1)),		\
+		__builtin_choose_expr(__builtin_constant_p(src),		\
+			memcmp((dest), (src), strlen(src) + 1),			\
+			(strcmp)((dest), (src))))
+
 #endif /* _LINUX_STRING_H_ */
-- 
2.21.0

