Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BFCC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10B220718
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641417;
	bh=e7MPd5L+4UOxxlO77Qm/1g3QIjNW2/XxFjrUC3k2BUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LV3j94s4HcnTyXV1p9WOGpJXkRGheOag8YGZ40Pa/30DYO9XlDAtN0H/JHUuHKZ1/
	 H6fY+w2Mq0HJK6oFcIiu7WwB24Uw9XBYkIvBZI86Qc8e+Zcm0gos3kY0gdYNEWCMf+
	 rcOSd7XGyW/z4qDqCQGjllns3tu+vXwQ3fTdyZtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfL2Rng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:43:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730491AbfL2Rnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:43:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C28AE206A4;
        Sun, 29 Dec 2019 17:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641411;
        bh=e7MPd5L+4UOxxlO77Qm/1g3QIjNW2/XxFjrUC3k2BUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=icwi8ydOd8lB6zTIeb6mmlVMLTCSGJW1VGNeILA0zyuxeIx/fjdML+eaNj2/zcwuy
         LIRNS6h+ZYvhAZD8ja6O9F4+6L3JurENu13JveWW6Odjer3YRD8f9kgw1fiV6KZFFg
         Tcyfl4YcZEPeIrXw/LvxVnlcoBph9HZA+MCEo1zY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Merello <andrea.merello@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 053/434] iio: max31856: add missing of_node and parent references to iio_dev
Date:   Sun, 29 Dec 2019 18:21:46 +0100
Message-Id: <20191229172705.435036592@linuxfoundation.org>
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

From: Andrea Merello <andrea.merello@gmail.com>

[ Upstream commit 505ea3ada665c466d0064b11b6e611b7f995517d ]

Adding missing indio_dev->dev.of_node references so that, in case multiple
max31856 are present, users can get some clues to being able to distinguish
each of them. While at it, add also the missing parent reference.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/temperature/max31856.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index f184ba5601d9..73ed550e3fc9 100644
--- a/drivers/iio/temperature/max31856.c
+++ b/drivers/iio/temperature/max31856.c
@@ -284,6 +284,8 @@ static int max31856_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->info = &max31856_info;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = id->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = max31856_channels;
-- 
2.20.1



