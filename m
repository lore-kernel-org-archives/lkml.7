Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CF0CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B64320650
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905968;
	bh=Ehrg5XgGuNFqkKHJPJTzn6hfByC9BDvQYGD1d5MwaD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WrleUxAR7Z/avP93P7D7TYPApendJUuKW0olZmV2PgJoWHReNWKj1Bqzb0Rwi0nuF
	 I+KSFhSwkkV3Ud4XkKPA3J3D5W0KJpMltq+F+mOFw4nEDjoScdrkDLcSaz+3VpmVmY
	 NmoiUH1gIrgytcmgG7vZ6J/feefVgzHjQkjLmuf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbfKDWBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388596AbfKDWAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:00:51 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 974132084D;
        Mon,  4 Nov 2019 22:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904851;
        bh=Ehrg5XgGuNFqkKHJPJTzn6hfByC9BDvQYGD1d5MwaD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQ0xkyK+tCDAwBwuS7qz5GwktxycUtfbnpeVRikRX3oQ9AgbPCjCpfITj+VLo4esC
         ivzx97KmriZLNJWAJnfv7K+gYDRMpXiNTJRjQQMxoHRKMt/DDXHPwVIMa++pV9Qwrc
         Om9vSQcxOnu3MjLJbBfCqanh4cbraLQQU45dLJhs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 094/149] iio: imu: adis16400: release allocated memory on failure
Date:   Mon,  4 Nov 2019 22:44:47 +0100
Message-Id: <20191104212143.142234086@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



