Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40476CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068B120872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437474;
	bh=VIrO3j77dxxMsFMeGPCcjYVY6hTOJ/CDZb3WA56IXZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h4cUdU5C2stJQBhVnOYmT5TJcBLdkoa2hiv4h3BXtCyWxNwOTL6ANUR2reRrg8dFw
	 IroXrfWMKGR6nAcKd67n4n9CQEwgxuW0SeJAeuINCqtsDdcQdr39qIpBzcNQgYs0cj
	 5qHgFYrSb6idK0XfTfkN+o469BkJ4nmoa8C+b20M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394474AbfJRWYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbfJRWFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:05:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3899E22466;
        Fri, 18 Oct 2019 22:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436300;
        bh=VIrO3j77dxxMsFMeGPCcjYVY6hTOJ/CDZb3WA56IXZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GUjnCJ3U41uFKa0/A6Lmm61xxnchByZ5Hojn6worYiOkbWUKiQjIWUDyR5h+7cw4E
         e269FOhQApEtjYFNzb/2FyW23zmHKI+bGHzzXIYI9BQIlpff7AKa3gQn6O5Gs8maau
         el2E0MZzb64in1s8lqvFQuewXZA3vIoqtKmcA/kw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Popa <stefan.popa@analog.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 71/89] iio: accel: adxl372: Fix push to buffers lost samples
Date:   Fri, 18 Oct 2019 18:03:06 -0400
Message-Id: <20191018220324.8165-71-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

[ Upstream commit 62df81b74393079debf04961c48cb22268fc5fab ]

One in two sample sets was lost by multiplying fifo_set_size with
sizeof(u16). Also, the double number of available samples were pushed to
the iio buffers.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Fixes: f4f55ce38e5f ("iio:adxl372: Add FIFO and interrupts support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/accel/adxl372.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 863fe61a371fb..fbad4b45fe42d 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -553,8 +553,7 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 			goto err;
 
 		/* Each sample is 2 bytes */
-		for (i = 0; i < fifo_entries * sizeof(u16);
-		     i += st->fifo_set_size * sizeof(u16))
+		for (i = 0; i < fifo_entries; i += st->fifo_set_size)
 			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
 	}
 err:
-- 
2.20.1

