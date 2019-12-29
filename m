Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660F9C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E699222C4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642070;
	bh=rWtTJOOTWlKRqhr2xk6sT9QzZg7nCIyA6BXbksC7ANI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yAvi84XX6j91SJFcnSnqcVt6uxHlpY5zG1BTDK36kAa0c4QmzXIHTHhDAAR6FYpkN
	 FNxKuiF1ZYpswQ2NBs7b8UD4r2okTC5DS1ocBBxQdElkr0JtnaiMLCCQO35EeQwoXO
	 g0Qg/N32Ub/2U5yVEObvbtaQojFU03UxfBSi538A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbfL2Ry2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:54:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732679AbfL2RyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:54:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F3B6208C4;
        Sun, 29 Dec 2019 17:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642062;
        bh=rWtTJOOTWlKRqhr2xk6sT9QzZg7nCIyA6BXbksC7ANI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOzVkeKoHfARiH8FGaDysD2zYsyzDFScBCp4tCKJwyW6eP2YZpdBLFrWoQtY8RaZq
         2YP9KFrooTF8RAoS32A1k69JBDMRlvrmQWAwF0hJ8bw+w3+gMnq6DZ1+HFP5hHS06Q
         kzW9EDPA3FJ4qAtA389AjAUavkWc9Z7KTAPI/xHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 283/434] iio: cros_ec_baro: set info_mask_shared_by_all_available field
Date:   Sun, 29 Dec 2019 18:25:36 +0100
Message-Id: <20191229172720.746996081@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

[ Upstream commit e9a4cbcaaa391ef44d623d548ee715e77265030c ]

Field was already set for light/proximity and
accelerometer/gyroscope/magnetometer sensors.

Fixes: ae7b02ad2f32 ("iio: common: cros_ec_sensors: Expose cros_ec_sensors frequency range via iio sysfs")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/cros_ec_baro.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 2354302375de..52f53f3123b1 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -114,6 +114,7 @@ static int cros_ec_baro_write(struct iio_dev *indio_dev,
 static const struct iio_info cros_ec_baro_info = {
 	.read_raw = &cros_ec_baro_read,
 	.write_raw = &cros_ec_baro_write,
+	.read_avail = &cros_ec_sensors_core_read_avail,
 };
 
 static int cros_ec_baro_probe(struct platform_device *pdev)
@@ -149,6 +150,8 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_FREQUENCY);
+	channel->info_mask_shared_by_all_available =
+		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
 	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
 	channel->scan_type.shift = 0;
-- 
2.20.1



