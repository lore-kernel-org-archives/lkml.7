Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790E7C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5445A2070A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgAHDtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:49:32 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbgAHDtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 22:49:32 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2F056623AA071B0ADDD8;
        Wed,  8 Jan 2020 11:49:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Wed, 8 Jan 2020 11:49:19 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Jean Delvare <jdelvare@suse.com>,
        "Dr . David Alan Gilbert" <linux@treblig.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] hwmon: (w83627ehf) Remove set but not used variable 'fan4min'
Date:   Wed, 8 Jan 2020 03:45:14 +0000
Message-ID: <20200108034514.50130-1-yuehaibing@huawei.com>
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

drivers/hwmon/w83627ehf.c: In function 'w83627ehf_check_fan_inputs':
drivers/hwmon/w83627ehf.c:1296:24: warning:
 variable 'fan4min' set but not used [-Wunused-but-set-variable]

commit 62000264cfa8 ("hwmon: (w83627ehf) remove nct6775 and nct6776 support")
left behind this unused variable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/hwmon/w83627ehf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 5a7239eb1c15..7ffadc2da57b 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1293,7 +1293,7 @@ static void
 w83627ehf_check_fan_inputs(const struct w83627ehf_sio_data *sio_data,
 			   struct w83627ehf_data *data)
 {
-	int fan3pin, fan4pin, fan4min, fan5pin, regval;
+	int fan3pin, fan4pin, fan5pin, regval;
 
 	/* The W83627UHG is simple, only two fan inputs, no config */
 	if (sio_data->kind == w83627uhg) {
@@ -1307,12 +1307,10 @@ w83627ehf_check_fan_inputs(const struct w83627ehf_sio_data *sio_data,
 		fan3pin = 1;
 		fan4pin = superio_inb(sio_data->sioreg, 0x27) & 0x40;
 		fan5pin = superio_inb(sio_data->sioreg, 0x27) & 0x20;
-		fan4min = fan4pin;
 	} else {
 		fan3pin = 1;
 		fan4pin = !(superio_inb(sio_data->sioreg, 0x29) & 0x06);
 		fan5pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x02);
-		fan4min = fan4pin;
 	}
 
 	data->has_fan = data->has_fan_min = 0x03; /* fan1 and fan2 */



