Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B870CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45D82246F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436657;
	bh=EZ38xqHL1iO39dpknD7nBw6uImA2WQGPxHKul5BNyY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=li750FsMFlhBsfyXCGaEn+a65CNevfPU3uqHgHVqpc0dQl3N9XzTpKAZNIE1sCFLi
	 nJR3wZ7lncKK/N6LbW/M+J0YJXA/vrJPPKSY/EuJjIp+yijSIaGQPL6ZGrRVEzo8BH
	 3vxXq5BApBqmmj24UqRYK6Kf6w3mjfN0Z3nv2/Jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390858AbfJRWKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390334AbfJRWKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602B82247D;
        Fri, 18 Oct 2019 22:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436634;
        bh=EZ38xqHL1iO39dpknD7nBw6uImA2WQGPxHKul5BNyY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2rnSt37whdOJ2Gciqa1WrvvhJXae+0+ss/pU0Y1GBtXjNDUvda1wLLEOUPTn/t/h8
         vd9S3Y798bqvEYsg2sEVzml6sIuYtyCpUs2kcyqG9t+wURQrZeZXiNF6hoX3TKkIYg
         7vo7uNz9XkWlTKMZc6/I2SSuj+6NU0lvrO1Bm8B0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Frey <dpfrey@gmail.com>,
        Andreas Dannenberg <dannenberg@ti.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 17/21] iio: light: opt3001: fix mutex unlock race
Date:   Fri, 18 Oct 2019 18:10:03 -0400
Message-Id: <20191018221007.10851-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018221007.10851-1-sashal@kernel.org>
References: <20191018221007.10851-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Frey <dpfrey@gmail.com>

[ Upstream commit 82f3015635249a8c8c45bac303fd84905066f04f ]

When an end-of-conversion interrupt is received after performing a
single-shot reading of the light sensor, the driver was waking up the
result ready queue before checking opt->ok_to_ignore_lock to determine
if it should unlock the mutex. The problem occurred in the case where
the other thread woke up and changed the value of opt->ok_to_ignore_lock
to false prior to the interrupt thread performing its read of the
variable. In this case, the mutex would be unlocked twice.

Signed-off-by: David Frey <dpfrey@gmail.com>
Reviewed-by: Andreas Dannenberg <dannenberg@ti.com>
Fixes: 94a9b7b1809f ("iio: light: add support for TI's opt3001 light sensor")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/opt3001.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 01e111e72d4bb..eecdc50ed282f 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -646,6 +646,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	struct iio_dev *iio = _iio;
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
+	bool wake_result_ready_queue = false;
 
 	if (!opt->ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
@@ -680,13 +681,16 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 		}
 		opt->result = ret;
 		opt->result_ready = true;
-		wake_up(&opt->result_ready_queue);
+		wake_result_ready_queue = true;
 	}
 
 out:
 	if (!opt->ok_to_ignore_lock)
 		mutex_unlock(&opt->lock);
 
+	if (wake_result_ready_queue)
+		wake_up(&opt->result_ready_queue);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.20.1

