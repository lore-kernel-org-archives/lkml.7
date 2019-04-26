Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F585C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:12:05 +0000 (UTC)
X-Greylist: delayed 91 seconds by postgrey-1.34 at mail.kernel.org; Fri, 26 Apr 2019 19:12:05 UTC
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1gmH/Zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2CB2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2CB2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDZTKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:10:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45506 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfDZTKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:10:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so2147700pfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Y8S2A6WXZNvlhMWa89wGivKsQq9SUrDku6Mk5QHcZ0k=;
        b=R1gmH/ZxBO4rQ+SwZKbB/D6Pswm8MWbLKuzntzruMkmU5d6CspFV+GTc937KY3ON9E
         JaZTRsjAJdjsCXraOt3wBjRzfnNqPdIQJDU/l0mChcUSmKHq8p0qjCdLAwyNxmM1FaqX
         tf4PqaRiEleoEHOnW1d9v0ToADxV/d0l0OZhjKoageRYjAFvTeXLCU/glsSSxOGHe1OJ
         +mxSv/vI5jS2XntLd14zDJCeBmhGCjMzTwSyYW2ji+MuE417SWKm8jiBQVZ4iMkPvbq9
         xAMpemCr4LD1WEFYFQluvYJrAlLGAPm54eawpHnv3G7yHT18y/SGEzUh3+9Bf1HaDS41
         qo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y8S2A6WXZNvlhMWa89wGivKsQq9SUrDku6Mk5QHcZ0k=;
        b=EJiLvadG9HYXB/QfZQDSWDU6+HjyX3hJFIrRo4CU9cyx2U/qSH1cOn4QTGCwziA64o
         kzqjbHva5uxZuyyAA113gZxaIXOwDQMHo4Z2vO5NEU2fhskSTiQs6mvtAw9drEieR5FB
         gBu6aJZc+RCkBRaWqJmFlnof8mtf3uivcfCuDZbVEJFs5GCgH/plskJONy2wPICKFbMf
         LMqJVYwpUFbXvVJTsxyH0kldOT5KsTloTnHrVr9pCTVOXwIgLmLc3+Bs6RWMYjF22ReR
         5Mt95ad1zb/JNUyZ2GkBhv7RMSVQTKOVHJ6XsRGvLu1PIjSJUX/UacsyddWG5wxlDWHG
         AmzA==
X-Gm-Message-State: APjAAAUlleyCz38R+ZVpsQSUm/zF6UpCSPANjPQfPxWUaBNnnSm9iJ9D
        vi+hWjEcIOPspt/zl4bGiCD5gQ==
X-Google-Smtp-Source: APXvYqx/qdOd9uMfMytAMcG/EP15ey83nrXBGEti/B8E6Zz5cgKwP/sGvYxO0Sqf22Ft68Y0zyvC6Q==
X-Received: by 2002:a63:5b24:: with SMTP id p36mr43712198pgb.84.1556305829298;
        Fri, 26 Apr 2019 12:10:29 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s3sm19961727pgi.74.2019.04.26.12.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 12:10:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845-mtp: Make USB1 peripheral
Date:   Fri, 26 Apr 2019 12:10:25 -0700
Message-Id: <20190426191025.16131-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MTP is a "mobile reference device", as such the default operation is
to use fastboot to boot/flash software onto it and the common case is
thereby that we boot with a USB cable connected downstream from a PC or
a hub.  And without support for the PMI8998 charger block VBUS will not
be driven by the device.

Switch to peripheral until we can enable OTG.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 02b8357c8ce8..2e78638eb73b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -404,8 +404,8 @@
 };
 
 &usb_1_dwc3 {
-	/* Until we have Type C hooked up we'll force this as host. */
-	dr_mode = "host";
+	/* Until we have Type C hooked up we'll force this as peripheral. */
+	dr_mode = "peripheral";
 };
 
 &usb_1_hsphy {
-- 
2.18.0

