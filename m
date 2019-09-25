Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F37C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899CB21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SwSWOlZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbfIYXmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 19:42:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35172 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732927AbfIYXml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 19:42:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id a24so314236pgj.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 16:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1oH7lj03wYz79i/zPzaUWTT6QxHftIiKZMYorEdLMBo=;
        b=SwSWOlZdAHc54NN1P9/DI2Ev3uZ/2WR8GFuUWdKYhLAOmYqLprdUfFmMCJEqLxlumz
         3gOwyocfMNPC5M7hckWXzk3Rb4ZOTIPwsJgqDLfh/tJuTauP3QP7ouMIgG2co4Dxsh2N
         ONNf//SkblbTzF6TOSU4VjZUHtJE/eqTSl+FUEtAm/JAnmTR7oFsPZnkStJMlK3EmNyU
         x+D9tbHrBIS6nv+BjgNvZ2Pnzwkar4rUHApgf6W2gTINQOWudc0WUMvfGmCPFC4pDIcP
         ztFQcEf7Wwl1j8gw1Vtii9E6qVYU6UfUWSHm+di9rXUEWL1caDGAOutBXIaEGkH8m8tx
         Jstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1oH7lj03wYz79i/zPzaUWTT6QxHftIiKZMYorEdLMBo=;
        b=ialmJMw6aw1Rq8EeO7RH0dVp1syUB9bs9DcqfZbxIDOvudGtRXj25WSnCmSheyKEvL
         6QUY80wmaqC/bakDGSpaMnG99UfTIgyUc+R11mTPT2NwQbpADrzcdT91UWVdPlJ+GIsN
         CaAr/GoYUc3o0BXgPC/TAiZZGg/SVbE0TE5qpJMLAv51g7gZGHcPPIobwFgKakqxvcYX
         SSD44nU8sYmuuqlRAqYdpzDXqCtK1IJ+6X3z44hiKaSx7FQisf0zAumnVlXLWIgTlWDB
         YEyNY3q0e9DpJVElVqqrFtxxr6QXkvPvBluw/BzuS9wpRGwuHVLmyMsE6w5V4Rpqg5we
         XUfQ==
X-Gm-Message-State: APjAAAU2M0akniwdFfYnaLUqo+9yfP+7HeynIbVZjFt76rVL5DenVCht
        M+//7QcQ8281t8PdmXf2c9q6oWRdTSY=
X-Google-Smtp-Source: APXvYqxBu00R/fhIXx8pELMq6NqJTAGfty4xq7C26/kBFDvAHrojlE9S5uCP8hyRBRU/G8IJBrwdGw==
X-Received: by 2002:a63:221f:: with SMTP id i31mr441694pgi.251.1569454960022;
        Wed, 25 Sep 2019 16:42:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d1sm131127pfc.98.2019.09.25.16.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 16:42:39 -0700 (PDT)
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
Subject: [PATCH 5/5] usb: dwc3: dwc3-of-simple: Add support for dwc3 of Hisilicon Soc Platform
Date:   Wed, 25 Sep 2019 23:42:24 +0000
Message-Id: <20190925234224.95216-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925234224.95216-1-john.stultz@linaro.org>
References: <20190925234224.95216-1-john.stultz@linaro.org>
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

