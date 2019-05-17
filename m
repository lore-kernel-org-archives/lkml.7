Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EA4C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA302087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiIXZ4su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfEQVRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:17:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38600 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfEQVRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:17:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so8494923wrs.5;
        Fri, 17 May 2019 14:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0QSp/nbNAN5CDGxs0f/bvo6nU3WJJBo15TSLrfM3Y4=;
        b=tiIXZ4sutgDVVU7SE8IeUiaj7yo1qHobxFKA+nnT31hSDFk46N7ENbC8r5EX2YtJfC
         BwCALt/MhUi4ZJnosTP6KRMyJbIygrOYxXPYS4fZ1g1UOxYNMX/4GI8Yg4/KkV8ytxkv
         byFEMejpRmPz3YupaSXtzS4QlUvfYeB0teT9/m5QN4iiXDiEdsMsnbYZynUKrRxcHUfZ
         NR5xY2Rf1rsY0eBQy6CjzgLk/qGocDmwyRHcZaSxWbC52WJolbkeH2/wmKVGKEyUx77E
         W06EjMuaSOLbiO9vfNuVT7CnMKD0H2QVmbbvmaDdmo18r+Cyx4uHhetxf+i6FvlztObr
         ZfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0QSp/nbNAN5CDGxs0f/bvo6nU3WJJBo15TSLrfM3Y4=;
        b=KDJEf85lF6OuYf/Xb/UvZYJf4MNx/CC1BvO4Fcp2chjHZPV7d/6JLX2qlJlvyhK+j/
         TOFYwaJrxmgb3cTE3uGBqEYHfLAl3+nVJkyCjr3psOgDHm3cjk/eGiv+VdXnU8yPi1p3
         UHHM+Y7/drXHPe3vynDKVqBl1ptbxGIgZutN8tFXrxAwCdtqzInUxA3jizqAt+s2r4U8
         Tww3NU0ANkBC5GdFwsVHbqv6wGmELG9cStUKOjGqeOgpcW+aFPom7wfiXZ6OTKDX+MZR
         khEpq3rPueFKet4CklnLiUzK7hGyeA5tt/0S1W2IVkpewaLhR8ZnWBBIVM7Ves9Xai38
         dqeA==
X-Gm-Message-State: APjAAAX0iUc+miem5dCqTtjeQD9pS176EuDN6UzHIxvAmyv/q9nmJP/7
        DlWdN0Y7ElnZcYoIpKeAsZs=
X-Google-Smtp-Source: APXvYqzQicc/iutHtLatS68TF4Wqp76ixuQit1ne4DOx7ecZiAUY9JpudaWRxE60ze3r41OtMhdwVQ==
X-Received: by 2002:adf:fa88:: with SMTP id h8mr1792358wrr.32.1558127869602;
        Fri, 17 May 2019 14:17:49 -0700 (PDT)
Received: from vaio.lan ([93.55.208.142])
        by smtp.gmail.com with ESMTPSA id 88sm20085400wrc.33.2019.05.17.14.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 14:17:48 -0700 (PDT)
From:   Stefano Manni <stefano.manni@gmail.com>
To:     nick@shmanahar.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     Stefano Manni <stefano.manni@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Input: atmel_mxt_ts - add wakeup support
Date:   Fri, 17 May 2019 23:17:40 +0200
Message-Id: <20190517211741.8906-1-stefano.manni@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wakeup support to the maxtouch driver.
The device can wake up the system from suspend,
mark the IRQ as wakeup capable, so that device
irq is not disabled during system suspend.

Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 5c63d25ce84e..2e0abc0b665d 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3041,6 +3041,7 @@ static const struct dmi_system_id chromebook_T9_suspend_dmi[] = {
 static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct mxt_data *data;
+	struct device_node *node = client->dev.of_node;
 	int error;
 
 	/*
@@ -3125,6 +3126,12 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		goto err_free_object;
 	}
 
+	if (node) {
+		if (of_property_read_bool(node, "wakeup-source") ||
+			of_property_read_bool(node, "linux,wakeup"))
+			device_init_wakeup(&client->dev, true);
+	}
+
 	return 0;
 
 err_free_object:
@@ -3156,6 +3163,9 @@ static int __maybe_unused mxt_suspend(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(client->irq);
+
 	if (input_dev->users)
 		mxt_stop(data);
 
@@ -3175,6 +3185,9 @@ static int __maybe_unused mxt_resume(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
+	if (device_may_wakeup(&client->dev))
+		disable_irq_wake(client->irq);
+
 	if (input_dev->users)
 		mxt_start(data);
 
-- 
2.20.1

