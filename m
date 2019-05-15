Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07B5C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AB0206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919268;
	bh=7zpMCgIPMTHieUH/kBsQzSjOK6LEHevYPbzwmbMoFgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nvw1rUsuvk1LSKqz7fOkN0UvCXg5sxP3WjGRp9p0vI3d2bNYsx1WwnWj2XculptwI
	 qBWdq2pdkvJi7Lq122Vy2w/PipjiAy4TNWAVzY+SX6nt1qspH9vHcZ531RmRG4Nv49
	 uM6E4tN0uTQb+eRFP5U5DEQPqFhXlrXSUBe9Rryw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfEOLVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730104AbfEOLVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:21:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0403D206BF;
        Wed, 15 May 2019 11:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919264;
        bh=7zpMCgIPMTHieUH/kBsQzSjOK6LEHevYPbzwmbMoFgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYwMTz5U73Lf/3u0lJV/UqNR2I3jGqXp6VIY4n8EqR3pSOK7iiVmv673WBfDAleeQ
         6wn73qP/upOR5GK+99wmkU4geJ6+RK0M6+JMszXqu/NTm/RFOEDd8AwKGgg4VGEjGT
         GBBCl5mOsDyWpzJofPMvEY1CDUNucwvL74HQ/WaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 010/113] iio: adc: xilinx: fix potential use-after-free on probe
Date:   Wed, 15 May 2019 12:55:01 +0200
Message-Id: <20190515090654.287207267@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 862e4644fd2d7df8998edc65e0963ea2f567bde9 ]

If probe errors out after request_irq(), its error path
does not explicitly cancel the delayed work, which may
have been scheduled by the interrupt handler.

This means the delayed work may still be running when
the core frees the private structure (struct xadc).
This is a potential use-after-free.

Fix by inserting cancel_delayed_work_sync() in the probe
error path.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/xilinx-xadc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 1960694e80076..15e1a103f37da 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1290,6 +1290,7 @@ static int xadc_probe(struct platform_device *pdev)
 
 err_free_irq:
 	free_irq(xadc->irq, indio_dev);
+	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 err_clk_disable_unprepare:
 	clk_disable_unprepare(xadc->clk);
 err_free_samplerate_trigger:
-- 
2.20.1



