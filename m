Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC1BC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 21:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFEF20838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 21:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ffIRcXxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfCBV1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 16:27:45 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:42946 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCBV1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 16:27:45 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id C82E2DE6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2019 21:27:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dAnuItaPQ2g1 for <linux-kernel@vger.kernel.org>;
        Sat,  2 Mar 2019 15:27:43 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 9601ACC0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2019 15:27:43 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id d7so1295393ios.17
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 13:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0NPqt03KPPHD//K2Osnhxg72NyH85JUvZkfB9DO+DkA=;
        b=ffIRcXxUUh+IaBsSDMLFY3UsRgNGtx1RG9CnLm4IbmRz7jSuD7nXwgou4JHy16uV1k
         dMoL/tPN8HcXphI2Sd8pHonMKERCSjn2Poo5Wj0Viv9uquaXgqZCShI7U5fDfHRcpZy0
         gxwQj+091xHw5vsMJvEEyHiH1oIShXYIjBWQjR5ZFTBs6sdxuZH/3bi++IpECBXEJCwr
         Tb5+f31xsoMyAOaTF/7FTyNi8ToXeHChzqW76NNlMA05Zu+A37PqEVrlw60YGq0bwJdc
         6V09CHpO5iyDbf3MnfRyDMjEY0JVmYJ/x3XdBFlqkqetO/uvwL+T15hfgBUat76HwRnR
         XIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0NPqt03KPPHD//K2Osnhxg72NyH85JUvZkfB9DO+DkA=;
        b=D0n7eNi9zeA4ymvT+FHJNTXf6JsKjWthhN1pjQOnWJcbkIy1ExDEEJLxWKK4SiilGK
         owmoj8H1YMCKDRRL6C05YBVjbUSr872SCVHIFWNrt1cU3sTo+xEmRYwmzn0AFhD6qN/X
         cuXXO1KYKEIsgCfdbfNVz8hMTlbQbA3sn2E4lHgzGCUcSRXfcdov0aj/3W4tbPmcKyoO
         a+Dm9Jg6H1ZvKMy/EkOZTAunTgufu/Tzdi049KjusL7eJejb4HkI7fVmvCZTDd50ftKv
         /ODtqWepCs+BjlgyWBBrsSaWaf/H1xV8MMrznXhszgVKqqoqZTIKzjBLWqxO8mCoHmi/
         q9Aw==
X-Gm-Message-State: APjAAAUjNQ+Z5CINZmevgEZ9ojR4DN7PDCdrBoAkI0uY8WZbkcXRrw9y
        Vz7CrKI7enrcS6CYqZKaiPwFRXJHgJGTwbZNhv5lIpe9RaHts5/G383ptDKqurAVHR3dddLS5/5
        h7HONAHS/9W5YTo2+snsaeQOHEejX
X-Received: by 2002:a5d:97c8:: with SMTP id k8mr6487818ios.267.1551562063272;
        Sat, 02 Mar 2019 13:27:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxgExxgg18sn4TQiKupbjGfC1774WaSrerDq/3yKqDwrfbKxvP/vYv2RyII12x1pbY1ODIE3Q==
X-Received: by 2002:a5d:97c8:: with SMTP id k8mr6487811ios.267.1551562063093;
        Sat, 02 Mar 2019 13:27:43 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id y3sm955383itb.2.2019.03.02.13.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 13:27:42 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: sm501: Fix potential NULL pointer dereference
Date:   Sat,  2 Mar 2019 15:27:27 -0600
Message-Id: <20190302212727.14118-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lookup variable on failure of allocating memory via devm_kzalloc
can cause a NULL pointer dereference. This patch avoids such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/mfd/sm501.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index a530972c5a7e..e0173bf4b0dc 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1145,6 +1145,9 @@ static int sm501_register_gpio_i2c_instance(struct sm501_devdata *sm,
 	lookup = devm_kzalloc(&pdev->dev,
 			      sizeof(*lookup) + 3 * sizeof(struct gpiod_lookup),
 			      GFP_KERNEL);
+	if (!lookup)
+		return -ENOMEM;
+
 	lookup->dev_id = "i2c-gpio";
 	if (iic->pin_sda < 32)
 		lookup->table[0].chip_label = "SM501-LOW";
-- 
2.17.1

