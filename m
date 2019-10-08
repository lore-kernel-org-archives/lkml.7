Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DC3C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536BE20815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfJHM0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:26:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:30802 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730316AbfJHM0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:26:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 05:26:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="206626813"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Oct 2019 05:26:05 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 2/2] extcon: axp288: Remove the build-in connection description
Date:   Tue,  8 Oct 2019 15:26:00 +0300
Message-Id: <20191008122600.22340-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008122600.22340-1-heikki.krogerus@linux.intel.com>
References: <20191008122600.22340-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting handle to the USB role switch by first finding its
software fwnode.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/extcon/extcon-axp288.c | 38 ++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index 415afaf479e7..a7f216191493 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -322,6 +322,25 @@ static void axp288_put_role_sw(void *data)
 	usb_role_switch_put(info->role_sw);
 }
 
+static int axp288_extcon_find_role_sw(struct axp288_extcon_info *info)
+{
+	const struct software_node *swnode;
+	struct fwnode_handle *fwnode;
+
+	if (!x86_match_cpu(cherry_trail_cpu_ids))
+		return 0;
+
+	swnode = software_node_find_by_name(NULL, "intel-xhci-usb-sw");
+	if (!swnode)
+		return -EPROBE_DEFER;
+
+	fwnode = software_node_fwnode(swnode);
+	info->role_sw = usb_role_switch_find_by_fwnode(fwnode);
+	fwnode_handle_put(fwnode);
+
+	return info->role_sw ? 0 : -EPROBE_DEFER;
+}
+
 static int axp288_extcon_probe(struct platform_device *pdev)
 {
 	struct axp288_extcon_info *info;
@@ -343,9 +362,10 @@ static int axp288_extcon_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, info);
 
-	info->role_sw = usb_role_switch_get(dev);
-	if (IS_ERR(info->role_sw))
-		return PTR_ERR(info->role_sw);
+	ret = axp288_extcon_find_role_sw(info);
+	if (ret)
+		return ret;
+
 	if (info->role_sw) {
 		ret = devm_add_action_or_reset(dev, axp288_put_role_sw, info);
 		if (ret)
@@ -440,26 +460,14 @@ static struct platform_driver axp288_extcon_driver = {
 	},
 };
 
-static struct device_connection axp288_extcon_role_sw_conn = {
-	.endpoint[0] = "axp288_extcon",
-	.endpoint[1] = "intel_xhci_usb_sw-role-switch",
-	.id = "usb-role-switch",
-};
-
 static int __init axp288_extcon_init(void)
 {
-	if (x86_match_cpu(cherry_trail_cpu_ids))
-		device_connection_add(&axp288_extcon_role_sw_conn);
-
 	return platform_driver_register(&axp288_extcon_driver);
 }
 module_init(axp288_extcon_init);
 
 static void __exit axp288_extcon_exit(void)
 {
-	if (x86_match_cpu(cherry_trail_cpu_ids))
-		device_connection_remove(&axp288_extcon_role_sw_conn);
-
 	platform_driver_unregister(&axp288_extcon_driver);
 }
 module_exit(axp288_extcon_exit);
-- 
2.23.0

