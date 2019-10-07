Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3434ECE599
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C9220684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iD2o9He3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfJGR4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:56:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32817 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbfJGR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:56:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id i76so1506270pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1oH7lj03wYz79i/zPzaUWTT6QxHftIiKZMYorEdLMBo=;
        b=iD2o9He3U69q6RpgqdzxaCMFlm/KSulpW5frmlBOgF4pZ0uYO5c4gejji2HqtrMSQt
         8JhD9FTrk7VwS9GB2wrv8Hba0ZUIEQWc9WuQjOP7YxIOKTfoneOS2w/L0Yeb+Ppfbn79
         SWF99J20b4fqvta/nclqz+QzVDbV4tZIOQhTbnETRWBCpLXosYrqEgWPHgV0nEEVG5IE
         T9jbitj49uv/eck9gVcH09akU4ZrdFhTPVaX7LcuokFH39wF81h2s3f+Kx5TVU38lUwk
         +Sz21hlnZ3RyMbV0oqLJKa6oZqZICMTUv8vFFP0PxLuGOnFixbMAk5Z4XfOwdpENVbIe
         XJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1oH7lj03wYz79i/zPzaUWTT6QxHftIiKZMYorEdLMBo=;
        b=Ek51ZpfKNIPIipn6MPpDyMnKGBx+e+LAaVQ8mTs0w+YI8cwoAkJdldZNV8C3BVJcZa
         3hfDBW0ZtyrJkpNCHTsWlsGCCWs4PZpoQVk+rLE9dJxybhvYZU1zytir3LyoDcOqG4DT
         Shws4o00f7JT8b4vXK7KbsUFIsSxfag5+buAOtuLddBYsWvB9FEtyCN1bNa8qVzqJzIg
         ca0RyBuzxz9up1sXIfLwC4TuPWm4fNWBhsSGqz5A46k06J6FkNnjqrxdxcbZ/0iX8fMn
         n2jgr4h+3UCXjOp1Fr/I1Qoj3njfS0IxQ01kGLeaWS4X/CQrzsb6sveFFzfz9tIjjNOd
         AQvw==
X-Gm-Message-State: APjAAAX1TNEP+QMCYknBkXk2kWxQj/4JLyzKEBN4M0/eCgAU7wZvb9TY
        0UCRMDcXcDQqtnWkUdm9ueRk75ivLc4=
X-Google-Smtp-Source: APXvYqz1K67CyWo0e/emHrkBQnZS3p/dyk4OrQ9OdF6w4uS+MO8fNgdny3guoMksP8tvRCj3SarDBw==
X-Received: by 2002:a17:90a:fa0d:: with SMTP id cm13mr610912pjb.70.1570470968394;
        Mon, 07 Oct 2019 10:56:08 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id k15sm3820096pgt.25.2019.10.07.10.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 10:56:07 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH v2 5/5] usb: dwc3: dwc3-of-simple: Add support for dwc3 of Hisilicon Soc Platform
Date:   Mon,  7 Oct 2019 17:55:53 +0000
Message-Id: <20191007175553.66940-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007175553.66940-1-john.stultz@linaro.org>
References: <20191007175553.66940-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

This patch adds support for the poweron and shutdown of dwc3 core
on Hisilicon Soc Platform.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index bdac3e7d7b18..78617500edee 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -51,7 +51,8 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 	 * Some controllers need to toggle the usb3-otg reset before trying to
 	 * initialize the PHY, otherwise the PHY times out.
 	 */
-	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
+	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3") ||
+	    of_device_is_compatible(np, "hisilicon,hi3660-dwc3"))
 		simple->need_reset = true;
 
 	if (of_device_is_compatible(np, "amlogic,meson-axg-dwc3") ||
@@ -183,6 +184,7 @@ static const struct of_device_id of_dwc3_simple_match[] = {
 	{ .compatible = "amlogic,meson-axg-dwc3" },
 	{ .compatible = "amlogic,meson-gxl-dwc3" },
 	{ .compatible = "allwinner,sun50i-h6-dwc3" },
+	{ .compatible = "hisilicon,hi3660-dwc3" },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_dwc3_simple_match);
-- 
2.17.1

