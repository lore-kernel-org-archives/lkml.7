Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30771C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0185218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962319;
	bh=2yWzdcIpJl1eWpNGQDtXa9BkpBvLMN8DxFGXO814MeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v6rbV8Y3i9YS1pTtavnolmZASOtqXLJO8B5z8FjxlGT+7Z0ADFSKOSsOpOan6RbTY
	 JNRLehkejfpZ476uatG+PpxKQAg3SzwqdyFZJJmK+CMjDU8KTf87IEjDSpfz4VUhic
	 HbGFkaa6Ptpirvqoc+xBlRy0+8x8DZIh15wd54Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfDVTpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729692AbfDVTpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:45:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E67E218D9;
        Mon, 22 Apr 2019 19:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962313;
        bh=2yWzdcIpJl1eWpNGQDtXa9BkpBvLMN8DxFGXO814MeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sbc40Txm1gffe5AkQmP6JkTszX4Rk6F1v2Jb/G5O1eIwi68twKtgMi7EKOZoCh1Mj
         fDfwyKsA+9Og44bHcP4cPS/pAw4RgJauF5fl0ahZ9AOPRtgu7/9aqKdEZHkoV5GfAn
         vDakRu6/g9eNNSIg3GFIjkIVEEehpqF5aJMotgXI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 97/98] leds: pca9532: fix a potential NULL pointer dereference
Date:   Mon, 22 Apr 2019 15:42:04 -0400
Message-Id: <20190422194205.10404-97-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 0aab8e4df4702b31314a27ec4b0631dfad0fae0a ]

In case of_match_device cannot find a match, return -EINVAL to avoid
NULL pointer dereference.

Fixes: fa4191a609f2 ("leds: pca9532: Add device tree support")
Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/leds/leds-pca9532.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
index 7fea18b0c15d..7cb4d685a1f1 100644
--- a/drivers/leds/leds-pca9532.c
+++ b/drivers/leds/leds-pca9532.c
@@ -513,6 +513,7 @@ static int pca9532_probe(struct i2c_client *client,
 	const struct i2c_device_id *id)
 {
 	int devid;
+	const struct of_device_id *of_id;
 	struct pca9532_data *data = i2c_get_clientdata(client);
 	struct pca9532_platform_data *pca9532_pdata =
 			dev_get_platdata(&client->dev);
@@ -528,8 +529,11 @@ static int pca9532_probe(struct i2c_client *client,
 			dev_err(&client->dev, "no platform data\n");
 			return -EINVAL;
 		}
-		devid = (int)(uintptr_t)of_match_device(
-			of_pca9532_leds_match, &client->dev)->data;
+		of_id = of_match_device(of_pca9532_leds_match,
+				&client->dev);
+		if (unlikely(!of_id))
+			return -EINVAL;
+		devid = (int)(uintptr_t) of_id->data;
 	} else {
 		devid = id->driver_data;
 	}
-- 
2.19.1

