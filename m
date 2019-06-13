Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9E0C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62A62175B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMyVNjAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbfFMPNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:13:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40835 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732842AbfFMPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:13:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so15379463lff.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 08:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oy4WRzt4oy7DKEhEUsk8mM+TKtbIR/SxiJkzCANc2S0=;
        b=jMyVNjAHR90qecUAhRrWQnYr3j5JfbQWsYrzQvWMbwWRPL0Z7nP94qt24V2i/E3l+a
         ZIvy9FmxmrQ2duSB2wqLIJDUZtCMYd07SgfkxP/rrJsQY5NilBYJej4YfiPEshJT52Lw
         mbC4J9qi3ZrY9C9o3nloY8heK6ApIxvZcz3KVAkBbGHPjnVjUCOdxZ+t3JVxn+dLbgDB
         rZoDDcp1kQykVvuwSqmhTgqgMlqyntHU71iS6oJVCAUd6/QQvjkYi8VZu+O5LpEmeSE7
         Jeoao2k+CmmIvF3A7/aq407OY7qRgIb9NEu2ypnge/Bou2ibNgLJNZ+0CNSmKd/W1/Ml
         Q80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oy4WRzt4oy7DKEhEUsk8mM+TKtbIR/SxiJkzCANc2S0=;
        b=MexuEA83KtHvBis9Ra9HgrtYogJgX6tPB0dZ9xscnVTsHNuDgKxasLmUmXkEOK4C2e
         0h68MStYDC/LYYr6118M8I3PJblevCHxfpNcf4BSHRdl1gCwnp8IeUSSUgsayt7tliYb
         4wEA1juoJybHKrvCMmXdwAyRL1r8aWKbIW4VsvONDn5ah8b8+nGiS57+Xj0JEUC5gXzm
         we58GdysTnNzNEUWS1IQde+l6XdK58VzRfAGDy1ErHYAF5TXV4LnAVDgx7+DUI5IYOxM
         LVCua4UdmmrqxrQZcfIsASno0YTst7Vpd03zeg6gCb0ypzKiIpGDaKrMwyiYC5EIzfuc
         mJ+A==
X-Gm-Message-State: APjAAAXTk/bathNVD+mfL5BcXb1jxYt6ROgGQQkLJQkwXLFE7RJAIccT
        AngfVx03D+1htfC6OxXycqhXOw==
X-Google-Smtp-Source: APXvYqw2pOxAB+cTtgkqIYSoU5XivAmb3YXGBRWP38d8Pc5gb206woR1gl2jQ2aHzJG36QtgigSvNQ==
X-Received: by 2002:a19:e619:: with SMTP id d25mr1335729lfh.34.1560438806327;
        Thu, 13 Jun 2019 08:13:26 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k4sm42923ljj.41.2019.06.13.08.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 08:13:25 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 0/5] Add QCS404 interconnect provider driver
Date:   Thu, 13 Jun 2019 18:13:18 +0300
Message-Id: <20190613151323.10850-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add drivers to support scaling of the on-chip interconnects on QCS404-based
platforms. Also add the necessary device-tree nodes, so that the driver for
each NoC can probe and register as interconnect-provider.

v4:
- Move DT headers into the dt-bindings patch (Bjorn)
- Pick Bjorn's r-b on some patches.
- Return error if platform_device_register_data() fails (Bjorn)
- Use platform_set_drvdata() only in the child device. (Bjorn)
- Hide the smd-rpm proxy driver from config menu. (Bjorn)
- Add remove() function to zero out the rpm handle. (Bjorn)
- Move move the qcs404 driver patch later in the serie. (Bjorn)
- Insert the DT nodes after rng to keep the list sorted by address. (Bjorn)

v3: https://lore.kernel.org/lkml/20190611164157.24656-1-georgi.djakov@linaro.org/
- Drop the patch introducing the qcom,qos DT property.
- Add two new patches to create an interconnect proxy device. This device is
  part of the RPM hardware and handles the communication of the bus bandwidth
  requests.
- Add a DT reg property and move the interconnect nodes under the "soc" node.

v2: https://lore.kernel.org/lkml/20190415104357.5305-1-georgi.djakov@linaro.org/
- Use the clk_bulk API. (Bjorn)
- Move the port IDs into the provider file. (Bjorn)
- Use ARRAY_SIZE in the macro to automagically count the num_links. (Bjorn)
- Improve code readability. (Bjorn)
- Add patch [4/4] introducing a qcom,qos DT property to represent the link to
  the MMIO QoS registers HW block.

v1: https://lore.kernel.org/lkml/20190405035446.31886-1-georgi.djakov@linaro.org/

Bjorn Andersson (1):
  interconnect: qcom: Add QCS404 interconnect provider driver

Georgi Djakov (4):
  dt-bindings: interconnect: Add Qualcomm QCS404 DT bindings
  soc: qcom: smd-rpm: Create RPM interconnect proxy child device
  interconnect: qcom: Add interconnect SMD over SMD driver
  arm64: dts: qcs404: Add interconnect provider DT nodes

 .../bindings/interconnect/qcom,qcs404.txt     |  46 ++
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  28 +
 drivers/interconnect/qcom/Kconfig             |  12 +
 drivers/interconnect/qcom/Makefile            |   4 +
 drivers/interconnect/qcom/qcs404.c            | 539 ++++++++++++++++++
 drivers/interconnect/qcom/smd-rpm.c           |  80 +++
 drivers/interconnect/qcom/smd-rpm.h           |  15 +
 drivers/soc/qcom/smd-rpm.c                    |  17 +-
 .../dt-bindings/interconnect/qcom,qcs404.h    |  88 +++
 9 files changed, 828 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
 create mode 100644 drivers/interconnect/qcom/qcs404.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs404.h

