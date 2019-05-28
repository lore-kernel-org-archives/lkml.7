Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379BBC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D26E21734
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDIn0nXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfE1Qq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:46:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34399 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE1Qq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:46:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id h2so8264653pgg.1;
        Tue, 28 May 2019 09:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u1PRUF8sKFOPE5c2JeDzwxAJ2jF9djlm2TXX02Ljq1w=;
        b=HDIn0nXXGHnoEIekkbx+iUVCYkdvcBxtMFBdQEKjR5k+4m/oZJxSv7kgnMgpTXAxGR
         /KxZPZ9gX9hXGMPiUAZcD5vVAwtQMytsd/F9g8s024eb9sEF38s20iTeQYfzxEKJJu8+
         SuInjKGeaS7h8QgTXPNp0AKF04yQrCw7A2awA7QN7q65z5TCkafBHC2GzCYzSq9YMPji
         rwedsGBVp0ei9KZioABjEcCPFh+41Ik6zoKOTUwzh0etgppnzSfndDIsLTrj3Krb2t1f
         z/8Xf5Kgfi3rSMnis7QTV0ILeqw97XUzrAROrvRWgTKJ+SNnCd9+oWuelHYPYhJjLP5M
         FOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u1PRUF8sKFOPE5c2JeDzwxAJ2jF9djlm2TXX02Ljq1w=;
        b=RaNWlCX+d8BpfauHwTsLHB8y4WCVvV4GoQiOVlwFg6/VUhInkaEId9XG4SLKQ3Yg43
         zNqjxp+eYcZKOdgZadq4YAGpDJDfrZQ45BAjWJ4T3nnuGW6iomfevhz058g31nv3yy91
         i/usVlrZo+D3NW8ZKOLE8WFVVxn6WaVHrJQdxkcm+HRZPCumI4K7A9QkbCE1PQCv6to+
         p6MnZQksfS82trMvc2mpywCWzLxqL+EnsyhO0W0wMdzuxYPVmiM2Dbj/9qsS3E/gjry7
         FcWoDEbd/69+/YYHEZIK9Tbt0q9CXz/UBlZexrX/QeRziyiEGjvGnd1yA8F02KSpcp+r
         EASQ==
X-Gm-Message-State: APjAAAWx8rJ3zFJCkZ2O19TZzTQ0bScz2jycQ/EgDx+xcePKfMNmgd5y
        raYbI1UcqOBhFYxBJ/yBlOE=
X-Google-Smtp-Source: APXvYqwUFnTd8ppNFycGy/ZoXliOo6VBj+IihItjk9xKzs+uMJtUHX/PYTwXjZTxihuW0Sb8HYjlmQ==
X-Received: by 2002:a65:638e:: with SMTP id h14mr60165079pgv.209.1559061985431;
        Tue, 28 May 2019 09:46:25 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id f29sm22891098pfq.11.2019.05.28.09.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 09:46:24 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     agross@kernel.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        marc.w.gonzalez@free.fr, jcrouse@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH 0/3] MSM8998 GPUCC Support
Date:   Tue, 28 May 2019 09:46:16 -0700
Message-Id: <20190528164616.38517-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Adreno GPU on MSM8998 has its own clock controller, which is a
dependency for bringing up the GPU.  This series gets the gpucc all in
place as another step on the road to getting the GPU enabled.

Jeffrey Hugo (3):
  dt-bindings: clock: Document gpucc for msm8998
  clk: qcom: Add MSM8998 GPU Clock Controller (GPUCC) driver
  arm64: dts: qcom: msm8998: Add gpucc node

 .../devicetree/bindings/clock/qcom,gpucc.txt  |   4 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  15 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/gpucc-msm8998.c              | 364 ++++++++++++++++++
 .../dt-bindings/clock/qcom,gpucc-msm8998.h    |  29 ++
 6 files changed, 420 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/qcom/gpucc-msm8998.c
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-msm8998.h

-- 
2.17.1

