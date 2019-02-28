Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809A2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FEA218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTpI9fRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfB1US1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:18:27 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38871 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387858AbfB1USY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:18:24 -0500
Received: by mail-it1-f196.google.com with SMTP id l66so17775761itg.3;
        Thu, 28 Feb 2019 12:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=leNRNY5PA6g1RqFbwlrVxKbLw9rvvy5ngWIY3AMUiI8=;
        b=WTpI9fRxafw4c6SnpmRogSHfP7KO1ZH2pd83VSn+1rT8xPZeAfJHk05ezwasI7kG1q
         J26gWARTIg3MazOsxYCU7l2pIHHg+J4HaJuEVudX/7/ekGEDjgMQBX58rzky2njmsEmi
         idM4jVxXcguZH+3f0kv+c7v2HqteuzkTuk+Ilid7MnfVJvj8CX61ig2KmRvzTKZfVstM
         Ss566pyGP6nRGlL1+2wkhNQHdzSb8SQYl145QGy8C5ZF6qU3yfP2xQ3oSQxvEUnrcl3f
         xtyXy7GJycxjtEtwlG+D1IAIZDCeJwa+v2esw6GTAfWiNEVvepo73+ucJYQm9RDgpoFo
         qtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=leNRNY5PA6g1RqFbwlrVxKbLw9rvvy5ngWIY3AMUiI8=;
        b=FozG7QJXsxz8yQ7Et2gNQtP2oTQ2eh5wEzQR0VWKHgOJstXVpxb4tYKdAd/kneVR88
         xAU4h8whJRpLS5dQOS9i18nSNTQN/UBJ8a7I9UPgNmRoPgWpEHQGK4hZRi0bFWkULWIs
         U+z9/IOwdBTCS0lQ5XMOtViK5zlQr3hUbmwcV/ZDh/gHCBy/ZWITBIVkFmf6bOeuIfgK
         +dwyF0aeImJToAIQNBmWDiO2CoaKiq/d5t96dfo1MxIL7k+S51YJoubjq6TiesRFqz2E
         bGaZ4KrSMSoynsJFnUeWbqB09gRDACrIcJ3572v76y5n7XyKYUkzLlfKYehCwnD19YiD
         b76A==
X-Gm-Message-State: AHQUAuZq83a/mCgmHbJ7ewVJvVWRO7imxj4gprtYChLz8WOO2fhwhnla
        MklNehh21gsO52eY8jT2Qw==
X-Google-Smtp-Source: APXvYqzdzkv+FnRHOSYcKiV5xprQboYbJ5vJFYwXpjjYf4K95TIkEFhSvSToJZ54MDVe1E3HZ5CSpg==
X-Received: by 2002:a24:3c94:: with SMTP id m142mr1066052ita.36.1551385102476;
        Thu, 28 Feb 2019 12:18:22 -0800 (PST)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id l131sm3388808itc.17.2019.02.28.12.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 12:18:21 -0800 (PST)
From:   Robert Yang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Yang <decatf@gmail.com>
Subject: [PATCH 3/3] iio: accel: kxcjk1013: Add device tree support
Date:   Thu, 28 Feb 2019 15:18:11 -0500
Message-Id: <20190228201811.7582-4-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228201811.7582-1-decatf@gmail.com>
References: <20190228201811.7582-1-decatf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for kxcjk-1013 accelerometer sensors.

Signed-off-by: Robert Yang <decatf@gmail.com>
---
 drivers/iio/accel/kxcjk-1013.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 7096e577b23f..e7a00743cdcb 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1510,10 +1510,21 @@ static const struct i2c_device_id kxcjk1013_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
 
+static const struct of_device_id kxcjk1013_of_match[] = {
+	{ .compatible = "kionix,kxcjk1013", },
+	{ .compatible = "kionix,kxcj91008", },
+	{ .compatible = "kionix,kxtj21009", },
+	{ .compatible = "kionix,kxtf9", },
+	{ .compatible = "kionix,SMO8500", },
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

