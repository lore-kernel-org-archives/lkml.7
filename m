Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CE8ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5111620872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263505;
	bh=nTrYc33Z6rbm4rrhHQSk/OlClv195qGJD9ncC4VWwVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OOxQ/j2nn8/kCzURA0dsX947BH1jDri2hGLXOKM2K2hPJux4/D6c96qt4a1mmP5Oe
	 7pDnzXM8BWS60LgyjsO0e8Zjq2Ik6Fi9UnK2u3fD4u85HNzsNLn1+KLl3MbZqmM+8r
	 fp/jMxjdvuInpjstdPPxEbU1anklexQPw8FzPpLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406888AbfJPWE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438327AbfJPV64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:56 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30AD921A49;
        Wed, 16 Oct 2019 21:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263136;
        bh=nTrYc33Z6rbm4rrhHQSk/OlClv195qGJD9ncC4VWwVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdOQj9YGFVJVVUK/wu5E4q1oG5z/IbKMxGw6wE5WY+Ds21udg9sCymaM9ksawk0/d
         3z5aPcAiR5RknCRcWpNt0JNnCdAAse+xnsgtqj57CSJwWj+xWw2CdwwXkdq0VkUy4l
         nR4IHEpuiGG8kJs6C73JI2PQ4IXUlgtc9ggv+dmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.3 060/112] iio: accel: adxl372: Fix push to buffers lost samples
Date:   Wed, 16 Oct 2019 14:50:52 -0700
Message-Id: <20191016214900.370082714@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

commit 62df81b74393079debf04961c48cb22268fc5fab upstream.

One in two sample sets was lost by multiplying fifo_set_size with
sizeof(u16). Also, the double number of available samples were pushed to
the iio buffers.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Fixes: f4f55ce38e5f ("iio:adxl372: Add FIFO and interrupts support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/accel/adxl372.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -553,8 +553,7 @@ static irqreturn_t adxl372_trigger_handl
 			goto err;
 
 		/* Each sample is 2 bytes */
-		for (i = 0; i < fifo_entries * sizeof(u16);
-		     i += st->fifo_set_size * sizeof(u16))
+		for (i = 0; i < fifo_entries; i += st->fifo_set_size)
 			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
 	}
 err:


