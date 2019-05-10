Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1219C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8A4217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uicbkota"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfEJL3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:29:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42059 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfEJL3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:29:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id 145so2889573pgg.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 04:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ue5mOOFAvoPLlx+aQdtAXM/fuPAWTez2nWPJo9g796E=;
        b=uicbkotaBDnFydBWVAjlyZRlDEMY5Vg3dmrqWg722894E8DW0iRM+IRPolafC3VzFk
         je/6llph6+Vbou40pDPIwMeYrFg0vFO7mrzlR7J4StXGMeHsZtwVxtOhCYe9He+OTZeW
         CBVwLAfCF7gcdrQ3nhhwGjtTk8sCu5tV71Wh69+jpbF9xTP8HfIDFm/D/PMeVFDw9hMB
         2H4Q1oqFuYGyrxqDsHo/XSily6/cG5WccWNG/eSN6CbIQmp2FJNTy4EXFY/mbX9BPDVs
         Zglb1moJZ66pBukTzDlLuWiY9XEOSn2Tu+UX9ayowtwR9I8zXu7DeSjH9mdtZ0J+CB2T
         LUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ue5mOOFAvoPLlx+aQdtAXM/fuPAWTez2nWPJo9g796E=;
        b=niyYv44/nfBEI3gPH041aFo2856aMEFUoxQaIHLX0421nB3ZK6H+ZS8ZsW2kAyRiga
         FiVOVcazwKsBaza7ePVNdFHlOBaSI7RVpgzt//zhaI4MPpKbgXidUFInZekoF69MWM9P
         rZmk6CTg+DLRnpdR7Ba1fehv2/1dS9c8ZwdpA1a7xK7y7FbzTWFXZN3l5zTZhqXzkbGM
         IRqFRqNLO0WIaXP584/MR4UMredln2p6b2kecAoGAxTVa6wL7v2dysHVYVYqI6/XmEcn
         FMokVVpwnn05bp3OrdufXMAcqnLWBumsaXw1/lCyyrpMRXHNBr5cIR7OxqHTVzWOwu5a
         YdAg==
X-Gm-Message-State: APjAAAXgM19ysgnJPTrEWWPhe4hMA/k2mOrnArVVdIGHHLWFdbCOvsjS
        12a4wEiBLmiZEPU5BiNV6LwDpNTSs+s=
X-Google-Smtp-Source: APXvYqzWQIWfv6uEkBOl2pEy6GNE/FSH6j6zBJxAG++VxRiPbxcfG1Ywi3f+IncMokmWUUgmQrzorw==
X-Received: by 2002:a63:e956:: with SMTP id q22mr12729606pgj.277.1557487792565;
        Fri, 10 May 2019 04:29:52 -0700 (PDT)
Received: from localhost ([103.8.150.7])
        by smtp.gmail.com with ESMTPSA id g71sm15166395pgc.41.2019.05.10.04.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 04:29:51 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCHv1 0/8] qcom: Add cpuidle to some platforms
Date:   Fri, 10 May 2019 16:59:38 +0530
Message-Id: <cover.1557486950.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up a few entry-method="psci" issues and then add cpuidle low power
states for msm8996, msm8998, qcs404, sdm845. All these have been tested
to only make sure that the C-states are entered from Linux point-of-view. 

We will continue to add more states and make power measurements to tweak
some of these numbers, but getting these merged will allow other people to
use these platforms to work on cpuidle, eas and related topics.


Amit Kucheria (6):
  arm64: dts: Fix various entry-method properties to reflect
    documentation
  Documentation: arm: Link idle-states binding to code
  arm64: dts: qcom: msm8916: Add entry-method property for the
    idle-states node
  arm64: dts: qcom: msm8916: Use more generic idle state names
  arm64: dts: qcom: msm8996: Add PSCI cpuidle low power states
  arm64: dts: qcom: msm8998: Add PSCI cpuidle low power states

Niklas Cassel (1):
  arm64: dts: qcom: qcs404: Add PSCI cpuidle low power states

Raju P.L.S.S.S.N (1):
  arm64: dts: qcom: sdm845: Add PSCI cpuidle low power states

 .../devicetree/bindings/arm/idle-states.txt   |  7 +++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         | 13 ++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 28 +++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi         | 32 ++++++++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 18 ++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 62 +++++++++++++++++++
 7 files changed, 156 insertions(+), 6 deletions(-)

-- 
2.17.1

