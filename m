Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E99C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA17C2467B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780564;
	bh=NKIKF7A5zn42BO7JUEY9uTMY+4ubMBgIJXguLfS5Lgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D6qZsTnG6StfT1bkuH6nM7hW7+/gM9iRIHCC9u6nV897hJPaGn5jmwQeiFJ99D2XZ
	 +/bfzjmBUWZNcHeW1LI8gw7Uyjhn1Bo7NP7T7+7iZW0Lbs0aF0x7yPDpO6xGGZs/jV
	 xLoLscguovR2jbymDTFTSZp3MWSoF5vIuY4UK79Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSSgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:36:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfLSSf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:35:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCDED24686;
        Thu, 19 Dec 2019 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780559;
        bh=NKIKF7A5zn42BO7JUEY9uTMY+4ubMBgIJXguLfS5Lgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ERfSHwxX7RFokTAzUEAWtubQg7fU/mfSR2tq1bmMmYGUZo5QcU65wvz9+XpDTAN38
         v27YeEAlPllGLQDn3vr6hYQaNtOpEC8V2sljuYnAjLSO9aAoPw+sE60wS3HBxUW2CN
         XOjZktiBtgY4rT2Y6LKlHxw7pLG5xRSyVnBAV3C0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 023/162] Staging: iio: adt7316: Fix i2c data reading, set the data field
Date:   Thu, 19 Dec 2019 19:32:11 +0100
Message-Id: <20191219183208.807901786@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreeya Patel <shreeya.patel23498@gmail.com>

[ Upstream commit 688cd642ba0c393344c802647848da5f0d925d0e ]

adt7316_i2c_read function nowhere sets the data field.
It is necessary to have an appropriate value for it.
Hence, assign the value stored in 'ret' variable to data field.

This is an ancient bug, and as no one seems to have noticed,
probably no sense in applying it to stable.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/iio/addac/adt7316-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 78fe0b5572802..fa1ef25d7a9a3 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -35,6 +35,8 @@ static int adt7316_i2c_read(void *client, u8 reg, u8 *data)
 		return ret;
 	}
 
+	*data = ret;
+
 	return 0;
 }
 
-- 
2.20.1



