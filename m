Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F130EC31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9E92086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trASQV/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfFLEpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 00:45:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44299 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbfFLEpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:45:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so8831251pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 21:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2TrMdbDpNorKaT7XDMSsPFdib5FuNIVgrqDkUZTgvr4=;
        b=trASQV/i6hQMvG3yM+1qDTXQeLDcKha94BSnA5kVPePebHBoJIxsntc8djDRhJIqJZ
         7O35TJWtIeGrzSZJftr+GkinjSHZcZPjaQKDKSDYtIfHsoFT5Jn239RfNVTJ/JzgvHAw
         KKQHZIgHn2BlosgRoLJNZ7E8HJ9dMzRyRV82H8cfZrB8ecQN59A3BhLhWdW6EJC1w6NV
         A+bmWk8lybIzWiHVLn+1xefTWJNUQAz82a/H+ECgzjKWHiOQM0gYSDyqRXq8r8bNRixU
         ySqlQ0LkSYOYmD5EQcS20WPP/vQyklCngGEcZFH9764eO3xIROqhkhZ7lQIWNANVdhgR
         O0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2TrMdbDpNorKaT7XDMSsPFdib5FuNIVgrqDkUZTgvr4=;
        b=FZg44Tk5PeDv/eboYFFQtjRUIde3DHVJeOYQPCG7+wKAbyWv+0dWtMdM1+HiK86Vwv
         iSHLbLEUSVdB8echRO1ZsYWl+5kQh44UuTHgwpxyWe3Qo9T9k0ExspRbDiDCXAGmfZPO
         O7AxrEr1/V5FMsj32KEHkX0XyZLhFk/vr6QNN9AzZGnDajY4oitrUa0H6aJMoXOiSyU5
         hTxo2+ZVMz8x2WX8p2HIdo3ZSklYpeK1d4ndC5IyKS7F4ZgXBENm97jDv/7jPmSf4V/D
         zWjoiIBV0Oip372hdm83gog1Drq9Ua4fdxYNCa8Pf1ond5skvCdk+HPHtN2nHKhuQ7dc
         miIQ==
X-Gm-Message-State: APjAAAUZag8Lf4dApzYpxE5TcmsCA7MCQRYi9vnPbvynM5fqB5CtbuKi
        yDz1g7NIUUpFlIyDYyAlq9qqGJdrjf0=
X-Google-Smtp-Source: APXvYqz3W8q9oigR26Mbx1v4xByijK9Jz/r+1Afep2gYKpXDUdM2PBuyTIripuQOAxLahLGYWoDmGA==
X-Received: by 2002:a62:5303:: with SMTP id h3mr3288553pfb.58.1560314739414;
        Tue, 11 Jun 2019 21:45:39 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z126sm17129194pfb.100.2019.06.11.21.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 21:45:38 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/4] Qualcomm AOSS QMP driver
Date:   Tue, 11 Jun 2019 21:45:32 -0700
Message-Id: <20190612044536.13940-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the QMP based side-channel communication mechanism to
the AOSS, which is used to control resources not exposed through the
RPMh interface.

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
 drivers/soc/qcom/qcom_aoss.c                  | 480 ++++++++++++++++++
 include/dt-bindings/power/qcom-aoss-qmp.h     |  14 +
 6 files changed, 656 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
 create mode 100644 drivers/soc/qcom/qcom_aoss.c
 create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h

-- 
2.18.0

