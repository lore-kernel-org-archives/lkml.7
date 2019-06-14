Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0C9C31E50
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFDC2184D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RaSoogsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfFNXO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 19:14:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38468 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFNXO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 19:14:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so2267233pfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 16:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T+BKVZFs5J0hQKKy7Xl9NEhtep6L20aFI9X20tcJ4Dc=;
        b=RaSoogsiuoKzfF03OimSCwN5DLWvNVLjg/Cw1uhd4GZF8UIqdZH4VIBMJUq7KmdLXs
         FOeT6TW3S2sKkKi67shgM+JOX9TZQX/0ceG9ZRQSHwfKB+Sy406/zV838lyhVUO1jTjJ
         94Zq3aYgRTyzEnpXP+A/JLp+IATlZju64xtlm53d+Rq2QIdOVkCrEV2wjOYI7+WGAP2P
         EzdhDo1j4sZfVA7nP3gfKip5XLKobHGBQNiHBNB76m/ad0AFbQKgW9Ibn99+pgCGwzxY
         j7YxnlhO6Qa7zDcrGeFEicTeszzLxVB6L2NTqMG2rnG8SB0upFZZkbU+JWTfr6Cm5NQK
         AoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T+BKVZFs5J0hQKKy7Xl9NEhtep6L20aFI9X20tcJ4Dc=;
        b=GHD4sLw5aSNbatQsHf0hot1oT1qB7QHX2eiDCn9htStmbVh/5ewFC2HVIorJ866Mpe
         Fthvc4BiHWhY3ITfHgsLrFRLVqq/wXu1JA1u80iJv0/+qDsGpnFAcomJI+TlTNqqElEO
         6V3hex5yPp509b9k+Sj+s4VGt5+Sl6H/NYnqbzpYFmFOVM+/pBqmJownBm1Q99NzTn9k
         GBAbSdLZbRTKN14ViLbjG81FhBLfiJQZznlcBfZdz8IhTHOgEzxW0elXXdXjBOoKb9tz
         CdKTCk9WxaHZ7D0vQxPS38fm+M8pux7EHq9nqywRKknY7s/grvSczh3sEBzDu7D3uVAo
         NUww==
X-Gm-Message-State: APjAAAUBBMMYsoAST2LutPysdu1aM3jTXBVhtXZB6c4ASWtdX3IQGQ/w
        m7TTWA404gQ/15NQnyRPqBygq83Frxc=
X-Google-Smtp-Source: APXvYqxO8GzkDnYm75Nso+MbL3XLjkJ512s1lRKWZAcBvGoZomz/WOCvvUcPjThL60n5kzlC5e9Eqw==
X-Received: by 2002:a63:da49:: with SMTP id l9mr38078876pgj.320.1560554096491;
        Fri, 14 Jun 2019 16:14:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id w187sm4486445pfb.4.2019.06.14.16.14.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 16:14:55 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: power: reset: qcom: Add qcom,pm8998-pon compatibility line
Date:   Fri, 14 Jun 2019 23:14:49 +0000
Message-Id: <20190614231451.45998-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update bindings to support for qcom,pm8998-pon which uses gen2 pon

Cc: Andy Gross <agross@kernel.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Typo fix in commit log suggeted by Marc Gonzalez
---
 Documentation/devicetree/bindings/power/reset/qcom,pon.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
index 5705f575862df..0c0dc3a1e693e 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
@@ -9,6 +9,7 @@ Required Properties:
 -compatible: Must be one of:
 	"qcom,pm8916-pon"
 	"qcom,pms405-pon"
+	"qcom,pm8998-pon"
 
 -reg: Specifies the physical address of the pon register
 
-- 
2.17.1

