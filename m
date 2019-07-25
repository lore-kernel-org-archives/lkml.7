Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7951C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B91F22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTIunbC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389852AbfGYImF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:42:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37076 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388889AbfGYImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:42:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so22386577pfa.4;
        Thu, 25 Jul 2019 01:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jxU8ocxtNspgHS0bBWYWqHKWB3dOfQqc8J5/U4Usfs=;
        b=lTIunbC3L9+ZpyrivHwjh7Sob+0Ek1auvhE3013d5pBolosyZ7a8dcEt5BHzMUZII+
         BdMATLlyVT2G7y+sJeAMftJf2WTzqgGrT9D4RLrohtirpL9TsHIs9vzLFD/v0s6eJ8VR
         S3AHzk9kT1/hKU0CuVv7+BfLMM0Jj+LPdIV4V5wjexiVt4dVursxaKAZkwbW71wPCw80
         Sd80dgZ9X9f68n2Kg5XdGANgU1kOvEy5NMjMsVrbzNRkqasRxyd0z/GM9ejcGb3TkoOd
         NBS26CnfLARO90GgdCqmP/itZYIiJd3/l3gOBEwWqMdV16OHIJnFtlZRHbkZF0qQZIft
         8NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jxU8ocxtNspgHS0bBWYWqHKWB3dOfQqc8J5/U4Usfs=;
        b=Bxo+VrBbG5/cKpAQ8VJKjV1Gz+f7+bvi2A3x0yiIiDc6DXvcb1l2y7r3GbASAmiBW3
         za82gu42dY2w2sJjtHAj7bXpIWS1mOdh6b2T1LP/Inesxrz5tEgHIslhv9zMFpAfoIA2
         KhPxh0JcmrFD9jGgHPE0zW8mJGN+PEcvm2y0wvX2JizptfK2iaXcgamZr0LVL7Q9yfa5
         URMlL4jWfao74V9JTC7gdX+g2654AUo2tX4dTSZTLO9uShbJMJfguJZ9ZA79KDL2mqx+
         Qkcltb/Zr7Zhk3Gthh7n3IFnjRL/ZuuE3Q9qB1b74nMpuyOyhWPVeAtr3Qs2rN7d8pUz
         fGUQ==
X-Gm-Message-State: APjAAAWlaNHXtPj2FDj7HmCuKBI1R0P+ulWcm+edDYXB9vQU4kEEPJ5U
        +i8FSIvUwg0/JzU7AXwDNJGNLXc7RHk=
X-Google-Smtp-Source: APXvYqzr34fVaEzAEmUYbX5D3xStShnzfjXtbRo7dkCXLDV5VFjbf6560wHBHZgc4ICCuO1yjC4gIg==
X-Received: by 2002:a65:464d:: with SMTP id k13mr76844528pgr.99.1564044124328;
        Thu, 25 Jul 2019 01:42:04 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id f20sm53250494pgg.56.2019.07.25.01.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 01:42:03 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     r.marek@assembler.cz, jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] hwmon: w83793: Fix possible null-pointer dereferences in watchdog_open()
Date:   Thu, 25 Jul 2019 16:41:56 +0800
Message-Id: <20190725084156.15554-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In watchdog_open(), data is initialized as NULL.
After the loop "list_for_each_entry" on lines 1302-1307, 
data may not be assigned, thus data is still NULL.

In this case, data is used on line 1310:
    watchdog_is_open = test_and_set_bit(0, &data->watchdog_is_open);
and on line 1317：
    kref_get(&data->kref);
and on line 1326:
    watchdog_enable(data);

Thus, possible null-pointer dereferences may occur.

To fix these bugs, data is checked after the loop.
If it is NULL, the mutex lock is released and -EINVAL is returned.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/hwmon/w83793.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 46f5dfec8d0a..f299716d5d94 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1306,6 +1306,11 @@ static int watchdog_open(struct inode *inode, struct file *filp)
 		}
 	}
 
+	if (!data) {
+		mutex_unlock(&watchdog_data_mutex);
+		return -EINVAL;
+	}
+
 	/* Check, if device is already open */
 	watchdog_is_open = test_and_set_bit(0, &data->watchdog_is_open);
 
-- 
2.17.0

