Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586EEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239BD2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktq14jVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfDXGsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:48:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44582 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbfDXGsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:48:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so4266055pgv.11;
        Tue, 23 Apr 2019 23:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSoAoJMW5ZxBTHxjDjokwEj2+VNulkB0jtHodzb6AHo=;
        b=ktq14jVTahw02M+54HHOssAFwJAbtD7+1f0N0iEoEJR0V123ZvHrPvbHaW5ydvsaOR
         f8G057TzGwQwjgw4ICLu/UsJrXc3wXGLD4cqpCHn6FN4ht66TG1Z9tdBV8NPlcP4ZOLj
         2nn8tlK6P1U0h8G3qVTfw7H3OGBwYQxKqylmKdyNmsigwSdN4teV5hppuiFFoXXsCgpI
         Fv9ZPeiqovxkBr/T+cBzHgHsrmTZNZlvUZUPL9mntnBMXLcV4FPwBWp9SpT9dcNsbAAl
         oVm6zrplFkZnA/+X1CsbvbDnNmdYcvBbn7bVJ2DuJfseSBgdN6kdUa4VtgMhTFmPC7C3
         3gCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSoAoJMW5ZxBTHxjDjokwEj2+VNulkB0jtHodzb6AHo=;
        b=Tkr+od3/viqcEUaALlDeIaveMhOmipUDvZNI/TmVmdBc7ZKvbdfYRBOuZBnZu2CCXJ
         vNR50KKu5X2tO+qvxAVjQ8+ZGYPYndpI+l4kwyYRGHIZdCNGBy7weEqZV0v+BHrVIxT5
         wv/jhDdswsK9DvyXtUic/5rSD+8FBIzrOrh6ORGmTvifik78CnYK6rvtAHivNBb6XoDp
         beKCTnjPlhMDLy66esg0J3rGrr3mJ9AcR+HZhDje79IGzRqE54M9X7xQcIAQm1KlambV
         wBgXK0YuQvuwHOMtr1Mjab0HWi2V6IMV11ineEKtr6BzesbLsABaHmyeYhSUghCIiGYk
         xmAQ==
X-Gm-Message-State: APjAAAV4LYq9foAqbSNBEsyeOBujhnXFyPExAW3gLNopQEaaBvLwSv9a
        XQgA+HyJUf2CRLFUUAemuC9tmH0uaZY=
X-Google-Smtp-Source: APXvYqyQNYb4shJHHRIS3lYoqM9se9xZBx7/sqVeTxDDQpbklTHoHB+8C3hLREgPXvToAD6Ix3PMFA==
X-Received: by 2002:aa7:914d:: with SMTP id 13mr31723560pfi.149.1556088518068;
        Tue, 23 Apr 2019 23:48:38 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e13sm26332457pgb.37.2019.04.23.23.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 23:48:37 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/12] thermal: qoriq: Remove unnecessary DT node is NULL check
Date:   Tue, 23 Apr 2019 23:48:19 -0700
Message-Id: <20190424064830.18179-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424064830.18179-1-andrew.smirnov@gmail.com>
References: <20190424064830.18179-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's impossible to use this driver outside of Device Tree, so if the
probe function is called, the dev.of_node is guaranteed to not be NULL
and guarding against that is pointless. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 405d1fbdd0cb..5828314ec74d 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -193,11 +193,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
 
-	if (!np) {
-		dev_err(&pdev->dev, "Device OF-Node is NULL");
-		return -ENODEV;
-	}
-
 	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
-- 
2.20.1

