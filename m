Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F366C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25F720866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCMrq09J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfEAE3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:29:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35225 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfEAE27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:28:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id h1so7840763pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 21:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JMEFW1F3ogTlltrf3f78tL/57sOx/RhTr3cC7ONZO+Y=;
        b=fCMrq09JeU0QbEQI3w26o2kfMeGloArCA6SqLokB68xGha3JYf6cb1gN8NfmxTR8UD
         X6f4S0XwG5Mc60wVDe3I9TEvcNSfMoJmDBFBfwuvWf4RHXOEfFfL2TeF09Aq6bD5BDNJ
         eld9q9G6zqUmGlAEPNNtAcvV4qQhm4tWXjMxyD4bPIail2qxJcp8+MPpsaxQMTCQQ8pC
         8+AFzpDqUNlnOYcG96odtdhA04aHAOfrFEM09/Qc3qB7lJkp1dklCGiSHJ4kZeKweGNB
         Ff5TDnJKhCQMCF0dukfX/VIEcKq8KLpYKQabbvEEBrQnMv/IMVn+RbwxNGMLuS3cYOHO
         SpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JMEFW1F3ogTlltrf3f78tL/57sOx/RhTr3cC7ONZO+Y=;
        b=gjLD0BwPLPis5hk1xXulAd2KKu8ytT7ufCC/5iww/v3xykoadi1UB72ItNhEofipR0
         UCs/iYGTYYI9hSVtr+IVXO2vujSQOsdU7o1DAc+TuniLcp4TFqaTomgZ0xOzChK0kMsJ
         YofDkHa3Khk3E4Z12qMxi29/g4HvwibZ6EG6vZtIWNAZLv5QcFEa5TViQOn3TSx595+z
         GEFmatHxNdRq4p7o32R+xirEXOT+Ti92LC3in+TfoXHYgl3c5pSrHVFRKKcmgqTRVD8U
         L6lzO/OS/AMFRSJkGkotyD6KjdYzynI8mM08F9fApymIFhD8ZM5MNE9CihavErB650m1
         eKyA==
X-Gm-Message-State: APjAAAUQuYhKQ/J+9Kr0lvnvSUQXxNOBspDqbnJPINTkQWp4yh/tF22n
        9Ro+kjpEdQTcBxxqLtSobPc0rg==
X-Google-Smtp-Source: APXvYqyqyz/6Isc8re162rFSusDzCRTwdsQFO8pdCwso2T+0+g6anOcYl/OYy9FP9uHM7nbuXttcFA==
X-Received: by 2002:a65:63cb:: with SMTP id n11mr39781315pgv.236.1556684939156;
        Tue, 30 Apr 2019 21:28:59 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f7sm50371341pga.56.2019.04.30.21.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:28:58 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/4] Qualcomm AOSS QMP driver
Date:   Tue, 30 Apr 2019 21:28:51 -0700
Message-Id: <20190501042855.26570-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a driver implementing Qualcomm Messaging Protocol (QMP) to
communicate with the Always On Subsystem (AOSS) and expose the low-power states
for the remoteprocs as a set of power-domains and the QDSS clock as a clock.

Bjorn Andersson (3):
  dt-bindings: soc: qcom: Add AOSS QMP binding
  soc: qcom: Add AOSS QMP driver
  arm64: dts: qcom: Add AOSS QMP node

Sibi Sankar (1):
  arm64: dts: qcom: sdm845: Add Q6V5 MSS node

 .../bindings/soc/qcom/qcom,aoss-qmp.txt       |  81 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  68 +++
 drivers/soc/qcom/Kconfig                      |  11 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qcom_aoss.c                  | 473 ++++++++++++++++++
 include/dt-bindings/power/qcom-aoss-qmp.h     |  14 +
 6 files changed, 648 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
 create mode 100644 drivers/soc/qcom/qcom_aoss.c
 create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h

-- 
2.18.0

