Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DE1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B6D2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369092;
	bh=o9mCRSO52kTNYGasdcQaU7KNAhzHmz+0LMi4XWaspcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lM4SxpjEdXWS8KAk0aJySDnFpAVJh4nPK44ZAaqRzHvQioCtROEGEooV/vlRkzcG5
	 rUMDTikxmGqdaK8O3UtmVXRXJtth/f8o11NVZVSdDpVqHFfQaOKNTADmpRgjbj3sMo
	 d6FEoYPAo4EDgQgmIn+HQiUBj8cwgKztYLsGYZ5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733176AbfDDJLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733162AbfDDJL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:11:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5D520693;
        Thu,  4 Apr 2019 09:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369086;
        bh=o9mCRSO52kTNYGasdcQaU7KNAhzHmz+0LMi4XWaspcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1FIoWsLalWrcWTibHzxy+2PXtJnxnLs3BsojnYnfp21uVD8SZU0P9v3ZO4jLxZvpp
         dGFZhAJ0SwczNx643opRfQvj1PgH9J2sACSDNiMgU4dlfIqT9+ElUxKOk+Bwd9CElr
         spxBEOP167S9S80VGcwh2UTk0eVDjQoDbPwpICsA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Broadus <jbroadus@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 092/246] i2c: Allow recovery of the initial IRQ by an I2C client device.
Date:   Thu,  4 Apr 2019 10:46:32 +0200
Message-Id: <20190404084622.366590957@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



