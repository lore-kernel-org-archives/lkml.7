Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5583AC004C9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F32B208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dc8l3OQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEBAUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 20:20:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38109 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfEBAT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 20:19:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so212199pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 17:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=M72UrqeRuyBcXD8fVbPV6qhuJNerzMcfy2w0Aus0l5Q=;
        b=dc8l3OQySRYWLVNn/lNNOOqt83xbVy2XhNg7RGbydOcYn7Om65TwQj0KBdKZMDrL0N
         QqLJN/xHpF1BlRPF2e/fy4TVOYZBVG11d9Ab/42A5XK13rpLDsIC3zjvo1ffygZ/C5Yg
         XWyrSHlchanQGOSqzmw4lBXzj8FfHQEV456idxvVHcL8ijw6OxX9bSIr+zwj51m2UMXJ
         mG+Y8DbpZ2DrqV7pDIFDRXwChZ25J68IQGDf6qJCwMWd24vxvAxyWEvCwMlo8q3KXjAe
         aaB1Q2K/fug4A2EyfYbJ+BBpFhIcXTz8oeszUfHkaE6a7heBF57cRX+ILLqRe15Swt7A
         pd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M72UrqeRuyBcXD8fVbPV6qhuJNerzMcfy2w0Aus0l5Q=;
        b=ITwahDzmafn3015MEVELi0sIdh+JFi10QP4g32A3OVsCccGRnpwEc5eXGb5ovdSRs0
         c8ICwTHPJkKF8RHSiNYkVP7IYqXhOXuIL2gBMaJPtn+hX96zclG42pr2bWHbxw/lVdlN
         nhBAGcvAv5fn1nZMSNv0TRJoTREZX5d0yBcOTcZXehsAXQKKe5Pju5CaE3haWSgnmYt1
         cpTwDldiUZONa2pNfOCeIOBCdQ8Fr1fA/8HKJi7KM2bSla5OkutRwh+3OR2fuq64h5qY
         8v7Jquz0lNcQ/FgTRw1aELHqQ9knNpJSZJauAsu0azxas2D7rW35uUNH7Oj5MhU7/TWJ
         j7ng==
X-Gm-Message-State: APjAAAX7Z2dCNEh6BDMNgzbFPyxx2lYXv8Q0rXLmSF+y+4Ju6mcW97ng
        E3Czylro9ug0Pm7lwOup0ooNeg==
X-Google-Smtp-Source: APXvYqwEsMTw7jtqbIuD2dAeIQqOvPTqQfWtFxK+h2Zk/KCJ6frEkbIqUzDedlB2IbgR1ONZECfytA==
X-Received: by 2002:a63:e042:: with SMTP id n2mr828742pgj.45.1556756399042;
        Wed, 01 May 2019 17:19:59 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s198sm36927534pfs.34.2019.05.01.17.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 17:19:58 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Qualcomm QCS404 PCIe support
Date:   Wed,  1 May 2019 17:19:52 -0700
Message-Id: <20190502001955.10575-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the PCIe controller in the Qualcomm QCS404
platform.

Bjorn Andersson (3):
  PCI: qcom: Use clk_bulk API for 2.4.0 controllers
  dt-bindings: PCI: qcom: Add QCS404 to the binding
  PCI: qcom: Add QCS404 PCIe controller support

 .../devicetree/bindings/pci/qcom,pcie.txt     |  25 +++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 109 ++++++++----------
 2 files changed, 73 insertions(+), 61 deletions(-)

-- 
2.18.0

