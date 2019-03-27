Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A70C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46F12082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713969;
	bh=E1GN1LeJDi807T8NKXejwTTUECyuEWTycUHjLlB74v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ISrD4wmkRpDL0nt9j9/ABv8Sbn7scH3XO7JZF3oxD7F19Ue8KMxWN9ja+7tRMUQti
	 rtVkg+IvDqHiJFkrAEI0ZlDjvBWFThuOz24zVfvsqyk+d9J9kPZg+NLBt+H0W36Ejn
	 WLe+nvjBQNXf1FMGSTzON2/Hk5A7bpVIv9uDs640=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389537AbfC0TMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388093AbfC0SKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8726F2147C;
        Wed, 27 Mar 2019 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710220;
        bh=E1GN1LeJDi807T8NKXejwTTUECyuEWTycUHjLlB74v0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BSTPOeD7o0wXhKN138QYr8oSIAtZhE86WKz1DpIdU/JBbV1Zm2nq/uF4CtFVFj83X
         s9zhTu59YkXLOuwRqNH0dbzSUL5erzc7fLAUSG995HiFJQ6H6bsSVp89I9VIAIqtlH
         p5oLrmCRPtUSWgj59qYv4KyyFamovC14DDWAwdb0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 259/262] appletalk: Fix compile regression
Date:   Wed, 27 Mar 2019 14:01:54 -0400
Message-Id: <20190327180158.10245-259-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 27da0d2ef998e222a876c0cec72aa7829a626266 ]

A bugfix just broke compilation of appletalk when CONFIG_SYSCTL
is disabled:

In file included from net/appletalk/ddp.c:65:
net/appletalk/ddp.c: In function 'atalk_init':
include/linux/atalk.h:164:34: error: expected expression before 'do'
 #define atalk_register_sysctl()  do { } while(0)
                                  ^~
net/appletalk/ddp.c:1934:7: note: in expansion of macro 'atalk_register_sysctl'
  rc = atalk_register_sysctl();

This is easier to avoid by using conventional inline functions
as stubs rather than macros. The header already has inline
functions for other purposes, so I'm changing over all the
macros for consistency.

Fixes: 6377f787aeb9 ("appletalk: Fix use-after-free in atalk_proc_exit")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/atalk.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/atalk.h b/include/linux/atalk.h
index 23f805562f4e..840cf92307ba 100644
--- a/include/linux/atalk.h
+++ b/include/linux/atalk.h
@@ -161,16 +161,26 @@ extern int sysctl_aarp_resolve_time;
 extern void atalk_register_sysctl(void);
 extern void atalk_unregister_sysctl(void);
 #else
-#define atalk_register_sysctl()		do { } while(0)
-#define atalk_unregister_sysctl()	do { } while(0)
+static inline int atalk_register_sysctl(void)
+{
+	return 0;
+}
+static inline void atalk_unregister_sysctl(void)
+{
+}
 #endif
 
 #ifdef CONFIG_PROC_FS
 extern int atalk_proc_init(void);
 extern void atalk_proc_exit(void);
 #else
-#define atalk_proc_init()	({ 0; })
-#define atalk_proc_exit()	do { } while(0)
+static inline int atalk_proc_init(void)
+{
+	return 0;
+}
+static inline void atalk_proc_exit(void)
+{
+}
 #endif /* CONFIG_PROC_FS */
 
 #endif /* __LINUX_ATALK_H__ */
-- 
2.19.1

