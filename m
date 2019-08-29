Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAF1C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D922053B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567076031;
	bh=Tohnue6jgZf0kCeuaIKW6SJ72fwGuoIpEm40KHoo9PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RDnOKYSVgwPsN4ZmVqKNkhanxP2ZrONF+lHvBFZ8LZTK+VdOXZDBg1Bb7LZBhlZxf
	 VtHyP8yVUf/nfEY9zV2KIxDr3kbra17QcxHADlxEHZ18QNkWiI+8zaOoIEqZUxmpeH
	 86EFY/2kjUPPht5sB2tS4DKaR0iYfvQCUQgTzWqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfH2Kxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728167AbfH2Kum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:50:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25B5623405;
        Thu, 29 Aug 2019 10:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567075840;
        bh=Tohnue6jgZf0kCeuaIKW6SJ72fwGuoIpEm40KHoo9PU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OX1NXpQy7r+11mes7C5RBGAu7XOKxZJCGGwWYa8aVN0Z8xOj6OAnYOfkAUQRuiwk0
         /DowYwTQlL91Zc+iwfYy8tR32UQlfrJN60gM5kpmJtjtk78j6BTu/jypiOV6UK0jNQ
         J6m9jeqfSbkHswDSp+cyVErUOV8T9vFZXISAfO3w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 27/29] remoteproc: qcom: q6v5: shore up resource probe handling
Date:   Thu, 29 Aug 2019 06:50:07 -0400
Message-Id: <20190829105009.2265-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829105009.2265-1-sashal@kernel.org>
References: <20190829105009.2265-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit 1e2517d126171a41f801738ffd19687836cd178a ]

Commit d5269c4553a6 ("remoteproc: qcom: q6v5: Propagate EPROBE_DEFER")
fixed up our probe code to handle -EPROBE_DEFER, but it ignored one of
our interrupts, and it also didn't really handle all the other error
codes you might get (e.g., with a bad DT definition). Handle those all
explicitly.

Fixes: d5269c4553a6 ("remoteproc: qcom: q6v5: Propagate EPROBE_DEFER")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_q6v5.c | 44 +++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index e9ab90c19304f..602af839421de 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -188,6 +188,14 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	init_completion(&q6v5->stop_done);
 
 	q6v5->wdog_irq = platform_get_irq_byname(pdev, "wdog");
+	if (q6v5->wdog_irq < 0) {
+		if (q6v5->wdog_irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to retrieve wdog IRQ: %d\n",
+				q6v5->wdog_irq);
+		return q6v5->wdog_irq;
+	}
+
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->wdog_irq,
 					NULL, q6v5_wdog_interrupt,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -198,8 +206,13 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->fatal_irq = platform_get_irq_byname(pdev, "fatal");
-	if (q6v5->fatal_irq == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (q6v5->fatal_irq < 0) {
+		if (q6v5->fatal_irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to retrieve fatal IRQ: %d\n",
+				q6v5->fatal_irq);
+		return q6v5->fatal_irq;
+	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->fatal_irq,
 					NULL, q6v5_fatal_interrupt,
@@ -211,8 +224,13 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->ready_irq = platform_get_irq_byname(pdev, "ready");
-	if (q6v5->ready_irq == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (q6v5->ready_irq < 0) {
+		if (q6v5->ready_irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to retrieve ready IRQ: %d\n",
+				q6v5->ready_irq);
+		return q6v5->ready_irq;
+	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->ready_irq,
 					NULL, q6v5_ready_interrupt,
@@ -224,8 +242,13 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->handover_irq = platform_get_irq_byname(pdev, "handover");
-	if (q6v5->handover_irq == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (q6v5->handover_irq < 0) {
+		if (q6v5->handover_irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to retrieve handover IRQ: %d\n",
+				q6v5->handover_irq);
+		return q6v5->handover_irq;
+	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->handover_irq,
 					NULL, q6v5_handover_interrupt,
@@ -238,8 +261,13 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	disable_irq(q6v5->handover_irq);
 
 	q6v5->stop_irq = platform_get_irq_byname(pdev, "stop-ack");
-	if (q6v5->stop_irq == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (q6v5->stop_irq < 0) {
+		if (q6v5->stop_irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to retrieve stop-ack IRQ: %d\n",
+				q6v5->stop_irq);
+		return q6v5->stop_irq;
+	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->stop_irq,
 					NULL, q6v5_stop_interrupt,
-- 
2.20.1

