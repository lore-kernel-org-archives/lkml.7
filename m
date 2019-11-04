Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDEECA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046AB21929
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905238;
	bh=ygm/bLbEKE+ydYb6n27zhUbjztKPi1bevmfl1GTnNCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0GREyX3xvg+Ga/AYss2RVfpIt5fWQT2pcddS8I17AfIVTGkXjPrBtmjTa1aW1QBtn
	 LtcLeksD08C6sYA01UsBAiKccKwbpSYrA/UH1Y8HhY0PYG8NgHKS6wxnH+ubdsz0Bs
	 lpAQQpf99IieBv/49DSgZ1lY7apsAagD/JxpJCW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbfKDWHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:07:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390074AbfKDWHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:07:07 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9E21214D8;
        Mon,  4 Nov 2019 22:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905226;
        bh=ygm/bLbEKE+ydYb6n27zhUbjztKPi1bevmfl1GTnNCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnGHS6baAJ/ctLIwjCrPRVuQjHBHc4JcQGbGYuLcCJaHh5Y6q+yxRHOzP+tBLKTYp
         2aPgFeabzapzRYir//Rd0FVwsyERaXq/S6o0vklCRl8euv7HQPAIUi6mSN9DSgFz/M
         VbnS0qYogBRPhg8BNdVUyMjkpRmWuPmGz3lrVyLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 072/163] iio: imu: adis16400: fix memory leak
Date:   Mon,  4 Nov 2019 22:44:22 +0100
Message-Id: <20191104212145.097944480@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 9c0530e898f384c5d279bfcebd8bb17af1105873 ]

In adis_update_scan_mode_burst, if adis->buffer allocation fails release
the adis->xfer.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/adis_buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index f446ff4978091..4998a89d083d5 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -35,8 +35,11 @@ static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
 		return -ENOMEM;
 
 	adis->buffer = kzalloc(burst_length + sizeof(u16), GFP_KERNEL);
-	if (!adis->buffer)
+	if (!adis->buffer) {
+		kfree(adis->xfer);
+		adis->xfer = NULL;
 		return -ENOMEM;
+	}
 
 	tx = adis->buffer + burst_length;
 	tx[0] = ADIS_READ_REG(adis->burst->reg_cmd);
-- 
2.20.1



