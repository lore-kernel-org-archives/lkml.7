Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0904C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA4F20726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575920002;
	bh=YKamD1F92dm0sW2KmlWTQVpyZ6P3uL46uhIRYxBO4JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bomYhcDZQhsPfRdeRk1cTDBPyVnwRwWDLJ2Orf7h7NXWyZJrlrr5xUsLt9Lq8P8gY
	 W9MUO2GmShLtjdJRCmZwLthR1hwFJB55b96G7C0wO72lnRmduLf6P8lqbEUJnsp6df
	 8DEe3hwGWxlkaAUJShhWbotakTVjCH3t2zYEi1DY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfLITdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:33:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfLITdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:33:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA56F20637;
        Mon,  9 Dec 2019 19:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575920000;
        bh=YKamD1F92dm0sW2KmlWTQVpyZ6P3uL46uhIRYxBO4JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KQ4vH9G6TqCqWfQjKVb/NAuG5qCVL6Bapj0+FHozitNRdUUYjOfCPqI9kCeN+WX4G
         KoQeaiqV/tY7Q4lLeDMBSPMI+X03cM8JxEYECRgssna2X6Go5j/sTxhnpK42zN+3un
         cWquTaCRBWb7NIE/ZT086fUZwg41XH2G/Nkj1OR8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 2/6] device.h: move devtmpfs prototypes out of the file
Date:   Mon,  9 Dec 2019 20:32:59 +0100
Message-Id: <20191209193303.1694546-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209193303.1694546-1-gregkh@linuxfoundation.org>
References: <20191209193303.1694546-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devtmpfs functions do not need to be in device.h as only the driver
core uses them, so move them to the private .h file for the driver core.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h    | 8 ++++++++
 include/linux/device.h | 4 ----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 80598b312940..40fb069a8a7e 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -186,3 +186,11 @@ extern void device_links_unbind_consumers(struct device *dev);
 
 /* device pm support */
 void device_pm_move_to_tail(struct device *dev);
+
+#ifdef CONFIG_DEVTMPFS
+int devtmpfs_create_node(struct device *dev);
+int devtmpfs_delete_node(struct device *dev);
+#else
+static inline int devtmpfs_create_node(struct device *dev) { return 0; }
+static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
+#endif
diff --git a/include/linux/device.h b/include/linux/device.h
index e226030c1df3..3daec3af1753 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1664,12 +1664,8 @@ extern void put_device(struct device *dev);
 extern bool kill_device(struct device *dev);
 
 #ifdef CONFIG_DEVTMPFS
-extern int devtmpfs_create_node(struct device *dev);
-extern int devtmpfs_delete_node(struct device *dev);
 extern int devtmpfs_mount(const char *mntdir);
 #else
-static inline int devtmpfs_create_node(struct device *dev) { return 0; }
-static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
 static inline int devtmpfs_mount(const char *mountpoint) { return 0; }
 #endif
 
-- 
2.24.0

