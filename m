Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919B5C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE39222A4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142008;
	bh=yJZQW5BnUSHbWHbhWh0m2DBiRAjsbY+dArtTZdzFv70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QUNO1ROq7Az9ymE4q5UgzB4FGAvkSW/FLq2pO4eZkbZQuFyn5tr2gZsSRtoXd2Fu4
	 OXwSjoPyJU47awfV/GC07EC3gzhPlm8QfzDSsvYIB0nVzc7P8dCK0G5N/UKKgezNqk
	 riI1Gj+BMVwzd9eWYQpOWxnEeX9nPcxfJEr9MMNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfKSFkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:40:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbfKSFkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:40:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E336B21783;
        Tue, 19 Nov 2019 05:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142003;
        bh=yJZQW5BnUSHbWHbhWh0m2DBiRAjsbY+dArtTZdzFv70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6NHtA9EM6Tq1Kd9H3j5dBq9JpDk9F3eBNat9aKJ4CeKTS9pLD7M12RRLQJ3Trp4Q
         fDOYgaQlkE60wxNOdaxs7WYUhCnmNh8sMTTK+U/72y8gk14R4wAGjzw70LCpdffm5p
         uWmmJlH5BDahkjCUQg4W8J3mswTjo3HE/tIDcjmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 352/422] slimbus: ngd: register ngd driver only once.
Date:   Tue, 19 Nov 2019 06:19:09 +0100
Message-Id: <20191119051421.826714842@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



