Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D265DC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD8220652
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXe1zn/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfEAEhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:37:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36522 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfEAEhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:37:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id w20so7112183plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 21:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=57ICluVQ3RIbtAJVvKOiKDvbYrXy0r4F6ND/9IOkSlQ=;
        b=hXe1zn/Uxwnr0xpFKdyJiyVbqWX2AObkJU2blrgZ4L7Lw8T3/LJwLTo86yviWCoIJm
         /u3yI07YJmS5UUkENXhvpeayrw1N3/kSh7fN+556/QPY6lHNHXCPPgQbX+ut4fj2Qv4K
         7dgWtu243ot+moo8dK5qyE2DX6wvPLWC+ipcyu+2USUQmKNXYrMRELLqBn1c4PKN8fO3
         EO6mptcZJXAz1tktRC9j3GbRtc+BFp87lwbGUKuGjdkB/Y7ijPLaMfIlY9wJ//1aKdhl
         0k/wXHBZKbjUxA+Pe8qnF6i2K4Fn2u5WKEeAOKC+9eAu/4AEq8qeW1kbRg0lwiEdx+0M
         ANkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=57ICluVQ3RIbtAJVvKOiKDvbYrXy0r4F6ND/9IOkSlQ=;
        b=r9yGs2P3a9qi6WfhYlfWHsQ4f1Lp9LPMKHNT9/ovqG4LiSTNRi1jF2xWEa6QUeQnGQ
         Wt9bH8YFYHINCOrDmfqqAy7l5HabRrvAt9i4RbxaGXAxEfSQJLjmsLyu7q5rBsQLGunc
         IzCRX+Sni034cqoK76uhs1Ovuq/NbiNqJJBLliujNjy+k8Hc81A+iIWYNPiuOh3dgMGn
         2FEn2H8aE/9TNGq/U+FocxoriJ6pe0z4RAK8Lm//9p1Z4L79QqC6ckA7/idEXpWF10QP
         VhOAT1Sx5gUrwvhikaUAxNRGUYYNC3gVaM8tJ0QPYlf4K6kVVho/brrnD+Fy3NUbpkUz
         31Zg==
X-Gm-Message-State: APjAAAUXeDvE1AeU0PuyUNClcwl6bcd2BtzIeVh4inw+fbpHv2RWriYw
        ulS2RrfzwUmjqOkixV4ivA8++w==
X-Google-Smtp-Source: APXvYqyf7YUoaBbVjG64SGuMzeVMa1l0ecLXavucehtQsLCaIS85gZ6qI8CST7OaowiAY0bWHfSbuQ==
X-Received: by 2002:a17:902:5a3:: with SMTP id f32mr72229182plf.82.1556685458165;
        Tue, 30 Apr 2019 21:37:38 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q128sm55912865pga.60.2019.04.30.21.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:37:36 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/4] Qualcomm AOSS QMP driver
Date:   Tue, 30 Apr 2019 21:37:30 -0700
Message-Id: <20190501043734.26706-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a driver implementing Qualcomm Messaging Protocol (QMP) to
communicate with the Always On Subsystem (AOSS) and expose the low-power
states for the remoteprocs as a set of power-domains and the QDSS clock
as a clock.

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

