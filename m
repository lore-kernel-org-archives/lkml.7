Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751D1C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CE8208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355458;
	bh=yJZQW5BnUSHbWHbhWh0m2DBiRAjsbY+dArtTZdzFv70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jxh3MZSTq+RuqxaAmudk3XAz01QFppcmUiheKqsae+pCoY4uX4JOtxMANSbPnFTDk
	 N9DizDhPlpFkzgxTBsYjoCH2pmytbkcfN+MAfH5BTIa0AU2r55gzVzqsyEy6ObvWNu
	 r08M4TRjb3MDY/vKhD3gTi0ZxdQO5Z2RWOrBP4Ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfKJCnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:43:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfKJCnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:43:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59B9521D7B;
        Sun, 10 Nov 2019 02:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353823;
        bh=yJZQW5BnUSHbWHbhWh0m2DBiRAjsbY+dArtTZdzFv70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjdNejalTs//1VKK3PBgV4ZXWue8z+CD9LLq73PUieGVoWo5K6gzybYIMaJVstzoo
         T8jZoU5FepB4IgRg3r9K4a2r2zco5aCwSs0Faw5pntxQMuRgM7DE6ttQD5U8j1OvVt
         vzkToVqdFNrq1XpbmgxoWdwfmExWIk7Fy0j02dhM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 118/191] slimbus: ngd: register ngd driver only once.
Date:   Sat,  9 Nov 2019 21:39:00 -0500
Message-Id: <20191110024013.29782-118-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 1830dad34c070161fda2ff1db77b39ffa78aa380 ]

Move ngd platform driver out of loop so that it registers only once.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index f63d1b8a09335..a9abde2f4088b 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1346,7 +1346,6 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		ngd->base = ctrl->base + ngd->id * data->offset +
 					(ngd->id - 1) * data->size;
 		ctrl->ngd = ngd;
-		platform_driver_register(&qcom_slim_ngd_driver);
 
 		return 0;
 	}
@@ -1445,6 +1444,7 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	init_completion(&ctrl->reconf);
 	init_completion(&ctrl->qmi.qmi_comp);
 
+	platform_driver_register(&qcom_slim_ngd_driver);
 	return of_qcom_slim_ngd_register(dev, ctrl);
 }
 
-- 
2.20.1

