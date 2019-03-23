Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81921C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC5A21841
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfCWR2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:28:31 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:41839 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfCWR2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:28:30 -0400
Received: from pc.localdomain (unknown [91.192.165.7])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7334D200008;
        Sat, 23 Mar 2019 17:28:27 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 2/4] iio: inkern: Convert iio_read_avail_channel_raw into a wrapper
Date:   Sat, 23 Mar 2019 18:28:07 +0100
Message-Id: <20190323172809.14407-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190323172809.14407-1-contact@artur-rojek.eu>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert "iio_read_avail_channel_raw" over to a wrapper around
"iio_read_avail_channel_attribute".

With the introduction of "iio_read_avail_channel_attribute",
the necessity of having a separate call to read raw channel values
became redundant.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---

Changes:

v2: new patch

 drivers/iio/inkern.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index f19dbde3c945..4a5eff3f18bc 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -759,16 +759,8 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
 	int ret;
 	int type;
 
-	mutex_lock(&chan->indio_dev->info_exist_lock);
-	if (!chan->indio_dev->info) {
-		ret = -ENODEV;
-		goto err_unlock;
-	}
-
-	ret = iio_channel_read_avail(chan,
-				     vals, &type, length, IIO_CHAN_INFO_RAW);
-err_unlock:
-	mutex_unlock(&chan->indio_dev->info_exist_lock);
+	ret = iio_read_avail_channel_attribute(chan, vals, &type, length,
+					 IIO_CHAN_INFO_RAW);
 
 	if (ret >= 0 && type != IIO_VAL_INT)
 		/* raw values are assumed to be IIO_VAL_INT */
-- 
2.21.0

