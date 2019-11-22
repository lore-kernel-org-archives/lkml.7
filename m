Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014C5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA02A20714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418796;
	bh=xmteAW81h2blFb8tQocIaklh7OglFSJcqZ7I45f1uC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fCht/V+M8lhZrUuo/ynC7qD/tFkuabMXtr0kpvdqACFzZnu4C5VRifdYB0aXb/obl
	 HJbpoEDG3pX+KKNZ824VNPxTolnDJWCxVHvtw2hmVQgVeQze8T8N4LCn4PprL/ZFxt
	 V6wGoMIyCsVY5nwO29OQTCe0qU0KmkVlmUTXoZ6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfKVKdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:33:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbfKVKdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:33:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BBCD20715;
        Fri, 22 Nov 2019 10:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418793;
        bh=xmteAW81h2blFb8tQocIaklh7OglFSJcqZ7I45f1uC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzx61zqeTrrxjzWf6VmbWHhAARMY/8a3gb5LpA5mF03Owo9yF3edkUvZHwZiw/CUA
         UMveP3O0j2INxAZjIxU954kVljF0kvghcCs+mHvQbdc1nXlDBOI0Z3vRwCK9SVwCpZ
         t4/8obt4cDiFywY/jIG1tGaFfT6VMRrFX2010kUo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 053/159] power: supply: ab8500_fg: silence uninitialized variable warnings
Date:   Fri, 22 Nov 2019 11:27:24 +0100
Message-Id: <20191122100745.696798321@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 drivers/power/ab8500_fg.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 3830dade5d69d..d91111200dde2 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -2447,17 +2447,14 @@ static ssize_t charge_full_store(struct ab8500_fg *di, const char *buf,
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
@@ -2469,20 +2466,16 @@ static ssize_t charge_now_store(struct ab8500_fg *di, const char *buf,
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



