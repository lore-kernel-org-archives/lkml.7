Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1374C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C8B2469A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186235;
	bh=/xgXLdIZmQ6E5ax/uAchCoFzvE9UX2jP7h3ZiscHh/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S+GzcUEZ32z3vjY6ydK5vN4UsugujtdepMJ19cIEN8pMR9Ptuzj2QT3m7+pMTnZr2
	 T7plHB6PidfH0VqzW5NkvvJ9eWSm9Q2rTyo5AmcshVVxcP40XSeoJXQq/Muqb7eQP7
	 zstVxwrbVjVfpAIqexKj+GufPFQAPPEnnIBu2GDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfE3DRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbfE3DNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:13:50 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B607124558;
        Thu, 30 May 2019 03:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186029;
        bh=/xgXLdIZmQ6E5ax/uAchCoFzvE9UX2jP7h3ZiscHh/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z00pKlAjaGgIP9GIzxHIOxs7ilDA5/q/C1grZ16DF412uBz9s9Mu0c3PPlv6TS5qy
         tiCsxTKHdrT39EnMSVkTE7XNrNluqzxG7PBucDxp5Ny3kxEmNQXHIGJhTG87PA+Dov
         4xQ6fVJ5FJA90seJqrhUCr02ZOzfMYCo9Q34aL2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 106/346] slimbus: fix a potential NULL pointer dereference in of_qcom_slim_ngd_register
Date:   Wed, 29 May 2019 20:02:59 -0700
Message-Id: <20190530030546.488815341@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 06d5d6b7f9948a89543e1160ef852d57892c750d ]

In case platform_device_alloc fails, the fix returns an error
code to avoid the NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 71f094c9ec684..f3585777324cf 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1342,6 +1342,10 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			return -ENOMEM;
 
 		ngd->pdev = platform_device_alloc(QCOM_SLIM_NGD_DRV_NAME, id);
+		if (!ngd->pdev) {
+			kfree(ngd);
+			return -ENOMEM;
+		}
 		ngd->id = id;
 		ngd->pdev->dev.parent = parent;
 		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
-- 
2.20.1



