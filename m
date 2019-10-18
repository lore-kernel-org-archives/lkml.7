Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAEDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E9321852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437066;
	bh=Ehrg5XgGuNFqkKHJPJTzn6hfByC9BDvQYGD1d5MwaD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cvMeIUKkUdbtlZNaqnPW5oijwQ/ijq4X2RSm1Yu/JcjnaDDdrXNm4BJjQ3qMcQ3wP
	 NsE4opDMlfgysoEX1Jm1crSdmn1z0kD1hQoLxhDjSqw1K0s1KM0kwJPsqz8lxMC7hw
	 YMKYCwIiTt87LJdg+AsQB+A80wA8t2d2BVJYRcys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393544AbfJRWRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733086AbfJRWHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:07:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD5022245C;
        Fri, 18 Oct 2019 22:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436458;
        bh=Ehrg5XgGuNFqkKHJPJTzn6hfByC9BDvQYGD1d5MwaD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1DbuJ+k5MIE5ue3y8PvB15ydQURyqE9z88Tocum4LJG4QZx1nhAGmyzPjQdXS6Frr
         mwtWefK5Qa6W35Mp2it/TLt7Xcd3+t14WkZgQyq0fd3w3yZIZgsrnLKITFoa4cqpxQ
         50oo6+4On3lAJ7pOzArNIYVm7BNG0VzMOd7EpKb8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 090/100] iio: imu: adis16400: release allocated memory on failure
Date:   Fri, 18 Oct 2019 18:05:15 -0400
Message-Id: <20191018220525.9042-90-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit ab612b1daf415b62c58e130cb3d0f30b255a14d0 ]

In adis_update_scan_mode, if allocation for adis->buffer fails,
previously allocated adis->xfer needs to be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/adis_buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 76643c5571aa8..e59d0438de732 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -39,8 +39,11 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 		return -ENOMEM;
 
 	adis->buffer = kcalloc(indio_dev->scan_bytes, 2, GFP_KERNEL);
-	if (!adis->buffer)
+	if (!adis->buffer) {
+		kfree(adis->xfer);
+		adis->xfer = NULL;
 		return -ENOMEM;
+	}
 
 	rx = adis->buffer;
 	tx = rx + scan_count;
-- 
2.20.1

