Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6CAC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0EA206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519817;
	bh=uvmuwkss42ULQYKZk7SlI3MEFf+rMhPfU9Iz/mewulQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yTrXOD3tBuXz6/LwHVo8bdnD8BTXwGjDRP44WvIO0t3LV1Bjw0wxduqGNpnha839b
	 SFko3sjMeygscUOdK2Lv8ih8phdqkHqkekzl+im5hTpFKPcIXyJ9y/PbSmKASOgN3K
	 RnJbmOGhP2AIPj7gbePao9rsDYqP6Dz/enEj0zDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbfLPSKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730577AbfLPSKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:10:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B349C206EC;
        Mon, 16 Dec 2019 18:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519813;
        bh=uvmuwkss42ULQYKZk7SlI3MEFf+rMhPfU9Iz/mewulQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nkoARiuPs9FubjzvWzXlQqVN1z5z7hh6mTKD/NXlOgc1oK7+5Wr6PmLDB+rGBuEcZ
         SzWrDxoVKi5e3t7gyzMndkxDesEXWNtD2UzAVtggH3B7U+R0zgX0wz3ZxrJJ+92Ve8
         CZLdx7FqD+ED1obom67tgWQfcR+wGhdJ1eZkuE9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.3 028/180] iio: adis16480: Add debugfs_reg_access entry
Date:   Mon, 16 Dec 2019 18:47:48 +0100
Message-Id: <20191216174812.511806453@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nuno Sá <nuno.sa@analog.com>

commit 4c35b7a51e2f291471f7221d112c6a45c63e83bc upstream.

The driver is defining debugfs entries by calling
`adis16480_debugfs_init()`. However, those entries are attached to the
iio_dev debugfs entry which won't exist if no debugfs_reg_access
callback is provided.

Fixes: 2f3abe6cbb6c ("iio:imu: Add support for the ADIS16480 and similar IMUs")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/imu/adis16480.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -919,6 +919,7 @@ static const struct iio_info adis16480_i
 	.read_raw = &adis16480_read_raw,
 	.write_raw = &adis16480_write_raw,
 	.update_scan_mode = adis_update_scan_mode,
+	.debugfs_reg_access = adis_debugfs_reg_access,
 };
 
 static int adis16480_stop_device(struct iio_dev *indio_dev)


