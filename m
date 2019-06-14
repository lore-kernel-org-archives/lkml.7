Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A25C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785BC21848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfFNRyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:54:46 -0400
Received: from foss.arm.com ([217.140.110.172]:39234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfFNRyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:54:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3577346;
        Fri, 14 Jun 2019 10:54:44 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F05FA3F718;
        Fri, 14 Jun 2019 10:54:43 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Christian Gromm <christian.gromm@microchip.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH v2 01/28] staging: most-core: Use bus_find_device_by_name
Date:   Fri, 14 Jun 2019 18:53:56 +0100
Message-Id: <1560534863-15115-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bus_find_device_by_name() helper instead of writing our
own helper.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Gromm <christian.gromm@microchip.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

---
Hi,

This patch can be split from the series. But it will eventually
conflict with the series. Hence included it here.
---
 drivers/staging/most/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 86a8545..b9841adb 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -561,13 +561,6 @@ static int split_string(char *buf, char **a, char **b, char **c, char **d)
 	return 0;
 }
 
-static int match_bus_dev(struct device *dev, void *data)
-{
-	char *mdev_name = data;
-
-	return !strcmp(dev_name(dev), mdev_name);
-}
-
 /**
  * get_channel - get pointer to channel
  * @mdev: name of the device interface
@@ -579,7 +572,7 @@ static struct most_channel *get_channel(char *mdev, char *mdev_ch)
 	struct most_interface *iface;
 	struct most_channel *c, *tmp;
 
-	dev = bus_find_device(&mc.bus, NULL, mdev, match_bus_dev);
+	dev = bus_find_device_by_name(&mc.bus, NULL, mdev);
 	if (!dev)
 		return NULL;
 	iface = to_most_interface(dev);
-- 
2.7.4

