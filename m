Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5614DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2724720652
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDmvInuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfCDPTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:19:38 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38164 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfCDPTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:19:36 -0500
Received: by mail-io1-f68.google.com with SMTP id p18so4221107ioh.5;
        Mon, 04 Mar 2019 07:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ztgl9diV87Ba05O2osrVUwzc+trE2CDlP15kE+eSaE=;
        b=cDmvInuBPuWXp1Jpc39KHHP4fqk4CCQIU/K1piCuoJs78w9JrV+p7KQM22yAyPCXEL
         pysoVK0ZYwkVnTQFrBMSgoGcxaTHOfoGYDHqozfL5Maq2DeKbGpgmM5voaIoeid8aRfF
         6xbvCcj/gUEB3Em3IDjZ13ykaUBvH6TsW1ZLoa1I5NiMXsE2sga1yY/2IpqKTWo8NnJo
         SL0BVzo/V37sw+P73mDiAxwfYIftyfr1vCNCGb5Jaqz2HHh8qtgikBCIk4qLHa7Iw3HQ
         3eSVG0znrdB/PqAHE/JOmADmYxzQIiFBY1spUiQBLqpFGWQqV8xDXeZHwctDJdyjKG3N
         /7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8ztgl9diV87Ba05O2osrVUwzc+trE2CDlP15kE+eSaE=;
        b=gUw85WYdbxfmlSdCMBEikNL0QhF4DIONGZWpylGR+DO8gZV3fJ7y3dxfBfw9zfe7EG
         KiVK2CRuis5fFZf9MOXu+WTJpZmqtgLkEmDsCXq7p1IT6zoAPdHrBhnciSHpwgUuXh+B
         Rz3FVlUyI2nzG1oN4DFexvaBeGcptXrqR7r2SKhqG9TsOyjsD+TdKkRn/XQ3nw+mi7GE
         UDjsIrcQD1dSpaiTe0z6mVtP6zVorQFE2SPRSLGA8eQNB47U16QmNloZ5DaNCufSi5J3
         KtaG2UasY7qmGSsRwRK3WD/TqSetS6u9t8wND+IF/0B8H6PBLNaIS9peSqadJOCQonsb
         LRXA==
X-Gm-Message-State: APjAAAUqN2QhqKMN7r6CIPyoC5NKRdr5fZJAwzFn/FvC94/oGYwgV/74
        s5RkWaVawrDgbm/HnUqyYA==
X-Google-Smtp-Source: APXvYqz/K90PLJzxeSJTarr5oKT9Zu92jr78L1W5kORhGf0JFWUIyWs8k/Dq7vG2UaePL7hodEAPTQ==
X-Received: by 2002:a6b:7a41:: with SMTP id k1mr7659928iop.284.1551712775930;
        Mon, 04 Mar 2019 07:19:35 -0800 (PST)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id 5sm3240615ity.40.2019.03.04.07.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:19:35 -0800 (PST)
From:   Robert Yang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Yang <decatf@gmail.com>
Subject: [PATCH v2 3/3] iio: accel: kxcjk1013: Add device tree support
Date:   Mon,  4 Mar 2019 10:19:12 -0500
Message-Id: <20190304151912.11485-4-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190304151912.11485-1-decatf@gmail.com>
References: <20190304151912.11485-1-decatf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for kxcjk-1013 accelerometer sensors.

Signed-off-by: Robert Yang <decatf@gmail.com>
---
 drivers/iio/accel/kxcjk-1013.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 7096e577b23f..e4cbc443e6ed 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1510,10 +1510,20 @@ static const struct i2c_device_id kxcjk1013_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
 
+static const struct of_device_id kxcjk1013_of_match[] = {
+	{ .compatible = "kionix,kxcjk1013", },
+	{ .compatible = "kionix,kxcj91008", },
+	{ .compatible = "kionix,kxtj21009", },
+	{ .compatible = "kionix,kxtf9", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, kxcjk1013_of_match);
+
 static struct i2c_driver kxcjk1013_driver = {
 	.driver = {
 		.name	= KXCJK1013_DRV_NAME,
 		.acpi_match_table = ACPI_PTR(kx_acpi_match),
+		.of_match_table = of_match_ptr(kxcjk1013_of_match),
 		.pm	= &kxcjk1013_pm_ops,
 	},
 	.probe		= kxcjk1013_probe,
-- 
2.17.1

