Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB93EC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA1F2425A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpyrIN3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfFCWXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:23:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44905 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfFCWXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:23:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so2581609pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6niAwzcPpAohPvJt4Jc8GtfUU8V0u7v0Rg+78LYun9M=;
        b=tpyrIN3pOhJIjlxgLadTRT5CufA7IzK4ux2DtTFgG7teYRUtUh06+WAmNriOTkh6u2
         2MPJhiEQjvyIIwN3TyUAgw4GPxAti8x9g4fIBmWMYaB5QSONi8/JJhBj05BA4+Wy5vRz
         PAHvFaONYBe6dGZblkI7awqz3xqSW6y6G4S4tWzElGh0XE0tJtHQDwjqisHNfdW4Veia
         rG7L5JGJzGKf+TeJNB1m+5C9cQ/Ew9nkrSOZyfz2akaUDuDwO6I8Q4/G8Z5J1jl4fLUi
         vvldAc/78m23v283dpNjp3mCpC3lLQc/hHp6cUFSWuh7a/kACawIPOMRZJAIJ9cIHIFd
         FxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6niAwzcPpAohPvJt4Jc8GtfUU8V0u7v0Rg+78LYun9M=;
        b=mWDsuNvspiRYjP8/Vseby6Fp8/G9hPWvTmj40eg+j4T6akbyTPKS6OKTwDOYgjqoHK
         XKyDKriwU/b5WhKohS+z4t3I2Q6NTqcSfVx29hneVZ/KPxs9iU1f9pJHFDBucjL5rQcI
         AnVyiIiKGahkZyYbk4DZC9dlQ86kMNaiy+pGJ/20CBxcvjtvU7AT0ROdNbZRvZ29+hcf
         RAfZW0xJOIE/Xi7b7OUfT6LTVmhFvjCi6NjtEGS3ZMLMSf3ckGHpqXU2miSwz/sALgHZ
         bRurgVjDBZaq29+xGTcw2+i61X+1fsuH52LAMpV6vPFXJ+EKvlJV5LiXMaXcBEmT5aen
         3ibw==
X-Gm-Message-State: APjAAAXAxuCzmJWiH8Px/QsUihyb8J0cNviBz0+sXTzKyu4dxfhE4hqi
        FmHgUadR2/V5FfNh2LjtoYTdKFv7ZRg=
X-Google-Smtp-Source: APXvYqyW9fNJIYUZyJi9V5wJYk9SdgROr34PF8/DcyWJQ0PKLOKb9vtvUgdQ2NiVawrNdsXoeyOSuw==
X-Received: by 2002:a17:90a:37e9:: with SMTP id v96mr18652976pjb.10.1559600602567;
        Mon, 03 Jun 2019 15:23:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id g8sm14320588pjp.17.2019.06.03.15.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 15:23:21 -0700 (PDT)
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
Subject: [PATCH 1/3 v2] dt-bindings: power: reset: qcom: Add qcom,pm8998-pon compatability line
Date:   Mon,  3 Jun 2019 22:23:17 +0000
Message-Id: <20190603222319.62842-1-john.stultz@linaro.org>
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

