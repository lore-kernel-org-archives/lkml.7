Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FC7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 22:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805DF214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 22:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+9P7Ywn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfEHWnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 18:43:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41263 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfEHWnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 18:43:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9so99706pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 15:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=M1B48uz7naoSYHk9LojprOtp1192ghEYyzqs88NhVJI=;
        b=h+9P7YwnWLHHuSzwZ2sv+mHuB4E7XG6CChvg3sGv62F6onzVd8jsOqcaxIj2LjxAxT
         1ih5EJ3MJS7PnnZRuZwNt1YaoH9DcM30vzWTUoeflEIv6Dtf+THHd7Dr9E7hf6W9csKg
         Vu3g+Y9+GRgL5yrh35U0cu+myItVdw3MBEagZyQR8I50s79J9yhmnYjkT59vTrAxxaqk
         FukJqSfQzJiaoXyGzZMhWXOpJimlLTZT7sSrjSuWAHzMaT0zTfC+NYPO1AIc1PwERqrs
         WyvT1sz9SepKCxf4jVE5FphxE5a1H+ih/psUoxAFHpztysaGC2/EN3eO+8kHFvpzno6b
         xibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M1B48uz7naoSYHk9LojprOtp1192ghEYyzqs88NhVJI=;
        b=q2S9zXbEduopCFcofTTvP8MjDx+FOFNET1bkm2GHZ7N3uu6vzTItI8K8HtP16gaKD7
         YxwLw7NsID0EMacsYuNVyg01Pob6Wa4qaJ7VGOybj75lafrcWfsKl2SN1x7LGCS2fhG0
         a7dQg8zwdlh3SsMVwHHUbtyN8DFzMHlDFFGfDoEnxRBKrs1CLTnzpTMWHZXvNOaejfTG
         bNEts5xbIttabZQygGAuH7tMFT4X8vrZ8l+V4c4Hi2WbVVbbsbiOGqxlTVKeeHdJd4xJ
         c75GZ8qQAbBXNu/458dg0fOk2rYAUwB0AMYRJZQtQ1Xu11oPFEGl4gc94FbuGqha7/Db
         ceOQ==
X-Gm-Message-State: APjAAAUIJgjl+xGedImegHnZfw+uzqRXBBNlOjxabwHPGO1kpMCEFRoK
        Rs++uoTlCmXwSym66wU0jPuU8g==
X-Google-Smtp-Source: APXvYqz6XWnNCnlZ4X+G7jjSasgvgF5m5Y/cdkIfjOx3lW+QBURzx9kbXupReuOJrB75rdT3Ubkfpw==
X-Received: by 2002:a17:902:aa48:: with SMTP id c8mr470608plr.130.1557355393196;
        Wed, 08 May 2019 15:43:13 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 25sm320494pfo.145.2019.05.08.15.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 15:43:12 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] arm64: dts: qcom: qcs404: Enable PCIe
Date:   Wed,  8 May 2019 15:43:06 -0700
Message-Id: <20190508224309.5744-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series defines the PCIe PHY and controller on QCS404 and enable them for
EVB. This was 1 commit, but per Vinod's request its split up in its individual
pieces.

Bjorn Andersson (3):
  arm64: dts: qcom: qcs404: Make gcc as reset-controller
  arm64: dts: qcom: qcs404: Add PCIe related nodes
  arm64: dts: qcom: qcs404-evb: Enable PCIe

 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 26 ++++++++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi     | 66 ++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

-- 
2.18.0

