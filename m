Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A21BC3403C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443E6246B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfLMPVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:21:42 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:54329 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727898AbfLMPVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:21:40 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from lsun@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 13 Dec 2019 17:21:35 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id xBDFLXVY023139;
        Fri, 13 Dec 2019 10:21:33 -0500
Received: (from lsun@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id xBDFLWLx027329;
        Fri, 13 Dec 2019 10:21:32 -0500
From:   Liming Sun <lsun@mellanox.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>
Cc:     Liming Sun <lsun@mellanox.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/mellanox: fix the mlx-bootctl sysfs
Date:   Fri, 13 Dec 2019 10:21:24 -0500
Message-Id: <1576250484-27291-1-git-send-email-lsun@mellanox.com>
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
itself instead of the driver. This commit adds the missing
sysfs_create_group() so the attributes can be created under the
device. The ABI document is also updated.

Fixes: 79e29cb8fbc5 ("platform/mellanox: Add bootctl driver for Mellanox BlueField Soc")
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
v1->v2: Added the Fixes tag according to Andy's comment.
v1: Initial version.
---
 Documentation/ABI/testing/sysfs-platform-mellanox-bootctl | 10 +++++-----
 drivers/platform/mellanox/mlxbf-bootctl.c                 | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

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
index 61753b6..9482eab 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -282,9 +282,16 @@ static bool mlxbf_bootctl_guid_match(const guid_t *guid,
 static int mlxbf_bootctl_probe(struct platform_device *pdev)
 {
 	struct arm_smccc_res res = { 0 };
+	struct device *dev = &pdev->dev;
 	guid_t guid;
 	int ret;
 
+	ret = sysfs_create_group(&dev->kobj, &mlxbf_bootctl_group);
+	if (ret) {
+		dev_err(dev, "failed to create attributes, err=%d\n", ret);
+		return ret;
+	}
+
 	/* Ensure we have the UUID we expect for this service. */
 	arm_smccc_smc(MLXBF_BOOTCTL_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0, &res);
 	guid_parse(mlxbf_bootctl_svc_uuid_str, &guid);
@@ -305,8 +312,16 @@ static int mlxbf_bootctl_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int mlxbf_bootctl_remove(struct platform_device *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &mlxbf_bootctl_group);
+
+	return 0;
+}
+
 static struct platform_driver mlxbf_bootctl_driver = {
 	.probe = mlxbf_bootctl_probe,
+	.remove = mlxbf_bootctl_remove,
 	.driver = {
 		.name = "mlxbf-bootctl",
 		.groups = mlxbf_bootctl_groups,
-- 
1.8.3.1

