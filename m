Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0FDC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C612086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HC8AWtBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405123AbfFKQmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:42:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41784 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391961AbfFKQmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:42:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id 136so9819072lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 09:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vh/p30irgSD9xffiE9oewWj7mUanYFsIl2djx+XobXY=;
        b=HC8AWtBBddfq3ja6eieAy2clA5L9ShGX6GyMrlQqv6G8p7YcQh6KXu6TZKJ6loUu8e
         uebZxIXw7Eer6dDh/YOVEkNczX7wjuQP390PWjZ4DtdMN3fZufuQO2zlu3FCWh0C6xQy
         zpr6YKhTIPYo6vBOPhE+ioXDgmlj5Uoh5PTtyaD8qNpHNLFMCJX/xSqGih3W7hjfGGWB
         oZu60TB9cXE61ntew4y5uKq8HyXYeXeJa+lQu+YFnHp3McpHYA8VbNB2rW0YwOxKfu60
         5BNOW9NXWkoFP4lqNwXOKu7APUdh+YsQJ1IJ0anWyS+KbTDPiO9KBTYuoCENpwZkD5/Y
         UEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vh/p30irgSD9xffiE9oewWj7mUanYFsIl2djx+XobXY=;
        b=CzME8GPL6gKpOEJzBs1InMm55NLQ2lhUnUO+hi43LyqfIPiFVuKFUaaBHqFrr4hfkv
         hod/Ql6co+2VSjM0lXYZx8qU37GYo2P79zbbpDBZmpHQrwShIY3MMcJ0BgJOvGPluCIe
         25P9syMCLIZz567FtXNOGlQJKPc599zHqcy0Sp8fNW8NW10pbgAeSKALGrfZZqNv4J3E
         NSIb1SIOPJmRzSzS7yoPcsTCq5wWAkqD70jou8jDl8ghPMc8HQFyVDT/Beq+jL6oAeMI
         BAAp69zJu+SHEHs70TglDNRuvU+FY/uD2ua7DmHsbJZbaNR757IdNQFTYQE2I6OdQ3gW
         RHjA==
X-Gm-Message-State: APjAAAWmKR1dc5wge7D5dRZP9VUxNeCM9iv6Tv95I5x99kgLHN+eRd+G
        g3di1S33CoSNjfjb5HfWlAc6Kw==
X-Google-Smtp-Source: APXvYqwxOIBJiSaoAZMSvSTjGBejLmme0GxMq3dDw3qX0/Zrv2BRLPzn5wPLhEGH5OEVByUqEgvSbg==
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr37488341lfl.188.1560271325298;
        Tue, 11 Jun 2019 09:42:05 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r14sm2616772lff.44.2019.06.11.09.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 09:42:04 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 0/5] Add QCS404 interconnect provider driver
Date:   Tue, 11 Jun 2019 19:41:52 +0300
Message-Id: <20190611164157.24656-1-georgi.djakov@linaro.org>
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

v3:
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
 drivers/interconnect/qcom/Kconfig             |  17 +
 drivers/interconnect/qcom/Makefile            |   4 +
 drivers/interconnect/qcom/qcs404.c            | 539 ++++++++++++++++++
 drivers/interconnect/qcom/smd-rpm.c           |  72 +++
 drivers/interconnect/qcom/smd-rpm.h           |  15 +
 drivers/soc/qcom/smd-rpm.c                    |  17 +-
 .../dt-bindings/interconnect/qcom,qcs404.h    |  88 +++
 9 files changed, 825 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
 create mode 100644 drivers/interconnect/qcom/qcs404.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs404.h

