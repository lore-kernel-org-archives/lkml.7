Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6953AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EEB20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfCFKxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:53:11 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:35909 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfCFKxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:53:11 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MZkxj-1gUoEv4BE7-00Wr18; Wed, 06 Mar 2019 11:52:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     netdev@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] appletalk: Fix compile regression
Date:   Wed,  6 Mar 2019 11:52:36 +0100
Message-Id: <20190306105249.2165038-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/jRd9q1XZJAFsz3r5gJJf4LaKq31rWb+CKKYKuPWmai36hTMVOl
 yDKw3+8qmqmyABGtbcDBmGEIdfg+WdkNRJ0jz18sOSBnsB2/R4SOrpbCESSfSZYzhY/h48D
 uDxEnAJE0XYxKHq1zx/0iiJ97gTKbkG81iEts6VZjMbYbENAb5uX6kggBnqjX5BM2Cr4fhM
 SkmbwV+nFOUOFNPM0VOfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zo5N12rnU68=:wi1oYA8ybpBHfDDE6wGLJx
 l+NATxFimdrWdwUUF/ltvg/cidhkREWJ/h657pVzBwgFjRgrvd6hw9+pwpbqjPjpEquckBlzI
 BHWcHyTLJKE/UKw/xWPaMfw/Vn0yCHCTDNGzj/XWEQuKci6oPCCD6GQADvwimbsDtM7ENXdPH
 DTjoNEt/4iFT7GFiVHULn5hFF9opeZNaE8lT0eZC6lpvQPUNTgzNdJEvqXlNl9KqjliM9Yc83
 QI1hJmJbzYq2s9a2LiX+7xPZfobtMeynLKPb8aB4EEOM77hWEocvdw27dvIVs+2DqKKCUD9d3
 6qW5MsBIJvc7rzIZzCdpeOFqgxBw1L/ST90UEKtfQZe607BeTllCXh1wFVtk6w1u85nS5tKMs
 oofLhaxbK0kG0oZeGtuZAY/1O02qyTvumcw/vqsIHCNiRmze9b0ogf41ai+ZTC1LTJyOOIqsb
 OtgP4Y5fEDZ0uJmtEJkcYIAAl7guCCU1oz8QG1lyAaoC/nwvuMQfMifDtsTE+PgqJlSy/57fU
 XzOH6US9JKNvtzosHdtf8LlH6x2psRjS7wgkpaWbTJ8U48tYiQC4VQqOYloSajJrx7ehohVZ7
 71mxKxr8X3CF8pR4MPWrlxS4xiQuL26Nw/y3W25q5pvR3SBETwey+Pi19cK5L19/ye9EVBLg2
 BJfKfV2TvlgSLgCQb/YTpFQpAod59cxpHN//FhwJQ1lqeTpkS1O7943KUvIzt+fWXB0oz4+Wx
 R9zntaUkH0trrwQTwk08VshocMBCrNp0+HmMpw==
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
resent with mailing list on Cc
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

