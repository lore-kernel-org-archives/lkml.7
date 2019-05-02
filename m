Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EBAC04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BDF20675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556812140;
	bh=071qU4FYFqP+jfSHj3u5DwRgRM6TOMGyikw3DM6siUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NvVfz3vOPHjeTY04wDRylCtktOI8xVhZWRPa1TSBOxJYkhmOKWhZI+81VHplxfknW
	 lFOWTJl7PFLZ6u8AxzLj1XyO5EOnWCIyvvCGeDKRNf5cdjBEUUeqUQepCEoK5y0TYC
	 SQpCvQ8l3yzy/lwtJ9mjW7ovSFUof5KC8IYPsIbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfEBPW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfEBPWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:22:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D71B216FD;
        Thu,  2 May 2019 15:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810574;
        bh=071qU4FYFqP+jfSHj3u5DwRgRM6TOMGyikw3DM6siUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCd6WvCvdRYOamEhYfTjr/DP66D6Vx6u133mPm9f8vsEd02CbitP6IzISLedFM5Jt
         0JD7AMQHHt6KCGZi325JZTsuSyNY3eJ85ygpsqVkHshYDHgqpCg0krtcum5vjWsk26
         sxABfYpZvND2QY80kJB5f71BsND3bup6WV/T192U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.9 31/32] leds: pca9532: fix a potential NULL pointer dereference
Date:   Thu,  2 May 2019 17:21:17 +0200
Message-Id: <20190502143323.337421780@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143314.649935114@linuxfoundation.org>
References: <20190502143314.649935114@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 09a7cffbc46f..896b38f6f9c0 100644
--- a/drivers/leds/leds-pca9532.c
+++ b/drivers/leds/leds-pca9532.c
@@ -488,6 +488,7 @@ static int pca9532_probe(struct i2c_client *client,
 	const struct i2c_device_id *id)
 {
 	int devid;
+	const struct of_device_id *of_id;
 	struct pca9532_data *data = i2c_get_clientdata(client);
 	struct pca9532_platform_data *pca9532_pdata =
 			dev_get_platdata(&client->dev);
@@ -503,8 +504,11 @@ static int pca9532_probe(struct i2c_client *client,
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



