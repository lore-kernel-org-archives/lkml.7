Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3984AC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B6C2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCMLlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:41:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35516 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfCMLk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:40:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5477827FB68
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@collabora.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] iio: cros_ec: Add kernel-doc for cros_ec_sensors_read_lpc
Date:   Wed, 13 Mar 2019 12:40:50 +0100
Message-Id: <20190313114050.11625-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

Document cros_ec_sensors_read_lpc, adding an additional note to explain
that this is the safe function for reading the EC data.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index c770a2a809d7..eb7b0edd5da4 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -268,6 +268,17 @@ static int cros_ec_sensors_read_data_unsafe(struct iio_dev *indio_dev,
 	return 0;
 }
 
+/**
+ * cros_ec_sensors_read_lpc() - read acceleration data from EC shared memory.
+ * @indio_dev: pointer to IIO device.
+ * @scan_mask: bitmap of the sensor indices to scan.
+ * @data: location to store data.
+ *
+ * Note: this is the safe function for reading the EC data. It guarantees
+ * that the data sampled was not modified by the EC while being read.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
 int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev,
 			     unsigned long scan_mask, s16 *data)
 {
-- 
2.20.1

