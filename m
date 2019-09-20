Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C72C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16D721A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391673AbfITOeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:34:15 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36270 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388196AbfITOZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:25:07 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iBJqK-0004xz-KO; Fri, 20 Sep 2019 15:25:04 +0100
Received: from ben by deadeye with local (Exim 4.92.1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iBJqH-0007zF-Jm; Fri, 20 Sep 2019 15:25:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
Date:   Fri, 20 Sep 2019 15:23:35 +0100
Message-ID: <lsq.1568989415.253022321@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 125/132] appletalk: Fix compile regression
In-Reply-To: <lsq.1568989414.954567518@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.74-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 27da0d2ef998e222a876c0cec72aa7829a626266 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/atalk.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/include/linux/atalk.h
+++ b/include/linux/atalk.h
@@ -153,16 +153,26 @@ extern int sysctl_aarp_resolve_time;
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

