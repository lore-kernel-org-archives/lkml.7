Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7BDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754A420856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558554869;
	bh=c6VsHFKQRXSatgbuDQAcJBnPN60zHUQiCX7glMLjcs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YNaoE22K9+eeGaHiTBkbgZgZzliuVJaOEuTpxX++9qqYHpKrTgiTvHF/IYumcqmTe
	 YLjwtO9fnget0mq1lApPuG/L6pyiRI2vehMCrA9vnuENHTTJXnz+IYWCmavWkDzXSu
	 8LxgXBhFtuy2odOoHNHh/Qo9YBSBXn8IXUrFG24Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbfEVTy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731681AbfEVTZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:25:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA684206BA;
        Wed, 22 May 2019 19:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553139;
        bh=c6VsHFKQRXSatgbuDQAcJBnPN60zHUQiCX7glMLjcs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AR0YrH+MrxTDneGOT2U+oOKllb3XLpvR/wf2NXux2OcLqPyc5k1FTRmxt7K8Y349N
         lL9RpDC/kI78nwst0LmnoXFsSefmc9qq66+T2MD3dieCppisCjMHa8lyAhz+7UNsSK
         QrQ+jYJDJCZ3DRtVm0VzCe+l12xE+I8+rtk+ya1M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 069/317] slimbus: fix a potential NULL pointer dereference in of_qcom_slim_ngd_register
Date:   Wed, 22 May 2019 15:19:30 -0400
Message-Id: <20190522192338.23715-69-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192338.23715-1-sashal@kernel.org>
References: <20190522192338.23715-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

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

