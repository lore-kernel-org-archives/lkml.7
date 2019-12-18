Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56346C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3219E206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLRPZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:25:30 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41911 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727001AbfLRPZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:25:29 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from lsun@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 18 Dec 2019 17:25:23 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id xBIFPLBc025573;
        Wed, 18 Dec 2019 10:25:21 -0500
Received: (from lsun@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id xBIFPJx6032084;
        Wed, 18 Dec 2019 10:25:19 -0500
From:   Liming Sun <lsun@mellanox.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>
Cc:     Liming Sun <lsun@mellanox.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] platform/mellanox: fix the mlx-bootctl sysfs
Date:   Wed, 18 Dec 2019 10:24:36 -0500
Message-Id: <1576682676-31957-1-git-send-email-lsun@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <94727fab054309cd98c876748fd27b130ce5031f.1575918870.git.lsun@mellanox.com>
References: <94727fab054309cd98c876748fd27b130ce5031f.1575918870.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up commit for the sysfs attributes to change
from DRIVER_ATTR to DEVICE_ATTR according to some initial comments.
In such case, it's better to point the sysfs path to the device
itself instead of the driver. The ABI document is also updated.

Fixes: 79e29cb8fbc5 ("platform/mellanox: Add bootctl driver for Mellanox BlueField Soc")
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
v2->v3:
    Fixes for comments from Andy
    - Convert to use dev_groups;
v1->v2:
    Fixes for comments from Andy
    - Added the Fixes tag;
v1: Initial version.
---
 Documentation/ABI/testing/sysfs-platform-mellanox-bootctl | 10 +++++-----
 drivers/platform/mellanox/mlxbf-bootctl.c                 | 11 +++++++++--
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
index c65a805..401d202 100644
--- a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
+++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
@@ -1,4 +1,4 @@
-What:		/sys/bus/platform/devices/MLNXBF04:00/driver/lifecycle_state
+What:		/sys/bus/platform/devices/MLNXBF04:00/lifecycle_state
 Date:		Oct 2019
 KernelVersion:	5.5
 Contact:	"Liming Sun <lsun@mellanox.com>"
@@ -10,7 +10,7 @@ Description:
 		  GA Non-Secured - Non-Secure chip and not able to change state
 		  RMA - Return Merchandise Authorization
 
-What:		/sys/bus/platform/devices/MLNXBF04:00/driver/post_reset_wdog
+What:		/sys/bus/platform/devices/MLNXBF04:00/post_reset_wdog
 Date:		Oct 2019
 KernelVersion:	5.5
 Contact:	"Liming Sun <lsun@mellanox.com>"
@@ -19,7 +19,7 @@ Description:
 		to reboot the chip and recover it to the old state if the new
 		boot partition fails.
 
-What:		/sys/bus/platform/devices/MLNXBF04:00/driver/reset_action
+What:		/sys/bus/platform/devices/MLNXBF04:00/reset_action
 Date:		Oct 2019
 KernelVersion:	5.5
 Contact:	"Liming Sun <lsun@mellanox.com>"
@@ -30,7 +30,7 @@ Description:
 		  emmc - boot from the onchip eMMC
 		  emmc_legacy - boot from the onchip eMMC in legacy (slow) mode
 
-What:		/sys/bus/platform/devices/MLNXBF04:00/driver/second_reset_action
+What:		/sys/bus/platform/devices/MLNXBF04:00/second_reset_action
 Date:		Oct 2019
 KernelVersion:	5.5
 Contact:	"Liming Sun <lsun@mellanox.com>"
@@ -44,7 +44,7 @@ Description:
 		  swap_emmc - swap the primary / secondary boot partition
 		  none - cancel the action
 
-What:		/sys/bus/platform/devices/MLNXBF04:00/driver/secure_boot_fuse_state
+What:		/sys/bus/platform/devices/MLNXBF04:00/secure_boot_fuse_state
 Date:		Oct 2019
 KernelVersion:	5.5
 Contact:	"Liming Sun <lsun@mellanox.com>"
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 61753b6..472dc74 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -259,7 +259,9 @@ static ssize_t secure_boot_fuse_state_show(struct device *dev,
 	NULL
 };
 
-ATTRIBUTE_GROUPS(mlxbf_bootctl);
+static const struct attribute_group mlxbf_bootctl_group = {
+	.attrs	= mlxbf_bootctl_attrs,
+};
 
 static const struct acpi_device_id mlxbf_bootctl_acpi_ids[] = {
 	{"MLNXBF04", 0},
@@ -305,11 +307,16 @@ static int mlxbf_bootctl_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct attribute_group *mlxbf_bootctl_dev_groups[] = {
+	&mlxbf_bootctl_group,
+	NULL
+};
+
 static struct platform_driver mlxbf_bootctl_driver = {
 	.probe = mlxbf_bootctl_probe,
 	.driver = {
 		.name = "mlxbf-bootctl",
-		.groups = mlxbf_bootctl_groups,
+		.dev_groups = mlxbf_bootctl_dev_groups,
 		.acpi_match_table = mlxbf_bootctl_acpi_ids,
 	}
 };
-- 
1.8.3.1

