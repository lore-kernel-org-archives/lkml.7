Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D1C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6695208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922996;
	bh=6VkPEARVCZ06+Ygd8cQ/SxPRE/BuGmGgIbuGgVSEmAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uIF8W5Km6EyW8jF9gAuljCuh7Wk7mVWtiylrvZv+MLXx4GmZzE9+s89uNw2UpNXzn
	 yRpFuaBsFSmfGt23HPlrzOlde913RcEEaRUm+HIGo1F5JaKyivjdj0M+AkRni0Exlg
	 EsN0HZmFh51cqpoChKtaD5E1kqOSboPybWOJsT5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbfFGP4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:56:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731074AbfFGPoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:44:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5A49212F5;
        Fri,  7 Jun 2019 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922265;
        bh=6VkPEARVCZ06+Ygd8cQ/SxPRE/BuGmGgIbuGgVSEmAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1MwDXrJZf0OjAeiwP0TEHevu5goLz6KG0N9SmzbUvGzIMjqXs95Hzdtxe4ORmVOwq
         jr1NwER+8Iy+MZXN34Y0KLJQQIC6nb1rH/sQAZtvWXsPvC8FqgYNbzGaj3gErPRwZ+
         qCHwohH07yGRcdcIkdJepRA6MxiEuMhM/MUoRIPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ruslan Babayev <ruslan@babayev.com>,
        xe-linux-external@cisco.com, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 25/73] iio: dac: ds4422/ds4424 fix chip verification
Date:   Fri,  7 Jun 2019 17:39:12 +0200
Message-Id: <20190607153851.825402618@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153848.669070800@linuxfoundation.org>
References: <20190607153848.669070800@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ruslan Babayev <ruslan@babayev.com>

commit 60f2208699ec08ff9fdf1f97639a661a92a18f1c upstream.

The ds4424_get_value function takes channel number as it's 3rd
argument and translates it internally into I2C address using
DS4424_DAC_ADDR macro. The caller ds4424_verify_chip was passing an
already translated I2C address as its last argument.

Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
Cc: xe-linux-external@cisco.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/dac/ds4424.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -166,7 +166,7 @@ static int ds4424_verify_chip(struct iio
 {
 	int ret, val;
 
-	ret = ds4424_get_value(indio_dev, &val, DS4424_DAC_ADDR(0));
+	ret = ds4424_get_value(indio_dev, &val, 0);
 	if (ret < 0)
 		dev_err(&indio_dev->dev,
 				"%s failed. ret: %d\n", __func__, ret);


