Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0C7C43630
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FB621D81
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2vPkiRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbfIYXmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 19:42:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34677 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfIYXmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 19:42:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id k7so414911pll.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 16:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BqAPbs/wZUWEhGivyo3NLB3Z3ocJiJHq8gLjsQrSOVI=;
        b=l2vPkiRmlXdJHN6GeFN8Z8GiZhmhg12dGgNyE97gFX1t7ha+98miz02tsg7Iek0dCg
         YoIg336NYQakybahq3pjXQV13OnYmh9bWgL1jRY5E9CDaycXkOrtT5JroxmvjkHypxwI
         gnxiap1CkAzXLcRY+iCMlLe9fxDBjp8FCX88MgFfNwx8Vr2u+lX9qbsEuSBaq2xUjRcm
         znMZhxhAgK1OX2g9PYKludIijQYdXzfey0dI+iQlBB6LHM21pWsoyNUlz7DGJE/4PwO3
         E1Bc5MEG371EEWMJNAGOFduBccgOxXKkgNPh/klrf+8pgvOIaRzM2e43J2lr/WYyce8k
         JjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BqAPbs/wZUWEhGivyo3NLB3Z3ocJiJHq8gLjsQrSOVI=;
        b=LjNqZNW1mcG2lXtZoCy2hsSPApi9uqVIgsgInXbYslT+IKsxijCVW3XpXlCkr+OiiV
         AGrMIDB0pIQH3qyZH3m8CrCMaNXiKbgXZIKuEAo2ZLvHgl0Ur6ftST0MC3aMO4PLnw58
         5GFWU490ZxQzAY4/yqonM6y5eP2x/EtoC7L49ZTgabG1Ab8DAQNNQ5OIwQGDedBsGEAQ
         54d66gGnvXS/nTd/31+DkgJed3/Wx30IxeNB1Fazj1h4jttwxN3PawQBGbcLbyUVPa5+
         GC4e/9+bKqENyhCZu3wVA6KsPMWm3fb/0MATT7xW5Qa/5K/k/BOQVxlG8FRvyvciBI13
         1Y+g==
X-Gm-Message-State: APjAAAUXs7yLijtBWWKg50U0U0VzRk/YcrVRNgTZQ5OyvOZxHI9C8K5C
        uBOECQ2aEulWOw/pqejRfSunfGWQrfw=
X-Google-Smtp-Source: APXvYqzMUd03gD/db63Y3t5pD+j0LGb6omLi0D1rmvHroR9ZzP4ylqsiPQgYxlYCCvBxuIxa9kobfw==
X-Received: by 2002:a17:902:6bc5:: with SMTP id m5mr707175plt.169.1569454951894;
        Wed, 25 Sep 2019 16:42:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d1sm131127pfc.98.2019.09.25.16.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 16:42:31 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yu Chen <chenyu56@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: usb: dwc3: Add a property to do a CGTL soft reset on mode switching
Date:   Wed, 25 Sep 2019 23:42:20 +0000
Message-Id: <20190925234224.95216-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925234224.95216-1-john.stultz@linaro.org>
References: <20190925234224.95216-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a dt-binding for quirk needed to do a GCTL soft reset on mode
switching

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
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 66780a47ad85..cf4ef6c22fb3 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -77,6 +77,8 @@ Optional properties:
 			during HS transmit.
  - snps,dis_metastability_quirk: when set, disable metastability workaround.
 			CAUTION: use only if you are absolutely sure of it.
+ - snps,gctl-reset-quirk: when set, GCTL soft reset will be executed on mode
+			switch.
  - snps,is-utmi-l1-suspend: true when DWC3 asserts output signal
 			utmi_l1_suspend_n, false when asserts utmi_sleep_n
  - snps,hird-threshold: HIRD threshold
-- 
2.17.1

