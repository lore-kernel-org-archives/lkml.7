Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08D3C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E4C2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IaOrcClV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLCFXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 00:23:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35779 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfLCFXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:23:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so1255570pfo.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 21:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N6/Vfj+VnloKWDrO0keM08fpBsJsdBma6GiUwIrec4g=;
        b=IaOrcClVOiytYPvZ/GyCl7kuuxS2MieZf3/zjMPjFrj1hz4nMh0GOUF3ReKo5ZnWXf
         sPqyz5YDiyjHrw3XjxPMjk/o/XFjBsvHNSB/+lzcKq3tm8wl6TA/lG0zXQkUgQ0xYrla
         ZdBYtFqJNDJYrLis5h4xdxE1egpYECrCh139U07hObomwBHkq0DSETdfgomv90oUAE5A
         mSXh7q0x568TE1zri8FftVKmhxCnyoHwGFI+K6+WR0fmhxvjEOSdUiPm3U4KGcNPuk4J
         /M+2yK+X1ATkKfbLKQsnmnWS5zuAmak7jSoX/81fPeooerKiexIomdAsxJG3OSY4J3tR
         t+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N6/Vfj+VnloKWDrO0keM08fpBsJsdBma6GiUwIrec4g=;
        b=fMUpFaznVwvzuD3av3nSu7XS06nufSSV9qw6bXzyU7XXhulKRFLY0Yh5P3O8T+gzjj
         k+WC2PHM43GORcf5b0s5XKGTd4WKnUbWyHO5Y0HHNSJKzRyFgRfXikCO2/Zj6DHeH6Xl
         q3rwY56fhBhP8R/ZsrWc3GfcPvEV4KilCkZlN721x2FmuddnNYvfmtZEp+bmDT+mBIIJ
         UgVMw1C3tR6V1rSUqR5fMKDKDbv4MX3yyUfPBuD5SsOIvhC4VgiZWWn0qkfX+utxM4Nv
         Q6n6Kk9ARw9As6Y5EOkZZ8GhzRdKaHCQKrJ0PAZd/BaWVo9l7ER/AK9Axz4jBZ6Tb7v+
         +GbA==
X-Gm-Message-State: APjAAAU/C+JWLCES9qT6v7Zmu9c06gUrHFF/OZjNstL/uv5RKYgVE8kt
        kSZAVcl1h1C1WBc5FD1rKqiWE3s2eevhhw==
X-Google-Smtp-Source: APXvYqzBmqmcs7hfpJvWbz3BETEGz2dOxflDfBhKP1dipSrFLRru5zt4EJ3eXlRAVFM7scft8Nk94A==
X-Received: by 2002:a63:1a22:: with SMTP id a34mr3250138pga.403.1575350616626;
        Mon, 02 Dec 2019 21:23:36 -0800 (PST)
Received: from localhost ([14.96.109.134])
        by smtp.gmail.com with ESMTPSA id d23sm1379850pfo.176.2019.12.02.21.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 21:23:35 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/9] thermal: tsens: Handle critical interrupts
Date:   Tue,  3 Dec 2019 10:53:21 +0530
Message-Id: <cover.1575349416.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TSENS IP v2.x supports critical interrupts and v2.3+ adds watchdog support
in case the FSM is stuck. Enable support in the driver.

This series was generated on top of linux-next from 20191202 to capture
const changes for msm8976 that is queued currently.

Changes from v1:
- Make tsens_features non-const to allow run time detection of features
- Pass tsens_sensor around as a const
- Fix a bug to release dev pointer in success path
- Address review comments from Bjorn and Stephen (thanks for the review)
- Add msm8998 and msm8996 DTSI changes for critical interrupts

Amit Kucheria (9):
  drivers: thermal: tsens: De-constify struct tsens_features
  drivers: thermal: tsens: Pass around struct tsens_sensor as a constant
  drivers: thermal: tsens: use simpler variables
  drivers: thermal: tsens: Release device in success path
  drivers: thermal: tsens: Add critical interrupt support
  drivers: thermal: tsens: Add watchdog support
  arm64: dts: sdm845: thermal: Add critical interrupt support
  arm64: dts: msm8996: thermal: Add critical interrupt support
  arm64: dts: msm8998: thermal: Add critical interrupt support

 arch/arm64/boot/dts/qcom/msm8996.dtsi |  10 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi |  10 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi  |  10 +-
 drivers/thermal/qcom/tsens-8960.c     |   4 +-
 drivers/thermal/qcom/tsens-common.c   | 188 +++++++++++++++++++++++---
 drivers/thermal/qcom/tsens-v0_1.c     |   6 +-
 drivers/thermal/qcom/tsens-v1.c       |   6 +-
 drivers/thermal/qcom/tsens-v2.c       |  24 +++-
 drivers/thermal/qcom/tsens.c          |  26 +++-
 drivers/thermal/qcom/tsens.h          | 104 ++++++++++++--
 10 files changed, 332 insertions(+), 56 deletions(-)

-- 
2.17.1

