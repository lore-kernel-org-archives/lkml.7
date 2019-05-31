Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F962C46470
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395A52626E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yc4Wu0e7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEaDBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:01:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40963 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfEaDBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:01:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so5222846pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 20:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9DXOFODBqmIato1G6sUFuAMjaJ7HfVcF5OL98ROBWB0=;
        b=yc4Wu0e7nn+b+z4wwDSsnR/SHWgh+XCFyN/oln/5lzBH41crQS7uiJhep0iOWwjXGp
         p7OKXuFybH2ZNLRvzZj7ULC7XoWg0RSxHju/Vek7wKiKG6rIhcm1tdNQzuZjFrQ64b5E
         6JogTE22Egfqqjh6YygMtEZ/+cxfxSiI1jxCKR43a7riQE8exXu/X8+XHgWllL6zEAl3
         hq+Od2DB5wAqvkGm7iJDl1ZQrGtcyGFdiAQEYbXa5nYLoW8OCkJ1hhs56nJkm6gnRxGo
         2HrVcLTvg2CwF5iny8LKVaEIbkYluuNeaTd34paQZSE28I40vDZdoaPaPYPAY9sBgrjp
         0Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9DXOFODBqmIato1G6sUFuAMjaJ7HfVcF5OL98ROBWB0=;
        b=I3Q0CPXvFRQ4NMeCEfYIUSsR8GAKk+kqxqF80OuhjrmYG896UKEtU0xNnkmOlHzUWi
         Nky0EO1VWwEHPJ/0ylTIqvlyKZKGwlKibsjEeEnJwkrrcJdRjQavcyCj3weFrowud2cU
         CkemUtfnoGKIvb5xqzXzgSbDwgsBH5/7XGciZDGH2hNIAd+aFHvlw4mYxYWf4ochTNCS
         MBzF7bUaTjpKc0tzEVK/ErMLU74YcsmoWmwd+fDT7kZhikE13FpJGTH0ccBELk82SU8N
         hOnCFDfIglbzkKRtgVT0fVQ1S+n+QVTdSUsqVHdKvzbaP28Yxqb+0hksZbPInks0h1yT
         2WhQ==
X-Gm-Message-State: APjAAAVibu3Ln5EkB2R5i++mPEAPvb9U5M1KsuQ4+5NyCjtYzS24wKrS
        vqQJxZFNu4zFuLkysBSXddZAfA==
X-Google-Smtp-Source: APXvYqxaMcySQg8PkW0Fh852AHXFzEMJZ1N/GTFlK0FWFL3OYC+XaIjOoLjttxL5urryeajcR0DCYg==
X-Received: by 2002:a17:90a:f488:: with SMTP id bx8mr6801107pjb.62.1559271661246;
        Thu, 30 May 2019 20:01:01 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m8sm6991549pff.137.2019.05.30.20.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 20:01:00 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/4] Qualcomm AOSS QMP driver
Date:   Thu, 30 May 2019 20:00:53 -0700
Message-Id: <20190531030057.18328-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a driver implementing Qualcomm Messaging Protocol (QMP) to
communicate with the Always On Subsystem (AOSS) and expose the low-power
states for the remoteprocs as a set of power-domains and the QDSS clock
as a clock.

Changes since v7:
- Minor tweaks code style tweaks and error handling

Changes since v6:
- First couple of patches merged for v5.2
- Squashed the qmp and qmp-pd driver into one and by that moved it all
  to one file
- Expose QDSS clock as a clock instead of a power domain

Bjorn Andersson (3):
  dt-bindings: soc: qcom: Add AOSS QMP binding
  soc: qcom: Add AOSS QMP driver
  arm64: dts: qcom: Add AOSS QMP node

Sibi Sankar (1):
  arm64: dts: qcom: sdm845: Add Q6V5 MSS node

 .../bindings/soc/qcom/qcom,aoss-qmp.txt       |  81 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  68 +++
 drivers/soc/qcom/Kconfig                      |  12 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qcom_aoss.c                  | 479 ++++++++++++++++++
 include/dt-bindings/power/qcom-aoss-qmp.h     |  14 +
 6 files changed, 655 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
 create mode 100644 drivers/soc/qcom/qcom_aoss.c
 create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h

-- 
2.18.0

