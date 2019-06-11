Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267E1C06508
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26A12173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0ptaN8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407123AbfFKTTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:19:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39090 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404789AbfFKTTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:19:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so8040531pfe.6;
        Tue, 11 Jun 2019 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J/xZLDiLprAi8z9dQ/9qJB5+wewmwploxA4je19QCGk=;
        b=n0ptaN8NAlVFDirqrMfLJYeUXgSiyaLf29Dh9YaFfz7g7LBipHlM70KT57ZKMQPpGB
         /AVpxACi089JSUlKgJqwp6/J4lJlVFgWtDYGHTBPkWFiHGA0n+qUrDygFp7eWRrkEims
         adE34NmdTIEPBTiNBxrRA/iH5juB2l5ulbpISEm6mZdk1Hzqj4bA2w0yG8fjNnSS9PzN
         y9nNEaQsLDwN4Uol7pGro41rMQKFhJxj9D//pVJCr/6OOUXLm7atYkw2K4KRnDo5ZTdf
         M4FCoHxYPXIUmL4tSih6hJDaO2mL1GnygigO2ZZkU99bN2PfAiETtQPdnn7e+FU+u0Ka
         MLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J/xZLDiLprAi8z9dQ/9qJB5+wewmwploxA4je19QCGk=;
        b=cS3VDnQeukjMugEN3RkArfcihwRwyStJbP/zsGPmFXnHHO+l6oOVDOGWHjxqi7OABa
         A7c+0vqWEvkF8lFrmyJHCMI9nDIXRoFlilv9UDBgjJInkJwBiNVzFtQnD7PIkArjDTZA
         NFSdJ0fQKTZm6t+PInuk7ZwCxumcIjeDh36gDwruWF4r3aPho2udHXNeskh4x8U3y3AE
         jBuoxGdGdxapqh11iC694sTkJwwdvWeDAVa4RbKgBjZ6nSbATjsh1/rVljPgk7LRDvUN
         aemjNuIwpeIhuqJZJnEx9WKiRK8QpnP+uCqam4Xq/oHHGUF1+/yM1vHleJwTZCO2ZKwC
         o0HA==
X-Gm-Message-State: APjAAAXNcl3m1E42ghW3RMR3oyyU9+ae1zSeG4deCOUGfN+XqI72x0Jz
        73/q4/ifrtdHQQOqfQq7xVQ=
X-Google-Smtp-Source: APXvYqzmRn16DG7bbYc+884o1bq/aK/65WwHVB908fINU8aVL18oOFnbAE7r4ioRxEXGZBjLYZg55Q==
X-Received: by 2002:a17:90a:9bca:: with SMTP id b10mr27672945pjw.90.1560280793850;
        Tue, 11 Jun 2019 12:19:53 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 19sm3112635pjj.8.2019.06.11.12.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 12:19:53 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     agross@kernel.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        marc.w.gonzalez@free.fr, jcrouse@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v3 0/2] MSM8998 GPUCC Support
Date:   Tue, 11 Jun 2019 12:19:49 -0700
Message-Id: <20190611191949.14906-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Adreno GPU on MSM8998 has its own clock controller, which is a
dependency for bringing up the GPU.  This series gets the gpucc all in
place as another step on the road to getting the GPU enabled.

v3:
-drop accepted DT patch
-correct "avoid" typo
-expand comment on why XO is required

v2:
-drop dead code

Jeffrey Hugo (3):
  dt-bindings: clock: Document gpucc for msm8998
  clk: qcom: Add MSM8998 GPU Clock Controller (GPUCC) driver
  arm64: dts: qcom: msm8998: Add gpucc node

 .../devicetree/bindings/clock/qcom,gpucc.txt  |   4 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  15 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/gpucc-msm8998.c              | 364 ++++++++++++++++++
 .../dt-bindings/clock/qcom,gpucc-msm8998.h    |  29 ++
 6 files changed, 420 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/qcom/gpucc-msm8998.c
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-msm8998.h

-- 
2.17.1

