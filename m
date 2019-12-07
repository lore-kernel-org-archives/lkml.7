Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A37DC2BBE2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 20:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7BE206DB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 20:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vINxdpIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfLGUge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 15:36:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37775 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfLGUgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 15:36:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so5075998pga.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 12:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4pU0TgCEVu3iILUXjS64n8D0+VYiF/iGQ/CEZMcyyRk=;
        b=vINxdpICYteO6gJRGK9ywPvLKgr/9A0DCY7QWTX859IXm3YJ+TN4esbzO3tuv7YCS9
         G6Rsl8hL06+MiFFFYuMe+02yjgJJWIdp541Jpkr2rSg8/0JnbyYH48EKE9l+Ogft/jWJ
         cnPo/mk+bg82Q32iz5cCwIN2CVkvg1fOVfxakwgLFFsQUQqeWSRbZVoXFpm3HR5FKeaG
         ulLl0iMW1hZrzIzdb27BUqmGh4OJ5ZRVObBBqQ9rTq+MYnC4ycnoJGApHS0ApBk+qfdr
         dqJjjvS+TV0Q2nsQ0PyXiU0WFQUAGc9gWT2blEQsXucKCGZtpBLcRyjkY/igtSZ22CbX
         LJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4pU0TgCEVu3iILUXjS64n8D0+VYiF/iGQ/CEZMcyyRk=;
        b=uIXOyaeDqwrEBSV5vubdrVZUJGlvnMLGR7OmSVZLUrXdCQT4Tdu9LtZSVr6u8omSur
         bVx1AmqI2nzbj7R7HeoDdthJmywlskElKJQSRcNqcSY5CV7oAfAMZd+t2qcjDYmpyVa0
         x/eaiehR2dqm4paNHvOZ7NWmZs0FtWDt/k7LW9yBG5K1jShrokpdTR/AKJPQXKHSKGx6
         JUbudHTbJ+kwzQ87oG2EQs/giFhDlKoVr9xu0du2rA0ge5mwiOKa8eT9U/ZSXqNyUWJ7
         SW2p01VRrMCZ3P2oY2+4ZdRKw6l9zO+QDfO3Jvxb0eBIlIiPWdu7T6v0qpfqbbRxiPkS
         eTAQ==
X-Gm-Message-State: APjAAAURZwlg1RZJkQEw/yRxhE9BWri2wzqUAKx+nLtZbLd6cmE8vHNd
        AD9ZHXbMgto4O0ydulAx+gg72g==
X-Google-Smtp-Source: APXvYqw901GjcbHTK90oZG2kYPsObEYLR/h3mKtSJ01x0JdZ6I2G5a44GfZhkTBXFwXydT3dY6rdWw==
X-Received: by 2002:a62:6086:: with SMTP id u128mr21734365pfb.4.1575750990366;
        Sat, 07 Dec 2019 12:36:30 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d14sm22982186pfq.117.2019.12.07.12.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 12:36:29 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Pisati <p.pisati@gmail.com>
Subject: [PATCH 0/2] clk: qcom: gcc-msm8996: Fix CLKREF parenting
Date:   Sat,  7 Dec 2019 12:36:01 -0800
Message-Id: <20191207203603.2314424-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've always seen intermittent resets of msm8996 during boot, seemingly related
to PCIe somehow. The likely cause of these errors are the fact that the CLKREF
of all PHYs are parented by LN_BB, which while being on during boot is disabled
by the UFS host driver if it fails to find its PHY.

As such, depending on the timeing (and success) of the UFS initialization PCIe
might loose its clocking.

These two patches ensures that LN_BB, connected to the CXO2 pad on the SoC, is
described as parent for all the CLKREF clocks. So that they all vote for this
clock appropriately.

Bjorn Andersson (2):
  clk: qcom: gcc-msm8996: Fix parent for CLKREF clocks
  arm64: dts: qcom: msm8996: Define parent clocks for gcc

 .../devicetree/bindings/clock/qcom,gcc.yaml   |  6 ++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  3 ++
 drivers/clk/qcom/gcc-msm8996.c                | 35 +++++++++++++++----
 3 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.24.0

