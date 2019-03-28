Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B2BC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0C121850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fa9c+8vG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfC1VX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 17:23:28 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48665 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfC1VX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 17:23:26 -0400
Received: by mail-pf1-f201.google.com with SMTP id b11so17274702pfo.15
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FTQNddlHZsmLTvmgUqkS3owI3qJO1ApHDbsDyvuVOwE=;
        b=Fa9c+8vGa1Oh7baZAD1kg9Z22RmkQpiwX9z+ROJPUB4Zl3RiQlmZtIvoseGtxAoQ3/
         EcflQUhg8K4eD84FThc1/ziLAIIv4P+RjRoMw4HpBN68sDU2jHUvnFYAzHI6EgzBc/fS
         GzDa6T4ZfW8Cly9diEjmGWjMvNC1UaUEZpbAumuhI11sKiYDTMYkFUQ6veIc12/dMOiN
         thUjyo7aihrNdtKihXhI8RQwR5Pl6mh3JnTPmkmHo+xtFvH7uC4zsYNhCWHKSSIdYV75
         XuQGzDpP4jdm7ARenURxSFm59KmOXszck7XyyWgg6S3p/vnOZjb/uxf9YnozyQvcDxI0
         NXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FTQNddlHZsmLTvmgUqkS3owI3qJO1ApHDbsDyvuVOwE=;
        b=gx8tKShkinB3hyHjyGJXUkVAdA+RTLWF69HwMHKlf72QUZcyryTiJVsfs4x5aQlZFk
         7XsD6I+SK03VzVKsgVo6nq1VLo8QyG1PNBEG2JaEu2uEahywYvnRDn9vYyRwdZKm5903
         heRdzSloY15CyXo6XhJb20sdPVRInv1HPQt7nJxRi5OyL3Kf0i0Esruljhzn2dwaQ9tn
         qE5Q/rs4XU99Q9E0qibWn3jBBDIJWO2Jxtsx0BZxVdB3m+xD/DwKU/eppSrdeeqdzCsK
         KWEaLxdMnA1nc8ANnlD4LoCT3Hc5gpFq9YymaY79XWpsu9UvEv4z1u2vR49cyaJwG8Rm
         Hk/g==
X-Gm-Message-State: APjAAAWfSlHNKQAZLlLkVUkvITugsaZ7X8lw0ATTSAS9ofN0a34+ZzE9
        JP0urJVvQyR+xY/uGzWkavwIjTWWCw==
X-Google-Smtp-Source: APXvYqz84M8G3bhZrO+qj8a30VgXzpgJbjxCKVJ2aZUWP1Aiv3GGnnT97213yULO5DcrZNPIquoF+yUrJw==
X-Received: by 2002:a62:5e43:: with SMTP id s64mr383531pfb.71.1553808205861;
 Thu, 28 Mar 2019 14:23:25 -0700 (PDT)
Date:   Thu, 28 Mar 2019 22:23:20 +0100
Message-Id: <20190328212321.92463-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 1/2] kernel.h: use parentheses around argument in u64_to_user_ptr()
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Signed-off-by : Qiaowei Ren" <qiaowei.ren@intel.com>
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

Fixes: f09174c501f8 ("x86: add user_atomic_cmpxchg_inatomic at uaccess.h")
Signed-off-by: Jann Horn <jannh@google.com>
---
Can we take this patch through the x86 tree with the following one, or
do we need to get this one through akpm's tree first?

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

