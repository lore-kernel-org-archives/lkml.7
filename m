Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E5DC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B29246A8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012148;
	bh=PX5vOMAe3WelCDyOsnCu/L2YTS9HO4Ui6SNmnp+WoH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VPolIDjeBfD7LYMyFUv68O20TccgGWganNSiKP+jTSinQnCOBwsuftDmEvCYyCeDz
	 ZpLPlBOF2VpnsertKtbfbsKwV+9hv5sDh29oplCR3S+Df3T7v8+nQ9b0WVL3ir0J5+
	 XSzYdCvsg3JZrQi+fyGsI6TM7tU8n/jhjJbd2YCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfLJVJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:09:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbfLJVJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:09:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10086246A7;
        Tue, 10 Dec 2019 21:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012139;
        bh=PX5vOMAe3WelCDyOsnCu/L2YTS9HO4Ui6SNmnp+WoH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/QIvS2BK0N9r/embhaJ/eJbZxF1mLkDhIQ3fSsyhWtIckoV892rIQYKDaAKXBgCe
         z+ZdNMJ23e9lIGTBKDKtCfsf0MxidnWDjywOYr/EzNyRBX5jBGyMawlkaTcICB/3S8
         GNaRZyMGzeYrmt+9p0L8UCoiAyKK1wJQO5P6riN0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 105/350] iio: chemical: atlas-ph-sensor: fix iio_triggered_buffer_predisable() position
Date:   Tue, 10 Dec 2019 16:03:30 -0500
Message-Id: <20191210210735.9077-66-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

[ Upstream commit 0c8a6e72f3c04bfe92a64e5e0791bfe006aabe08 ]

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
the poll functions.

The iio_triggered_buffer_predisable() should be called last, to detach the
poll func after the devices has been suspended.

The position of iio_triggered_buffer_postenable() is correct.

Note this is not stable material. It's a fix in the logical
model rather fixing an actual bug.  These are being tidied up
throughout the subsystem to allow more substantial rework that
was blocked by variations in how things were done.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/chemical/atlas-ph-sensor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index 3a20cb5d9bffc..6c175eb1c7a7f 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -323,16 +323,16 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
 	struct atlas_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_triggered_buffer_predisable(indio_dev);
+	ret = atlas_set_interrupt(data, false);
 	if (ret)
 		return ret;
 
-	ret = atlas_set_interrupt(data, false);
+	pm_runtime_mark_last_busy(&data->client->dev);
+	ret = pm_runtime_put_autosuspend(&data->client->dev);
 	if (ret)
 		return ret;
 
-	pm_runtime_mark_last_busy(&data->client->dev);
-	return pm_runtime_put_autosuspend(&data->client->dev);
+	return iio_triggered_buffer_predisable(indio_dev);
 }
 
 static const struct iio_trigger_ops atlas_interrupt_trigger_ops = {
-- 
2.20.1

