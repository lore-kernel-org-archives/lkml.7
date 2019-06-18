Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345FEC31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091E120873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfFRMXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:23:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18639 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfFRMXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:23:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AAE13FEECF18CAF8C6D5;
        Tue, 18 Jun 2019 20:23:08 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 18 Jun 2019 20:23:01 +0800
From:   SunKe <sunke32@huawei.com>
To:     <jlbec@evilplan.org>, <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <sunke32@huawei.com>
Subject: [PATCH 1/2] sample_configfs: bin_file read and write
Date:   Tue, 18 Jun 2019 20:28:28 +0800
Message-ID: <1560860909-51059-2-git-send-email-sunke32@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560860909-51059-1-git-send-email-sunke32@huawei.com>
References: <1560860909-51059-1-git-send-email-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bin_file read and write function

Signed-off-by: SunKe <sunke32@huawei.com>
---
 samples/configfs/configfs_sample.c | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index 004a4e2..c76b784 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -146,6 +146,8 @@ static struct childless childless_subsys = {
 struct simple_child {
 	struct config_item item;
 	int storeme;
+	void *data;
+	size_t len;
 };
 
 static inline struct simple_child *to_simple_child(struct config_item *item)
@@ -153,6 +155,46 @@ static inline struct simple_child *to_simple_child(struct config_item *item)
 	return item ? container_of(item, struct simple_child, item) : NULL;
 }
 
+static ssize_t simple_child_bin_storeme_bin_write(struct config_item *item,
+				    const void *data, size_t size)
+{
+	struct simple_child *simple_child = to_simple_child(item);
+
+	kfree(simple_child->data);
+	simple_child->data = NULL;
+
+	simple_child->data = kmemdup(data, size, GFP_KERNEL);
+	if (!simple_child->data)
+		return -ENOMEM;
+	simple_child->len = size;
+
+	return 0;
+}
+
+static ssize_t simple_child_bin_storeme_bin_read(struct config_item *item,
+				   void *data, size_t size)
+{
+	struct simple_child *simple_child = to_simple_child(item);
+
+	if (!data) {
+		size = simple_child->len;
+	} else {
+		memcpy(data, simple_child->data, simple_child->len);
+		size = simple_child->len;
+	}
+
+	return size;
+}
+
+#define MAX_SIZE (128 * 1024)
+
+CONFIGFS_BIN_ATTR(simple_child_bin_, storeme_bin, NULL, MAX_SIZE);
+
+static struct configfs_bin_attribute *simple_child_bin_attrs[] = {
+	&simple_child_bin_attr_storeme_bin,
+	NULL,
+};
+
 static ssize_t simple_child_storeme_show(struct config_item *item, char *page)
 {
 	return sprintf(page, "%d\n", to_simple_child(item)->storeme);
@@ -196,6 +238,7 @@ static struct configfs_item_operations simple_child_item_ops = {
 static const struct config_item_type simple_child_type = {
 	.ct_item_ops	= &simple_child_item_ops,
 	.ct_attrs	= simple_child_attrs,
+	.ct_bin_attrs	= simple_child_bin_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 
-- 
2.7.4

