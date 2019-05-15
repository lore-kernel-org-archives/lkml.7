Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C9FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB9E20644
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918991;
	bh=Dtl3/xAorkDBpUk0AwV0EuPpkH3a0trEHTT9+iK5BsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JZjzSQbXAz+ZEG9wfxPFt9g/jS6zWoTdyhYRpIYAsvd+CrOgyY2eVLkubQ+eujCgQ
	 YMxIljLbv59gONJ7JudlyzbUfIskdNRIPum4RaFiUjFzcvDoaD4jiF1UHYZ0F5kOIn
	 Ps1cuOGn0zEtxm/+chFHx60hxMFXKWVb7BJHkHMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfEOLQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730496AbfEOLQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:16:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1104720644;
        Wed, 15 May 2019 11:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918987;
        bh=Dtl3/xAorkDBpUk0AwV0EuPpkH3a0trEHTT9+iK5BsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBPOp4nyfsT0npPXbBaJkz6TQQEKg074hfQu/HU3mIMSrhMBDuBNMDN27Iq9bb4X/
         g5SmSNB1+Ka8kqIBrq6SWrnB0Ss+K4eWXMfsw66G4Pxld9eCmoPRTSeOk6LoiFIXLI
         IZQ4fC6UCCOse/I0BOKn7kcV6QqzetpCEds7mHII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 007/115] iio: adc: xilinx: fix potential use-after-free on remove
Date:   Wed, 15 May 2019 12:54:47 +0200
Message-Id: <20190515090659.790296821@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 62039b6aef63380ba7a37c113bbaeee8a55c5342 ]

When cancel_delayed_work() returns, the delayed work may still
be running. This means that the core could potentially free
the private structure (struct xadc) while the delayed work
is still using it. This is a potential use-after-free.

Fix by calling cancel_delayed_work_sync(), which waits for
any residual work to finish before returning.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/xilinx-xadc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 4a60497a1f193..e89711b30ae8f 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1302,7 +1302,7 @@ static int xadc_remove(struct platform_device *pdev)
 	}
 	free_irq(irq, indio_dev);
 	clk_disable_unprepare(xadc->clk);
-	cancel_delayed_work(&xadc->zynq_unmask_work);
+	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 	kfree(xadc->data);
 	kfree(indio_dev->channels);
 
-- 
2.20.1



