Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74F1C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF822081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FH/e3Uzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfEBAOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 20:14:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37258 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfEBAOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 20:14:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id z8so172896pln.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 17:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Iu74mABmTcz9qvR1S/macY1NtZu8pvPEuuqjMwQiaE4=;
        b=FH/e3UzlQ7TB4FnQeE6cZQOpYdJsfmmYvWaIiYgK/HVPkws+au4HUZ4zfRZSUqCw8W
         iDa8MMPxVT5cZODFinL7MbXkbkFDsz2uFzH8RExkRM8fI0bSh0/RVpDfZaHSydEAWe7B
         Xkyd0lHCKdmg06QsT9m5uoiQOQ9kalFqgUhIkFfjy3VDHCBFAFmNVN6NmNWGeM5xtjWi
         fTjeRgDNSNTaZcocnfW6U2XNaWe1tpDH9hCogBGUe3b6K5dB5W8Pe29TvULxbAvAjCa7
         v7yjN8fC82oyMh1d5BRhvS3ZlYVP7M5s3ei9kr3aPOxzo+GpSqjFnyH3gOvhY8hQ/rNQ
         2A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Iu74mABmTcz9qvR1S/macY1NtZu8pvPEuuqjMwQiaE4=;
        b=UMZdCStrL5dkm1bKlK2kbLmkq2HOuytfx2ZHMS1QEsDIeSsQABnilU4b+JWsG2bC4Q
         j+dtZPa3a9jXItiaG2Eg0HjoOOct6xNfvLAurVMd4QJXTjqiUJVL6fhpTiYHGppjTiyA
         WDe57nNZLqPBDhfc3jc8pvtNSyyzvs01b3a2GqkSCYYFP4la5REk/QQk+LtDsZFYHes8
         pwaXM64MaJ1bCMxe+Hww7klz0RasgnXVWn9xYmRWO6sa78q/s4s0shkODlszGX1kswUF
         rhf/T2gFFfrhCwVv+qQffub87G6Sc/NwebkanityBHrS/+9FEt5WJzXfg62+tQKQ5hef
         RurQ==
X-Gm-Message-State: APjAAAWz9R1TtMpkioj7oS1HUm3QSL/lFuj9UgTipdZ6CWzMpvjmT5o2
        w0w8lEvTpvGM2JWlKZ/tANv7Gg==
X-Google-Smtp-Source: APXvYqx9imtGsUTvT2yc4e3OReRF3d5SmwGegbm39zqB/5mcFc34Icou5TEX9bIbSs6JmXJm1dWS/g==
X-Received: by 2002:a17:902:2:: with SMTP id 2mr486749pla.61.1556756050469;
        Wed, 01 May 2019 17:14:10 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z9sm2329695pga.92.2019.05.01.17.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 17:14:09 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] Qualcomm PCIe2 PHY
Date:   Wed,  1 May 2019 17:14:04 -0700
Message-Id: <20190502001406.10431-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm PCIe2 PHY is based on design from Synopsys and found in
several different platforms where the QMP PHY isn't used.

Bjorn Andersson (2):
  dt-bindings: phy: Add binding for Qualcomm PCIe2 PHY
  phy: qcom: Add Qualcomm PCIe2 PHY driver

 .../bindings/phy/qcom-pcie2-phy.txt           |  42 +++
 drivers/phy/qualcomm/Kconfig                  |   8 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 drivers/phy/qualcomm/phy-qcom-pcie2.c         | 331 ++++++++++++++++++
 4 files changed, 382 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-pcie2.c

-- 
2.18.0

