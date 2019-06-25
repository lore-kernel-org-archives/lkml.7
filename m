Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBFDC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430C0216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbfFYJVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:21:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:19105 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731347AbfFYJVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:21:10 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2CB8F2A3234098BC61A5;
        Tue, 25 Jun 2019 17:21:05 +0800 (CST)
Received: from huawei.com (10.175.101.78) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 25 Jun 2019
 17:20:54 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <jeyu@kernel.org>,
        <peterz@infradead.org>
CC:     <yangyingliang@huawei.com>, <namit@vmware.com>,
        <cj.chengjian@huawei.com>, <sfr@canb.auug.org.au>,
        <linux-next@vger.kernel.org>
Subject: [PATCH] modules: fix compile error if don't have strict module rwx
Date:   Tue, 25 Jun 2019 17:40:28 +0800
Message-ID: <1561455628-50795-1-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.78]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_ARCH_HAS_STRICT_MODULE_RWX is not defined,
we need stub for module_enable_nx() and module_enable_x().

If CONFIG_ARCH_HAS_STRICT_MODULE_RWX is defined, but
CONFIG_STRICT_MODULE_RWX is disabled, we need stub for
module_enable_nx.

Move frob_text() outside of the CONFIG_STRICT_MODULE_RWX,
because it is needed anyway.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/module.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index c3ae34c..cfff441 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1875,7 +1875,7 @@ static void mod_sysfs_teardown(struct module *mod)
 	mod_sysfs_fini(mod);
 }
 
-#ifdef CONFIG_STRICT_MODULE_RWX
+#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
 /*
  * LKM RO/NX protection: protect module's text/ro-data
  * from modification and any data from execution.
@@ -1898,6 +1898,7 @@ static void frob_text(const struct module_layout *layout,
 		   layout->text_size >> PAGE_SHIFT);
 }
 
+#ifdef CONFIG_STRICT_MODULE_RWX
 static void frob_rodata(const struct module_layout *layout,
 			int (*set_memory)(unsigned long start, int num_pages))
 {
@@ -2010,15 +2011,19 @@ void set_all_modules_text_ro(void)
 	}
 	mutex_unlock(&module_mutex);
 }
-#else
+#else /* !CONFIG_STRICT_MODULE_RWX */
 static void module_enable_nx(const struct module *mod) { }
-#endif
-
+#endif /*  CONFIG_STRICT_MODULE_RWX */
 static void module_enable_x(const struct module *mod)
 {
 	frob_text(&mod->core_layout, set_memory_x);
 	frob_text(&mod->init_layout, set_memory_x);
 }
+#else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
+static void module_enable_nx(const struct module *mod) { }
+static void module_enable_x(const struct module *mod) { }
+#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
+
 
 #ifdef CONFIG_LIVEPATCH
 /*
-- 
1.8.3

