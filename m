Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA2DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFFE21850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DY6eu9Mc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfCTNT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:19:29 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:46914 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbfCTNT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:19:26 -0400
Received: by mail-pg1-f175.google.com with SMTP id a22so1767530pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iB+qXWUd5MH36EuKW0QX1Zz13dgt3ZzYo72RTOcmlkQ=;
        b=DY6eu9MclZkFd44KfN7j4xlekZHvBA3SGIuQM1IU3TPaN1Spf2LlAijdNv0iN8eQ70
         GMbyUiDxootoK0t9Q/lsU1Kir0b36qwyTkjQnoCO+0JzMB3k9LH9dxHRNwbWEIZF7If4
         qY2HIjATzyPoPU9rXXureIAlp23fZ9lCltauSrmbj/jKhqJIgnjRV+bToXVWgh8dlXNw
         PilzJgR8l+TXHkDhRMhGTqQ1X3UP5EllaTe+xHkE23usF+1YWQT/117W9GSkK2/6ArH1
         uFxTMxHAZTtLb/86T3PEigialP8HNHk0J6O8/XdBREqGNB1fpiQW0Vf4jCKeYUV/2yej
         Dtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iB+qXWUd5MH36EuKW0QX1Zz13dgt3ZzYo72RTOcmlkQ=;
        b=d7uPp6Sx5814MqX+gT9wsOEZRqzaufD+FTm4K5ZkujSJx9kPSyxm6sVqbsypgHPETV
         mqXwqf3POEzghw4wBUY/COGNxLUbK2awUvXshJlgmHj50iBOega22cU3eizzRVnk2Dil
         D31O0FfNAm+FJHHWbH8+vKv5CHBedyVd5Lt43pjZVmIj6LHqsacPKgvKcIYqxQIZBVnF
         WnRIdHVqmOiyXxAkMqKg8MKbfN8W9ISgkgbjvA/ghFp0tv0DBFvsj7U3xluN2gg0VPUu
         wq4EzH13QODBBj5eo9arkoLA7MAmlllNdaQUUQNjYOUGoRabA8EDFs9HiLKndHUymPG8
         6Gkg==
X-Gm-Message-State: APjAAAXny1mXFDjM+KfnDuYVD+eZ4jLH7sBFueG5VS4kqTw71UIFYRmS
        8XCT9ETFfgn7T/a4+QOIsBpwgcYtWFE=
X-Google-Smtp-Source: APXvYqzip6n6hmC7i8Srs4GdQXA0SIdJYPMXO3K1+p7/6AWvViw1xr8iCNCQQUDdc4t8P67Ey74N7A==
X-Received: by 2002:a17:902:8d97:: with SMTP id v23mr8218944plo.274.1553087965649;
        Wed, 20 Mar 2019 06:19:25 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id u62sm7589873pfa.124.2019.03.20.06.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:19:25 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 14/23] drivers: thermal: tsens: change data type for sensor IDs
Date:   Wed, 20 Mar 2019 18:47:54 +0530
Message-Id: <5b21bbc7e331a4ee415b62e8cb78ada953c98278.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IDs cannot be negative, fix the data type.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index a3bf7de88ae8..527c42cfd2d5 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -35,8 +35,8 @@ struct tsens_sensor {
 	struct tsens_priv		*priv;
 	struct thermal_zone_device	*tzd;
 	int				offset;
-	int				id;
-	int				hw_id;
+	unsigned int			id;
+	unsigned int			hw_id;
 	int				slope;
 	u32				status;
 };
-- 
2.17.1

