Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484ECC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EC4206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BID66P7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbfHZQqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:46:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40674 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733123AbfHZQqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:46:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id c3so15979504wrd.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 09:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NEmCczScxOjFfK/GsZ795dKDEuO/wf3t9hNmpIlsOQI=;
        b=BID66P7itQJ4yzTshEIGtAkG0upK9NrN2v/H5HGmn2LXb3nRYWGysQQJy5GzkKi2Ww
         WNiK+LKqgnRqiDXKI6r/L1duC7cuRDAryXvD2RjGgdBOoXZypangAWFW2vZ55LF9/VLc
         4If9ZuuZGAqArMiM49ae7lw1IcWdjFGFR8RCYPnl3SXbcmHEgIj8kMq/2Li1RDGWTz+q
         DpTtYHlxBqHyKRzIVhI+x3HtHvwHnp2TTkqE+5U5XnGEAY6OY0Yxu4I5EAXvkR2MBEiX
         dIrPcqbgaC/ADd9ITbSrT2WOiPfY9m8btcyS4kxBQjhgR+/RqZbmf7KphKMQOYvMWjqI
         5lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NEmCczScxOjFfK/GsZ795dKDEuO/wf3t9hNmpIlsOQI=;
        b=t43vpgVW2v5ny3ZPv3JqDk0AeYme1m8KYA/SK5bE1e5ftVNdudVCtSpDkEtwJV/gB/
         ntnN/+bbOQO72jhwelOwAV7mG7/hWGUmqRx1vn1CtjvcDjbKxR89QT9guXltH48XVLm8
         r5sD7+aCShnorlBww5DPUDtfs3+PBKDspwOQmX0mtAmvgM/UXaHQ9laNRTluj6jw818q
         14HPd1jUkU82kK17ShV7G18oOtG1al8HWB+ONpeY6i3uJ2+f2DgIcXzd+s+CzX0jL5J6
         +0dqb9Xg0CzXSL+bfcepgsryJ7XTQGc8eNeUPD3e2wz0Swc7J2nX3wghS0f4tf4cIdlj
         iwQA==
X-Gm-Message-State: APjAAAWFoy1VXI0jjcLmIMbhvVvvJ/+wvP2Y7P3kwarYUs4UCEeR2Dd/
        QyBc4YjnHjhT+jEAl82dA408wQ==
X-Google-Smtp-Source: APXvYqxf5ydx1zKi75IMmBCsndAtfgevLo3Rematxh30e+AFNnfRuUZ6qNl1huKC6S6s/k53vqnR9Q==
X-Received: by 2002:a05:6000:1186:: with SMTP id g6mr24328520wrx.17.1566837989922;
        Mon, 26 Aug 2019 09:46:29 -0700 (PDT)
Received: from localhost.localdomain (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id 5sm18768wmg.42.2019.08.26.09.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Aug 2019 09:46:29 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, jassisinghbrar@gmail.com,
        agross@kernel.org
Cc:     niklas.cassel@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mbox: qcom: replace integer with valid macro
Date:   Mon, 26 Aug 2019 18:46:25 +0200
Message-Id: <20190826164625.6744-2-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826164625.6744-1-jorge.ramirez-ortiz@linaro.org>
References: <20190826164625.6744-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct macro when registering the platform device.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 76e1ad433b3f..dc198802bdf7 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -96,7 +96,8 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 
 		apcs->clk = platform_device_register_data(&pdev->dev,
 							  "qcom-apcs-msm8916-clk",
-							  -1, NULL, 0);
+							  PLATFORM_DEVID_NONE,
+							  NULL, 0);
 		if (IS_ERR(apcs->clk))
 			dev_err(&pdev->dev, "failed to register APCS clk\n");
 	}
-- 
2.22.0

