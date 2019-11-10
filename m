Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5127C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35E121848
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355475;
	bh=oNMpK4uCT6FqDAbQaOrbyYV5qSgpW9C8QAqC4iyX9LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ie3bSMqJML5s7H1fkTrF2EWlJnVRz+TRGMUW1ThbXQ5cnDq2qVkxAFWKwlRxGsZuO
	 HS9oaz6f2FKabU3sr5d6/Sf670vExXe6ksryQsNicSpBLS5CPrF3YUpqamFroQvYx4
	 ZY2kqTah2T2CEdXIdJnX/tNP/5J3uFkcQHjl5K8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfKJDLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:11:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:42364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbfKJCnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:43:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA1D21655;
        Sun, 10 Nov 2019 02:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353825;
        bh=oNMpK4uCT6FqDAbQaOrbyYV5qSgpW9C8QAqC4iyX9LQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iv5Nk4rY8fJMw8Uwn8HGWM7D4oUR3ij6QC1TPawJPI+HsIMn7KUGcfb+O0+554Qwq
         fO6OtUBnbyTi4WtJ0sZpQW35B2AUUgF3kFEWkoWJndkcorNTYgcKfAMZojWSMS3qSL
         PbVtVCU3lg8xfOpI6l5keJK281cTgVOpbCUUBxkQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 120/191] silmbus: ngd: register controller after power up.
Date:   Sat,  9 Nov 2019 21:39:02 -0500
Message-Id: <20191110024013.29782-120-sashal@kernel.org>
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

[ Upstream commit 94fe5f2b45c4108885e4b71f6b181068632ec904 ]

Register slimbus controller only after finishing powerup sequnce so that we
do not endup in situation where core starts sending transactions before
the controller is ready.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index e587be9064e74..d72f8eed2e8b7 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1234,8 +1234,17 @@ static int qcom_slim_ngd_enable(struct qcom_slim_ngd_ctrl *ctrl, bool enable)
 			pm_runtime_resume(ctrl->dev);
 		pm_runtime_mark_last_busy(ctrl->dev);
 		pm_runtime_put(ctrl->dev);
+
+		ret = slim_register_controller(&ctrl->ctrl);
+		if (ret) {
+			dev_err(ctrl->dev, "error adding slim controller\n");
+			return ret;
+		}
+
+		dev_info(ctrl->dev, "SLIM controller Registered\n");
 	} else {
 		qcom_slim_qmi_exit(ctrl);
+		slim_unregister_controller(&ctrl->ctrl);
 	}
 
 	return 0;
@@ -1360,11 +1369,6 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	int ret;
 
 	ctrl->ctrl.dev = dev;
-	ret = slim_register_controller(&ctrl->ctrl);
-	if (ret) {
-		dev_err(dev, "error adding slim controller\n");
-		return ret;
-	}
 
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, QCOM_SLIM_NGD_AUTOSUSPEND);
@@ -1374,7 +1378,7 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
 	if (ret) {
 		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
-		goto err;
+		return ret;
 	}
 
 	INIT_WORK(&ctrl->m_work, qcom_slim_ngd_master_worker);
@@ -1386,8 +1390,6 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-err:
-	slim_unregister_controller(&ctrl->ctrl);
 wq_err:
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
 	if (ctrl->mwq)
@@ -1460,7 +1462,7 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-	slim_unregister_controller(&ctrl->ctrl);
+	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
 	if (ctrl->mwq)
-- 
2.20.1

