Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0008C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B961A2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfFRMXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:23:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18637 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfFRMXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:23:11 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A76C98FF936F9BCDD3DB;
        Tue, 18 Jun 2019 20:23:08 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 18 Jun 2019 20:23:01 +0800
From:   SunKe <sunke32@huawei.com>
To:     <jlbec@evilplan.org>, <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <sunke32@huawei.com>
Subject: [PATCH 2/2] sample_configfs: soft link creat and delete
Date:   Tue, 18 Jun 2019 20:28:29 +0800
Message-ID: <1560860909-51059-3-git-send-email-sunke32@huawei.com>
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

Add soft link creation and deletion

Signed-off-by: SunKe <sunke32@huawei.com>
---
 samples/configfs/configfs_sample.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index c76b784..58915b8 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -392,6 +392,46 @@ static struct configfs_subsystem group_children_subsys = {
 /* ----------------------------------------------------------------- */
 
 /*
+ * 04-link-children
+ *
+ */
+static int link_children_allow_link(struct config_item *parent,
+		struct config_item *target)
+{
+	return 0;
+}
+
+static void link_children_drop_link(struct config_item *parent,
+		struct config_item *target)
+{
+
+}
+
+
+static struct configfs_item_operations link_children_item_ops = {
+	.allow_link		= link_children_allow_link,
+	.drop_link		= link_children_drop_link,
+};
+
+
+static const struct config_item_type link_children_type = {
+	.ct_item_ops		= &link_children_item_ops,
+	.ct_owner		= THIS_MODULE,
+
+};
+
+static struct configfs_subsystem link_children_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "04-link-children",
+			.ci_type = &link_children_type,
+		},
+	},
+};
+
+/* ----------------------------------------------------------------- */
+
+/*
  * We're now done with our subsystem definitions.
  * For convenience in this module, here's a list of them all.  It
  * allows the init function to easily register them.  Most modules
@@ -402,6 +442,7 @@ static struct configfs_subsystem *example_subsys[] = {
 	&childless_subsys.subsys,
 	&simple_children_subsys,
 	&group_children_subsys,
+	&link_children_subsys,
 	NULL,
 };
 
-- 
2.7.4

