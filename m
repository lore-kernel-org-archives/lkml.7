Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B1DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE4620842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfCENYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:24:50 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:47469 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfCENYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:24:49 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MmU1H-1hRwEj2jjN-00iWp7; Tue, 05 Mar 2019 14:24:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] appletalk: Fix compile regression
Date:   Tue,  5 Mar 2019 14:24:21 +0100
Message-Id: <20190305132430.3821758-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CMlmt/4ZshxSNOPfjEiGE+sHg9rAnLQwkNc0Cz8uZW9mG36IiTq
 uRVt1kh8YxIX4B+w5lFW/rLduqQYN4vShZjJ9CxrlRs41pzvf35L46u0bblGctmX1EeFoOt
 TrKOgtKhNAK1yw6mtE7mohyT0XQS+LX/vq7rzGIqs83cZcHDR/p09E9bKh4XWROWt1ftPMn
 TFDAkLmIpypMH/Y2kU1Yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xtERsaA6P3U=:wlVRPpVi0tpvynO5nhJGyo
 zGp0MpY5So0bW35q3paDY+Xr9L7M/EeFjLV1r862CIlaFB2DZcW8yrU9pBlsZeMT2keYxqVJv
 1ZaLRMfPFRiAF4GshZDZ3bnfSUGAa63/u/At5TrjkDRMlxbk4czyuRtu+XQX0e83gUGJ1d0qE
 r9AsApNi0NQUWo+XCHNgAIliXiZFa5J+JnR2Sa+GxNLZXWBrzbtSy3V5pW/Dm4xr8Y3lCVQpl
 QrEOQ+mNtOZevyqmmH+flDGvbiEqOr0wSOjlb1tzVbS10AoBbsc1klPWouOUzSUSozQJ9VTfq
 12bs5O6uXsbZwSR1N4Yo05K31RizSCACfRC4tMlC3+lnFo/NQlWNlSlwaicG44lJsAUzFw9O/
 kTYw3g+SI52tAg50vyji7Rrop71XoiBYXH0FwcY2a5mpEEn2u2wIwEcAbPDHh22wV1KWGe7jS
 NDqIRN5zcwILEuN/uT+D58BaLe1zD1V4VXMRbxgRUsdY6kmno77Z2ZCBZz0FcryUHDWKIv8eM
 6ZUif+/aKzCY8VpUfO6Az0/qlE+vrfbf0DFzVOsFA1LoqwONUnWmVvzMpH4+N6Kv3MRu+ZiYy
 IV2SwJEwQn7zELFhMHv4HCS62dDFvabu1pMQsHJNVqZrKnxFEz91SMI5rK0+DAW+n0mzyLhUX
 2r54/9CnKvV5IiCF2XqbG/G6uXenPjObdyFU3s0cb6UaTuOXXYnjJyocAsa7Ozee1XQlKMTpT
 nv64J3ZNNpNbJLbNaUNYfENg7TW6Kvfr4E0IDQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 include/linux/atalk.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/atalk.h b/include/linux/atalk.h
index 5a90f28d5ff2..d5cfc0b15b76 100644
--- a/include/linux/atalk.h
+++ b/include/linux/atalk.h
@@ -161,16 +161,26 @@ extern int sysctl_aarp_resolve_time;
 extern int atalk_register_sysctl(void);
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
2.20.0

