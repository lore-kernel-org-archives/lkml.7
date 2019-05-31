Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06185C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2C926F80
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJ5xKl0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfEaXrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 19:47:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47009 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfEaXrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 19:47:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so4849458pgr.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 16:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ssV0Kpewe7V3chVlIn07ylhgai93WBPa5K6GWFW9pK0=;
        b=KJ5xKl0XkK8xfSoBs9VmPUFTbT54EICRlFJivsuzwebkNtDKFLpUJ33geHMGddH7UH
         w3/MSstmwv9OMEBmDvvAlz1PjL2KsWSQJHNz4YGtCW2XkY4w1BKyppCHkuVQueq27kZC
         YBk1ZnXq3eQ0jMl/xfEzp9CmLylDUKjriMFmFqHmtnsfsd5HGaG+99WRKOzoRk26ELoa
         ldQGi8ZpGKWb/FOJC5WK8Acwf7ncsDk5BGS/15OlF53A5pKJbzfCSJvmCT93tEgh4JU/
         F63DyhyYh74DbsKVd6VMOO2ByF1G6bzz4HfyClQ4JMt2gyIEZLlz7ofSUKYACjEHk5He
         BvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ssV0Kpewe7V3chVlIn07ylhgai93WBPa5K6GWFW9pK0=;
        b=fwns1dVQNf5CP+ABEVRfWi9AjLN9c46nMyO7jDyBl+Z6DRHehiaAu2qW5wc/iiIgtK
         ECiQjJX8w4lMsmKNHM9aCkTv4pJFdxW4oywQIpnX+zRPmYbC7WB9fFBfE6uiVjfObVXC
         1Nj+Zd0QETnDTMbNdYFyBXaldufRMs4Ug9uX+bFpQ531oG9Qqw+IEX+8m3/t+iFkT4/F
         s1C7hPobEhaPBSp7hp/B7Mve7gQCflQWKfUkp3LNjT1QZs0X8p+SH5mrUyYK2a6V7mJJ
         uEtki6KxgJ8/RBwhG5An4572dgNs5Lb4ZwKF2M0uBC3VdDleuf4mJu9Q1ovMv3Gkz2F/
         Dmtg==
X-Gm-Message-State: APjAAAU/RugG1EYW/XiT2mLePumOKEIkzpM3bAA0TiehSEaYtvHXFVvz
        SOGs/9nL501obFACQCZSLmTSDkLW8BY=
X-Google-Smtp-Source: APXvYqwtjTiDatBn5Vb3SL+i2YrV0hy4eHkglHMR/DHW3QZBNEZU4xtufJ4SoM5+3ahLS9OihXpixg==
X-Received: by 2002:a62:e90b:: with SMTP id j11mr13195158pfh.88.1559346462171;
        Fri, 31 May 2019 16:47:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y191sm7056843pfb.179.2019.05.31.16.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 16:47:41 -0700 (PDT)
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
Subject: [RFC][PATCH 1/2] dt-bindings: power: reset: qcom: Add qcom,pm8998-pon compatability line
Date:   Fri, 31 May 2019 23:47:33 +0000
Message-Id: <20190531234734.102842-1-john.stultz@linaro.org>
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
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 Documentation/devicetree/bindings/power/reset/qcom,pon.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
index 5705f575862d..0c0dc3a1e693 100644
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

