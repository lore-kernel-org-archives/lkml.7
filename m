Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA3EC10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F9C21841
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfCWR2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:28:19 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50937 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbfCWR2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:28:18 -0400
Received: from pc.localdomain (unknown [91.192.165.7])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 10B4320000E;
        Sat, 23 Mar 2019 17:28:14 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 1/4] iio: inkern: API for reading available iio channel attribute values
Date:   Sat, 23 Mar 2019 18:28:06 +0100
Message-Id: <20190323172809.14407-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the inkern API with a function for reading available
attribute values of iio channels.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---

Changes:

v2: no change

 drivers/iio/inkern.c         | 20 ++++++++++++++++++++
 include/linux/iio/consumer.h | 14 ++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 06ca3f7fcc44..f19dbde3c945 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -733,6 +733,26 @@ static int iio_channel_read_avail(struct iio_channel *chan,
 						 vals, type, length, info);
 }
 
+int iio_read_avail_channel_attribute(struct iio_channel *chan,
+				     const int **vals, int *type, int *length,
+				     enum iio_chan_info_enum attribute)
+{
+	int ret;
+
+	mutex_lock(&chan->indio_dev->info_exist_lock);
+	if (!chan->indio_dev->info) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	ret = iio_channel_read_avail(chan, vals, type, length, attribute);
+err_unlock:
+	mutex_unlock(&chan->indio_dev->info_exist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_read_avail_channel_attribute);
+
 int iio_read_avail_channel_raw(struct iio_channel *chan,
 			       const int **vals, int *length)
 {
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 9887f4f8e2a8..b2d34831ed7c 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -290,6 +290,20 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
 int iio_read_avail_channel_raw(struct iio_channel *chan,
 			       const int **vals, int *length);
 
+/**
+ * iio_read_avail_channel_attribute() - read available channel attribute values
+ * @chan:		The channel being queried.
+ * @vals:		Available values read back.
+ * @type:		Type of values read back.
+ * @length:		Number of entries in vals.
+ * @attribute:		info attribute to be read back.
+ *
+ * Returns an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST.
+ */
+int iio_read_avail_channel_attribute(struct iio_channel *chan,
+				     const int **vals, int *type, int *length,
+				     enum iio_chan_info_enum attribute);
+
 /**
  * iio_get_channel_type() - get the type of a channel
  * @channel:		The channel being queried.
-- 
2.21.0

