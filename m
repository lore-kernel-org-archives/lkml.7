Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525A1C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A9720693
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0RCS61bP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfFDRog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:44:36 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:27715 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfFDRof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:44:35 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x54HiGwD019946;
        Wed, 5 Jun 2019 02:44:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x54HiGwD019946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559670256;
        bh=hfYqstATMxMwoXJHu8Wkpjvj39D6WWogH7gu86RCn1I=;
        h=From:To:Cc:Subject:Date:From;
        b=0RCS61bPD/YYo8BxOT1uO7oS/UEQVBA6xBU23hhs7oqIerqoN5+lMvG9gS42QNDRU
         Tzr/7eej23xlc3nbmGxQpFhVlPM5vP6+Ep2KPD7Urm6SVsDC5MEAZ/gTXi17nYtXM4
         vZMSGLpKZ1GnCYvUEMB/OakehOT4dLVvb73o1OClRKu76zLPYYFJxUrgbRvAM5Sl6/
         ECinsXWTx/Sw0xdXz0Ksk+4aYyG0A7WDslL8bbozmSIovF+PkOhnlNAxhn15/BSGqv
         /pJQwzyf/ipj1B4EWvCaHuQOu5O5KhYiz1D4zws8F53epqiWmiLGYd40BAB1HiFqmI
         B82PIMDkjnWaA==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] kobject: return -ENOSPC when add_uevent_var() fails
Date:   Wed,  5 Jun 2019 02:44:12 +0900
Message-Id: <20190604174412.13324-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function never attempts to allocate memory, so returning -ENOMEM
looks weird to me. The reason of the failure is there is no more space
in the given kobj_uevent_env structure.

No caller of this function relies on this functing returning a specific
error code, so just change it to return -ENOSPC. The intended change,
if any, is the error number displayed in log messages.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

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

