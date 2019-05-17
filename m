Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A71C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8082168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfEQRuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:50:06 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46095 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725932AbfEQRuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:50:05 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from lsun@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 17 May 2019 20:49:30 +0300
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x4HHnTeK007503;
        Fri, 17 May 2019 13:49:29 -0400
Received: (from lsun@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x4HHnR1D032577;
        Fri, 17 May 2019 13:49:27 -0400
From:   Liming Sun <lsun@mellanox.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>
Cc:     Liming Sun <lsun@mellanox.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH v5 2/2] platform/mellanox/mlxbf-bootctl: Add the ABI definitions
Date:   Fri, 17 May 2019 13:49:05 -0400
Message-Id: <1558115345-32476-2-git-send-email-lsun@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558115345-32476-1-git-send-email-lsun@mellanox.com>
References: <1558115345-32476-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the ABI definitions exposed to userspace for
the platform/mellanox/mlxbf-bootctl driver.

Reviewed-by: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 .../ABI/testing/sysfs-platform-mellanox-bootctl    | 58 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-mellanox-bootctl

diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
new file mode 100644
index 0000000..19a14db
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
@@ -0,0 +1,58 @@
+What:		/sys/bus/platform/drivers/mlxbf-bootctl/lifecycle_state
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	"Liming Sun <lsun@mellanox.com>"
+Description:
+		The Life-cycle state of the SoC, which could be one of the
+		following values.
+		  Production - Production state and can be updated to secure
+		  GA Secured - Secure chip and not able to change state
+		  GA Non-Secured - Non-Secure chip and not able to change state
+		  RMA - Return Merchandise Authorization
+
+What:		/sys/bus/platform/drivers/mlxbf-bootctl/post_reset_wdog
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	"Liming Sun <lsun@mellanox.com>"
+Description:
+		The watchdog setting in seconds for the next booting. It's used
+		to reboot the chip and recover it to the old state if the new
+		boot partition fails.
+
+What:		/sys/bus/platform/drivers/mlxbf-bootctl/reset_action
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	"Liming Sun <lsun@mellanox.com>"
+Description:
+		The source of the boot stream for the next reset. It could be
+		one of the following values.
+		  external - boot from external source (USB or PCIe)
+		  emmc - boot from the onchip eMMC
+		  emmc_legacy - boot from the onchip eMMC in legacy (slow) mode
+
+What:		/sys/bus/platform/drivers/mlxbf-bootctl/second_reset_action
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	"Liming Sun <lsun@mellanox.com>"
+Description:
+		Update the source of the boot stream after next reset. It could
+		be one of the following values and will be applied after next
+		reset.
+		  external - boot from external source (USB or PCIe)
+		  emmc - boot from the onchip eMMC
+		  emmc_legacy - boot from the onchip eMMC in legacy (slow) mode
+		  swap_emmc - swap the primary / secondary boot partition
+		  none - cancel the action
+
+What:		/sys/bus/platform/drivers/mlxbf-bootctl/secure_boot_fuse_state
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	"Liming Sun <lsun@mellanox.com>"
+Description:
+		The state of eFuse versions with the following values.
+		  InUse - burnt, valid and currently in use
+		  Used - burnt and valid
+		  Free - not burnt and free to use
+		  Skipped - not burnt but not free (skipped)
+		  Wasted - burnt and invalid
+		  Invalid - not burnt but marked as valid (error state).
diff --git a/MAINTAINERS b/MAINTAINERS
index fb9f9d7..8a9d9ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10018,6 +10018,7 @@ M:	Darren Hart <dvhart@infradead.org>
 M:	Vadim Pasternak <vadimp@mellanox.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Supported
+F:	Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
 F:	drivers/platform/mellanox/
 F:	include/linux/platform_data/mlxreg.h
 
-- 
1.8.3.1

