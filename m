Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B065C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7506924C6B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187866;
	bh=Ss3/1aNf6BV0NDPMl7bx6++BVlpIDWzqubpvj80s7W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ih3BmY41Csyyz8uDRC2B7XMueZ56fXZvzmvtSbVwJwY0VFmMbe6rY26dccgT1kYYb
	 JGzIbbPJsI5BSuRQBskyR8Zd2xmuN1ijXa3IDkLTw4+a7k/iy7YYPY1EHOwLK9nYEZ
	 xEJYCDoM2/PaVirG5k2qQHuKwEoTGj91pL+WJT/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbfE3DoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732394AbfE3DU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:20:58 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 268B52499E;
        Thu, 30 May 2019 03:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186458;
        bh=Ss3/1aNf6BV0NDPMl7bx6++BVlpIDWzqubpvj80s7W0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxqAmzoyRO51MFf9jtADJg5ED6e922qULqC9s6x8EQZI0ZnoGa2gI9lruZgLZ9TwF
         Uj/ZEDIvMeltX8CwfLssZlvyZuqy1Scv7Elh7mzTT1bnS942ick8H9OEXX9vybIaCt
         4juDNdLsT2PZ8I8gRcuty5Xztpwi9i+eTPrEsKFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 073/128] hwmon: (smsc47m1) Use request_muxed_region for Super-IO accesses
Date:   Wed, 29 May 2019 20:06:45 -0700
Message-Id: <20190530030447.790366676@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030432.977908967@linuxfoundation.org>
References: <20190530030432.977908967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d6410408ad2a798c4cc685252c1baa713be0ad69 ]

Super-IO accesses may fail on a system with no or unmapped LPC bus.

Also, other drivers may attempt to access the LPC bus at the same time,
resulting in undefined behavior.

Use request_muxed_region() to ensure that IO access on the requested
address space is supported, and to ensure that access by multiple drivers
is synchronized.

Fixes: 8d5d45fb1468 ("I2C: Move hwmon drivers (2/3)")
Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reported-by: John Garry <john.garry@huawei.com>
Cc: John Garry <john.garry@huawei.com>
Acked-by: John Garry <john.garry@huawei.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/smsc47m1.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index 5d323186d2c10..d24df0c50bea4 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -73,16 +73,21 @@ superio_inb(int reg)
 /* logical device for fans is 0x0A */
 #define superio_select() superio_outb(0x07, 0x0A)
 
-static inline void
+static inline int
 superio_enter(void)
 {
+	if (!request_muxed_region(REG, 2, DRVNAME))
+		return -EBUSY;
+
 	outb(0x55, REG);
+	return 0;
 }
 
 static inline void
 superio_exit(void)
 {
 	outb(0xAA, REG);
+	release_region(REG, 2);
 }
 
 #define SUPERIO_REG_ACT		0x30
@@ -531,8 +536,12 @@ static int __init smsc47m1_find(struct smsc47m1_sio_data *sio_data)
 {
 	u8 val;
 	unsigned short addr;
+	int err;
+
+	err = superio_enter();
+	if (err)
+		return err;
 
-	superio_enter();
 	val = force_id ? force_id : superio_inb(SUPERIO_REG_DEVID);
 
 	/*
@@ -608,13 +617,14 @@ static int __init smsc47m1_find(struct smsc47m1_sio_data *sio_data)
 static void smsc47m1_restore(const struct smsc47m1_sio_data *sio_data)
 {
 	if ((sio_data->activate & 0x01) == 0) {
-		superio_enter();
-		superio_select();
-
-		pr_info("Disabling device\n");
-		superio_outb(SUPERIO_REG_ACT, sio_data->activate);
-
-		superio_exit();
+		if (!superio_enter()) {
+			superio_select();
+			pr_info("Disabling device\n");
+			superio_outb(SUPERIO_REG_ACT, sio_data->activate);
+			superio_exit();
+		} else {
+			pr_warn("Failed to disable device\n");
+		}
 	}
 }
 
-- 
2.20.1



