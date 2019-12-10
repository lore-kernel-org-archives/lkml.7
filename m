Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FE2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCB520637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014174;
	bh=tDtACXBXbqHPcMvtLvKgW4vP4L8no5eGik2GC2gs7To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jziKALPJzm271uez+8Nba04d0+uHkAYU9AGg2BciW+VhpFNfkoySKqZI00dphx05/
	 b+RVwmaZe41ZH9yKqg4KOGKsKNK9iVrmoj5rAsqnt9sEYWBu7gzK8iLzi+0FwHH+6A
	 8zHIdX+F5eHAkvBftdTPelm3qxnr0ACRBFwd+cjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfLJVmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729842AbfLJVds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:33:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CA732465C;
        Tue, 10 Dec 2019 21:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013628;
        bh=tDtACXBXbqHPcMvtLvKgW4vP4L8no5eGik2GC2gs7To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zD4oqU+2EjZ8FYQ8sUwIw4w2pZMzKotBAezXZJztEWxIhMWdEluwb3qy/bMPvLCl8
         4x+JiiO2tOuXFxTYf8El9EbdXexamkQzwcfoQACbrFgU+E5U26+0//v4mYA+3EiFTd
         P6rE+rKSpQl+sIjg812y3lE675YTZSatMrH6q4E0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 070/177] iio: pressure: zpa2326: fix iio_triggered_buffer_postenable position
Date:   Tue, 10 Dec 2019 16:30:34 -0500
Message-Id: <20191210213221.11921-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

[ Upstream commit fe2392c67db9730d46f11fc4fadfa7bffa8843fa ]

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
the poll functions.

The iio_triggered_buffer_postenable() should be called before (to attach
the poll func) and then the

The iio_triggered_buffer_predisable() function is hooked directly without
anything, which is probably fine, as the postenable() version seems to also
do some reset/wake-up of the device.
This will mean it will be easier when removing it; i.e. it just gets
removed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/zpa2326.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 81d8f24eaeb44..f3c5c9ee645ca 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -1251,6 +1251,11 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
 	const struct zpa2326_private *priv = iio_priv(indio_dev);
 	int                           err;
 
+	/* Plug our own trigger event handler. */
+	err = iio_triggered_buffer_postenable(indio_dev);
+	if (err)
+		goto err;
+
 	if (!priv->waken) {
 		/*
 		 * We were already power supplied. Just clear hardware FIFO to
@@ -1258,7 +1263,7 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
 		 */
 		err = zpa2326_clear_fifo(indio_dev, 0);
 		if (err)
-			goto err;
+			goto err_buffer_predisable;
 	}
 
 	if (!iio_trigger_using_own(indio_dev) && priv->waken) {
@@ -1268,16 +1273,13 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
 		 */
 		err = zpa2326_config_oneshot(indio_dev, priv->irq);
 		if (err)
-			goto err;
+			goto err_buffer_predisable;
 	}
 
-	/* Plug our own trigger event handler. */
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err)
-		goto err;
-
 	return 0;
 
+err_buffer_predisable:
+	iio_triggered_buffer_predisable(indio_dev);
 err:
 	zpa2326_err(indio_dev, "failed to enable buffering (%d)", err);
 
-- 
2.20.1

