Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD97EC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE462173E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hcB5s7w/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GefpQLdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfGAPcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:32:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52792 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGAPcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:32:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 80CE36087F; Mon,  1 Jul 2019 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561995138;
        bh=FoV2coVDXy5ivyKrTBUVcDFYj8JMXwYeCYY1wHzBNqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcB5s7w/YylEBdd3fgb1QxbRHIR/9sv8E4zr8AeDj9iSrKYl6WTpmrUBH5qknIHLG
         qpxMt9dJWMUvi55fR9CS4hqotkejgOGnK8pSwH3Yid81UWTiY82z+eOXVIkAougWBD
         DuZdj6cJR+yoXY46OKP45Pv06MoAM/3+grVpVQxg=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03EC6607DF;
        Mon,  1 Jul 2019 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561995137;
        bh=FoV2coVDXy5ivyKrTBUVcDFYj8JMXwYeCYY1wHzBNqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GefpQLdNw9i+ssCyYSXd1UxNOlipWaRVR42ei50Ifykd2UisMaw1MNg/aAc0ibe6Z
         qiZn9pDGh4cqzmfdmm2qGPRTP8XwiNgSAPCiwS1CroVb1sKYqdgd/R25IDcFdp1s7n
         6TNPQ25UpNosJYInAYULjrnVXeimwvKWCWgbs6ag=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03EC6607DF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     andy.gross@linaro.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, swboyd@chromium.org,
        dianders@chromium.org, mkshah@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 2/2] drivers: qcom: rpmh-rsc: fix read back of trigger register
Date:   Mon,  1 Jul 2019 09:29:07 -0600
Message-Id: <20190701152907.16407-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190701152907.16407-1-ilina@codeaurora.org>
References: <20190701152907.16407-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When triggering a TCS to send its contents, reading back the trigger
value may return an incorrect value. That is because, writing the
trigger may raise an interrupt which could be handled immediately and
the trigger value could be reset in the interrupt handler. By doing a
read back we may end up spinning waiting for the value we wrote.

Fixes: 658628 ("drivers: qcom: rpmh-rsc: add RPMH controller for QCOM
SoCs")
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 92461311aef3..2fc2fa879480 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -300,7 +300,7 @@ static void __tcs_trigger(struct rsc_drv *drv, int tcs_id)
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

