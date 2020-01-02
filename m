Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB61FC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CBF206DA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BWwaYA6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgABOyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:54:44 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34092 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbgABOyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:54:43 -0500
Received: by mail-pj1-f68.google.com with SMTP id s94so2072617pjc.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 06:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VtDUTQjwQa4iJtNbmp2oh8w540jx+9fBWmE0OFJWN5s=;
        b=BWwaYA6vNRkCdYaWQy6Xo1X1nAgYmYYaM7X09iTP5li6SWvSHs5nZvbJsVKpQvMHtf
         zdojI0OK6raZEtT6w9mR+8Iv9LXNaDdjuqH+91QIsfVVe4MvXLCFAurL+c7CCjzyENzQ
         kwzjzxbnG8sqoqAZ914QuEGjIGupcxixZHb9tgEYMcr6CiV6QCbTwgQbluB/1DdDAksf
         OCqWkgsX6l21elKxZdelw+vznZzdX4Cr6nfppWMGyohTlMS4ijaU1KN9VwnRizKqOgU/
         rh07FXy3kdW819H5vP4skfEhulDJhhdsrEt/19qEEVo1mx67TB66sZsNrrdwPSRFcQPf
         z9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VtDUTQjwQa4iJtNbmp2oh8w540jx+9fBWmE0OFJWN5s=;
        b=VhcVYH0/Cv8TjeLHTeb9CQ6wMkqzlymJ0jR10gobqWPPLbTvXpAum7ij/kacGRMsPC
         X/mWj2RTZd8QqdHRQ5dg/Kb+4+v3bAntgzquYA9ZA1GsCB21wHQjKs8G59JgjxC4HVht
         JadXBMhLTGf+Fa+m67vIEUlwDNge0wSUraOM6IrUItdAyxViTf/14VYCxfhKwYBw8Owf
         ferMCnGmgrdE4SgECrss4h/ho6DyoOFhzwgVNezjygqHUw079yE1BcFJrV+yW2fwU59+
         qgOkKvSNEA/rqzBX3HJdi2NzHkeFujr5zt2QPq+RN8wfj/TMbRLa/89jrVXVRsNSi9oX
         JrdQ==
X-Gm-Message-State: APjAAAWa3bRoqHWaVXp2zT1V13JrbS1gb0rxghQeMIMXmodhzGj+3AN5
        csfyl8k7oJAE0dfG6k4sLEkunzQ5iIktwA==
X-Google-Smtp-Source: APXvYqx/t9weau/82TBMzffkI1Rt4tlViNW0WGABJ+oSXsGqWDmmqCdMRwpjK0DHHZU1ry16gVuZxg==
X-Received: by 2002:a17:902:bf49:: with SMTP id u9mr32469865pls.199.1577976880635;
        Thu, 02 Jan 2020 06:54:40 -0800 (PST)
Received: from localhost ([103.195.202.148])
        by smtp.gmail.com with ESMTPSA id q25sm65113198pfg.41.2020.01.02.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 06:54:40 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/9] thermal: tsens: Handle critical interrupts
Date:   Thu,  2 Jan 2020 20:24:25 +0530
Message-Id: <cover.1577976221.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TSENS IP v2.x supports critical interrupts and v2.3+ adds watchdog support
in case the FSM is stuck. Enable support in the driver.

This series was generated on top of linux-next from 20191202 to capture
const changes for msm8976 that is queued currently.

Changes from v2:
- Handle old DTBs w/o critical irq in the same way as fix sent for 5.5

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
 drivers/thermal/qcom/tsens.c          |  24 +++-
 drivers/thermal/qcom/tsens.h          | 104 ++++++++++++--
 10 files changed, 330 insertions(+), 56 deletions(-)

-- 
2.20.1

