Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BF1C2BBE2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 20:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9D2206DB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 20:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sMdhhOEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLGUWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 15:22:16 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33391 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfLGUWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 15:22:15 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so4178127pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 12:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cv9PFgxd+0ufyuR7A03LfCaab8lYp1IYh77BW2Yyv2Q=;
        b=sMdhhOEeF+9PHB2cISUhVxSv54pX/6w6qa3Pco8zbpZ74ZrDvyFmZ4O9n628qcD/p/
         N4DWKYO3/hEbax8NPH7mgct9uSiMkYXOmi4pX5SKP8cHuAirfbnlgdymWlW0PO2t0biE
         A/Mmz/RDlGAe8zv28mESWOQXD0RA7xbNaJ3toERYw9PVdaZjpYFxVISrePGOblhKiX/G
         El+LCTr3Oi+1lUe6dElaFkSVfsBtcUpXO5GLjK+UxD75U+KzzLQeEpLjgbg3ZcjPDZaU
         y5k94WsVzUEzFg/tWnB9Bv7A6qll93Oab/cAPEdaalbDhszP+mn3hod6HpwFeHLliDKN
         jC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cv9PFgxd+0ufyuR7A03LfCaab8lYp1IYh77BW2Yyv2Q=;
        b=ZeDLd0PkW2bH3NKp+0m0YMLBPM5+xLj81T7AwAveelHcibuhSc9Q16y5GnvvirttJH
         NjbDuTHZ8nEHu6jgJAzEMk9qgGoZh7Y52yU74IPn0iV2tLbl4SuEIgfraZK1++ZiP6aK
         yIK9jyIRCmOVaTR6Jz+vxmJH+L6/61+JdgEI29spCAHK3K48E06oNOpr0+IQ90CpaRUe
         2COsQ8C67d/8pw5spL+hgULrtW9Okqi2qYDsPrkY+nPFlwjT03Ct9emKk6qLOljuGRtP
         eIJyNFeZKRd/giHKpVh4xajVVd05xuAOM1/I2eM7ZRBd9VNlteCQuP47Yit4uy2SDCmp
         Q2Vg==
X-Gm-Message-State: APjAAAWVkhJ8g9OObHlbZhx/sweMCXdQEOjXiPJ8KWjbs41mOEvXkofC
        3/5lYLLUOVCMtI/HsoMCH5pdIQ==
X-Google-Smtp-Source: APXvYqwOnrQuvearhvCVS49JtKer/rXeakhDpM22xC6kF7PQKZFidEccTgLMHFoQWd0Yc84CRXNSqQ==
X-Received: by 2002:a17:90a:cb0d:: with SMTP id z13mr22886140pjt.111.1575750133903;
        Sat, 07 Dec 2019 12:22:13 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r7sm21969662pfg.34.2019.12.07.12.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 12:22:12 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vinod.koul@linaro.org
Subject: [PATCH 0/2] phy: qcom-qmp: Add MSM8996 UFS QMP support
Date:   Sat,  7 Dec 2019 12:21:45 -0800
Message-Id: <20191207202147.2314248-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the 14nm UFS PHY found in MSM8996 to the common QMP PHY
driver and migrates the msm8996 dts to the new binding, which will allow us to
remove the old driver (and the broken 20nm driver).

Bjorn Andersson (2):
  phy: qcom-qmp: Add MSM8996 UFS QMP support
  arm64: dts: qcom: msm8996: Use generic QMP driver for UFS

 .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   5 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  33 +++---
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 106 ++++++++++++++++++
 3 files changed, 129 insertions(+), 15 deletions(-)

-- 
2.24.0

