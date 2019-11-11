Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169D8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2DC20659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573499303;
	bh=lqibCGxFpPmW4bH98IfS8pzBPh6v1U4+L0cwszJn9lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wgPIKEXb5s/qQYsvns8O3SlZCDl2kmNvptSdPhhd341cTVOjI6JsIyipDj5Hc+59B
	 dXdl3QBzebWmNfvT4UNfSM/Z6U4ecDwG9uuBJSFRljHm1qgFvGaLavjTH6llonV8Kr
	 Ax2ag4sO+DcvjJdmoqZOVlD4eToZd7CoUJObCDfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfKKSgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:36:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbfKKSf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:35:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E70E222C2;
        Mon, 11 Nov 2019 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497357;
        bh=lqibCGxFpPmW4bH98IfS8pzBPh6v1U4+L0cwszJn9lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPjZE487cb/xUMawgMO7fXdRjrMcr1mHQcskH+SiTTWbFpaZ8u2jybV/WubSgJC1F
         gq3tJg7q4Bj5veRFws0gi/QWSDVy4DyEhdiyzfD8zGqnMbwt0ureawfSRyutBW4dem
         JP+V1PKUrNoUO7SRKy01RHrVdD2oZZggDDl7cjDg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 026/105] iio: adc: stm32-adc: fix stopping dma
Date:   Mon, 11 Nov 2019 19:27:56 +0100
Message-Id: <20191111181437.672482246@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181421.390326245@linuxfoundation.org>
References: <20191111181421.390326245@linuxfoundation.org>
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
@@ -1343,7 +1343,7 @@ static int stm32_adc_dma_start(struct ii
 	cookie = dmaengine_submit(desc);
 	ret = dma_submit_error(cookie);
 	if (ret) {
-		dmaengine_terminate_all(adc->dma_chan);
+		dmaengine_terminate_sync(adc->dma_chan);
 		return ret;
 	}
 
@@ -1416,7 +1416,7 @@ static int stm32_adc_buffer_predisable(s
 		dev_err(&indio_dev->dev, "predisable failed\n");
 
 	if (adc->dma_chan)
-		dmaengine_terminate_all(adc->dma_chan);
+		dmaengine_terminate_sync(adc->dma_chan);
 
 	if (stm32_adc_set_trig(indio_dev, NULL))
 		dev_err(&indio_dev->dev, "Can't clear trigger\n");


