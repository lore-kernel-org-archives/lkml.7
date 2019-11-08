Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F18C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD0E2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214189;
	bh=n2Kq4bKS+TGDHgmOJCQsdltB/pApKesDKfkqxEbgnqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uW3eftlleJWbhvFlXacOWMPAS9bfK3Mq7bX1alPJJW4s76CztVjzGlkpS8LD0mt/5
	 bzA+gjVHWb09G5bATpyJyOnZ+REDfNXxJq4fnd0fP9QslOIf/OikUJi1pkYb6TY1sM
	 IPdv2WCLpMUZOeOpaV2iYkI0bjuUL3elJYSYNDXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391612AbfKHL42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:56:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391133AbfKHLpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:45:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FF1B20656;
        Fri,  8 Nov 2019 11:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213532;
        bh=n2Kq4bKS+TGDHgmOJCQsdltB/pApKesDKfkqxEbgnqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxxqHEp7ZUIxlxoToDOUi70/v5byEwUKLuHcyRlD2Zij1VLGfIOYwMp/wpFXBKiGV
         uJjd5xSvCDkBVV5B+kTL8an8zyydL+9ie5ZjhWnka3Px+H5VKuhud32LMIgDq8ZCc+
         jlapWuqvUXV5iFS1CmYxxP8WZ0Iex5rB7CGWpfRM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 095/103] power: supply: ab8500_fg: silence uninitialized variable warnings
Date:   Fri,  8 Nov 2019 06:43:00 -0500
Message-Id: <20191108114310.14363-95-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 54baff8d4e5dce2cef61953b1dc22079cda1ddb1 ]

If kstrtoul() fails then we print "charge_full" when it's uninitialized.
The debug printk doesn't add anything so I deleted it and cleaned these
two functions up a bit.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ab8500_fg.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index c569f82a00718..b87768238b702 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2437,17 +2437,14 @@ static ssize_t charge_full_store(struct ab8500_fg *di, const char *buf,
 				 size_t count)
 {
 	unsigned long charge_full;
-	ssize_t ret;
+	int ret;
 
 	ret = kstrtoul(buf, 10, &charge_full);
+	if (ret)
+		return ret;
 
-	dev_dbg(di->dev, "Ret %zd charge_full %lu", ret, charge_full);
-
-	if (!ret) {
-		di->bat_cap.max_mah = (int) charge_full;
-		ret = count;
-	}
-	return ret;
+	di->bat_cap.max_mah = (int) charge_full;
+	return count;
 }
 
 static ssize_t charge_now_show(struct ab8500_fg *di, char *buf)
@@ -2459,20 +2456,16 @@ static ssize_t charge_now_store(struct ab8500_fg *di, const char *buf,
 				 size_t count)
 {
 	unsigned long charge_now;
-	ssize_t ret;
+	int ret;
 
 	ret = kstrtoul(buf, 10, &charge_now);
+	if (ret)
+		return ret;
 
-	dev_dbg(di->dev, "Ret %zd charge_now %lu was %d",
-		ret, charge_now, di->bat_cap.prev_mah);
-
-	if (!ret) {
-		di->bat_cap.user_mah = (int) charge_now;
-		di->flags.user_cap = true;
-		ret = count;
-		queue_delayed_work(di->fg_wq, &di->fg_periodic_work, 0);
-	}
-	return ret;
+	di->bat_cap.user_mah = (int) charge_now;
+	di->flags.user_cap = true;
+	queue_delayed_work(di->fg_wq, &di->fg_periodic_work, 0);
+	return count;
 }
 
 static struct ab8500_fg_sysfs_entry charge_full_attr =
-- 
2.20.1

