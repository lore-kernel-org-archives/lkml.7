Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FABDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACC52189D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbfH0TRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:17:16 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:38909 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731072AbfH0TRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:17:13 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 Aug 2019 22:17:09 +0300
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7RJGuGv026842;
        Tue, 27 Aug 2019 22:17:08 +0300
From:   Parav Pandit <parav@mellanox.com>
To:     alex.williamson@redhat.com, jiri@mellanox.com,
        kwankhede@nvidia.com, cohuck@redhat.com, davem@davemloft.net
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Parav Pandit <parav@mellanox.com>
Subject: [PATCH v1 5/5] mtty: Optionally support mtty alias
Date:   Tue, 27 Aug 2019 14:16:54 -0500
Message-Id: <20190827191654.41161-6-parav@mellanox.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190827191654.41161-1-parav@mellanox.com>
References: <20190826204119.54386-1-parav@mellanox.com>
 <20190827191654.41161-1-parav@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a module parameter to set alias length to optionally generate
mdev alias.

Example to request mdev alias.
$ modprobe mtty alias_length=12

Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 samples/vfio-mdev/mtty.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
index 92e770a06ea2..92208245b057 100644
--- a/samples/vfio-mdev/mtty.c
+++ b/samples/vfio-mdev/mtty.c
@@ -1410,6 +1410,15 @@ static struct attribute_group *mdev_type_groups[] = {
 	NULL,
 };
 
+static unsigned int mtty_alias_length;
+module_param_named(alias_length, mtty_alias_length, uint, 0444);
+MODULE_PARM_DESC(alias_length, "mdev alias length; default=0");
+
+static unsigned int mtty_get_alias_length(void)
+{
+	return mtty_alias_length;
+}
+
 static const struct mdev_parent_ops mdev_fops = {
 	.owner                  = THIS_MODULE,
 	.dev_attr_groups        = mtty_dev_groups,
@@ -1422,6 +1431,7 @@ static const struct mdev_parent_ops mdev_fops = {
 	.read                   = mtty_read,
 	.write                  = mtty_write,
 	.ioctl		        = mtty_ioctl,
+	.get_alias_length	= mtty_get_alias_length
 };
 
 static void mtty_device_release(struct device *dev)
-- 
2.19.2

