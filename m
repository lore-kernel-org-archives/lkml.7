Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F9EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613902190B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962531;
	bh=2yWzdcIpJl1eWpNGQDtXa9BkpBvLMN8DxFGXO814MeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q+QZouuK3hnUE9gd30BfqQuOBpTV5pK7eDlR4FEw1ySeqkJKHJJEC3C8cQ4GA44lP
	 m6IDLTug5B77FnN2XDeoZVk4WYROLofq4ymUwwRUp3C9fpkKjfrSRnoRGf0kGAPK1O
	 Jh3s520ZLOJ9WhydVYUOPYxXessxCYuNORZCoO0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfDVTsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbfDVTss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 027482190B;
        Mon, 22 Apr 2019 19:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962527;
        bh=2yWzdcIpJl1eWpNGQDtXa9BkpBvLMN8DxFGXO814MeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Noi9rZYIPcZO00F9orDi6MnBYC4pvxx+ZKkM38c89pHpwPwTymyW6mU8ggE8/4wfQ
         y6168eQrC50r3/n3Lb14quwfuiNQ/YPQJ2rcSS3UWxZQ58NyVmyyPRKVH6VaDPa+d3
         vGmrKKExzrWZBTL1qxhwVSuHTWOwV20RxHW844+I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 43/43] leds: pca9532: fix a potential NULL pointer dereference
Date:   Mon, 22 Apr 2019 15:47:27 -0400
Message-Id: <20190422194727.12495-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
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

