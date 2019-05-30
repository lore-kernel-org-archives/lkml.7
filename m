Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B06C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75C225421
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfE3IuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:50:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18052 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbfE3IuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:50:06 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 19FCA99016C98BE4DA14;
        Thu, 30 May 2019 16:50:04 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 30 May 2019
 16:49:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bleung@chromium.org>, <enric.balletbo@collabora.com>,
        <groeck@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] platform/chrome: cros_ec: Make some symbols static
Date:   Thu, 30 May 2019 16:49:32 +0800
Message-ID: <20190530084932.2576-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190529150749.8032-1-yuehaibing@huawei.com>
References: <20190529150749.8032-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/platform/chrome/cros_ec_debugfs.c:256:30: warning: symbol 'cros_ec_console_log_fops' was not declared. Should it be static?
drivers/platform/chrome/cros_ec_debugfs.c:265:30: warning: symbol 'cros_ec_pdinfo_fops' was not declared. Should it be static?
drivers/platform/chrome/cros_ec_lightbar.c:550:24: warning: symbol 'cros_ec_lightbar_attr_group' was not declared. Should it be static?
drivers/platform/chrome/cros_ec_sysfs.c:338:24: warning: symbol 'cros_ec_attr_group' was not declared. Should it be static?
drivers/platform/chrome/cros_ec_vbc.c:104:24: warning: symbol 'cros_ec_vbc_attr_group' was not declared. Should it be static?
drivers/platform/chrome/cros_ec_lpc.c:408:25: warning: symbol 'cros_ec_lpc_pm_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: fix patch title
---
 drivers/platform/chrome/cros_ec_debugfs.c  | 4 ++--
 drivers/platform/chrome/cros_ec_lightbar.c | 2 +-
 drivers/platform/chrome/cros_ec_lpc.c      | 2 +-
 drivers/platform/chrome/cros_ec_sysfs.c    | 2 +-
 drivers/platform/chrome/cros_ec_vbc.c      | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 4c2a27f6a6d0..4578eb3e0731 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -241,7 +241,7 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
 				       read_buf, p - read_buf);
 }
 
-const struct file_operations cros_ec_console_log_fops = {
+static const struct file_operations cros_ec_console_log_fops = {
 	.owner = THIS_MODULE,
 	.open = cros_ec_console_log_open,
 	.read = cros_ec_console_log_read,
@@ -250,7 +250,7 @@ const struct file_operations cros_ec_console_log_fops = {
 	.release = cros_ec_console_log_release,
 };
 
-const struct file_operations cros_ec_pdinfo_fops = {
+static const struct file_operations cros_ec_pdinfo_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
 	.read = cros_ec_pdinfo_read,
diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index d30a6650b0b5..23a82ee4c785 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -547,7 +547,7 @@ static struct attribute *__lb_cmds_attrs[] = {
 	NULL,
 };
 
-struct attribute_group cros_ec_lightbar_attr_group = {
+static struct attribute_group cros_ec_lightbar_attr_group = {
 	.name = "lightbar",
 	.attrs = __lb_cmds_attrs,
 };
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index c9c240fbe7c6..aaa21803633a 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -405,7 +405,7 @@ static int cros_ec_lpc_resume(struct device *dev)
 }
 #endif
 
-const struct dev_pm_ops cros_ec_lpc_pm_ops = {
+static const struct dev_pm_ops cros_ec_lpc_pm_ops = {
 	SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend, cros_ec_lpc_resume)
 };
 
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index fe0b7614ae1b..3edb237bf8ed 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -335,7 +335,7 @@ static umode_t cros_ec_ctrl_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-struct attribute_group cros_ec_attr_group = {
+static struct attribute_group cros_ec_attr_group = {
 	.attrs = __ec_attrs,
 	.is_visible = cros_ec_ctrl_visible,
 };
diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index 8392a1ec33a7..2aaefed87eb4 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -101,7 +101,7 @@ static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
 	NULL
 };
 
-struct attribute_group cros_ec_vbc_attr_group = {
+static struct attribute_group cros_ec_vbc_attr_group = {
 	.name = "vbc",
 	.bin_attrs = cros_ec_vbc_bin_attrs,
 };
-- 
2.17.1


