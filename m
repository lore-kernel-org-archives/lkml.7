Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0378C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1ABB20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406807AbfFLB1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:27:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406215AbfFLB1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:27:40 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7885718CA3B9CC4C27AE;
        Wed, 12 Jun 2019 09:27:38 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 12 Jun 2019
 09:27:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jeyu@kernel.org>, <gregkh@linuxfoundation.org>, <mbenes@suse.cz>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v4] kernel/module: Fix mem leak in module_add_modinfo_attrs
Date:   Tue, 11 Jun 2019 23:00:07 +0800
Message-ID: <20190611150007.21064-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190603144554.18168-1-yuehaibing@huawei.com>
References: <20190603144554.18168-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In module_add_modinfo_attrs if sysfs_create_file
fails, we forget to free allocated modinfo_attrs
and roll back the sysfs files.

Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v4: call module_remove_modinfo_attrs only while i > 0
v3: reuse module_remove_modinfo_attrs
v2: free from '--i' instead of 'i--'
---
 kernel/module.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index f954d72..3310a39 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1696,6 +1696,8 @@ static int add_usage_links(struct module *mod)
 	return ret;
 }
 
+static void module_remove_modinfo_attrs(struct module *mod, int end);
+
 static int module_add_modinfo_attrs(struct module *mod)
 {
 	struct module_attribute *attr;
@@ -1710,24 +1712,34 @@ static int module_add_modinfo_attrs(struct module *mod)
 		return -ENOMEM;
 
 	temp_attr = mod->modinfo_attrs;
-	for (i = 0; (attr = modinfo_attrs[i]) && !error; i++) {
+	for (i = 0; (attr = modinfo_attrs[i]); i++) {
 		if (!attr->test || attr->test(mod)) {
 			memcpy(temp_attr, attr, sizeof(*temp_attr));
 			sysfs_attr_init(&temp_attr->attr);
 			error = sysfs_create_file(&mod->mkobj.kobj,
 					&temp_attr->attr);
+			if (error)
+				goto error_out;
 			++temp_attr;
 		}
 	}
+
+	return 0;
+
+error_out:
+	if (i > 0)
+		module_remove_modinfo_attrs(mod, --i);
 	return error;
 }
 
-static void module_remove_modinfo_attrs(struct module *mod)
+static void module_remove_modinfo_attrs(struct module *mod, int end)
 {
 	struct module_attribute *attr;
 	int i;
 
 	for (i = 0; (attr = &mod->modinfo_attrs[i]); i++) {
+		if (end >= 0 && i > end)
+			break;
 		/* pick a field to test for end of list */
 		if (!attr->attr.name)
 			break;
@@ -1815,7 +1827,7 @@ static int mod_sysfs_setup(struct module *mod,
 	return 0;
 
 out_unreg_modinfo_attrs:
-	module_remove_modinfo_attrs(mod);
+	module_remove_modinfo_attrs(mod, -1);
 out_unreg_param:
 	module_param_sysfs_remove(mod);
 out_unreg_holders:
@@ -1851,7 +1863,7 @@ static void mod_sysfs_fini(struct module *mod)
 {
 }
 
-static void module_remove_modinfo_attrs(struct module *mod)
+static void module_remove_modinfo_attrs(struct module *mod, int end)
 {
 }
 
@@ -1867,7 +1879,7 @@ static void init_param_lock(struct module *mod)
 static void mod_sysfs_teardown(struct module *mod)
 {
 	del_usage_links(mod);
-	module_remove_modinfo_attrs(mod);
+	module_remove_modinfo_attrs(mod, -1);
 	module_param_sysfs_remove(mod);
 	kobject_put(mod->mkobj.drivers_dir);
 	kobject_put(mod->holders_dir);
-- 
2.7.4


