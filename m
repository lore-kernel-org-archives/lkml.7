Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACB3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9F52186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UgBFdxGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfDEDy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:54:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44639 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbfDEDy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:54:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id v71so3292642lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 20:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2fmX8L8mVM4NgXf1g6sWhqGWg2W4HcpcrPAHYFtDCt8=;
        b=UgBFdxGk4+iN7NvDvKO+FAV9JoRsB9UxPq2WVWObq3KFOG9x6fMEX/uwqBXfXk5Bet
         1tkdntV+KpNxcUxH94mNAjoCXmfbAbaiplVTXPeNW4W/1jXBT/zkX/q6DGDUkGb8YkiH
         ov7R3zvrPHA7O6MBJqDVFrgjwjmTq6zFG1s1OM0a3GwlOM0DEaJ+4meFz4nTlCajlIwC
         vgIpsscQHE8xyxOQsAZCV6j4wlX9YIPK/HBjaqTW70OV2H21MGlee4gn5HrOqqN69tk7
         MbcJC4fY7/VaUZCgfdCJ2/onV6ID9MpzhKsBHj8IXwBMZ9VFh4bm/eNc4G74o2FnlyiU
         glKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2fmX8L8mVM4NgXf1g6sWhqGWg2W4HcpcrPAHYFtDCt8=;
        b=jTFreI7EUBjepf1MUA/9P4xbUbQ7Qdp6R4fN1aWBW60ZgoBnvZu6Lx5isv/3/uyQii
         un7Ek5+zIt2/42Yo6+MYpIRVmSYhgFQ3ocQ6jxgRTOWnUlq8MezYnXcfS0tl+DYjZ1lS
         19czgMAiNDPqaUSdWemd/XxDUBwj9F00KqC6sWmhGVvA20YFHbc6adAUXtVTWCBSFeyq
         pkzyJ0RZwS+S9EWJw9K6uOUwY+Yg9ZzqHk/Z2DDIt+3F6PzQQQj0P50Q08dL2YjZ7ZxG
         f3Kd0vrUXNpqUbhK5XAy2hSBhDSKO0lIcl+pv+IJHN0uKXf06tQ1fJH9tbkUn5n6XHG4
         GJhQ==
X-Gm-Message-State: APjAAAW0ushU6CQssfXdsAuhIMFyNC6ciJohJ2uLRfpAB/lKElondVWt
        Sf4FIrCDZxKZsObEN2XWRYBosA==
X-Google-Smtp-Source: APXvYqxW/kC8uTisJp2RkN1WX4o9fXwBzzXDH6b88HrbQm73taNxn5gY59AOQsHBx6GKc0Or1kidFg==
X-Received: by 2002:ac2:4554:: with SMTP id j20mr5518950lfm.112.1554436495446;
        Thu, 04 Apr 2019 20:54:55 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i24sm4417633ljb.31.2019.04.04.20.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 20:54:54 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/3] Add QCS404 interconnect provider driver
Date:   Fri,  5 Apr 2019 10:54:43 +0700
Message-Id: <20190405035446.31886-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver to support scaling of the on-chip interconnects on QCS404-based
platforms. Also add the necessary device-tree nodes, so that the driver for
each NoC can probe and register as interconnect-provider.

Bjorn Andersson (1):
  interconnect: qcom: Add QCS404 interconnect provider driver

Georgi Djakov (2):
  dt-bindings: interconnect: Add Qualcomm QCS404 DT bindings
  arm64: dts: qcs404: Add interconnect provider DT nodes

 .../bindings/interconnect/qcom,qcs404.txt     |  45 ++
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  25 +
 drivers/interconnect/qcom/Kconfig             |   8 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/qcs404.c            | 488 ++++++++++++++++++
 drivers/interconnect/qcom/qcs404_ids.h        |  86 +++
 .../dt-bindings/interconnect/qcom,qcs404.h    |  88 ++++
 7 files changed, 742 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
 create mode 100644 drivers/interconnect/qcom/qcs404.c
 create mode 100644 drivers/interconnect/qcom/qcs404_ids.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs404.h

