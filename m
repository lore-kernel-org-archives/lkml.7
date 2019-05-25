Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6F1C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 14:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC2420675
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 14:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfEYOaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 10:30:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726951AbfEYOaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 10:30:39 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D7A5F801C288D102A183;
        Sat, 25 May 2019 22:30:35 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 22:30:25 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] Input: tca8418 - Remove set but not used variable ''
Date:   Sat, 25 May 2019 22:29:21 +0800
Message-ID: <20190525142921.18812-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/input/keyboard/tca8418_keypad.c: In function tca8418_keypad_probe:
drivers/input/keyboard/tca8418_keypad.c:269:24: warning: variable max_keys set but not used [-Wunused-but-set-variable]

It's not used since commit 16ff7cb1848a ("Input:
tca8418-keypad - switch to using managed resources")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 6da607d3b811..3bbd7e652533 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -266,7 +266,7 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 	struct tca8418_keypad *keypad_data;
 	struct input_dev *input;
 	u32 rows = 0, cols = 0;
-	int error, row_shift, max_keys;
+	int error, row_shift;
 	u8 reg;
 
 	/* Check i2c driver capabilities */
@@ -291,7 +291,6 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 	}
 
 	row_shift = get_count_order(cols);
-	max_keys = rows << row_shift;
 
 	/* Allocate memory for keypad_data and input device */
 	keypad_data = devm_kzalloc(dev, sizeof(*keypad_data), GFP_KERNEL);
-- 
2.17.1


