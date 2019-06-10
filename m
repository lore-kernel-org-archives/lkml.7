Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C1AC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8312C20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QxjEJROh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389986AbfFJVJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:09:52 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:33663 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfFJVJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:09:52 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x5AL9Tug023067;
        Tue, 11 Jun 2019 06:09:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x5AL9Tug023067
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560200970;
        bh=gBHuB2VNJ5k6YmFjVqedIpm8iZuBjeT1LQUHDwfjGnA=;
        h=From:To:Cc:Subject:Date:From;
        b=QxjEJROhZTUj4Ngn88siuPtMJPW5B+uaonsOC3pKbYu1DQgOy8kC/YmI1fQBpbrBF
         S2x3ROIR4K6XnyRKjAnY2wOK3B2WhFZ+bikXYoMVdhBL4XMn65NSffWqxWijegpvw2
         mdCVcupWQWMhvfIOPr2AofH4L5kPPUnKkg6j5vMtGG11eFDL+8ecPQEgC4Pkk0JjBo
         oDZgcoqtxaprFNkatHWXfh2Lnn7sjXj/uU/cEFDXpd8z8fpAvKh6+MDbHjFtMRVxcB
         VDgaUa0V03VEUy3xx99FzDd1FqJf5rKqBLvKzESlZhf4NhIVA1AK3fs4J7rw/JOadr
         lXMcApWEqtS0Q==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2] kobject: return -ENOSPC when add_uevent_var() fails
Date:   Tue, 11 Jun 2019 06:09:24 +0900
Message-Id: <20190610210924.9514-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function never attempts to allocate memory, so returning -ENOMEM
looks weird to me. The reason of the failure is there is no more space
in the given kobj_uevent_env structure.

Let's change the error code to -ENOSPC.

This patch is safe since this function had never failed in reality.

The callers of this function put a fixed number of small strings into
the buffer.

The buffer is defined to be large enough:

  #define UEVENT_NUM_ENVP                 32      /* number of env pointers */
  #define UEVENT_BUFFER_SIZE              2048    /* buffer for the variables */

As you see WARN() in the error paths, any failure of this function is
a software bug.

If such a case had ever happened before, you would have already seen
a noisy back-trace, then you would have increased UEVENT_NUM_ENVP or
UEVENT_BUFFER_SIZE.

Nobody has ever increased UEVENT_NUM_ENVP or UEVENT_BUFFER_SIZE since
their addition, that is, this structure is always large enough.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Rephrase the commit log. No code change.

 lib/kobject_uevent.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 7998affa45d4..5ffd44bf4aad 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -647,7 +647,7 @@ EXPORT_SYMBOL_GPL(kobject_uevent);
  * @env: environment buffer structure
  * @format: printf format for the key=value pair
  *
- * Returns 0 if environment variable was added successfully or -ENOMEM
+ * Returns 0 if environment variable was added successfully or -ENOSPC
  * if no space was available.
  */
 int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
@@ -657,7 +657,7 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
 
 	if (env->envp_idx >= ARRAY_SIZE(env->envp)) {
 		WARN(1, KERN_ERR "add_uevent_var: too many keys\n");
-		return -ENOMEM;
+		return -ENOSPC;
 	}
 
 	va_start(args, format);
@@ -668,7 +668,7 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
 
 	if (len >= (sizeof(env->buf) - env->buflen)) {
 		WARN(1, KERN_ERR "add_uevent_var: buffer size too small\n");
-		return -ENOMEM;
+		return -ENOSPC;
 	}
 
 	env->envp[env->envp_idx++] = &env->buf[env->buflen];
-- 
2.17.1

