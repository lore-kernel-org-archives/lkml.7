Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8782C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE0720449
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811740;
	bh=UQbqGMDCgBNAjQjZMA67nwKs/q9PTTAcMDrta56byeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2f593qIkHg5iFLQZSmirjaTI+4PNxha0RpR5qxUIBEZjcWtMBNU5KUqb5ofc1cmzq
	 2VlxnoXQJPt/zcD+LFaMiSBvHMXJw8LoDDcGSLb0yOtqkIoDKRv1ALpne6cnT7Lzjd
	 aBa5TQgTBkls+lqKCeElC/C8L6oPG7pM7z/gpREo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfEBPmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbfEBP2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:28:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CF2216FD;
        Thu,  2 May 2019 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810898;
        bh=UQbqGMDCgBNAjQjZMA67nwKs/q9PTTAcMDrta56byeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4j/5XbO7ukMI2fu8jzJMFIRFs4++zLSusscyAOk4w8lAEkC2mW/CDiY+BIWyDhiM
         kOvbT3Qz70WueF4K1yqzgkvIv3AXTD7MBqgzB1ockhfpCCg2luFJNg6RDvWDbpPIcj
         pLOS0bPAh1IinyXrfEI7WWXYjK1pGVIWRTusTsy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 71/72] leds: pca9532: fix a potential NULL pointer dereference
Date:   Thu,  2 May 2019 17:21:33 +0200
Message-Id: <20190502143338.881186186@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
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



