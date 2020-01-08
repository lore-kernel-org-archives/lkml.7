Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B0DC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFB22081E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAHB5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:57:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgAHB5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:57:39 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 065854DCD4BCE0D4F0B9;
        Wed,  8 Jan 2020 09:57:36 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Wed, 8 Jan 2020 09:57:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dan Murphy <dmurphy@ti.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] leds: leds-bd2802: remove set but not used variable 'pdata'
Date:   Wed, 8 Jan 2020 01:53:22 +0000
Message-ID: <20200108015322.51103-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/leds/leds-bd2802.c: In function 'bd2802_probe':
drivers/leds/leds-bd2802.c:663:35: warning:
 variable 'pdata' set but not used [-Wunused-but-set-variable]

commit 4c3718f9d6a6 ("leds: bd2802: Convert to use GPIO descriptors")
left behind this unused variable.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/leds/leds-bd2802.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/leds/leds-bd2802.c b/drivers/leds/leds-bd2802.c
index bd61a823d0ca..8bbaef5a2986 100644
--- a/drivers/leds/leds-bd2802.c
+++ b/drivers/leds/leds-bd2802.c
@@ -660,7 +660,6 @@ static int bd2802_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct bd2802_led *led;
-	struct bd2802_led_platform_data *pdata;
 	int ret, i;
 
 	led = devm_kzalloc(&client->dev, sizeof(struct bd2802_led), GFP_KERNEL);
@@ -668,7 +667,6 @@ static int bd2802_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	led->client = client;
-	pdata = led->pdata = dev_get_platdata(&client->dev);
 	i2c_set_clientdata(client, led);
 
 	/*



