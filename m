Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B9FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 01:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF60D21741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 01:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSkOMucy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfCXBpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 21:45:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34757 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfCXBpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 21:45:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id k21so3768553otf.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 18:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4Lzus5Wtyy9wQfFPKmZQ8LTkfwqtT/vG63rLzLNciA=;
        b=vSkOMucyrF0lXVJbSpxrrz26lvpq8K6bw2ERHuZBYdE8ARbRtGGF/ZXAjvCgSjiDy9
         tBXeiXNA1MkQBVPehs5I8qWv1nC5gXh1BwJLcNVVp96mu8rNWgoHXt4mm5TFdeW6KPtI
         6l+35sudSDj3+LcceW8v54rPJUQfzTHBUb7g/MyrogEaClL9cdUXCHt6KcTRyZlS1+j4
         vCx6lxJ7q955GC4Z2+LRaNSmIpaBFTW6ycOHwdXW2ejCwRil5FoaEW7yqIaLnhG+JKL0
         zlWcALnX7GHGT6B53NpW6zPD3bc9abMgflS0+w+2Z37EJhh1qny4J24Rp1XVFvkYTcPE
         +fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=C4Lzus5Wtyy9wQfFPKmZQ8LTkfwqtT/vG63rLzLNciA=;
        b=krg0t6BQC0DXH/g9jn9Vx5c/eREPpPwI2KS2r5csBZ20DX52WMKJ4trYfksR6Hxtrz
         ZCkTYjHR68OxLQJdbaEO9+/890Y7b8WGE6bqOeTlzf6d53dCCIkhieCJ5VQsnhHjvB7P
         wx1feqCPCylUi64PXrh8sgtHI+/AGVVr4qJkVYf6y40Do95+OHBNRFtfTGQ7nJ/wvUHq
         gDyJ0tOnM7q9Y2V1rEGNrGmIj5LiUO6MshUq52A9nuBgFlRMgui+rY2O7sZX1hDwPUs9
         rNQ7BDadfqBxB87qfXHNEvYRZIGvbS0dhJama6Eat6hEwPTG3hnNMpJFxWodR9fNAyvt
         z9Sw==
X-Gm-Message-State: APjAAAUNHJNk/+VD91+SCVzNEnef7hxeXMfGUIZAPuXd5nNL0LLN34ov
        DNOg4jRMJACpwiVzKyUijJtALbr1
X-Google-Smtp-Source: APXvYqwy2Orl75GvclYmQx701xXBmUXxoOgB4Uay19rZpqKc7c7YgO3idOrDAVvv03nDP9hX+LBjvA==
X-Received: by 2002:a05:6830:14f:: with SMTP id j15mr12713435otp.278.1553391907360;
        Sat, 23 Mar 2019 18:45:07 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id n12sm4881369otl.22.2019.03.23.18.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 18:45:06 -0700 (PDT)
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     akpm@linux-foundation.org, Sultan Alsawaf <sultan@kerneltoast.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC] string: Use faster alternatives when constant arguments are used
Date:   Sat, 23 Mar 2019 18:44:45 -0700
Message-Id: <20190324014445.28688-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 include/linux/string.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b875f..65db58342 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -476,4 +476,31 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
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
+#define strcpy(dest, src)						\
+	__builtin_choose_expr(__builtin_constant_p(src),		\
+		memcpy((dest), (src), strlen(src) + 1),			\
+		(strcpy)((dest), (src)))
+
+#define strcat(dest, src)						\
+	__builtin_choose_expr(__builtin_constant_p(src),		\
+		memcpy(strchr((dest), '\0'), (src), strlen(src) + 1),	\
+		(strcat)((dest), (src)))
+
+#define strcmp(dest, src)						\
+	__builtin_choose_expr(__builtin_constant_p(dest),		\
+		__builtin_choose_expr(__builtin_constant_p(src),	\
+			(strcmp)((dest), (src)),			\
+			memcmp((dest), (src), strlen(dest) + 1)),	\
+		__builtin_choose_expr(__builtin_constant_p(src),	\
+			memcmp((dest), (src), strlen(src) + 1),		\
+			(strcmp)((dest), (src))))
+
 #endif /* _LINUX_STRING_H_ */
-- 
2.21.0

