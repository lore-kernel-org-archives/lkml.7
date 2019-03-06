Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC952C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE2020661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BqnAKru1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfCFRrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:47:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38634 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfCFRrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:47:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id m2so8978812pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bCfHKDpjlcJZ40uakK9Elj+UI9/Ckw029IL+mhz3BAw=;
        b=BqnAKru1tFLJ1BJU4khWYSqJocamWQfThf8+VDtnNVX7zAzHZCfb0zM/EJJhwqhLie
         0Bzgih3KCC+oBJ5yVpT6PLmbpg5m8gdz3hWtH1CNKTALbkYAlYffNxHdqQzj1pyRc4hi
         BlM2Xt1J8C6jZxf23aEA1M9c250WYxTB6qxj7mRGAvNDYrH6s94hz25M4eWfOmVS5mGu
         KmYu481kaDi4WJdsz/HYNHrDYfEjLyk+eClqyWGbj5RThcrZQzoGoZWdZbF7MhQ9eVDc
         XOXP5rL50H3m+YWule2rolos4L7c5rId92495ExG0OG8RSeC8hM0uNGP0BXMSIAiwnv1
         /xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bCfHKDpjlcJZ40uakK9Elj+UI9/Ckw029IL+mhz3BAw=;
        b=pjQh1Coa+mR0oBxq3X86ITDSXAFKTdRK1RVLfI3WVz91CkcPr0A5Sto4F9s8Uko7aP
         BVUwN5LIGMRJE2plff94EvFMAJrWv3X8fhtEohu4P6QqYv0G/iMqN+nHRXuP/vwP0Puh
         G7QILBvSuD+jqHzI1qTmYenAQJOIEx6iVs1vehAeVNeYDYnrI8uP/Jjkg5xcjPQgh0JW
         TXWEzurB1gHnnKDSY35i5cXNjDqocLMCWPd3UOA+sESVYlu5ahZV5op/ewyiprbnmmY6
         Snar21+JlUypJSkBQhGsLLFW1jqPPiazBT9MsgPm1fkv3Iqha08A1DOg9Nq09CQpyZE1
         NeUQ==
X-Gm-Message-State: APjAAAXUEWsHnuenh2aoHq1l1Sl+6KRoumEu0gxQfkOl5ZSzgfps/fnU
        9kgvH8/ZxG5xJ7+XCjRRBmRLEVgv4RU=
X-Google-Smtp-Source: APXvYqyaJVR41ZoTU4chKteD1ffSxMk+4TZfMJpWqyBKHMHxpVM4tupruERHqyTHjWxwZQ3uC3om8A==
X-Received: by 2002:a63:e844:: with SMTP id a4mr6817906pgk.231.1551894431384;
        Wed, 06 Mar 2019 09:47:11 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h64sm4098293pfj.40.2019.03.06.09.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 09:47:10 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Qualcomm QCS404 Turing Clock Controller
Date:   Wed,  6 Mar 2019 09:47:55 -0800
Message-Id: <20190306174758.22462-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The turing clock controller provides clocks necessary to run the compute
subsystem in QCS404.

Bjorn Andersson (3):
  dt-bindings: clock: Introduce Qualcomm Turing Clock controller
  clk: qcom: branch: Add AON clock ops
  clk: qcom: Add QCS404 TuringCC

 .../bindings/clock/qcom,turingcc.txt          |  19 ++
 drivers/clk/qcom/Kconfig                      |   6 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clk-branch.c                 |   6 +
 drivers/clk/qcom/clk-branch.h                 |   1 +
 drivers/clk/qcom/turingcc-qcs404.c            | 170 ++++++++++++++++++
 .../dt-bindings/clock/qcom,turingcc-qcs404.h  |  15 ++
 7 files changed, 218 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,turingcc.txt
 create mode 100644 drivers/clk/qcom/turingcc-qcs404.c
 create mode 100644 include/dt-bindings/clock/qcom,turingcc-qcs404.h

-- 
2.18.0

