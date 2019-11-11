Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55248C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251F12067B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497714;
	bh=Bp+BCo3Rwgul7jvVV+Mz35jKgTHEIpcqUo9xo1puIpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F61Y/umgOObRni3IAWb4frJyTTgVPZVImwYTOYc1JuLzZcfMwJ1a25fqfyrE6nf0z
	 +rtnCxkH990a14NZH5ynES4VCd+uoHqKF6f/1xE0ReHgZ31KvNrfig5sNTOFFdP1Q5
	 TnXglZVa82aKNcfPFDR4c+ePXvWJQBkUKitLlWWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfKKSlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:41:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:32942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728725AbfKKSlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:41:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D5B420674;
        Mon, 11 Nov 2019 18:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497709;
        bh=Bp+BCo3Rwgul7jvVV+Mz35jKgTHEIpcqUo9xo1puIpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q8CJ9Oy/aIUUSg4IxwgEHq8nXBbyKs6F0Hq98W2YuXuh5QEZ2W4wz8lz0VI5GzqoQ
         No0Kp8FQ63WGfLD+/uh77X2QkqozDUsDXmJLoNWMrnXCRda24TUNQ/x9/6sIpDt46U
         C/NoyMxEgLoX+epWDIeeIF3Lq4vnqNpKTQvXhilE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 033/125] iio: adc: stm32-adc: fix stopping dma
Date:   Mon, 11 Nov 2019 19:27:52 +0100
Message-Id: <20191111181445.074033994@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

commit e6afcf6c598d6f3a0c9c408bfeddb3f5730608b0 upstream.

There maybe a race when using dmaengine_terminate_all(). The predisable
routine may call iio_triggered_buffer_predisable() prior to a pending DMA
callback.
Adopt dmaengine_terminate_sync() to ensure there's no pending DMA request
before calling iio_triggered_buffer_predisable().

Fixes: 2763ea0585c9 ("iio: adc: stm32: add optional dma support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/stm32-adc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1340,7 +1340,7 @@ static int stm32_adc_dma_start(struct ii
 	cookie = dmaengine_submit(desc);
 	ret = dma_submit_error(cookie);
 	if (ret) {
-		dmaengine_terminate_all(adc->dma_chan);
+		dmaengine_terminate_sync(adc->dma_chan);
 		return ret;
 	}
 
@@ -1413,7 +1413,7 @@ static int stm32_adc_buffer_predisable(s
 		dev_err(&indio_dev->dev, "predisable failed\n");
 
 	if (adc->dma_chan)
-		dmaengine_terminate_all(adc->dma_chan);
+		dmaengine_terminate_sync(adc->dma_chan);
 
 	if (stm32_adc_set_trig(indio_dev, NULL))
 		dev_err(&indio_dev->dev, "Can't clear trigger\n");


