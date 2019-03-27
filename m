Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87501C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD05206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714797;
	bh=y6Se3t2aBTfGe8oj5pfCOQOQ6/xPBNCRYHWhm7koozs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ccR5hw56Ii9QwHoHNmi2YFtby1qMeVFSzf0UCfGnaLy8oYEn38AUB0iGNw1Ykr0OG
	 yTlMmVaxskEHnWijPVRjmtAeBQ4a9yN9w6Sjcnp9EIAqt+XQfMZ5nVB6CW5xXjyXog
	 s0SfCTo2w+MC+JS6x2J55fgLH6gQ0ESCOTImwOCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbfC0T0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731754AbfC0SFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB6BF2063F;
        Wed, 27 Mar 2019 18:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709900;
        bh=y6Se3t2aBTfGe8oj5pfCOQOQ6/xPBNCRYHWhm7koozs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfmfIVDRV4zRvx55sn85YqNdjEMyuctN92k1V9T+n/W1dvFWEA+Gxkcv/36RJDtnG
         1uQLe9ftwbMRuMoft7i+OJ/UQcopUDFmGUx9JWL/Sean/0VPgpsqXgpNdJzF533V+A
         KC9Chxzp7qFqy+T0T/A0BXmLKKUDW/iwcSoWP9nw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jim Broadus <jbroadus@gmail.com>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 098/262] i2c: Allow recovery of the initial IRQ by an I2C client device.
Date:   Wed, 27 Mar 2019 13:59:13 -0400
Message-Id: <20190327180158.10245-98-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Broadus <jbroadus@gmail.com>

[ Upstream commit 93b6604c5a669d84e45fe5129294875bf82eb1ff ]

A previous change allowed I2C client devices to discover new IRQs upon
reprobe by clearing the IRQ in i2c_device_remove. However, if an IRQ was
assigned in i2c_new_device, that information is lost.

For example, the touchscreen and trackpad devices on a Dell Inspiron laptop
are I2C devices whose IRQs are defined by ACPI extended IRQ types. The
client device structures are initialized during an ACPI walk. After
removing the i2c_hid device, modprobe fails.

This change caches the initial IRQ value in i2c_new_device and then resets
the client device IRQ to the initial value in i2c_device_remove.

Fixes: 6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
Signed-off-by: Jim Broadus <jbroadus@gmail.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
[wsa: this is an easy to backport fix for the regression. We will
refactor the code to handle irq assignments better in general.]
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 9 +++++----
 include/linux/i2c.h         | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 28460f6a60cc..af87a16ac3a5 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -430,7 +430,7 @@ static int i2c_device_remove(struct device *dev)
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
 
-	client->irq = 0;
+	client->irq = client->init_irq;
 
 	return status;
 }
@@ -741,10 +741,11 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->flags = info->flags;
 	client->addr = info->addr;
 
-	client->irq = info->irq;
-	if (!client->irq)
-		client->irq = i2c_dev_irq_from_resources(info->resources,
+	client->init_irq = info->irq;
+	if (!client->init_irq)
+		client->init_irq = i2c_dev_irq_from_resources(info->resources,
 							 info->num_resources);
+	client->irq = client->init_irq;
 
 	strlcpy(client->name, info->type, sizeof(client->name));
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 65b4eaed1d96..7e748648c7d3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -333,6 +333,7 @@ struct i2c_client {
 	char name[I2C_NAME_SIZE];
 	struct i2c_adapter *adapter;	/* the adapter we sit on	*/
 	struct device dev;		/* the device structure		*/
+	int init_irq;			/* irq set at initialization	*/
 	int irq;			/* irq issued by device		*/
 	struct list_head detected;
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-- 
2.19.1

