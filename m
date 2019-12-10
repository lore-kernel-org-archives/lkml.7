Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C63C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943C62053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576015832;
	bh=zPctY8+3us3rg4lt69IF2T0GLa/mbYJ8eSz0Agf7hpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g7O/F2VYjZYq00pjUJHkxQfqre2P7BwZCc8X9xnyl+99EouQNVy2k1sI4Ml0fLh6U
	 fZFRf43R0di3wE3PVx82eEk+W9vr2bCcZHx3BrSTaX+4+BDLS+JBFXdWnPcfnt1Myp
	 CRmLolGR++6KrsKwao4dWWBK6I0HrBD/5LGFJQwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfLJWKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:10:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbfLJWEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:04:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F93220838;
        Tue, 10 Dec 2019 22:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015447;
        bh=zPctY8+3us3rg4lt69IF2T0GLa/mbYJ8eSz0Agf7hpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1/dqv1eCnu/kGSxABd3Rvw/DtDD8ISOV3AEe4LeirKAJ2y6DbN6X0GAXULlvIZT9T
         G/0vZZcfV9nuN+WeIzqcARNoweDd3gObhrxWEziQlsVD039J6yAOrVNBHsjZG2jwUo
         gQWbn+1waWy/K4jZdpkSHchtPTsVenLWrz02img4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 055/130] iio: pressure: zpa2326: fix iio_triggered_buffer_postenable position
Date:   Tue, 10 Dec 2019 17:01:46 -0500
Message-Id: <20191210220301.13262-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
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
index 91431454eb85d..10bd5e56aacbb 100644
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

