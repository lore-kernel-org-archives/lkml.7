Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7821C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3212341C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567075861;
	bh=f83q1siPucHmVnrzP6Y+fGhWbXT3hG3C/OSD9JDoQlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XmWIKYiq0UnatseiZ1r45pWDDlMmHTpB+/Nknx5I1bjWZKoz59Swn1BszjPuxHRTv
	 ZF3UfX4GTdFlg/ckxAHYA3obM/DIuNS+Zdavb3Kcub0IY97Pa/COH1SEjOaEO1GjJ+
	 OJEq5JUil8mbhA6OUpByVubXAZqhvWijUjvt37Ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfH2KvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbfH2Kuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:50:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BF9623426;
        Thu, 29 Aug 2019 10:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567075843;
        bh=f83q1siPucHmVnrzP6Y+fGhWbXT3hG3C/OSD9JDoQlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHpX/xJ34VbN926OhQx0LmaDDlnGUW6kCkkto1Yl2shuRCOb74YPlTGK9veHZOMtY
         CZFUQ5m0x97aXfquVxTY6R9t+3w4z0qbJOqyrGWf+aLCl0ZkBY3a07ElyGt9Jzqnag
         v0ul4vipLSW5tWwJksRL73d2ICEf06pHfzWoItKI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 29/29] kernel/module: Fix mem leak in module_add_modinfo_attrs
Date:   Thu, 29 Aug 2019 06:50:09 -0400
Message-Id: <20190829105009.2265-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829105009.2265-1-sashal@kernel.org>
References: <20190829105009.2265-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit bc6f2a757d525e001268c3658bd88822e768f8db ]

In module_add_modinfo_attrs if sysfs_create_file
fails, we forget to free allocated modinfo_attrs
and roll back the sysfs files.

Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/module.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 2dec3d4a9b627..0d86fc73d63d1 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1694,6 +1694,8 @@ static int add_usage_links(struct module *mod)
 	return ret;
 }
 
+static void module_remove_modinfo_attrs(struct module *mod, int end);
+
 static int module_add_modinfo_attrs(struct module *mod)
 {
 	struct module_attribute *attr;
@@ -1708,24 +1710,34 @@ static int module_add_modinfo_attrs(struct module *mod)
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
@@ -1813,7 +1825,7 @@ static int mod_sysfs_setup(struct module *mod,
 	return 0;
 
 out_unreg_modinfo_attrs:
-	module_remove_modinfo_attrs(mod);
+	module_remove_modinfo_attrs(mod, -1);
 out_unreg_param:
 	module_param_sysfs_remove(mod);
 out_unreg_holders:
@@ -1849,7 +1861,7 @@ static void mod_sysfs_fini(struct module *mod)
 {
 }
 
-static void module_remove_modinfo_attrs(struct module *mod)
+static void module_remove_modinfo_attrs(struct module *mod, int end)
 {
 }
 
@@ -1865,7 +1877,7 @@ static void init_param_lock(struct module *mod)
 static void mod_sysfs_teardown(struct module *mod)
 {
 	del_usage_links(mod);
-	module_remove_modinfo_attrs(mod);
+	module_remove_modinfo_attrs(mod, -1);
 	module_param_sysfs_remove(mod);
 	kobject_put(mod->mkobj.drivers_dir);
 	kobject_put(mod->holders_dir);
-- 
2.20.1

