Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D96C28D1E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B18920866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfFFMjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:39:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51352 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFMjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:39:02 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hYrfU-0005oo-W8; Thu, 06 Jun 2019 12:38:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     "amy . shih" <amy.shih@advantech.com.tw>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: nct7904: fix comparison of u8 variable ret with less than zero
Date:   Thu,  6 Jun 2019 13:38:56 +0100
Message-Id: <20190606123856.18531-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently u8 variable tmp is being checked for negative error returns
however this will be false since tmp is unsigned. Fix this by making
tmp an int.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: af55ab0b0792 ("hwmon: (nct7904) Add extra sysfs support for fan, voltage and temperature.")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hwmon/nct7904.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 5fa69898674c..b63f51d0378e 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -567,8 +567,7 @@ static int nct7904_write_in(struct device *dev, u32 attr, int channel,
 			    long val)
 {
 	struct nct7904_data *data = dev_get_drvdata(dev);
-	int ret, index;
-	u8 tmp;
+	int ret, index, tmp;
 
 	index = nct7904_chan_to_index[channel];
 
-- 
2.20.1

