Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFF3C28D18
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9AE208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSnkgkj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfFFBCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 21:02:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40905 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfFFBCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:02:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id d30so307074pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 18:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=A3e4mWtDvoL8bXfJvxffe+5ZazlEmjOb3McggPS9Avs=;
        b=rSnkgkj7ns3K16zuZcdEi6cb801U98fio5fbEzP2UdnS/Nm4wTOFB6zXqdsagDI7z4
         LKdZInQq92yZmswl5tfO9W+Ot7TtGbvsHYYvsRNld4K+vceHus2drvCDK5sr/EnAap48
         g4GtCQaKr8sOBQbiOUIwaEmhT8dw6tAFE5Zl9bU2jZODV/MWMw+XqU43kP4sAhggQXnu
         HzsRG1Eeqy3AAIaKEKkIz5DjBc6N2VPIPFjO2rs+H4cVjaXNAHwxbteF1LHbXD0M83I9
         1M9XmhZ/Nwc3zlJpnE1z/3I/eq1YZgL/j+N3qg5CNtg2ehMuN5/Jjnrtr3sIdmpa+9zE
         /G2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A3e4mWtDvoL8bXfJvxffe+5ZazlEmjOb3McggPS9Avs=;
        b=dlH7hcyPo+gFqAcfZq1roNTG3gLP83V0rIOACa9G3EXmuQBbJYDqsyHVSNcXKlwfYY
         VRoffPyxr0Z8DW2hFph5CKmOYeL7FDMAjA25srnive/9++B+ne73OYkd1FNI5v+Aplre
         vzrjm9KfWt1EYS5F1bvnQofDBPoJQ5iGjJObvAWnO2goyzslyv9np8wnzg0l/hi5o9rQ
         FPxiY9jrvsBO8+imptorj1vGc7DFDPRBHwmPDN9f/Lrl06UobMCB0G8dtX0GROCwGXG+
         qw1elnvmUO5fwiN/vb3rxPiCQu2eZiYVjMG51yCiyWcB9VEnUgzfhCgzndyG0uIStBd5
         G6/A==
X-Gm-Message-State: APjAAAW8PU5kUKBjphwZG1h8DcsIqKxMk0LcVy1v+0GyVT7azAhnbayO
        kyDBB8nhYBrqWqazDRxiJNX7aA==
X-Google-Smtp-Source: APXvYqx/bSa1Dbjvq7bqSIloUGEE/H2kkQfxUwX8mrfDswpMxtORjizTjCmCVJCEazDcEZ709fA5UA==
X-Received: by 2002:a63:eb50:: with SMTP id b16mr711499pgk.150.1559782972862;
        Wed, 05 Jun 2019 18:02:52 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 144sm170856pfy.54.2019.06.05.18.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 18:02:52 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v2 0/3] (Qualcomm) UFS device reset support
Date:   Wed,  5 Jun 2019 18:02:46 -0700
Message-Id: <20190606010249.3538-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series exposes the ufs_reset line as a gpio, adds support for ufshcd to
acquire and toggle this and then adds this to SDM845 MTP.

Bjorn Andersson (3):
  pinctrl: qcom: sdm845: Expose ufs_reset as gpio
  scsi: ufs: Allow resetting the UFS device
  arm64: dts: qcom: sdm845-mtp: Specify UFS device-reset GPIO

 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  |  2 +-
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  2 +
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  2 +
 drivers/pinctrl/qcom/pinctrl-sdm845.c         | 12 ++---
 drivers/scsi/ufs/ufshcd.c                     | 44 +++++++++++++++++++
 drivers/scsi/ufs/ufshcd.h                     |  4 ++
 6 files changed, 59 insertions(+), 7 deletions(-)

-- 
2.18.0

