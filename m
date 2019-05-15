Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109CEC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AB620644
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918564;
	bh=A4r0JM/UoYUkEF5U+B0mA9S0y6VS+13Qd7+8GKDJf2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B2YSKL56DPyKCgmu/e1OtKuXLvs9dC8yOAxA4Yu99PKFn7RCel1+SBistYmphy6V+
	 tdxjsNjsHH0yZbzi2fKvJ4zUdZep9Q2irLaWsbcQ/sTWqmGOIzxSJH83Tdfa4lKIwr
	 hN43xjzUc3D3Qz+vPl5gf4T1k+124gvdK5JljzAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfEOLJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbfEOLJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:09:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C11420644;
        Wed, 15 May 2019 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918561;
        bh=A4r0JM/UoYUkEF5U+B0mA9S0y6VS+13Qd7+8GKDJf2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/LvyIfxPPt9/0gSiRFle6W7SaWfiVI1mShR9dHYv44dub3I1/LXeVSgrsv+5ioLC
         KoHcF0Y0JN3cxZEl6qV8pX1dkZppH0Hna4DS7WwfzJTldcGtLGTM2mgFscJVKRiMJb
         Jma5pIVvwyN/pLeycTnhEDzH55pp2/E0UKV0OdaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 162/266] iio: adc: xilinx: fix potential use-after-free on remove
Date:   Wed, 15 May 2019 12:54:29 +0200
Message-Id: <20190515090728.397542330@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
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
index 475c5a74f2d1f..6398e86a272b8 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1299,7 +1299,7 @@ static int xadc_remove(struct platform_device *pdev)
 	}
 	free_irq(irq, indio_dev);
 	clk_disable_unprepare(xadc->clk);
-	cancel_delayed_work(&xadc->zynq_unmask_work);
+	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 	kfree(xadc->data);
 	kfree(indio_dev->channels);
 
-- 
2.20.1



