Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D88C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D41F2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013480;
	bh=Uu84qpMnEvTek01jYaB5sD7m/AD+QkDsg73IgbTZqkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K42P5J+J1rRBXwEP7WM0CHbdaxwrblioAscNeVOhxDv1ZfSt/GzFPzv12oHOvgJRc
	 CTho+/5xQeLGR5jXinXEDQQYm+HdWip9QQmQWF80NvE5Fj8PhjuJOcReev6wyOub8F
	 rJes8WEEYnsLUNuSBS7JBdqsUoBrUZfZ8ibOX0Qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfLJVJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbfLJVJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:09:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39F7E246A2;
        Tue, 10 Dec 2019 21:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012170;
        bh=Uu84qpMnEvTek01jYaB5sD7m/AD+QkDsg73IgbTZqkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=11qm0ncgsqu23jJFRvuEqlC0ws4zA0Z6/B2X4w9CeCU2bbK2wr25yp+cdxEpWqhON
         QYJo/DbyeU4OQ4JZsqTVWGu/Kv9CNTWg80/cjysNgFnUD6yidHWidl498AUv4KRaFF
         7xow5Hbq74eW71JphrqwENmUhRgaXWklx2hMIAS4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.4 129/350] staging: iio: ad9834: add a check for devm_clk_get
Date:   Tue, 10 Dec 2019 16:03:54 -0500
Message-Id: <20191210210735.9077-90-sashal@kernel.org>
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

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit a96de139301385e5992768c0f60240ddfbb33325 ]

ad9834_probe misses a check for devm_clk_get and may cause problems.
Add a check like what ad9832 does to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/iio/frequency/ad9834.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 038d6732c3fdb..23026978a5a5f 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -417,6 +417,10 @@ static int ad9834_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
 	st->mclk = devm_clk_get(&spi->dev, NULL);
+	if (IS_ERR(st->mclk)) {
+		ret = PTR_ERR(st->mclk);
+		goto error_disable_reg;
+	}
 
 	ret = clk_prepare_enable(st->mclk);
 	if (ret) {
-- 
2.20.1

