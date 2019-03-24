Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06852C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F562147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="odfl4D2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfCXRUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:20:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38134 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:20:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so2782913pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 10:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=b93MZFm0cjMk8vip+cTqYwYZn3dg8V909AgdpeqKtAQ=;
        b=odfl4D2ufzt59IInjpsj4QnflwAf0txzAJdxDMRfioqFIF/XYQB5XJuTkQrEbzSXVS
         2SPDlupC6xgCm7wafwFQXAniO6TX41+EWEYRFzwZcMuiMwqtI/bOFBNxrHt+E2bKv4QT
         NapdFCFqhjYzb81uUK87leizB7YaqGIwRCREyvY85oXuQstIwdx59Nj2MAMtRGRTvFil
         QBdUmH9H0/9UQ3c+EIUuVSsNqO9YmI5lmZ2J0oYuU+lbUagRm1yx/UzvZiyrU0N5GNh4
         MTIrnxqb+ujJ7FGBLpgJ/p/2ErN8iiud5odYbBELMICgSMd81WToX/uL6gXVEKJAkujr
         efTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b93MZFm0cjMk8vip+cTqYwYZn3dg8V909AgdpeqKtAQ=;
        b=DuL6ToCBOHeufDSPUmjcSdeutLfzBIWU1qOIMHMhIqtFYmK8XxzusAYnZNpl3BG2pY
         SGy5NlQj1S/Uyr0xyW9gIQcaG4sNH+FCMVH0pjSVMUO3BcdukaX916iy9qsSUWsLdRyt
         5fPmdFymtC2RnPFKHm83YPGfU9vLOhfmttizv4cbnWNE/W259uWdb2A6TGM5sEWtQBI9
         +fd5DoWqadb7MP1s0Lz8KFpJx3xuy5gd7e9xZhbRmeUFjj2AhXNGotFUK6Am1clyKB+Y
         +Wd+oKBQP0abjdPNa/k3yQKtObGWkT+naZkzWSxWQmdm/VwbW27MybE3CO7KJNbHUqKq
         6bFw==
X-Gm-Message-State: APjAAAUzbKSdFA/Uq5AGO40tHNqAwlkySTEf1Zk9MYqpJkjglaDXkCQv
        felQ0br+wVQzwgxeEb+wZP7/7Q==
X-Google-Smtp-Source: APXvYqzrBwGGudion6f2CxckcUleZfrmnFQI5ZQUdzeGPZyJYi+MAsokCnH1VQOSH4qRBsul6Mqv5g==
X-Received: by 2002:a65:6108:: with SMTP id z8mr5362109pgu.106.1553448019601;
        Sun, 24 Mar 2019 10:20:19 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g6sm20382713pgq.54.2019.03.24.10.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 10:20:18 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: qcom: qcs404: CDSP for APF support
Date:   Sun, 24 Mar 2019 10:20:14 -0700
Message-Id: <20190324172016.1195-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock controller and describe the cdsp in a way that it can be reused
between different trusted environments.

Bjorn Andersson (2):
  arm64: dts: qcom: qcs404: Add turingcc node
  arm64: dts: qcom: Fully describe the CDSP

 arch/arm64/boot/dts/qcom/qcs404.dtsi | 100 ++++++++++++++++++---------
 1 file changed, 69 insertions(+), 31 deletions(-)

-- 
2.18.0

