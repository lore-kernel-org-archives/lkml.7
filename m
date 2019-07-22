Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A32C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F6E219BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gYjXWSiO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gYjXWSiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbfGVVx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:53:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36626 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732959AbfGVVxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:53:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B735561785; Mon, 22 Jul 2019 21:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563832434;
        bh=RlWL48UI3PgO6diXYD1un69eisGSJ5AGaNNzhzZW95k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYjXWSiOZnE5/llNK5rwCFyUSOKNROo4GVMKSCUU9apa2IYoWJOPXiUuEs2lXTkKf
         mIteqbWYc1Zleo5AgcfOmRCqxJK7ZODSLn6wwFeeh2NsMLh9eKJObncLSEmm+AtADL
         nplkvMDSHyX4nKwRr3ur54Dvr7v5ZGUXiHlR3m84=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49E7060FEB;
        Mon, 22 Jul 2019 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563832434;
        bh=RlWL48UI3PgO6diXYD1un69eisGSJ5AGaNNzhzZW95k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYjXWSiOZnE5/llNK5rwCFyUSOKNROo4GVMKSCUU9apa2IYoWJOPXiUuEs2lXTkKf
         mIteqbWYc1Zleo5AgcfOmRCqxJK7ZODSLn6wwFeeh2NsMLh9eKJObncLSEmm+AtADL
         nplkvMDSHyX4nKwRr3ur54Dvr7v5ZGUXiHlR3m84=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49E7060FEB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, swboyd@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH V2 2/4] drivers: qcom: rpmh-rsc: avoid locking in the interrupt handler
Date:   Mon, 22 Jul 2019 15:53:38 -0600
Message-Id: <20190722215340.3071-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190722215340.3071-1-ilina@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid locking in the interrupt context to improve latency. Since we
don't lock in the interrupt context, it is possible that we now could
race with the DRV_CONTROL register that writes the enable register and
cleared by the interrupt handler. For fire-n-forget requests, the
interrupt may be raised as soon as the TCS is triggered and the IRQ
handler may clear the enable bit before the DRV_CONTROL is read back.

Use the non-sync variant when enabling the TCS register to avoid reading
back a value that may been cleared because the interrupt handler ran
immediately after triggering the TCS.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 5ede8d6de3ad..694ba881624e 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -242,9 +242,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i, 0);
 		write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, i, 0);
 		write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, BIT(i));
-		spin_lock(&drv->lock);
 		clear_bit(i, drv->tcs_in_use);
-		spin_unlock(&drv->lock);
 		if (req)
 			rpmh_tx_done(req, err);
 	}
@@ -304,7 +302,7 @@ static void __tcs_trigger(struct rsc_drv *drv, int tcs_id)
 	enable = TCS_AMC_MODE_ENABLE;
 	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
 	enable |= TCS_AMC_MODE_TRIGGER;
-	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
+	write_tcs_reg(drv, RSC_DRV_CONTROL, tcs_id, enable);
 }
 
 static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

