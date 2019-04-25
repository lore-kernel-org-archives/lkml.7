Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754EFC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FA62088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sX9aMTMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbfDYMeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:34:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42852 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfDYMea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:34:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id i186so6177066lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gZbAV42ouC+LryXkXm2kLrS68IYQoSD4rl5WaYxDQxA=;
        b=sX9aMTMz8SM6MCg3VoGHSCZtmXRNWRkckyhqOav3u2F7qmMvwa4h8jM+6lCcF6A98E
         9V/a9w7LetuNkWOVah9YUNDDYgfRIQLHhzn15OJkha7K8/GPzUMV1mbTkh//cy9JYYkl
         FDZCBOOqmpIcmUUBeXYxiY7kVOOQ+Q41EzRdKwphIiXQ4SbxBf8HpjAtwqudblbGKW7P
         oOWmfm9YqAk5pTlhw4iijh0g+Ev2zhqNw/BEGj1Sx/L+WEsyvqvBsGzXZLZ7qFML3MrF
         r/HEGhPuAIWKXmNL0TxoDGA/vuYLXuXImohuwZHjTzosoD6i4oxum5/U00zLeScRZw0O
         I5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gZbAV42ouC+LryXkXm2kLrS68IYQoSD4rl5WaYxDQxA=;
        b=Yo/7C6y2TG6+sIwXYJIwolg5b5lfErb8r8IutNIG1plczo1RJWnB3WzXtrut2Zit0q
         ToH8v1gFxnBa59xubyCGBLAy2ynJQZ0W0Cc9xktKPlJYKnxs1XI2bwlDB34YOraqGQgw
         ANlstLiNekA2Zv0jebHy+zGtjPjfv4x5R9IbVJHB8FkGBx3HqwMdSgXahBns8wEjbTVL
         3mOmsuPyiK5TOpMeHVRZuAYhppIL7jc5xGQZLWfq4sBr/idXJCw/wwJaZi61ti+aYygZ
         w8XOMYUBsHb3dw/6f7w0J/E8foEM5ZdnNWNrMQzb6/0zWWRlFH815XFI4pKY0bSGQyBJ
         j4qQ==
X-Gm-Message-State: APjAAAW85SUOO2xNQY6vMMVsEaD0/wwj9q+Hnc8qHkE3qqcgd9J7KdsF
        0ThJTvD/SAWC3bE8Lm/4z8O29A==
X-Google-Smtp-Source: APXvYqw+r/6TrzK80Xuz5Kp8OZNi7ks1UWM+ofr6m5h/UwzmN0rS8Z22P8AYegP4X5rdKbzIvtQM7Q==
X-Received: by 2002:a2e:87cd:: with SMTP id v13mr20445464ljj.98.1556195668680;
        Thu, 25 Apr 2019 05:34:28 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-72.NA.cust.bahnhof.se. [158.174.22.72])
        by smtp.gmail.com with ESMTPSA id v28sm5046667lfi.33.2019.04.25.05.34.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 05:34:27 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: qcs404-evb: fix l3 min voltage
Date:   Thu, 25 Apr 2019 14:34:01 +0200
Message-Id: <20190425123402.18167-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current l3 min voltage level is not supported by
the regulator (the voltage is not a multiple of the regulator step size),
so a driver requesting this exact voltage would fail, see discussion in:
https://patchwork.kernel.org/comment/22461199/

It was agreed upon to set a min voltage level that is a multiple of the
regulator step size.

There was actually a patch sent that did this:
https://patchwork.kernel.org/patch/10819313/

However, the commit 331ab98f8c4a ("arm64: dts: qcom: qcs404:
Fix voltages l3") that was applied is not identical to that patch.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 6910fc663fe1..9a7d930dcd23 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -118,7 +118,7 @@
 		};
 
 		vreg_l3_1p05: l3 {
-			regulator-min-microvolt = <1050000>;
+			regulator-min-microvolt = <1048000>;
 			regulator-max-microvolt = <1160000>;
 		};
 
-- 
2.20.1

