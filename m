Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA47C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DBE22527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TrM7s1KV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfLLTgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:36:17 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39832 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbfLLTgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:36:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so1367031pfx.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 11:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEGuXuYPUWE/qYdSZqED1gh4bU/O1uzRJFgkr80g5hE=;
        b=TrM7s1KVt+BcjbKEaGH7FQnsY49TdXgU8izplBUx/dCEO0MX3pTuBKF0wxwWHmauNX
         OwrsQv4JxlXkxvePcns/akl3lBJVwNWyWbBMz7UpTg9Nku8ehYHundEKPsvwpqaBmeVU
         Ka6mVdvvvCVv7s3gRlKvcGgGRXbWmlYyfl0ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEGuXuYPUWE/qYdSZqED1gh4bU/O1uzRJFgkr80g5hE=;
        b=d8u3JMuKsSLyCWMrdsGBQe85Cd9OoweYhLUQFXni0P1ViznnljDk/rqwEsXsr21htY
         BQjzTKT28KK0A7qWVL2BpcIm2yQJNypcShkEWMsnKiVwPNJrudL/O/zeqalO9TtTNOwm
         ANHALf1FIkmz02EZFdbDc5THNm2Pn1oDTmPJ6ATntvhmjxVNGXEsj+br48r8RrbE9nZy
         COFPCvXC40Y0I+7WgDt8be9tXv+HLeCaBuNx8NwFuimklnm3sdP14u4v4uIDe/hisbZN
         tHIdf91r7ezaerZR+dT0/hc20Xoqs/FuTs+QoY67r4rHm2Scd+lvJ2yNvmZEWW/ba5Wf
         FaLw==
X-Gm-Message-State: APjAAAUChK79ac/IYi1dOlFzytmR14mWQbYGQBJTXL4gFeC4XPVnXmDC
        kHPzVZQ4qZwWdoq3Q4h2U6cd5Q==
X-Google-Smtp-Source: APXvYqxghN0ayxKucn1BnTnQnYD8PpnXbxp/upzKjgiCF4kPosXUnpb3rT2o3+6itZxqbbh957q/bA==
X-Received: by 2002:a63:7985:: with SMTP id u127mr12217817pgc.169.1576179376641;
        Thu, 12 Dec 2019 11:36:16 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id m34sm7568302pgb.26.2019.12.12.11.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 11:36:16 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        mka@chromium.org, Sandeep Maheswaram <sanm@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/7] arm64: dts: sc7180: Make dtbs_check mostly happy
Date:   Thu, 12 Dec 2019 11:35:36 -0800
Message-Id: <20191212193544.80640-1-dianders@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This gets rid of all of the dtbs_check that showed up atop the current
qcom maintainer tree for sc7180-idp, except the errors in the
'thermal-sensor' nodes.  I believe those are known / being dealt with
separately [1] [2].

I don't expect this series to have any functional changes, it just
makes the device tree cleaner.  I was able to boot after applying
these patches atop a working tree.

I have tried to sort the changes here, first including the "obviously
correct" changes and later changes I am less certain about.  There are
no known dependencies between the changes.

[1] https://lore.kernel.org/r/CAD=FV=UXC3UT78vGBr9rRuRxz=8iwH4tOkFx6NC-pSs+Z5+7Xw@mail.gmail.com
[2] https://lore.kernel.org/r/CAD=FV=UtHebABCpJo1QUc6C2v2iZq2rFL+pTMx=EHBL+7d=jTQ@mail.gmail.com


Douglas Anderson (7):
  arm64: dts: qcom: sc7180: Add SoC name to compatible
  arm64: dts: qcom: sc7180: Rename gic-its node to msi-controller
  arm64: dts: qcom: sc7180: Add "#clock-cells" property to usb_1_ssphy
  arm64: dts: qcom: pm6150: Remove macro from unit name of adc-chan
  arm64: dts: qcom: sc7180: Avoid "memory" for cmd-db reserved-memory
    node
  arm64: dts: qcom: sc7180: Avoid "phy" for USB QMP PHY wrapper
  arm64: dts: qcom: sc7180: Use 'ranges' in arm,armv7-timer-mem node

 arch/arm64/boot/dts/qcom/pm6150.dtsi    |  2 +-
 arch/arm64/boot/dts/qcom/sc7180-idp.dts |  2 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi    | 45 +++++++++++++------------
 3 files changed, 25 insertions(+), 24 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

