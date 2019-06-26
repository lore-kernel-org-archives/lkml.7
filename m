Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21769C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE24320663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfFZIrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:47:03 -0400
Received: from foss.arm.com ([217.140.110.172]:56504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfFZIrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:47:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA2F92B;
        Wed, 26 Jun 2019 01:47:02 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 092603F71E;
        Wed, 26 Jun 2019 01:47:01 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH] drivers: s390/cio: Fix compilation warning about const qualifiers
Date:   Wed, 26 Jun 2019 09:46:53 +0100
Message-Id: <1561538813-19807-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190626012218.GB24105@kroah.com>
References: <20190626012218.GB24105@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update __ccwdev_check_busid() and __ccwgroupdev_check_busid() to use
"const" qualifiers to fix the compiler warning.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/s390/cio/ccwgroup.c | 2 +-
 drivers/s390/cio/device.c   | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index ea176157..c522e93 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -610,7 +610,7 @@ EXPORT_SYMBOL(ccwgroup_driver_unregister);
 
 static int __ccwgroupdev_check_busid(struct device *dev, const void *id)
 {
-	char *bus_id = id;
+	const char *bus_id = id;
 
 	return (strcmp(bus_id, dev_name(dev)) == 0);
 }
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index f27536b..1132482 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1655,9 +1655,7 @@ EXPORT_SYMBOL_GPL(ccw_device_force_console);
 static int
 __ccwdev_check_busid(struct device *dev, const void *id)
 {
-	char *bus_id;
-
-	bus_id = id;
+	const char *bus_id = id;
 
 	return (strcmp(bus_id, dev_name(dev)) == 0);
 }
-- 
2.7.4

