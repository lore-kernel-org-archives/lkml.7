Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD38C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12304217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Ui9bIRpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfCRXQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:16:04 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:38700 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbfCRXQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:16:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 67566A06
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 23:15:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yRSvTE0trhMr for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 18:15:59 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 39183697
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 18:15:59 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id r21so14649505iod.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 16:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+ZJmJ2UM5bB0oCIauMpHMdRG8HOlzN7uYKLmmvwFiO4=;
        b=Ui9bIRpgXX8gG2r4owhpMXf9GzFRmqGCjUr7CFvTPsFblxaDZ0FuKrOwYrRGKSLgj/
         dmDnw7ucrBj+76Dei0BjaxcMA9UGhtD//byERMryGc76ZXtryJplZwS0ARBXmTkIcADc
         A9eTIfHJ++FRvOtbvnJmHVFRGC1TFY4dAWlODHEyLvymDD444rvei5Z6h6GRYPLwSMU/
         aEvOEZN8/uc0f8abWLXNeje+hzdWt1zMLSrT8QS5i+b49iRa04sZyeotDLFGCQGTyXWy
         KBCrZoFGSzHhc8KUU9tHUjx2QutsbqfGU+uu5NBOvsARKUl+xRxbUzROJxAJvQkZTpWO
         jaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+ZJmJ2UM5bB0oCIauMpHMdRG8HOlzN7uYKLmmvwFiO4=;
        b=I3XGd9nM4TRlXf5zZNnl3sSKajE1Bk2eYeLSFSRPG15glKQiDOKjabcGt/nC8V9C0m
         C7PHeFAGNL3UmycVm4PvcHicssfsUmPG/EFT8bUt68nb5vzUOcoFN5k77Nkk5I0bEwL2
         lm6iZXFFXifjyMDaS1iTzHmAN/HsSaXH31HSzKjmnSEoQ8nJIuGXnfXLN6zgziHGaZBm
         9+r6UrbUv7rxGQJJFo45uSOrMsrILDst9cu0BzvQk+jDR4/hYRfUa1B/8HEe6eaQk6JO
         VWI8xsVT0ECC0ee45oR0x9890NGnU3YynFRgbyS33G/uEo7Lpj6QMZHm2woKtJhrlKFf
         eU9A==
X-Gm-Message-State: APjAAAUBcxoEIFPbc5miaN3tIB3m5Byvy7A+Enqf8Xdb3Yg2d0YUJcKi
        eGG/xQwxY2tR9i7p25A51XEIJZmIxOKxS3j5eRlFRPqWPZb9bO4K6fbrynSyPK+KCKvp4klkpsZ
        kU1LEG9tprzW0oCvCJkkkNXH2zZjz
X-Received: by 2002:a6b:4102:: with SMTP id n2mr2854665ioa.256.1552950958856;
        Mon, 18 Mar 2019 16:15:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyotnn/YcDYNpUoq4n65VPzx4KWQ2IcUczBt4aFp2xGPpAqVEwM5Dm6J82hq/M/Nqnop358vQ==
X-Received: by 2002:a6b:4102:: with SMTP id n2mr2854660ioa.256.1552950958666;
        Mon, 18 Mar 2019 16:15:58 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id b202sm396706itb.36.2019.03.18.16.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 16:15:58 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: mc13xxx: i2c/spi Fix to avoid NULL pointer dereference
Date:   Mon, 18 Mar 2019 18:15:54 -0500
Message-Id: <20190318231554.8862-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device can return NULL if no matching device is found. The patches
avoids a scenario causing null pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/mfd/mc13xxx-i2c.c | 2 ++
 drivers/mfd/mc13xxx-spi.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mfd/mc13xxx-i2c.c b/drivers/mfd/mc13xxx-i2c.c
index 67e4c9aa7d18..1fbc9713bb9a 100644
--- a/drivers/mfd/mc13xxx-i2c.c
+++ b/drivers/mfd/mc13xxx-i2c.c
@@ -80,6 +80,8 @@ static int mc13xxx_i2c_probe(struct i2c_client *client,
 	if (client->dev.of_node) {
 		const struct of_device_id *of_id =
 			of_match_device(mc13xxx_dt_ids, &client->dev);
+		if (!of_id)
+			return -ENODEV;
 		mc13xxx->variant = of_id->data;
 	} else {
 		mc13xxx->variant = (void *)id->driver_data;
diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index ee3411cc5ce4..c044a02bdb64 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -158,6 +158,8 @@ static int mc13xxx_spi_probe(struct spi_device *spi)
 	if (spi->dev.of_node) {
 		const struct of_device_id *of_id =
 			of_match_device(mc13xxx_dt_ids, &spi->dev);
+		if (!of_id)
+			return -ENODEV;
 
 		mc13xxx->variant = of_id->data;
 	} else {
-- 
2.17.1

