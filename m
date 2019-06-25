Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E91C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B8F216E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="unkd+FMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbfFYQrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:47:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44890 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730824AbfFYQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:47:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16so18640015wrl.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWqeg/uRBmP4v1S0mrfdgUlh6T/cak+6t6geY/+2zUc=;
        b=unkd+FMrbJN9AzanjOJ4wpmc5HlH/ET5TudwrnAvOcWYz1FhJuNWwwXVCCo/y84G6i
         nH2bHVyL1b8OXnBdWWvQ9MPcfVs/5S5DYUf7iCUuZS47RVYNIleEcEDKbEsYWLMeLJ6e
         TLKLP7ZrGuZSCTyJbu20xIi0iuhnhI4FBK6EYE/Os57yaBo1IYfBAiv9pUjyFW/4j6Q2
         rpsOjD52BAjQRBC4//y1jisx8bzNWSTn0Xf52FSCHwQHBaHwrjO82XvDAsHMtRvJpfDn
         9iuwnV+CGdKw0aqvwaspbpSaq14/rrZ3eqD1COJr+X3VxcezUlVryu0Eo02Tqu9s5TrR
         DbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWqeg/uRBmP4v1S0mrfdgUlh6T/cak+6t6geY/+2zUc=;
        b=IrKGjS6ZADvBYtvtrnQTtz2o8pEYuUU75XnRDFszcdrqnL5Sgs1FFvhNoTtMM0/q2u
         QEGbioazG3Qsdd/I21FwTtVwUAm2Jy2sB6CkQFWoO4t6qvnPcKpsM03/+vNPNKnP15Jj
         vk3gdxf96lpdnVz3pUzBBTeb0dXk65quOkcoykJ5d0ltgUTtlUgfYNOqv/M+7KuW95vg
         6by+t+R7Y6ZjNlOQJX/I3o+3BRvBEQC0LykJ+FXmMmkkT7q7BaWdRJH6ha2m9sSSvZ+V
         ZB/NI9XftKBVVN90J6ayyjR2H7Qf2JGyubUJp7WjcVeYJFwOCDwqbwr1jn9MxBznLmq+
         HkCA==
X-Gm-Message-State: APjAAAUV0XyGeMMLgTII34hhKAyZIXxtNMm9/OSrbXkfb/ApqJ6AR2xb
        Le3jLJgFV5Umrcnf0cnjpF2rOg==
X-Google-Smtp-Source: APXvYqy6K2OKJaRWYw2cM2myPOUo982DJCOgC+HO5QqOBSGkx5aQTFdQWGebuD8lsFMVewG0rHya+Q==
X-Received: by 2002:adf:f948:: with SMTP id q8mr17100963wrr.196.1561481262770;
        Tue, 25 Jun 2019 09:47:42 -0700 (PDT)
Received: from localhost.localdomain (30.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.30])
        by smtp.gmail.com with ESMTPSA id d18sm42594476wrb.90.2019.06.25.09.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 09:47:42 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, will.deacon@arm.com,
        arnd@arndb.de, horms+renesas@verge.net.au, heiko@sntech.de,
        sibis@codeaurora.org, enric.balletbo@collabora.com,
        jagan@amarulasolutions.com, olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v3 03/14] mbox: qcom: replace integer with valid macro
Date:   Tue, 25 Jun 2019 18:47:22 +0200
Message-Id: <20190625164733.11091-4-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
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
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index a05dc3aabac7..c8088e9caf02 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -97,7 +97,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 
 	apcs->clk = platform_device_register_data(&pdev->dev,
 						  "qcom-apcs-msm8916-clk",
-						  -1, NULL, 0);
+						  PLATFORM_DEVID_NONE, NULL, 0);
 	if (IS_ERR(apcs->clk))
 		dev_err(&pdev->dev, "failed to register APCS clk\n");
 
-- 
2.21.0

