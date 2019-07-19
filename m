Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34020C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08058206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563511076;
	bh=9f1wajjvi5fzOiQPCP16sLyUiNuP4qgvjsgcriCP8us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jklgqOoDV4/PHqRGR1hmlcmgXRxQDEiXsGo2VMZ2WXRNkX433HHRzNc37b27IYLcu
	 TOrRGYrIOycXkxv7IbZTewkqYIXdXpkVR756X9AqkSZj1//m5237JkjDBCXGM2Ij3C
	 ioMYzut9Jx/U19JZurnD1wETpBvhioAudSZgxg3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389393AbfGSEhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728795AbfGSD7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:59:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CA162189F;
        Fri, 19 Jul 2019 03:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508777;
        bh=9f1wajjvi5fzOiQPCP16sLyUiNuP4qgvjsgcriCP8us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2a/LfTbcb12rrIGe+d3zYnH+a+BKUGKzQwX8Z+4IGIi4PPCEDQwjYK3JtzToMiva/
         xzbRwunUyOkQx7bXUPSrkg6rkp9dnjAKAd9/+HcYd9XTYtg6l1754rF1CDPgAqxdGu
         r/fwfIoxmIGspwggS7Nnmm8LILssyv8fpN+0nzTg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 084/171] iio: st_accel: fix iio_triggered_buffer_{pre,post}enable positions
Date:   Thu, 18 Jul 2019 23:55:15 -0400
Message-Id: <20190719035643.14300-84-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

[ Upstream commit 05b8bcc96278c9ef927a6f25a98e233e55de42e1 ]

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
the poll functions.

For the predisable hook, the disable code should occur before detaching
the poll func, and for the postenable hook, the poll func should be
attached before the enable code.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Acked-by: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/accel/st_accel_buffer.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 54f2ae91f614..0205c0167cdd 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -45,17 +45,19 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 		goto allocate_memory_error;
 	}
 
-	err = st_sensors_set_axis_enable(indio_dev,
-					(u8)indio_dev->active_scan_mask[0]);
+	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
 		goto st_accel_buffer_postenable_error;
 
-	err = iio_triggered_buffer_postenable(indio_dev);
+	err = st_sensors_set_axis_enable(indio_dev,
+					(u8)indio_dev->active_scan_mask[0]);
 	if (err < 0)
-		goto st_accel_buffer_postenable_error;
+		goto st_sensors_set_axis_enable_error;
 
 	return err;
 
+st_sensors_set_axis_enable_error:
+	iio_triggered_buffer_predisable(indio_dev);
 st_accel_buffer_postenable_error:
 	kfree(adata->buffer_data);
 allocate_memory_error:
@@ -64,20 +66,22 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 
 static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
 {
-	int err;
+	int err, err2;
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 
-	err = iio_triggered_buffer_predisable(indio_dev);
-	if (err < 0)
-		goto st_accel_buffer_predisable_error;
-
 	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
 	if (err < 0)
 		goto st_accel_buffer_predisable_error;
 
 	err = st_sensors_set_enable(indio_dev, false);
+	if (err < 0)
+		goto st_accel_buffer_predisable_error;
 
 st_accel_buffer_predisable_error:
+	err2 = iio_triggered_buffer_predisable(indio_dev);
+	if (!err)
+		err = err2;
+
 	kfree(adata->buffer_data);
 	return err;
 }
-- 
2.20.1

