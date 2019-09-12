Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56161C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FD9208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PO1eVqH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfILIaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:30:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53704 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbfILIaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:30:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id q18so6410130wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cqzuGZoym9FEk7gYB3476i+uOhYWCF5S/jPvzlZG8fg=;
        b=PO1eVqH06sZ0c21pOCfkvDiG+rH4UUPr0QVMoyijSFhI1rEs+Saiik5zH6V2qzitv+
         tPYO4FPOEOgQbEP9WRebZysmk7OYoWtRCU+VEDZBWd4UHQvuMy4SKHgD/ppIV/JFhlF4
         8jfDnZkV/EG6VAtslQEP+NxPQdbZhNZFrpLvzzH2Mv71wpC6YMAgszzeFzI49F89VCwE
         6RtA5CTCyZBDL7e6qWt8MsKC+siGpXgKhNwXRqYmUtw2tL107DB0SzZZAuhmbi5aEhxA
         IRbevC4URQe6Wr9FE7JgfYrPrkdZb4zdyMuAV+MjlSHb9gD+DWAevK4TCU2shrITKDhq
         KEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cqzuGZoym9FEk7gYB3476i+uOhYWCF5S/jPvzlZG8fg=;
        b=GczqyLyqU/VdHvetD5yPLN2gTpuxufEFGmdUGWCelvAilV4y0yq9xgV7Iswh2XKjfu
         LwSd9PBNHBWEOiuWyYEmBtQbmnaPTi0TTbCmfX6lPvNn49hg4B9QZzkfAY9lPtGwivgH
         y36UM4qrdmr0hM2rYShltnhJ/u2ONKgOCmcmkTP09HM9LPsaBZzsBS9F6g1pC/N5pJ5F
         VzOcbHyutvcOYZVEtCociyBhwXLQ0q5n2suqCdnm9HbzI2m1IoTyETTsq861CMDpO3MR
         9IXg0Tl8gYbW93Ay2xi4Q2XQqY2MbWCXQAGgczVp5InFoD/M8At6Of3cAe0qID1WX2l4
         T/TA==
X-Gm-Message-State: APjAAAVsGaT/aL5Bw9btyaFzoqGeeF5VPvf32+LxmdQHn4DUzB157G/y
        QA7fgC/iSRgM44lSCFTwoJOodA==
X-Google-Smtp-Source: APXvYqwYiDdzKRqCJnoPo2p9S9CPrEEXB20zsEsHTgOhYMXdxJZ2Nw47zX2yALtzjs2dQc1lvu1iWw==
X-Received: by 2002:a05:600c:1106:: with SMTP id b6mr6048249wma.127.1568277006590;
        Thu, 12 Sep 2019 01:30:06 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 189sm7100877wmz.19.2019.09.12.01.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 01:30:05 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 0/2] Venus interconnect support for sdm845
Date:   Thu, 12 Sep 2019 11:29:46 +0300
Message-Id: <20190912082948.22836-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here are two patches which adds interconnect bandwidth requests
depending on the resolution (macroblocks) in order to lower
bandwidth pressure on the interconnect and memory.

Changes since v1:
 - correct typo in the 1/2 patch description
 - add a dependency to INTERCONNECT

regards,
Stan

Stanimir Varbanov (2):
  venus: use on-chip interconnect API
  arm64: dts: sdm845: Add interconnect properties for Venus

 arch/arm64/boot/dts/qcom/sdm845.dtsi        |  3 +
 drivers/media/platform/Kconfig              |  1 +
 drivers/media/platform/qcom/venus/core.c    | 34 +++++++++++
 drivers/media/platform/qcom/venus/core.h    | 14 +++++
 drivers/media/platform/qcom/venus/helpers.c | 67 ++++++++++++++++++++-
 5 files changed, 118 insertions(+), 1 deletion(-)

-- 
2.17.1

