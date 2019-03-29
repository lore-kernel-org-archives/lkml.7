Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E13C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5C321773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TljUoFUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfC2VrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:47:07 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:36022 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbfC2VrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:47:07 -0400
Received: by mail-it1-f202.google.com with SMTP id l202so3499936ita.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Lju3Sh2kmpmmLQeEIQ2kymRMSnNvrQCfL6/ZPFgSoEI=;
        b=TljUoFUDkPFUmXkzJOJw61Own5HUus9rZgycUxURNEbrdYp95r8+f9pkGC/lLC9ZPs
         jEloLEiAocsNFr0DXxqX80YLzav3gWJsNUw5Kgz6dgb2mvV7qxZm64MWRMjvwLQ7Ry7W
         ycmjbmrNlAnL9pD26Zw9wx1/yZxvvZgnEn9Tz3AuF7dV/jOUtV1cSBSDIoRTr7PTz1ox
         dSaNT5E1o87aRWojcr9J5kDLZ+ONbjqmDWxKmOf4MGPEiAM6+VWPouh85bWd1nOl1+Xu
         MYEKFY1khKQOFftF2ZlsKiawCLB/jpYNXcvWaZ9PI1vG7xpXKlCsqy83ssMsWOBY94cH
         /T6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Lju3Sh2kmpmmLQeEIQ2kymRMSnNvrQCfL6/ZPFgSoEI=;
        b=J7lJ+jhK7sqNdTo1dbDhDhRAM9d1MBLkfofp2+S38kGKU79KiiW6R0wkJINHhJ1UwO
         HQPJZrhIM9MshxCjl3EoP/7lr5I40gGhBOp4qMmMoK1xL4lcZKMkdwl0fajGB2BKykGc
         ti7gDWjm/3X93M2cwQT7BkSMsG7II9RKhwO20ApyP9XsnzMvOM0taO/yH0DSFsjMsdru
         +plrU9D3nA1T6JNbWjRSfO+hnFrNoGiAQY8P5stB8pVN+9FSAQ0n0574SlK2EzOOSeoF
         uRvCBJFEZmAVWKIfwW4yV9VXp9O+MQ2vH5maeu1p4JYxNw3dJ3O1Vc7EulHm8zsvgu03
         FJ8w==
X-Gm-Message-State: APjAAAW9JXjkLedj1FVaR+hTKTZUIhik0thQyl7Q5wdLPQeifZ3QgraO
        i9/9nPmqYqj+H0V8Ivogmd1PoGOprA==
X-Google-Smtp-Source: APXvYqxkwuw2CQt0Z9Y7/gxlyvhqE8zePmv+jFBrwT9zhInUGeltF4rgFXn71lIir7ufXlWDbjY+81W5bQ==
X-Received: by 2002:a24:3608:: with SMTP id l8mr2148429itl.35.1553896026529;
 Fri, 29 Mar 2019 14:47:06 -0700 (PDT)
Date:   Fri, 29 Mar 2019 22:46:49 +0100
Message-Id: <20190329214652.258477-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 1/4] kernel.h: use parentheses around argument in u64_to_user_ptr()
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Mukesh Ojha <mojha@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use parentheses around uses of the argument in u64_to_user_ptr() to ensure
that the cast doesn't apply to part of the argument.

There are existing uses of the macro of the form `u64_to_user_ptr(A + B)`,
which expands to `(void __user *)(uintptr_t)A + B` (the cast applies to the
first operand of the addition, the addition is a pointer addition). This
happens to still work as intended, the semantic difference doesn't cause a
difference in behavior.
But I want to use u64_to_user_ptr() with a ternary operator in the
argument, like so: `u64_to_user_ptr(A ? B : C)`. This currently doesn't
work as intended.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/kernel.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 34a5036debd3..2d14e21c16c0 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -47,8 +47,8 @@
 
 #define u64_to_user_ptr(x) (		\
 {					\
-	typecheck(u64, x);		\
-	(void __user *)(uintptr_t)x;	\
+	typecheck(u64, (x));		\
+	(void __user *)(uintptr_t)(x);	\
 }					\
 )
 
-- 
2.21.0.392.gf8f6787159e-goog

