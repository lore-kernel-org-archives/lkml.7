Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94517C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FE42070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E79+1WD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfC2KMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:12:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38951 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbfC2KM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:12:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so1869023wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+y2/6kyAo4OW6pN0+X/HTs1Di6/VAYdc4IbJi/g6D0s=;
        b=E79+1WD6yG7I1rAGwucw8mSrRpVZzdtyj60LFUTOZHzaTBwdVj7+5p/ShoGPSqJZQF
         A0IZ9kfVm4Vvoa9YRfKrxhmzNyKtQwie8682AkOyPVnMnQFqMrPweRwwwkYleu2dAEp/
         t+wULHGOUCDYcnjz58xpjosl0BoKqaIzXnSReeY1bqw6LzwIUJJFEHkBtWf+p1hxobnD
         uSfe+SzJ8f8FgJzK37cIgjc5Sgl0k5f0GeW389kzqWeFV4FWMjqIAAHi3s3YBK63n7vk
         okjvTlz9OdUDrddjhTYQ2IZEWkRMIX04MjdyAp+p8A/TJcM+sHxPpEM8HkcNA5H+Hmxw
         LoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+y2/6kyAo4OW6pN0+X/HTs1Di6/VAYdc4IbJi/g6D0s=;
        b=KNCsqKuwXxlmuVEY90OgWpdvxNgb1RhHZJWzuWlT1aJ9fEK9uW4rdjjDBHOkWYy1ht
         /8CU7vaVSZ+hRJtefKZkbVYjeNBErLYtJRKr154cKzUclRBGCB+vs/QhPjt5Vg9aZdaa
         Q9OFcWiU/urKRRoxUMn3bTru+CPAOHQYfiZtaDxu0+FYetPxdR12b06CDw1E8f9Qki7Y
         uPAJ5O2ouTXkY6Y93WdEUxRAt3LJL8tF5R+LHSrm4UEuaJorbUgIkzFrzLtMi+KWuOcn
         hBZCswaeXmzHsNVMXgwGiX1yNneUihnQCEMU0NBXdnGZ+9JeI7unji5vl8j/tGtR6NcE
         RNtQ==
X-Gm-Message-State: APjAAAX9YBpKbojbHXaeBh6002NcT7CyCpgIza32er/+NPSL03035CVZ
        UUDrDJAsY4TlvXJyxFCsXsPGvwOss4E=
X-Google-Smtp-Source: APXvYqx/K6/OhePyJmLhHnw1UNWISPEFUL4c2IPAdLrS3SmO1alBA91ceXJX0i6B+aX+ddTlW7kmEQ==
X-Received: by 2002:adf:eb84:: with SMTP id t4mr32636389wrn.100.1553854347780;
        Fri, 29 Mar 2019 03:12:27 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id f128sm1572404wme.28.2019.03.29.03.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 03:12:26 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 00/13] qcom: dts: thermal cleanups
Date:   Fri, 29 Mar 2019 15:42:06 +0530
Message-Id: <cover.1553853990.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
- Devices that are not associated with cooling-maps use the 'hot' type
- Remove critical trip from such devices too and restrict that type of CPUs
- For 8916, add the sensor on the modem

Description:
- Expose all temperature sensors on msm8916, msm996, msm8998, sdm845
- split up the register address map for msm8998
- standardize names of the various thermal-zones across boards to make it
  easy for test scripts to parse

Amit Kucheria (13):
  arm64: dts: msm8998: thermal: split address space into two
  arm64: dts: msm8998: efficiency is not valid property
  arm64: dts: msm8916: thermal: Add sensor for modem
  arm64: dts: msm8996: thermal: Add temperature sensors near major
    peripherals
  arm64: dts: msm8998: thermal: Fix the cpu sensor numbers
  arm64: dts: msm8998: thermal: Fix the gpu sensor number
  arm64: dts: msm8998: thermal: GPU has two sensors, add the second
  arm64: dts: msm8998: thermal: Add temperature sensors near major
    peripherals
  arm64: dts: sdm845: thermal: Add temperature sensors near major
    peripherals
  arm64: dts: msm8998: thermal: Make trip names consistent
  arm64: dts: msm8916: thermal: Make trip names consistent
  arm64: dts: msm8996: thermal: Make trip names consistent
  arm64: dts: msm8916: thermal: Convert camera trip type to hot

 arch/arm64/boot/dts/qcom/msm8916.dtsi |  41 +++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 174 ++++++++++++++++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 242 +++++++++++++++++++++-----
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 205 ++++++++++++++++++++++
 4 files changed, 589 insertions(+), 73 deletions(-)

-- 
2.17.1

