Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0677C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE922146E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922587;
	bh=PrD6rkDeS7M9HCGKUpTzQI8+wV+CQLqM8IBUuPREUzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IUMfHsZMisi49tIeIqS+74zJASo368O3vsuh3a5kNxLGG0odj0W4tXrnOKyBc/g7E
	 KVmKTTNI3GhPtTxfdCxbA0Sb+4Tz3d0+0cJmjvPrgQ+r4n3OV8WjVxZ2qsq3gZ+K19
	 sa42p/hli9SILyNEcQhGx/iK/hmrztlUpHB5DQ6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbfFGPtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732000AbfFGPtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:49:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 744FA20657;
        Fri,  7 Jun 2019 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922584;
        bh=PrD6rkDeS7M9HCGKUpTzQI8+wV+CQLqM8IBUuPREUzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AA44OzIt0DCKcd22X5jqk4NUqY+7Ls+cZKgP5ZlO/w4rC7Sk9p1J8/H7CRtoeezLT
         3A/jH/VNvfbhj0uB5AktvNNjUC/uvq/IdTlM5D11ZhiOQWdRNXN1zN0p0Z4ccv4qLW
         W1KtxyXnv6EqxGx81y96j+TRSUkQ1JZjurKnIpWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Dan Murphy <dmurphy@ti.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.1 29/85] iio: adc: ads124: avoid buffer overflow
Date:   Fri,  7 Jun 2019 17:39:14 +0200
Message-Id: <20190607153852.884905919@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
References: <20190607153849.101321647@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Stehlé <vincent.stehle@laposte.net>

commit 0db8aa49a97e7f40852a64fd35abcc1292a7c365 upstream.

When initializing the priv->data array starting from index 1, there is one
less element to consider than when initializing the full array.

Fixes: e717f8c6dfec8f76 ("iio: adc: Add the TI ads124s08 ADC code")
Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Reviewed-by: Dan Murphy <dmurphy@ti.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/ti-ads124s08.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -202,7 +202,7 @@ static int ads124s_read(struct iio_dev *
 	};
 
 	priv->data[0] = ADS124S08_CMD_RDATA;
-	memset(&priv->data[1], ADS124S08_CMD_NOP, sizeof(priv->data));
+	memset(&priv->data[1], ADS124S08_CMD_NOP, sizeof(priv->data) - 1);
 
 	ret = spi_sync_transfer(priv->spi, t, ARRAY_SIZE(t));
 	if (ret < 0)


